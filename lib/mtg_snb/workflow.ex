defmodule MtgSnb.Workflow do
  def parse_pages(pages_list) do
    pages_list
      |> Enum.map(&parse_page/1)
  end

  def intersect_stores(cards) do
    number_of_cards = length(cards)
    grouped_cards = cards
      |> Enum.map(fn(card) -> card.stores end)
      |> List.flatten
      |> Enum.group_by(fn(store) -> store.name end)

    Map.keys(grouped_cards)
      |> Enum.map(fn(key) -> grouped_cards[key] end)
      |> Enum.reduce([], fn card, acc ->
                            if length(card) == number_of_cards do
                              [card | acc]
                            else
                              acc
                            end
                          end)
  end

  defp parse_page(page) do
    min_qty = Enum.at(page, 1)
    content = Enum.at(page, 0)
    card_name = get_name(content)
    stores = parse_content(content, min_qty)

    %Card{
      name: card_name,
      stores: stores
    }
  end

  def get_name(body) do
    File.write!('error_log.txt', body)
    # pt_br_name = Floki.find(body, "h3.titulo-card") |> Floki.text
    #
    # case Floki.find(body, ".subtitulo-card") |> Floki.text do
    #   "" ->
    #     original_name = pt_br_name
    #     original_name
    #   original_name ->
    #     original_name
    # end
  end

  defp parse_content(body, min_qty) do
    Floki.find(body, "#cotacao-1 tbody tr")
      |> Enum.map(fn(store) ->
        caller = self
        spawn(fn ->
          send(caller, {:store, parse_store(store, min_qty)})
        end)
      end)
      |> Enum.map(fn (_) ->
        receive do
          {:store , store} -> store
        end
      end)
      |> Enum.reduce([], fn store, acc ->
                          if store != nil do
                            [store | acc]
                          else
                            acc
                          end
                        end)
      |> Enum.uniq_by(fn(store) -> store.name end)
      |> Enum.sort_by(fn(store) -> store.price end)
  end

  defp parse_store(store, min_qty) do
    qty =
      store
      |> Floki.find("td")
      |> Enum.at(3)
      |> Floki.text
      |> Store.clean_qty

    if qty >= min_qty do
      name =
        store
        |> Floki.find("td.banner-loja a img")
        |> Floki.attribute("title")
        |> Enum.at(0)

      price =
        store
        |> Floki.find("td p.lj")
        |> Floki.filter_out("font")
        |> Floki.text
        |> Store.clean_price

      url =
        store
        |> Floki.find("td.col-5 a.botao")
        |> Floki.attribute("href")
        |> Enum.at(0)
        |> Store.normalize_url

      %Store{
        name: name,
        price: price,
        url: url,
        qty: qty
      }
    else
      nil
    end
  end
end

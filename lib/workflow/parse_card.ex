defmodule Workflow.ParseBody do
  def parse(body) do
    Floki.find(body, "#cotacao-1 tbody tr")
      |> Enum.map(fn(store) ->
        caller = self
        spawn(fn ->
          send(caller, {:store, fetch_store(store)})
        end)
      end)
      |> Enum.map(fn (_) ->
        receive do
          {:store , store} -> store
        end
      end)
      |> Enum.reduce([], fn store, acc -> [store | acc] end)
      |> Enum.sort_by(fn(store) -> store.price end)
  end

  def fetch_store(store) do
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

    qty =
      store
      |> Floki.find("td")
      |> Enum.at(3)
      |> Floki.text
      |> Store.clean_qty

    %Store{
      name: name,
      price: price,
      url: url,
      qty: qty
    }
  end
end

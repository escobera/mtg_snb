defmodule MtgSnb do
  @ligamagic_show_card_url "http://www.ligamagic.com.br/?view=cards/card&card="
  require Logger

  def get_card(card_name) do
    card_url = ligamagic_url(card_name)
    Logger.info "Fetching from #{card_url}"
    case HTTPotion.get(card_url, [timeout: 30_000]) do
      %HTTPotion.Response{ body: "Site em manutencao, por favor aguarde alguns minutos.", headers: _, status_code: 200 } ->
        {:err, "Ligamagic em manutenção"}
      %HTTPotion.Response{ body: body, headers: _headers, status_code: 200 } ->
        {:ok, fetch_card_info(body) } #, fetch_prices(body)
      _ ->
        {:err, "not found"}
    end
  end

  def fetch_card_info(body) do
    name = fetch_name(body)
    stores = fetch_stores(body)
    %Card{ name: name, stores: stores }
  end

  def fetch_name(body) do
    Floki.find(body, ".subtitulo-card") |> Floki.text
  end

  def fetch_stores(body) do
    Floki.find(body, "#cotacao-1 tbody tr")
      |> Enum.map(fn(store) -> fetch_store(store) end)
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
      url: url
    }
  end

  # def http_headers do
  #   [
  #     headers: [
  #       "User-Agent": @user_agent,
  #       "Accept": "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8"
  #     ]
  #   ]
  # end

  def ligamagic_url(card_name) do
    @ligamagic_show_card_url <> card_name
  end
end

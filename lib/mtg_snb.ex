defmodule MtgSnb do
  @ligamagic_show_card_url "http://www.ligamagic.com.br/?view=cards/card&card="
  require Logger

  def get_cards(card_name_list) do
    card_name_list
    |> Enum.map(fn(card) -> get_card(card) end)
    |> Enum.reduce([], fn ({:ok, card}, acc) -> [card | acc] end)
    |> BestOrder.find_best_order
  end

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
    pt_br_name = Floki.find(body, "h3.titulo-card") |> Floki.text

    case Floki.find(body, ".subtitulo-card") |> Floki.text do
      "" ->
        original_name = pt_br_name
      original_name ->
        original_name
    end

  end

  def fetch_stores(body) do
    Workflow.ParseBody.parse(body)
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
    @ligamagic_show_card_url <> URI.encode(card_name)
  end
end

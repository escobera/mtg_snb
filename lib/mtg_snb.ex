defmodule MtgSnb do
  require Logger
  alias MtgSnb.Workflow

  @ligamagic_show_card_url "http://www.ligamagic.com.br/?view=cards/card&card="

  def get_card_html_body(card_name, qty) do
    card_url = ligamagic_url(card_name)
    Logger.info "Fetching from #{card_url}"
    case HTTPotion.get(card_url, [timeout: 30_000]) do
      %HTTPotion.Response{ body: "Site em manutencao, por favor aguarde alguns minutos.", headers: _, status_code: 200 } ->
        {:err, "Ligamagic em manutenção"}
      %HTTPotion.Response{ body: body, headers: _headers, status_code: 200 } ->
        [body, qty]
      _ ->
        {:err, "not found"}
    end
  end

  def ligamagic_url(card_name) do
    @ligamagic_show_card_url <> URI.encode(card_name)
  end

  def get_cards(card_list) do
    card_list
      |> Enum.map(fn(card) ->
        caller = self
        spawn(fn ->
          send(caller, {:card, get_card_html_body(Enum.at(card,0), Enum.at(card, 1))})
        end)
      end)
      |> Enum.map(fn (_) ->
        receive do
          {:card , card} -> card
        end
      end)
      |> Enum.reduce([], fn card, acc ->
                            [card | acc]
                        end)
      |> Workflow.parse_pages
      |> Workflow.intersect_stores
  end

  def fetch_name(body) do
    Workflow.get_name(body)
  end


  # def http_headers do
  #   [
  #     headers: [
  #       "User-Agent": @user_agent,
  #       "Accept": "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8"
  #     ]
  #   ]
  # end
end

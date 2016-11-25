defmodule MtgSnb do
  require MtgSnb.Workflow.ParseBody
  # require Workflow.ParseBody
  # def get_cards(card_name_list) do
  #   card_name_list
  #   |> Enum.map(fn(card) -> get_card(card) end)
  #   |> Enum.reduce([], fn ({:ok, card}, acc) -> [card | acc] end)
  #   |> BestOrder.find_best_order
  # end

  def get_best_price(card_list) do
    card_list
      |> Enum.map(fn(card_name) ->
          MtgSnb.Workflow.FetchUrl.get_card_html_body(card_name)
            |> MtgSnb.Workflow.ParseBody.parse
        end
      )


  end

  def fetch_stores(body) do
    MtgSnb.Workflow.ParseBody.parse(body)
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

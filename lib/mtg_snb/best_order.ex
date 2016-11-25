defmodule BestOrder do
  defstruct [:store, :total_price, :urls]

  def find_best_order(cards) do
    sorted_cards =
      cards
      |> Enum.sort_by(fn(card) -> card.name end)

    {:ok, store_names} = stores_with_cards(sorted_cards)

    store_groupings =
      store_names
      |> Enum.map(fn(store_name) -> get_lowest_price_by_store(sorted_cards, store_name) end)

    find_best_combination(store_groupings)
    |> Enum.min_by(fn(order) -> order.total_price end)
  end

  def get_lowest_price_by_store(cards, store_name) do
    Enum.map(cards, fn(card) -> Card.lowest_price_by_store(card, store_name) end)
  end

  def find_best_combination(store_grouping_list) do
    store_grouping_list
    |> Enum.map( fn(store_grouping_list) -> assemble_orders(store_grouping_list) end)
  end

  def assemble_orders(store_grouping_list) do
    store =
      store_grouping_list
      |> Enum.at(0)

    total_price =
      store_grouping_list
      |> Enum.reduce(0, fn(store, acc) -> store.price + acc end)

    urls =
      store_grouping_list
      |> Enum.map(fn(store) -> store.url end)

    %BestOrder{store: store.name, total_price: total_price, urls: urls}
  end

  def stores_with_cards(cards) do
    stores_with_cards = cards
      |> Enum.map(fn(card) -> get_names(card.stores) end)
      |> Enum.reduce([], &BestOrder.intersect_names/2)
      |> MapSet.to_list

    case stores_with_cards do
      [] ->
        {:err, "Os cards não existem em todas as lojas"}
      stores_with_cards ->
        {:ok, stores_with_cards}
    end
  end

  def get_names(stores) do
    Enum.map(stores, fn(store) -> store.name end) |> Enum.dedup |> MapSet.new
  end

  def intersect_names(stores, []) do
    stores
  end

  def intersect_names(stores, acc) do
    MapSet.intersection(stores, acc)
  end

end

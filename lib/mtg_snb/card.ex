defmodule Card do
  defstruct [:name, :stores]

  def lowest_price_store(card) do
    Enum.min_by(card.stores, fn(item) -> item.price end)
  end

  def lowest_price(card) do
    lowest_price_store(card).price
  end

  def lowest_price_by_store(card, store_name) do
    card.stores
    |> Enum.filter(fn(store) -> store.name == store_name end)
    |> Enum.min_by(fn(item) -> item.price end)
  end

end

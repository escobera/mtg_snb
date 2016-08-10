defmodule Card do
  defstruct [:name, :stores]

  def lowest_price_store(card) do
    Enum.min_by(card.stores, fn(item) -> item.price end)
  end

  def lowest_price(card) do
    lowest_price_store(card).price
      |> String.to_float
  end
end

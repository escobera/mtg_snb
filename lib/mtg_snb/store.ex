defmodule Store do
  @ligamagic_base "http://www.ligamagic.com.br/"
  defstruct [:name, :price, :qty, :url]

  def clean_price(price) do
    price
    |> String.trim
    |> String.slice(3,500)
    |> String.replace(".", "")
    |> String.to_float
  end

  def clean_qty(qty_str) do
    qty_str
    |> String.split
    |> Enum.at(0)
    |> String.to_integer
  end

  def normalize_url(url) do
    @ligamagic_base <> url
  end

  def filter_by_qty(store_list, min_qty) do
    store_list
      |> Enum.filter(fn(store) -> store.qty >= min_qty end)
  end

end

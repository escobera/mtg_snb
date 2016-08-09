defmodule Store do
  @ligamagic_base "http://www.ligamagic.com.br"
  defstruct [:name, :price, :url]

  def clean_price(price) do
    price |> String.trim |> String.slice(3,500)
  end

  def normalize_url(url) do
    @ligamagic_base <> url
  end
end

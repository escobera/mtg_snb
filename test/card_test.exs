defmodule CardTest do
  use ExUnit.Case

  test "Gets the lowest price from a list of Stores" do
    stores = [
      %Store{name: "loja 1", price: "2,99", url: ""},
      %Store{name: "loja 2", price: "3,99", url: ""},
      %Store{name: "loja 3", price: "0,99", url: ""}
    ]
    card = %Card{name: "Phyrexian Revoker", stores: stores}

    assert Card.lowest_price_store(card) == %Store{name: "loja 3", price: "0,99", url: ""}
    assert Card.lowest_price(card) == 0.99
  end
end

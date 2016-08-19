defmodule StoreTest do
  use ExUnit.Case

  test "Cleans the quantity string" do
    quantity_str_1 = "1 unid."
    quantity_str_12 = "12 unids."
    quantity_str_123 = "123 unids."

    assert Store.clean_qty(quantity_str_1) == 1
    assert Store.clean_qty(quantity_str_12) == 12
    assert Store.clean_qty(quantity_str_123) == 123
  end
end

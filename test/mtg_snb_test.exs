defmodule MtgSnbTest do
  use ExUnit.Case
  @html File.read!("test/samples/ligamagic_counterspell.html")
  doctest MtgSnb

  test "Fetches the name" do
    name = MtgSnb.fetch_name(@html)
    assert name == "Counterspell"
  end

  test "Fetches stores that have that card for sale" do
    stores = MtgSnb.fetch_stores(@html)
    assert is_list(stores)
  end

  test "Fetches stores that have that card for sale (parallel)" do
    stores = MtgSnb.fetch_stores_c(@html)
    assert is_list(stores)
  end
end

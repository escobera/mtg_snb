defmodule MtgSnbTest do
  use ExUnit.Case
  @counterspell File.read!("test/samples/ligamagic_counterspell.html")
  @gideon File.read!("test/samples/ligamagic_gideon.html")
  doctest MtgSnb

  test "Fetches the name" do
    counterspell = MtgSnb.fetch_name(@counterspell)
    assert counterspell == "Counterspell"

    gideon = MtgSnb.fetch_name(@gideon)
    assert gideon == "Gideon, Ally of Zendikar"
  end

  test "Fetches stores that have that card for sale" do
    stores = MtgSnb.fetch_stores(@counterspell)
    assert is_list(stores)
  end

  test "Fetches stores that have that card for sale (limited by quantity)" do
    stores = MtgSnb.fetch_stores(@gideon)
              |> Store.filter_by_qty(3)
    assert length(stores) == 1
  end


end

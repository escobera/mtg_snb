defmodule MtgSnbTest do
  use ExUnit.Case
  @counterspell File.read!("test/samples/ligamagic_counterspell.html")
  @gideon File.read!("test/samples/ligamagic_gideon.html")
  @angelic File.read!("test/samples/ligamagic_angelic.html")
  doctest MtgSnb

  test "Fetches the name" do
    counterspell = MtgSnb.fetch_name(@counterspell)
    assert counterspell == "Counterspell"

    gideon = MtgSnb.fetch_name(@gideon)
    assert gideon == "Gideon, Ally of Zendikar"

    angelic = MtgSnb.fetch_name(@angelic)
    assert angelic == "Angelic Renewal"
  end
end

defmodule WorkflowTest do
  use ExUnit.Case
  alias MtgSnb.Workflow
  @counterspell File.read!("test/samples/ligamagic_counterspell.html")
  @gideon File.read!("test/samples/ligamagic_gideon.html")

  test "Parses the page" do
    cards = Workflow.parse_pages([[@gideon,2], [@counterspell,5]])
    gideon = Enum.at(cards,0)
    counterspell = Enum.at(cards,1)
    assert Enum.member?(gideon.stores,  %Store{name: "CHQ Cards", price: 104.13, qty: 2, url: "http://www.ligamagic.com.br/b/?p=299675"})
    assert Enum.member?(counterspell.stores,  %Store{name: "Magic Secrets", price: 4.49, qty: 51, url: "http://www.ligamagic.com.br/b/?p=e460413"})
    assert Enum.member?(counterspell.stores,  %Store{name: "MTG IDEAL", price: 3.93, qty: 5, url: "http://www.ligamagic.com.br/b/?p=e528383"})
  end

  test "Get the store that has all the cards" do
    stores = Workflow.parse_pages([[@gideon,2], [@counterspell,5]])
      |> Workflow.intersect_stores
      |> List.flatten

    assert Enum.member?(stores, %Store{name: "CHQ Cards", price: 104.13, qty: 2, url: "http://www.ligamagic.com.br/b/?p=299675"})
  end
end

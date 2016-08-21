defmodule CardTest do
  use ExUnit.Case
  @card %Card{name: "Propaganda", stores: [
    %Store{name: "House of Cards - Cardgames", price: "11,00", qty: 1, url: "http://www.ligamagic.com.brb/?p=e521738"},
    %Store{name: "Walkers Magic Store", price: "12,99", qty: 2, url: "http://www.ligamagic.com.brb/?p=e619886"},
    %Store{name: "Walkers Magic Store", price: "12,99", qty: 2,  url: "http://www.ligamagic.com.brb/?p=e619885"},
    %Store{name: "Legion CG", price: "14,75", qty: 1, url: "http://www.ligamagic.com.brb/?p=298291"},
    %Store{name: "Redzone", price: "14,95", qty: 1, url: "http://www.ligamagic.com.brb/?p=e423515"},
    %Store{name: "MAGOBOX", price: "14,99", qty: 2, url: "http://www.ligamagic.com.brb/?p=e607579"},
    %Store{name: "MUNDOKINOENE", price: "14,99", qty: 1, url: "http://www.ligamagic.com.brb/?p=172375"},
    %Store{name: "MUNDOKINOENE", price: "14,99", qty: 1, url: "http://www.ligamagic.com.brb/?p=24598"},
    %Store{name: "Draw-Go. Games", price: "15,00", qty: 1, url: "http://www.ligamagic.com.brb/?p=e499202"},
    %Store{name: "Draw-Go. Games", price: "15,00", qty: 3, url: "http://www.ligamagic.com.brb/?p=e493141"},
    %Store{name: "Draw-Go. Games", price: "16,00", qty: 3, url: "http://www.ligamagic.com.brb/?p=e272104"},
    %Store{name: "magicbembarato", price: "18,33", qty: 4, url: "http://www.ligamagic.com.brb/?p=225756"},
    %Store{name: "Cards e Games", price: "18,99", qty: 10, url: "http://www.ligamagic.com.brb/?p=e9700"},
    %Store{name: "magicbembarato", price: "19,16", qty: 4, url: "http://www.ligamagic.com.brb/?p=215390"},
    %Store{name: "magicbembarato", price: "21,16", qty: 4, url: "http://www.ligamagic.com.brb/?p=226761"}
  ]}
  test "Gets the lowest price from a list of Stores" do
    assert Card.lowest_price_store(@card) == %Store{name: "House of Cards - Cardgames", price: "11,00", qty: 1, url: "http://www.ligamagic.com.brb/?p=e521738"}
    assert Card.lowest_price(@card) == 11.00
  end

  test "Gets the lowest price filtering by store name" do
    assert Card.lowest_price_by_store(@card, "Walkers Magic Store") == %Store{name: "Walkers Magic Store", price: "12,99", qty: 2, url: "http://www.ligamagic.com.brb/?p=e619886"}
  end
end

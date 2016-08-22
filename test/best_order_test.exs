defmodule BestOrderTest do
  use ExUnit.Case

  @cards [
    %Card{name: "Propaganda", stores: [
      %Store{name: "House of Cards - Cardgames",  price: 11.00, qty: 1, url: "http://www.ligamagic.com.brb/?p=e521738"},
      %Store{name: "Walkers Magic Store",         price: 12.99, qty: 2, url: "http://www.ligamagic.com.brb/?p=e619886"},
      %Store{name: "Walkers Magic Store",         price: 12.99, qty: 2,  url: "http://www.ligamagic.com.brb/?p=e619885"},
      %Store{name: "Legion CG",                   price: 14.75, qty: 1, url: "http://www.ligamagic.com.brb/?p=298291"},
      %Store{name: "Redzone",                     price: 14.95, qty: 1, url: "http://www.ligamagic.com.brb/?p=e423515"},
      %Store{name: "MAGOBOX",                     price: 14.99, qty: 2, url: "http://www.ligamagic.com.brb/?p=e607579"},
      %Store{name: "MUNDOKINOENE",                price: 14.99, qty: 1, url: "http://www.ligamagic.com.brb/?p=172375"},
      %Store{name: "MUNDOKINOENE",                price: 14.99, qty: 1, url: "http://www.ligamagic.com.brb/?p=24598"},
      %Store{name: "Draw-Go. Games",              price: 15.00, qty: 1, url: "http://www.ligamagic.com.brb/?p=e499202"},
      %Store{name: "Draw-Go. Games",              price: 15.00, qty: 3, url: "http://www.ligamagic.com.brb/?p=e493141"},
      %Store{name: "Draw-Go. Games",              price: 16.00, qty: 3, url: "http://www.ligamagic.com.brb/?p=e272104"},
      %Store{name: "magicbembarato",              price: 18.33, qty: 4, url: "http://www.ligamagic.com.brb/?p=225756"},
      %Store{name: "Cards e Games",               price: 18.99, qty: 10, url: "http://www.ligamagic.com.brb/?p=e9700"},
      %Store{name: "magicbembarato",              price: 19.16, qty: 4, url: "http://www.ligamagic.com.brb/?p=215390"},
      %Store{name: "magicbembarato",              price: 21.16, qty: 4, url: "http://www.ligamagic.com.brb/?p=226761"}
    ]},
    %Card{name: "Armageddon", stores: [
      %Store{name: "Prometheus RPG",                            price: 12.00, qty: 2, url: "http://www.ligamagic.com.brb/?p=e32494"},
      %Store{name: "Draw-Go. Games",                            price: 13.00, qty: 2, url: "http://www.ligamagic.com.brb/?p=e425162"},
      %Store{name: "UPONLINE",                                  price: 13.50, qty: 3, url: "http://www.ligamagic.com.brb/?p=e569642"},
      %Store{name: "LOJA CALABOUÇO - HOBBIES E COLECIONÁVEIS",  price: 14.00, qty: 3, url: "http://www.ligamagic.com.brb/?p=e594047"},
      %Store{name: "UPONLINE",                                  price: 14.00, qty: 2, url: "http://www.ligamagic.com.brb/?p=e569635"},
      %Store{name: "magicbembarato",                            price: 14.13, qty: 4, url: "http://www.ligamagic.com.brb/?p=216229"},
      %Store{name: "Bazar de Bagdá",                            price: 14.99, qty: 4, url: "http://www.ligamagic.com.brb/?p=e263589"},
      %Store{name: "Bazar de Bagdá",                            price: 14.99, qty: 1, url: "http://www.ligamagic.com.brb/?p=e553873"},
      %Store{name: "MAGICHOUSE",                                price: 14.99, qty: 2, url: "http://www.ligamagic.com.brb/?p=190142"},
      %Store{name: "Bazar de Bagdá",                            price: 14.99, qty: 1, url: "http://www.ligamagic.com.brb/?p=e260301"},
      %Store{name: "UGCardShop",                                price: 14.99, qty: 40, url: "http://www.ligamagic.com.brb/?p=182576"},
      %Store{name: "Cards e Games",                             price: 15.00, qty: 1, url: "http://www.ligamagic.com.brb/?p=e217876"},
      %Store{name: "magicbembarato",                            price: 15.54, qty: 4, url: "http://www.ligamagic.com.brb/?p=216909"},
      %Store{name: "magicbembarato",                            price: 16.27, qty: 4, url: "http://www.ligamagic.com.brb/?p=217827"},
      %Store{name: "Bazar de Bagdá",                            price: 19.99, qty: 1, url: "http://www.ligamagic.com.brb/?p=e610437"},
      %Store{name: "MAGICHOUSE",                                price: 19.99, qty: 1, url: "http://www.ligamagic.com.brb/?p=38222"},
      %Store{name: "UGCardShop",                                price: 19.99, qty: 1, url: "http://www.ligamagic.com.brb/?p=168265"},
      %Store{name: "Bazar de Bagdá",                            price: 199.99, qty: 2, url: "http://www.ligamagic.com.brb/?p=e230804"},
      %Store{name: "House of Cards - Cardgames",                price: 20.00, qty: 2, url: "http://www.ligamagic.com.brb/?p=e519731"},
      %Store{name: "magicbembarato",                            price: 22.31, qty: 4, url: "http://www.ligamagic.com.brb/?p=232970"},
      %Store{name: "Mulligan Geek Store",                       price: 22.95, qty: 1, url: "http://www.ligamagic.com.brb/?p=e132389"},
      %Store{name: "MUNDOKINOENE",                              price: 24.90, qty: 1, url: "http://www.ligamagic.com.brb/?p=207029"},
      %Store{name: "Cards Of Paradise",                         price: 29.75, qty: 3, url: "http://www.ligamagic.com.brb/?p=e647708"},
      %Store{name: "Bazar de Bagdá",                            price: 29.99, qty: 9, url: "http://www.ligamagic.com.brb/?p=e232367"},
      %Store{name: "Draw-Go. Games",                            price: 45.00, qty: 1, url: "http://www.ligamagic.com.brb/?p=e602499"},
      %Store{name: "MAGICHOUSE",                                price: 80.00, qty: 1, url: "http://www.ligamagic.com.brb/?p=295127"}
      ]
    }
  ]


  test "Finds best order for one-offs" do
    assert BestOrder.find_best_order(@cards) == %BestOrder{store: "Draw-Go. Games", total_price: 28.00, urls: [
      "http://www.ligamagic.com.brb/?p=e425162", #armageddon
      "http://www.ligamagic.com.brb/?p=e499202"  #propaganda
      ]}
  end
end

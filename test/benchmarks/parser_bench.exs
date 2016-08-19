html = File.read!("test/samples/ligamagic_counterspell.html")

Benchee.run(%{
  "serial"    => fn -> MtgSnb.fetch_card_info(html) end,
  "concurrent" => fn -> MtgSnb.fetch_card_info_c(html) end})

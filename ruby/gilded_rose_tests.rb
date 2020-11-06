gem 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require File.join(File.dirname(__FILE__), 'gilded_rose')


class GildedRoseTest < Minitest::Test

  def test_generic_item_decrease_quality
    generic = Generic.new(Item.new("foo", 1, 1))
    obj = [generic]
    assert_equal obj[0].item.quality, 1
    GildedRose.new(obj).update_quality
    pp obj[0].item
    assert_equal obj[0].item.name, "foo"
    assert_equal obj[0].item.quality, 0
  end

  def test_generic_item_min_quality_0

    generic = Generic.new(Item.new("foo", 1, 1))
    obj = [generic]
    assert_equal obj[0].item.quality, 1
    GildedRose.new(obj).update_quality()
    assert_equal obj[0].item.name, "foo"
    assert_equal obj[0].item.sell_in, 0
    assert_equal obj[0].item.quality, 0
    GildedRose.new(obj).update_quality()
    assert_equal obj[0].item.name, "foo"
    assert_equal obj[0].item.sell_in, -1
    assert_equal obj[0].item.quality, 0
  end

  def test_generic_item_decrease_sell_in
    generic = Generic.new(Item.new("foo", 1, 1))
    obj = [generic]
    assert_equal obj[0].item.sell_in, 1
    GildedRose.new(obj).update_quality()
    assert_equal obj[0].item.name, "foo"
    assert_equal obj[0].item.sell_in, 0
  end

  def test_generic_item_loses_double_quality_passed_sell_in
    generic = Generic.new(Item.new("foo", 1, 10))
    obj = [generic]
    assert_equal obj[0].item.sell_in, 1
    assert_equal obj[0].item.quality, 10
    GildedRose.new(obj).update_quality()
    assert_equal obj[0].item.sell_in, 0
    assert_equal obj[0].item.quality, 9
    GildedRose.new(obj).update_quality()
    assert_equal obj[0].item.sell_in, -1
    assert_equal obj[0].item.quality, 7
  end

  def test_aged_brie_item_increase_quality_max_50
    brie = AgedBrie.new(Item.new("Aged Brie", 4, 48))
    obj = [brie]
    assert_equal obj[0].item.quality, 48
    assert_equal obj[0].item.sell_in, 4
    GildedRose.new(obj).update_quality()
    assert_equal obj[0].item.quality, 49
    assert_equal obj[0].item.sell_in, 3
    GildedRose.new(obj).update_quality()
    assert_equal obj[0].item.quality, 50
    assert_equal obj[0].item.sell_in, 2
    GildedRose.new(obj).update_quality()
    assert_equal obj[0].item.quality, 50
    assert_equal obj[0].item.sell_in, 1
    GildedRose.new(obj).update_quality()
    assert_equal obj[0].item.quality, 50
    assert_equal obj[0].item.sell_in, 0
  end

  def test_concert_pass_increase_in_quality_each_day
    ticket = Backstage.new(Item.new("Backstage passes to a TAFKAL80ETC concert", 15, 10))
    obj = [ticket]
    assert_equal obj[0].item.sell_in, 15
    assert_equal obj[0].item.quality, 10
    GildedRose.new(obj).update_quality()
    assert_equal obj[0].item.sell_in, 14
    assert_equal obj[0].item.quality, 11
  end

  def test_concert_pass_increase_2_quality_within_10_days
    ticket = Backstage.new(Item.new("Backstage passes to a TAFKAL80ETC concert", 11, 10))
    obj = [ticket]
    assert_equal obj[0].item.sell_in, 11
    assert_equal obj[0].item.quality, 10
    GildedRose.new(obj).update_quality()
    assert_equal obj[0].item.sell_in, 10
    assert_equal obj[0].item.quality, 11
    GildedRose.new(obj).update_quality()
    assert_equal obj[0].item.sell_in, 9
    assert_equal obj[0].item.quality, 13
    GildedRose.new(obj).update_quality()
    assert_equal obj[0].item.sell_in, 8
    assert_equal obj[0].item.quality, 15
  end

  def test_concert_pass_increase_3_quality_within_5_days
    ticket = Backstage.new(Item.new("Backstage passes to a TAFKAL80ETC concert", 6, 10))
    obj = [ticket]
    assert_equal obj[0].item.sell_in, 6
    assert_equal obj[0].item.quality, 10
    GildedRose.new(obj).update_quality
    assert_equal obj[0].item.sell_in, 5
    assert_equal obj[0].item.quality, 12
    GildedRose.new(obj).update_quality
    assert_equal obj[0].item.sell_in, 4
    assert_equal obj[0].item.quality, 15
    GildedRose.new(obj).update_quality
    assert_equal obj[0].item.sell_in, 3
    assert_equal obj[0].item.quality, 18
  end

  def test_concert_pass_quality_to_0_after_concert
    ticket = Backstage.new(Item.new("Backstage passes to a TAFKAL80ETC concert", 2, 10))
    obj = [ticket]
    assert_equal obj[0].item.sell_in, 2
    assert_equal obj[0].item.quality, 10
    GildedRose.new(obj).update_quality()
    assert_equal obj[0].item.sell_in, 1
    assert_equal obj[0].item.quality, 13
    GildedRose.new(obj).update_quality()
    assert_equal obj[0].item.sell_in, 0
    assert_equal obj[0].item.quality, 16
    GildedRose.new(obj).update_quality()
    assert_equal obj[0].item.sell_in, -1
    assert_equal obj[0].item.quality, 0
    GildedRose.new(obj).update_quality()
    assert_equal obj[0].item.sell_in, -2
    assert_equal obj[0].item.quality, 0
  end

  def test_concert_pass_quality_not_to_exceed_50
    ticket = Backstage.new(Item.new("Backstage passes to a TAFKAL80ETC concert", 10, 48))
    obj = [ticket]
    assert_equal obj[0].item.sell_in, 10
    assert_equal obj[0].item.quality, 48
    GildedRose.new(obj).update_quality()
    assert_equal obj[0].item.sell_in, 9
    assert_equal obj[0].item.quality, 50
    GildedRose.new(obj).update_quality()
    assert_equal obj[0].item.sell_in, 8
    assert_equal obj[0].item.quality, 50
    GildedRose.new(obj).update_quality()
    assert_equal obj[0].item.sell_in, 7
    assert_equal obj[0].item.quality, 50
  end

  def test_concert_pass_quality_not_to_exceed_50_different
    ticket = Backstage.new(Item.new("Backstage passes to a TAFKAL80ETC concert", 10, 49))
    obj = [ticket]
    assert_equal obj[0].item.sell_in, 10
    assert_equal obj[0].item.quality, 49
    GildedRose.new(obj).update_quality()
    assert_equal obj[0].item.sell_in, 9
    assert_equal obj[0].item.quality, 50
    GildedRose.new(obj).update_quality()
    assert_equal obj[0].item.sell_in, 8
    assert_equal obj[0].item.quality, 50
    GildedRose.new(obj).update_quality()
    assert_equal obj[0].item.sell_in, 7
    assert_equal obj[0].item.quality, 50
  end
  
  def test_sulfuras_does_not_decrease_sell_in_or_quality
    sulfuras = Sulfuras.new(Item.new("Sulfuras, Hand of Ragnaros", 2, 10))
    obj = [sulfuras]
    assert_equal obj[0].item.sell_in, 2
    assert_equal obj[0].item.quality, 10
    GildedRose.new(obj).update_quality()
    assert_equal obj[0].item.sell_in, 2
    assert_equal obj[0].item.quality, 10
  end

end

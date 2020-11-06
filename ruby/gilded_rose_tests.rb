gem 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require File.join(File.dirname(__FILE__), 'gilded_rose')


class GildedRoseTest < Minitest::Test

  def test_generic_item_decrease_quality
    items = [Item.new("foo", 1, 1)]
    assert_equal items[0].quality, 1
    GildedRose.new(items).update_quality()
    assert_equal items[0].name, "foo"
    assert_equal items[0].quality, 0
  end

  def test_generic_item_min_quality_0
    items = [Item.new("foo", 1, 1)]
    assert_equal items[0].quality, 1
    GildedRose.new(items).update_quality()
    assert_equal items[0].name, "foo"
    assert_equal items[0].sell_in, 0
    assert_equal items[0].quality, 0
    GildedRose.new(items).update_quality()
    assert_equal items[0].name, "foo"
    assert_equal items[0].sell_in, -1
    assert_equal items[0].quality, 0
  end

  def test_generic_item_decrease_sell_in
    items = [Item.new("foo", 1, 1)]
    assert_equal items[0].sell_in, 1
    GildedRose.new(items).update_quality()
    assert_equal items[0].name, "foo"
    assert_equal items[0].sell_in, 0
  end

  def test_generic_item_loses_double_quality_passed_sell_in
    items = [Item.new("foo", 1, 10)]
    assert_equal items[0].sell_in, 1
    assert_equal items[0].quality, 10
    GildedRose.new(items).update_quality()
    assert_equal items[0].sell_in, 0
    assert_equal items[0].quality, 9
    GildedRose.new(items).update_quality()
    assert_equal items[0].sell_in, -1
    assert_equal items[0].quality, 7
  end

  def test_aged_brie_item_increase_quality_max_50
    items = [Item.new("Aged Brie", 4, 48)]
    assert_equal items[0].quality, 48
    assert_equal items[0].sell_in, 4
    GildedRose.new(items).update_quality()
    assert_equal items[0].quality, 49
    assert_equal items[0].sell_in, 3
    GildedRose.new(items).update_quality()
    assert_equal items[0].quality, 50
    assert_equal items[0].sell_in, 2
    GildedRose.new(items).update_quality()
    assert_equal items[0].quality, 50
    assert_equal items[0].sell_in, 1
    GildedRose.new(items).update_quality()
    assert_equal items[0].quality, 50
    assert_equal items[0].sell_in, 0
  end

  def test_concert_pass_increase_in_quality_each_day
    items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 15, 10)]
    assert_equal items[0].sell_in, 15
    assert_equal items[0].quality, 10
    GildedRose.new(items).update_quality()
    assert_equal items[0].sell_in, 14
    assert_equal items[0].quality, 11
  end

  def test_concert_pass_increase_2_quality_within_10_days
    items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 11, 10)]
    assert_equal items[0].sell_in, 11
    assert_equal items[0].quality, 10
    GildedRose.new(items).update_quality()
    assert_equal items[0].sell_in, 10
    assert_equal items[0].quality, 11
    GildedRose.new(items).update_quality()
    assert_equal items[0].sell_in, 9
    assert_equal items[0].quality, 13
    GildedRose.new(items).update_quality()
    assert_equal items[0].sell_in, 8
    assert_equal items[0].quality, 15
  end

  def test_concert_pass_increase_3_quality_within_5_days
    items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 6, 10)]
    assert_equal items[0].sell_in, 6
    assert_equal items[0].quality, 10
    GildedRose.new(items).update_quality()
    assert_equal items[0].sell_in, 5
    assert_equal items[0].quality, 12
    GildedRose.new(items).update_quality()
    assert_equal items[0].sell_in, 4
    assert_equal items[0].quality, 15
    GildedRose.new(items).update_quality()
    assert_equal items[0].sell_in, 3
    assert_equal items[0].quality, 18
  end

  def test_concert_pass_quality_to_0_after_concert
    items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 2, 10)]
    assert_equal items[0].sell_in, 2
    assert_equal items[0].quality, 10
    GildedRose.new(items).update_quality()
    assert_equal items[0].sell_in, 1
    assert_equal items[0].quality, 13
    GildedRose.new(items).update_quality()
    assert_equal items[0].sell_in, 0
    assert_equal items[0].quality, 16
    GildedRose.new(items).update_quality()
    assert_equal items[0].sell_in, -1
    assert_equal items[0].quality, 0
    GildedRose.new(items).update_quality()
    assert_equal items[0].sell_in, -2
    assert_equal items[0].quality, 0
  end

  def test_concert_pass_quality_not_to_exceed_50
    items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 10, 48)]
    assert_equal items[0].sell_in, 10
    assert_equal items[0].quality, 48
    GildedRose.new(items).update_quality()
    assert_equal items[0].sell_in, 9
    assert_equal items[0].quality, 50
    GildedRose.new(items).update_quality()
    assert_equal items[0].sell_in, 8
    assert_equal items[0].quality, 50
    GildedRose.new(items).update_quality()
    assert_equal items[0].sell_in, 7
    assert_equal items[0].quality, 50
  end

  def test_concert_pass_quality_not_to_exceed_50_different
    items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 10, 49)]
    assert_equal items[0].sell_in, 10
    assert_equal items[0].quality, 49
    GildedRose.new(items).update_quality()
    assert_equal items[0].sell_in, 9
    assert_equal items[0].quality, 50
    GildedRose.new(items).update_quality()
    assert_equal items[0].sell_in, 8
    assert_equal items[0].quality, 50
    GildedRose.new(items).update_quality()
    assert_equal items[0].sell_in, 7
    assert_equal items[0].quality, 50
  end

  def test_sulfuras_does_not_decrease_sell_in_or_quality
    items = [Item.new("Sulfuras, Hand of Ragnaros", 2, 10)]
    assert_equal items[0].sell_in, 2
    assert_equal items[0].quality, 10
    GildedRose.new(items).update_quality()
    assert_equal items[0].sell_in, 2
    assert_equal items[0].quality, 10
  end

end

class GildedRose

  def initialize(items)
    @items = items
  end

  def update_quality
    @items.each do |item|
      if item.name == "Sulfuras, Hand of Ragnaros"
        Sulfuras.new(item).update_quality
      elsif item.name == 'Aged Brie'
        AgedBrie.new(item).update_quality
      elsif item.name == "Backstage passes to a TAFKAL80ETC concert"
        Backstage.new(item).update_quality
      else
        Generic.new(item).update_quality
      end
    end
  end
end

class Sulfuras
  attr_reader :item
  def initialize(item)
    @item = item
  end

  def update_quality
    item
  end
end

class AgedBrie
  attr_reader :item
  def initialize(item)
    @item = item
  end

  def update_quality
    item.sell_in -= 1
    item.quality += 1 unless item.quality >= 50
  end
end

class Generic
  attr_reader :item
  def initialize(item)
    @item = item
  end

  def update_quality
    item.sell_in -= 1
    item.quality -= 1 if item.quality > 0
    if item.sell_in < 0
      item.quality -= 1 if item.quality > 0
    end
  end
end

class Backstage
  attr_reader :item
  def initialize(item)
    @item = item
  end

  def update_quality
    item.sell_in -= 1
    item.quality += 1 unless item.quality >= 50
    if item.sell_in < 10
      item.quality += 1 unless item.quality >= 50
    end
    if item.sell_in < 5
      item.quality += 1 unless item.quality >= 50
    end
    if item.sell_in < 0
      item.quality = 0
    end
  end
end

class Item
  attr_accessor :name, :sell_in, :quality

  def initialize(name, sell_in, quality)
    @name = name
    @sell_in = sell_in
    @quality = quality
  end

  def to_s()
    "#{@name}, #{@sell_in}, #{@quality}"
  end
end

##steps
## 1) write tests
# 2) shorten if/else statements
# 3) rewrite GildedRose sorted by item type

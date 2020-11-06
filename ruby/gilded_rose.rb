class GildedRose

  def initialize(items)
    @items = items
  end

  def update_quality
    @items.each do |item|
      item.sell_in -= 1
      if item.name == 'Aged Brie'
        item.quality += 1 unless item.quality >= 50
      elsif item.name == "Backstage passes to a TAFKAL80ETC concert"
        
      elsif item.name == "Sulfuras, Hand of Ragnaros"
      else
      end
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

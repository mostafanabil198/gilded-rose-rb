class GildedRose
  def initialize(items)
    @items = items
  end

  def update_quality
    @items.each do |item|
      if item.name != 'Aged Brie' && item.name != 'Backstage passes to a TAFKAL80ETC concert' && item.name != 'Sulfuras' && item.name != 'Hand of Ragnaros'
        if item.sell_in > 0
          x = 1
          x = 2 if item.name == 'Conjured'
          item.sell_in = item.sell_in - 1 if item.sell_in > 0
          item.quality = item.quality / 2 * x if item.sell_in == 0
          item.quality = item.quality - 1 * x if item.quality > 0 && item.sell_in != 0
        end
      elsif item.name == 'Aged Brie' || item.name == 'Backstage passes'
        if item.sell_in > 0
          item.sell_in = item.sell_in - 1
          item.quality = 0 if item.sell_in == 0
          if item.sell_in <= 5 && item.quality <= 47
            item.quality = item.quality + 3
          elsif item.sell_in <= 10 && item.quality <= 48
            item.quality = item.quality + 2
          elsif item.sell_in > 10 && item.quality <= 49
            item.quality = item.quality + 1
          end
        end
        item.quality = 0 if item.sell_in == 0
      elsif item.name == 'Conjured'

      end
    end
  end
end

class Item
  attr_accessor :name, :sell_in, :quality

  def initialize(name, sell_in, quality)
    @name = name
    @sell_in = sell_in
    if quality >= 0
      @quality = quality
    else
      raise ArgumentError.new("Quality cant be negative")
    end
  end

  def to_s()
    "#{@name}, #{@sell_in}, #{@quality}"
  end
end

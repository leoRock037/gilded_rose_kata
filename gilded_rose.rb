def update_quality(items)

  items.each do |item|
    if item.name != 'Aged Brie' && item.name != 'Backstage passes to a TAFKAL80ETC concert' && item.name != 'Sulfuras, Hand of Ragnaros'
      if item.quality > 0
        item.quality -= 1
      end
    else
      if item.quality < 50
        sum_one_quality(item)
        if item.name == 'Backstage passes to a TAFKAL80ETC concert'
          if item.sell_in < 11
            sum_one_quality(item)
          end
          if item.sell_in < 6
            sum_one_quality(item)
          end
        end
      end
    end
    if item.name != 'Sulfuras, Hand of Ragnaros'
      rest_one_sell_in(item)
    end
    if item.sell_in < 0
      if item.name != "Aged Brie"
        if item.name != 'Backstage passes to a TAFKAL80ETC concert'
          if item.quality > 0 && item.name != 'Sulfuras, Hand of Ragnaros'
            item.quality -= 1
          end
        else
          item.quality = 0
        end
      else
        if item.quality < 50
          sum_one_quality(item)
        end
      end
    end
  end
end

def sum_one_quality(item)
  item.quality += 1
end


def rest_one_sell_in(item)
  item.sell_in -= 1
end

# DO NOT CHANGE THINGS BELOW -----------------------------------------

Item = Struct.new(:name, :sell_in, :quality)

# We use the setup in the spec rather than the following for testing.
#
# Items = [
#   Item.new("+5 Dexterity Vest", 10, 20),
#   Item.new("Aged Brie", 2, 0),
#   Item.new("Elixir of the Mongoose", 5, 7),
#   Item.new("Sulfuras, Hand of Ragnaros", 0, 80),
#   Item.new("Backstage passes to a TAFKAL80ETC concert", 15, 20),
#   Item.new("Conjured Mana Cake", 3, 6),
# ]


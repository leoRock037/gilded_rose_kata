def update_quality(items)
  METHODS_NAME = {
    "quality_uper_than_zero" => {
      "+5 Dexterity Vest" => {rest_one_quality},
      "Elixir of the Mongoose" => {rest_one_quality},
      "Backstage passes to a TAFKAL80ETC concert" => {},
      "Conjured Mana Cake" => {rest_one_quality}
    },
    "quality_lower_than_50" => {
      "Aged Brie" => {},
      "Sulfuras, Hand of Ragnaros" => {},
      "Backstage passes to a TAFKAL80ETC concert" => {},
    }
  }

  items.each do |item|

    METHODS_NAME[evaluate_quality(item.quality)][item.name][item.sell_in]

    def evaluate_quality(quality)
      if quality > 0
        "quality_uper_than_zero"
      end
      if quality < 50
        "quality_lower_than_50"
      end
    end

    if item.name != 'Aged Brie' && item.name != 'Backstage passes to a TAFKAL80ETC concert' && item.name != 'Sulfuras, Hand of Ragnaros'
      if item.quality > 0
        rest_one_quality(item)
      end
    end


    if item.quality < 50
      if item.name == 'Aged Brie' || item.name == 'Sulfuras, Hand of Ragnaros'
        sum_one_quality(item)
      end
      if item.name == 'Backstage passes to a TAFKAL80ETC concert'
        sum_one_quality(item)
        if item.sell_in < 11
          sum_one_quality(item)
        end
        if item.sell_in < 6
          sum_one_quality(item)
        end
      end
    end

    rest_one_sell_in(item)

    if item.name == "Aged Brie" && item.sell_in < 0 && item.quality < 50
      sum_one_quality(item)
    end

    quality_eql_to_zero(item)

    if item.name != "Aged Brie" && item.sell_in < 0 && item.quality > 0 && item.name != 'Sulfuras, Hand of Ragnaros'
      rest_one_quality(item)
    end
  end
end

def sum_one_quality(item)
  item.quality += 1
end

def rest_one_quality(item)
  item.quality -= 1
end

def quality_eql_to_zero(item)
  if item.name == 'Backstage passes to a TAFKAL80ETC concert' && item.sell_in < 0
    item.quality = 0
  end
end

def rest_one_sell_in(item)
  if item.name != 'Sulfuras, Hand of Ragnaros'
    item.sell_in -= 1
  end
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


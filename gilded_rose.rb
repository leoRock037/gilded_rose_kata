VALUES_TO_QUALITY_LOWER_THAN_ZERO = {true => {true => -2, false => -1}, false => {true => 0, false => 0}}
VALUES_TO_A = {true => {true => 2, false => 1}, false => {true => 0, false => 0}}
VALUES_TO_S= {true => 1, false => 0}

def update_quality(items)
  items.each do |item|
    item.quality = item.quality + send("return_quality_value_to_#{item.name[0]}".to_sym) 
    item.sell_in -= 1
    if item.name == 'Sulfuras, Hand of Ragnaros'
      item.sell_in += 1
    end
    item.save
  end
end

def return_quality_value_to_5(item)
  VALUES_TO_QUALITY_LOWER_THAN_ZERO[quality_upper_than_zero(item)][sell_in_lower_than_zero(item)]
end

def return_quality_value_to_E(item)
  VALUES_TO_QUALITY_LOWER_THAN_ZERO[quality_upper_than_zero(item)][sell_in_lower_than_zero(item)]
end

def return_quality_value_to_C(item)
  VALUES_TO_QUALITY_LOWER_THAN_ZERO[quality_upper_than_zero(item)][sell_in_lower_than_zero(item)]
end

def return_quality_value_to_A(item)
  VALUES_TO_A[quality_lower_than_fifty(item)][sell_in_lower_than_zero(item)]
end

def return_quality_value_to_S(item)
  VALUES_TO_S[quality_lower_than_fifty(item)]
end

def return_quality_value_to_N(item)
  VALUES_TO_A[quality_lower_than_fifty(item)][sell_in_lower_than_zero(item)]
end

def return_quality_value_to_B(item)
  x = 0
  if item.quality < 50
    x =+1
    if item.sell_in < 11
      x =+1
    end
    if item.sell_in < 6
      x =+1
    end
  end
  if item.sell_in < 0 && item.quality > 0
    x =-1
  end
end





def quality_upper_than_zero(item)
  item.quality > 0
end

def quality_lower_than_fifty(item)
  item.quality < 50
end

def sell_in_lower_than_zero(item)
  item.sell_in < 0
end

def sell_in_lower_than_six(item)
  item.sell_in < 6
end

def sell_in_lower_than_eleven(item)
  item.sell_in < 11
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


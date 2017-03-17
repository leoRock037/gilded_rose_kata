def update_quality(items)
  items.each do |item|
    rest_one_quality_when_no_aged_no_sulfuras_no_backstage_and_quality_upper_than_zero(item)
    sum_one_quality_when_name_and_quality_lower_than_fifty(item, "Aged")
    sum_one_quality_when_name_and_quality_lower_than_fifty(item, "Sulfuras")
    sum_one_quality_when_name_and_quality_lower_than_fifty(item, "Backstage")
    sum_one_quality_when_backstage_and_quality_lower_than_fifty_and_sell_in_lower_than_number(item, 11)
    sum_one_quality_when_backstage_and_quality_lower_than_fifty_and_sell_in_lower_than_number(item, 6)
    rest_one_sell_in(item) 
    sum_one_quality_when_aged_sell_lower_than_zero_and_quality_lower_than_fifty(item)
    quality_eql_to_zero(item)
    rest_one_quality_when_no_aged_no_sulfuras_and_sell_lower_than_zero_and_quality_upper_than_zero(item)
  end
end

private

  def sum_one_quality_when_backstage_and_quality_lower_than_fifty_and_sell_in_lower_than_number(item, number)
    sum_one_quality(item) if quality_lower_than_fifty(item) && name_include?(item,'Backstage') && sell_in_lower_than(item, number)
  end

  def sum_one_quality_when_name_and_quality_lower_than_fifty(item, name)
    sum_one_quality(item) if quality_lower_than_fifty(item) && name_include?(item,name)
  end

  def rest_one_quality_when_no_aged_no_sulfuras_no_backstage_and_quality_upper_than_zero(item)
    rest_one_quality(item) if !name_include?(item,'Aged') && !name_include?(item,'Backstage') && !name_include?(item,'Sulfuras') && quality_upper_than_zero?(item)
  end

  def rest_one_quality_when_no_aged_no_sulfuras_and_sell_lower_than_zero_and_quality_upper_than_zero(item)
    rest_one_quality(item) if !name_include?(item,"Aged") && !name_include?(item,"Sulfuras") && sell_in_lower_than_zero?(item) && quality_upper_than_zero?(item)
  end

  def sum_one_quality_when_aged_sell_lower_than_zero_and_quality_lower_than_fifty(item)
    sum_one_quality(item) if name_include?(item,"Aged") && sell_in_lower_than_zero?(item) && quality_lower_than_fifty(item)
  end

  def name_include?(item, name)
    item.name.include?(name)
  end

  def sell_in_lower_than(item, number)
    item.sell_in < number
  end

  def quality_lower_than_fifty(item)
    item.quality < 50
  end

  def sell_in_lower_than_zero?(item)
    item.sell_in < 0
  end

  def quality_upper_than_zero?(item)
    item.quality > 0
  end

  def sum_one_quality(item)
    item.quality += 1
  end

  def rest_one_quality(item)
    item.quality -= 1
  end

  def quality_eql_to_zero(item)
    item.quality = 0 if name_include?(item, 'Backstage') && sell_in_lower_than_zero?(item)
  end

  def rest_one_sell_in(item)
    item.sell_in -= 1 if !name_include?(item,"Sulfuras")
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


#refactored by Cristian Benitez and David Arevalo

ZERO = 0
SIX = 6
ELEVEN = 11
FIFTY = 50
AGED = "Aged"
BACKSTAGE = "Backstage"
SULFURAS = "Sulfuras"
VALUE_TRUE = {true => 1, false => 0}
VALUE_TRUE_TRUE = {true => { true => 1, false => 0}, false => { true => 0, false => 0}}
VALUE_TRUE_TRUE_TRUE = {true => { true => {true => 1, false => 0}, false => {true => 0, false => 0}}, false => { true => {true => 0, false => 0}, false => {true => 0, false => 0}}}
VALUE_TRUE_TRUE_TRUE_TRUE = {true => { true => {true => { true => 1, false => 0}, false => {true => 0, false => 0}}, false => {true => {true => 0, false => 0}, false => {true => 0, false => 0}}}, false => { true => {true => {true => 0, false => 0}, false => {true => 0, false => 0}}, false => {true => {true => 0, false => 0}, false => {true => 0, false => 0}}}}

def update_quality(items)
  items.each do |item|
    rest_one_quality_when_no_three_names_and_quality_upper_than_number(item, AGED, BACKSTAGE, SULFURAS, ZERO)
    [AGED,SULFURAS,BACKSTAGE].each {|i| sum_one_quality_when_name_and_quality_lower_than_number(item, i, FIFTY)}
    [ELEVEN,SIX].each { |i| sum_one_quality_when_name_and_quality_lower_than_number_and_sell_in_lower_than_number(item, BACKSTAGE, FIFTY, i)}
    rest_one_sell_when_no_name(item,SULFURAS)
    sum_one_quality_when_name_and_quality_lower_than_number_and_sell_in_lower_than_number(item, AGED, FIFTY, ZERO)
    quality_eql_to_zero_when_name_and_sell_lower_than_number(item,BACKSTAGE,ZERO)
    rest_one_quality_when_no_two_names_and_quality_upper_than_number_and_sell_lower_than_number(item,AGED,SULFURAS,ZERO,ZERO)
  end
end

private

  def sum_one_quality_when_name_and_quality_lower_than_number_and_sell_in_lower_than_number(item,  name, q_number, s_number)
    item.quality += VALUE_TRUE_TRUE_TRUE[number_lower_than_number?(item.quality,q_number)][name_include?(item,name)][number_lower_than_number?(item.sell_in,s_number)]
  end

  def sum_one_quality_when_name_and_quality_lower_than_number(item, name, q_number)
    item.quality += VALUE_TRUE_TRUE[number_lower_than_number?(item.quality, q_number)][name_include?(item,name)]
  end

  def rest_one_quality_when_no_three_names_and_quality_upper_than_number(item, name_1, name_2, name_3, q_number)
    item.quality -= VALUE_TRUE_TRUE_TRUE_TRUE[!name_include?(item,name_1)][!name_include?(item,name_2)][!name_include?(item,name_3)][number_upper_than_number?(item.quality,q_number)]
  end

  def rest_one_quality_when_no_two_names_and_quality_upper_than_number_and_sell_lower_than_number(item,name_1,name_2,q_number,s_number)
    item.quality -= VALUE_TRUE_TRUE_TRUE_TRUE[!name_include?(item,name_1)][!name_include?(item,name_2)][number_lower_than_number?(item.sell_in,s_number)][number_upper_than_number?(item.quality,q_number)]
  end

  def rest_one_sell_when_no_name(item,name)
    item.sell_in -= VALUE_TRUE[!name_include?(item,name)]
  end

  def quality_eql_to_zero_when_name_and_sell_lower_than_number(item,name,s_number)
    item.quality = 0 if name_include?(item, name) && number_lower_than_number?(item.sell_in,s_number)
  end

  def name_include?(item, name)
    item.name.include?(name)
  end

  def number_lower_than_number?(number_a, number_b)
    number_a < number_b
  end

  def number_upper_than_number?(number_a, number_b)
    number_a > number_b
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


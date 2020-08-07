class Recipe
  # Syntatic sugar: creates two getter methods
  attr_reader :name, :description

  # Recipe.new(name, description)
  def initialize(name, description)
    # Instance variables are internal data
    # Not available from the outside
    @name = name
    @description = description
  end

  def to_csv_row
    [name, description]
  end

  def to_s
    "Name: #{name} | Description: #{description}"
  end

  # attr_reder crates methods like these:
  # def name
  #   @name
  # end

  # def description
  #   @description
  # end
end

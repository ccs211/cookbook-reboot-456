class Recipe
  # Syntatic sugar: creates two getter methods
  attr_reader :name, :description

  # Review.new(name, description)
  def initialize(name, description)
    # Instance variables are internal data
    # Not available from the outside
    @name = name
    @description = description
  end

  # attr_reder crates methods like these:
  # def name
  #   @name
  # end

  # def description
  #   @description
  # end
end

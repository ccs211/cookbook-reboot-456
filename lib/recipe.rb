class Recipe
  # Syntatic sugar: creates two getter methods
  attr_reader :name, :description, :prep_time

  # Recipe.new(name, description)
  # FIX Argument Order Dependency
  def initialize(attributes = {})
    # Instance variables are internal data
    # Not available from the outside
    @name = attributes[:name]
    @description = attributes[:description]
    @prep_time = attributes[:prep_time]
    # Setting a default value to @done
    @done = attributes[:done] || false
  end

  # Reader for Boolean value
  def done?
    @done
  end

  # Change state of @done
  def toggle_done!
    # false => true
    # true => false
    # if done?
    #   @done = false
    # else
    #   @done = true
    # end
    # Ternary Operator:
    # @done = done? ? false : true
    # Flipping a boolean
    @done = !@done
  end

  def to_csv_row
    [name, description, prep_time, done?]
  end

  def to_s
    "[#{done? ? 'X' : ' '}] Name: #{name} | Time: #{prep_time}"
  end

  # attr_reder crates methods like these:
  # def name
  #   @name
  # end

  # def description
  #   @description
  # end
end

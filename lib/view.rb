class View
  # Receives an Array of Recipes
  def display(recipes)
    recipes.each_with_index do |recipe, index|
      # puts "#{index + 1} - #{recipe.to_s}"
      puts "#{index + 1} - #{recipe.to_s}"
    end
  end

  def ask_for_attribute(attribute)
    puts "What's the #{attribute} of the recipe?"
    print "> "
    gets.chomp
  end

  def ask_for_index
    puts "What's the number of the recipe?"
    print "> "
    # Convert user input to a REAL index
    gets.chomp.to_i - 1
  end

  # Returns the user input as String
  def ask_for_ingredient
    puts "What ingredient do you want to search for?"
    print "> "
    gets.chomp
  end
end

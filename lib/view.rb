class View
  def display(recipes)
    recipes.each_with_index do |recipe, index|
      puts "#{index + 1} - #{recipe}"
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
end

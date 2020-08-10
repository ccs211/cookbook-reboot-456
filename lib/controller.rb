require_relative "view"
require_relative "scraper_service"

class Controller
  def initialize(cookbook)
    @cookbook = cookbook
    @view = View.new
  end

  def list
    display_recipes
  end

  def create
    # Ask the user for the name
    name = @view.ask_for_attribute(:name)
    # Ask th euser for the description
    description = @view.ask_for_attribute(:description)
    # Ask th euser for the description
    prep_time = @view.ask_for_attribute("prep time")
    # Instanciate a new Recipe
    # Recipe takes a hash of attributes
    attributes = {
      name: name,
      description: description,
      prep_time: prep_time
    }
    recipe = Recipe.new(attributes)
    # Tell the cookbook repo to add this new recipe
    @cookbook.add_recipe(recipe)
  end

  def destroy
    # Display the recipes
    display_recipes
    # Ask the user for an index
    index = @view.ask_for_index
    # Tell the cookbook to remove the recipe at that index
    @cookbook.remove_recipe(index)
  end

  def import
    # Ask a user for a keyword to search
    ingredient = @view.ask_for_ingredient

    # Scraper!
    # Make an HTTP request to the recipe’s website with our keyword
    # Parse the HTML document to extract the first 5 recipes suggested and store them in an Array
    recipes = ScraperService.new(ingredient).perform
    # Display them in an indexed list
    @view.display(recipes)
    # Ask the user which recipe they want to import (ask for an index)
    index = @view.ask_for_index
    # Add it to the Cookbook
    recipe = recipes[index]
    @cookbook.add_recipe(recipe)
  end

  def mark
    # Display recipes to User
    display_recipes
    # Ask the user to pick a recipe (with the number)
    # Store the number the user picked
    index = @view.ask_for_index
    # Find the recipe with the index that the User picked
    recipe = @cookbook.find(index)
    # Toggle the value of done in the recipe
    recipe.toggle_done!
    # Save the changes in the Repo
    @cookbook.save
  end

  private

  def display_recipes
    # Grabs all recipes from the cookbook
    recipes = @cookbook.all
    # Tell the view to display all recipes
    @view.display(recipes)
  end
end

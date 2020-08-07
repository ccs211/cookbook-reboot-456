require_relative "view"

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
    # Instanciate a new Recipe
    recipe = Recipe.new(name, description)
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

  private

  def display_recipes
    # Grabs all recipes from the cookbook
    recipes = @cookbook.all
    # Tell the view to display all recipes
    @view.display(recipes)
  end
end

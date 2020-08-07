# Repository

require_relative "recipe"
require "csv"
require "byebug"

class Cookbook
  def initialize(csv_filepath)
    @recipes = []
    @csv_filepath = csv_filepath
    load_csv
  end

  # Public Interface:
  # Methods callable from the outside
  # (this is how objects receive messages)

  # Getter
  def all
    @recipes
  end

  # Receives an instance of Recipe
  def add_recipe(recipe)
    @recipes << recipe
    save_csv
  end

  def remove_recipe(index)
    # Array CRUD: Delete by index
    @recipes.delete_at(index)
    save_csv
  end

  # Internal workings of a class
  # Not available from the outside
  private

  def load_csv
    CSV.foreach(@csv_filepath) do |row|
      # Read the data from the CSV row
      name = row.first
      description = row.last
      # Create a Recipe instance in-memory
      recipe = Recipe.new(name, description)
      @recipes << recipe
    end
  end

  def save_csv
    CSV.open(@csv_filepath, 'wb') do |csv|
      @recipes.each do |recipe|
        # The recipe knows how to convert itself
        # into a CSV row (Array with internal data)
        csv << recipe.to_csv_row
      end
    end
  end
end

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
    save
  end

  def remove_recipe(index)
    # Array CRUD: Delete by index
    @recipes.delete_at(index)
    save
  end

  # Should return a Recipe
  # with the right index
  def find(index)
    # Arrau CRUD: Read
    @recipes[index]
  end

  def save
    save_csv
  end

  # Internal workings of a class
  # Not available from the outside
  private

  def load_csv
    CSV.foreach(@csv_filepath) do |row|
      # Read the data from the CSV row

      # Converting the String "bolean" to a REAL boolean
      # done = row[3] == "true"

      attributes = {
        name: row[0],
        description: row[1],
        prep_time: row[2],
        done: row[3] == "true"
      }
      # Create a Recipe instance in-memory
      recipe = Recipe.new(attributes)
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

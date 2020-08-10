require 'open-uri'
require 'nokogiri'


# <a> => "a" | <div> => "div"
# <div class="bold"> => ".bold"
# <h1 id="title"> => "#title"
# <span class="bold text-center"> => "span.bold.text-center"

# This is only to help me
# code the scraper
require 'byebug'

require_relative "recipe"

# Service Objects are very common in Rails
# SO are usually implemented as PORO: Plain Old Ruby Objects
class ScraperService
  BASE_URL = "https://www.bbcgoodfood.com/search"

  # This needs a query/keyword/ingredient to build the url
  def initialize(query)
    @query = query
  end

  # This is the only Public Interface of
  # this Service Object
  # Returns an Array of Recipes
  def perform
    articles
  end

  private

  def url
    BASE_URL + "/recipes?query=#{@query}"
  end

  def html_file
    open(url).read
  end

  def page
    Nokogiri::HTML.parse(html_file)
  end

  # Returns an Array of Recipes
  def articles
    page.search(".view-content article")
        .take(5)
        .map { |article| parse_article(article) }
  end

  # Receives an article HTML element
  def parse_article(article)
    # Grab name from article HTML element
    name = article.search("h3 a").text.strip
    # Grab description from article HTML element
    description = article.search(".field-item").text.strip
    prep_time = article.search(".teaser-item__info-item--total-time").text.strip
    # Return a new Recipe instance
    Recipe.new(name, description, prep_time)
  end
end

# ScraperService.new("chocolate").perform






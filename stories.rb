require 'rest-client'
require 'json'

require_relative 'petition'
require_relative 'reddit_story'

puts "Welcome to Stories!"

while true

  puts "What kind of stories would you like to see?"
  puts "1. Open Petitions"
  puts "2. Top Reddit Stories"

  choice = gets.strip

  stories = []

  if choice == "1"
    url = "https://api.whitehouse.gov/v1/petitions.json?limit=10&status=open"
  elsif choice == "2"
    url = "http://www.reddit.com/top.json?limit=10"
  end

  response = RestClient.get(url)
  parsed_response = JSON.parse(response)

  if choice == "1"
    parsed_response["results"].each do |story|
      stories << Petition.new(story["title"], story["url"])
    end
  elsif choice == "2"
    parsed_response["data"]["children"].each do |story|
      stories << RedditStory.new(story["data"]["title"], story["data"]["url"])
    end
  end

  # print out ANY stories
  stories.each_with_index do |story, index|
    puts "#{index+1}. #{story.title}: #{story.url}"
  end

  puts "Would you like to see more stories? (Y/N)"

  break unless gets.strip == "Y"
end
require_relative 'story'

class Petition < Story
  def initialize(title, url)
    @title = title
    @url = url
  end

  def sign
    # sign the petition
  end
end
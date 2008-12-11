module Qype

  class Link
    include HappyMapper

    tag 'link'

    attribute :href, String
    attribute :hreflang, String
    attribute :title, String
    attribute :rel, String
    attribute :count, Integer
  end

  class Category
    include HappyMapper

    tag 'category'

    element :title, String
  end

  class Image
    include HappyMapper

    tag 'image'

    attribute :small, String
    attribute :medium, String
    attribute :large, String
  end

  class Address
    include HappyMapper

    tag 'address'

    element :street, String
    element :postcode, String
    element :housenumber, String
    element :city, String
  end

  class Place
    include HappyMapper

    tag 'place'

    element :title, String
    element :phone, String
    element :average_rating, Float
    element :point, String

    has_one :image, Image
    has_one :address, Address
    has_many :categories, Category
    has_many :links, Link

    def reviews(client, language_code)
      link = self.links.find { |link| link.rel == 'http://schemas.qype.com/reviews' && link.hreflang == language_code }
      throw :language_not_supported if link.nil?

      response = client.get(link.href)
      Review.parse(response)
    end

    def self.get(client, place_id)
      response = client.get("/places/#{place_id}")
      parse(response, :single => true)
    end

    def self.search(client, search_term, location_name)
      response = client.get('/places', :query => { :show => search_term, :in => location_name })
      Place.parse(response)
    end

    # options can be
    #   :show => search_term            show places matching this search term
    #   :in_category => category_id     only show places in a specific category 
    #   :order => order                 order results by: 'distance' (default), 'rating'
    #
    def self.nearby(client, latitude, longitude, options = {})
      response = client.get("/positions/#{latitude},#{longitude}/places", :query => options)
      Place.parse(response)
    end

  end

  class Tag
    include HappyMapper

    tag 'tag'

    attribute :term, String
  end

  class Review
    include HappyMapper

    tag 'review'

    element :rating, Integer
    element :language, String
    element :content, String, :tag => "content[@type='text']"
    element :formatted_content, String, :tag => "content[@type='xhtml']"

    has_many :tags, Tag
    has_many :links, Link
  end

  class User
    include HappyMapper

    tag 'user'

    element :title, String
    element :points, Integer
    element :language, String
    element :level, String

    has_many :links, Link

    def self.get(client, user_id)
      response = client.get("/users/#{user_id}")
      parse(response, :single => true)
    end

    # options can be
    #   :in_category => category_id     only show reviews written for places in this category 
    #   :tagged_with => tag             only show reviews tagged with a specific tag
    #   :order => order                 order results by: 'date_created', 'date_updated' or 'rating'
    #
    def reviews(client, options = {})
      link = self.links.find { |link| link.rel == 'http://schemas.qype.com/reviews' }
      throw :reviews_not_found if link.nil?

      response = client.get(link.href, :query => options)
      Review.parse(response)
    end
  end

end
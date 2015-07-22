require_relative '../../config/instagram'
require_relative 'image'

module Fetch
	
  def self.popular_media
    client = Instagram.client()
	for media_item in client.media_popular
	  begin
	    Image.create(
		  :instagram_id => media_item.id,
		  :link => media_item.link,
		  :image => media_item.images.standard_resolution.url,
		  :date => media_item.created_time,
		  :likes => media_item.likes[:count])
	    puts '.'
	  rescue Sequel::UniqueConstraintViolation => e
	    puts "caught exception #{e}! ohnoes!"
	  end
    end
  end
end
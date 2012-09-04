require 'open-uri'
class Listing < ActiveRecord::Base
  attr_accessible :beds, :date, :description, :link, :price, :price_and_sqft, :price_per_sqft, :gmap_url
  
  validates_uniqueness_of :description, :link
  
  def self.get_listings #I need to refactor this... badly
    doc = Nokogiri::HTML(open('http://sfbay.craigslist.org/search/apa/sfc?query=&srchType=A&minAsk=&maxAsk=&bedrooms=3&addTwo=purrr&hasPic=1'))

    doc.css('p').each do |listing| 
      @new_list = Listing.new
      date = listing.css("span")[1].content
      price_and_sqft = listing.css("span")[4].content
      split_str = price_and_sqft.split(" ")
      price = split_str[0].gsub(/[$]/, "").to_f
      beds = split_str[2].split(//)[0].to_i
      price_per_bedroom = price/beds
      link = listing.css("a")[0]['href']
      description = listing.css("a")[0].content
      location = listing.css("span")[6].content.gsub(/[()]/, "")
      
      doc2 = Nokogiri::HTML(open(link))

      if !doc2.xpath('//*[@id="userbody"]/comment()[2]').to_s.include?('END')
        street1 = doc2.xpath('//*[@id="userbody"]/comment()[2]')
        street1 = street1.to_s.match(/[=](.*?)[->]/)[1]
        street2 = doc2.xpath('//*[@id="userbody"]/comment()[3]')
        street2 = street2.to_s.match(/[=](.*?)[->]/)[1]
        city = doc2.xpath('//*[@id="userbody"]/comment()[4]')
        city = city.to_s.match(/[=](.*?)[->]/)[1]
        state = doc2.xpath('//*[@id="userbody"]/comment()[5]')
        state = state.to_s.match(/[=](.*?)[->]/)[1]
        @new_list.gmap_url = "https://maps.google.com/maps?q=#{street1}+at+#{street2}+#{city}+#{state}&ie=UTF-8&hl=en"
      end
      
      @new_list.date = date
      @new_list.description = description
      @new_list.price_per_bedroom = price_per_bedroom
      @new_list.beds = beds
      @new_list.price = price
      @new_list.link = link
      @new_list.location = location
      @new_list.save
    end
  end

end

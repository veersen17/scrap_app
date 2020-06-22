class WebScrapper

	def initialize()
		@browser = Watir::Browser.new		
		
	end 
	def set_scraping_data (site_url,city)

		@browser.goto site_url	
		@browser.text_field(id: 'autoComplete__home').set city
		@browser.div(class: 'geoSuggestionsList__container').divs.first.click
		@browser.button(class: 'searchButton--home').click
		@browser.div(:class => 'hotelCardListing__descriptionWrapper').wait_until(&:present?)
		
		#@browser.text_field(id: 'bigsearch-query-attached-query').set 'Goa'
		#@browser.button(data_testid: 'structured-search-input-field-split-dates-0').click		
		#@browser.button(data_testid: 'structured-search-input-field-split-dates-1').click		
		#@browser.div(data_testid: 'structured-search-input-field-dates-panel').wait_until(&:present?)		
		#@browser.button(data_testid: 'structured-search-input-search-button').click
		
		#@browser.button(class: '_3h0uzoe').click		
		process_data
		close_browser
	end			

	def process_data		
	   hotel_data=Array.new
	  
		@browser.divs(class: 'hotelCardListing__descriptionWrapper').each do |hotel|
			temp_hotel_data = Hash.new		
			temp_hotel_data['title']=hotel.h3.text
			price=hotel.span(class: 'listingPrice__finalPrice').text
			near_by=hotel.span(class: 'u-line--clamp-2').text
			discount_percentage=hotel.span(class: 'listingPrice__percentage').text
			description= "Price:#{price}|DiscountPercentage:#{discount_percentage}|NearByLocation#{near_by} "
			temp_hotel_data['data'] = description	
			hotel_data << temp_hotel_data unless temp_hotel_data.empty?		
		end	

		if !hotel_data.empty? && Scrap.create(hotel_data)
			puts "Records added successfully"
		else
			puts "Failed to Add the records"
		end
	end

	def close_browser
		@browser.close
	end

end
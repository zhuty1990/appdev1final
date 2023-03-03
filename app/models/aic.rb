class Aic
  
  attr_accessor :title
  attr_accessor :artist
  attr_accessor :style
  attr_accessor :medium
  attr_accessor :year
  attr_accessor :place_of_origin
  attr_accessor :image
  attr_accessor :aic_id


  require "open-uri"
  
  def Aic.search(input)
    
    search_term = input.to_s.strip.squeeze(" ").gsub(" ","+")
    results_limit = 40
    url = "https://api.artic.edu/api/v1/artworks/search?q=#{search_term}&limit=#{results_limit}&fields=id,title,artist_title,style_title,place_of_origin,artwork_type_title,date_display,image_id"  
    raw_search_data = URI.open(url).read
    parsed_search_data = JSON.parse(raw_search_data)["data"]
    iiif_url = JSON.parse(raw_search_data)["config"]["iiif_url"]
    iiif_hash = {"iiif_url" => iiif_url}

    results_count = parsed_search_data.count
    rand_limit = results_count + 1
    random1 = rand(rand_limit)
    random2 = rand(rand_limit)
    
    while random2 == random1
      random2 = rand(rand_limit)
    end
    
    first_result = parsed_search_data[random1].merge(iiif_hash)
    second_result = parsed_search_data[random2].merge(iiif_hash)

    first_result.transform_values do |value|
      value.presence || 'None'
    end
   
    second_result.transform_values do |value|
      value.presence || 'None'
    end
       
    output = Array.new
    output.push(first_result)
    output.push(second_result)
        
    return output
  end

  def Aic.parse(data)
    artwork = Aic.new
    artwork.title = data["title"]
    artwork.artist = data["artist_title"]
    artwork.style = data["style_title"]
    artwork.medium = data["artwork_type_title"] 
    artwork.year = data["date_display"]
    artwork.place_of_origin = data["place_of_origin"]
    
    image_id = data["image_id"]
    iiif_url = data["iiif_url"]
    artwork.image = "https://www.artic.edu/iiif/2/#{image_id}/full/843,/0/default.jpg"
    
    artwork.aic_id = data["id"]

    return artwork
  
  end

end

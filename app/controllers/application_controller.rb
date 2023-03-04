class ApplicationController < ActionController::Base
  def test
    search_term = "birds"
    test = Aic.search(search_term)
    @test_array = Array.new
    
    test.each do |result|
      data = Aic.parse(result)
      @test_array.push(data)
    end

    render({:template => "test.html.erb"})
  end

  def search_category
    categories_hash = {:artist => "artist_title", :title => "title", :style => "style_id", :medium => "artwork_type_id", :year => "date_display", :place_of_origin => "place_of_origin"}
    search_category = params["category"].to_sym
    search_category = categories_hash[search_category]
    search_term = params["search_term"]

    @search_result = Aic.category_search(search_category, search_term)
   

    render({:template => "test_search.html.erb"})

  end

end

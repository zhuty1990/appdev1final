class SearchController < ActionController::Base
  layout ("application")

  def index
    @medium_hash = Aic.getmediums
    render({ :template => "/search/index.html.erb" })
  end

  def search_general
    @search_term = params["search_input"]
    search_data = Aic.search(@search_term)
    @result_array = Array.new

    if search_data.empty?
      @result_array = "There is nothing here ..."
    else
      search_data.each do |result|
        data = Aic.parse(result)
        @result_array.push(data)
      end
    end

    last_views_aicids = Array.new
    @result_array.each do |artwork|
      last_views_aicids.push(artwork.aic_id)
    end

    session[:artwork_id_1] = last_views_aicids[0]
    session[:artwork_id_2] = last_views_aicids[1]

    render({ :template => "/search/results.html.erb" })
  end

  def search_category
    categories_hash = { :artist => "artist_title", :title => "title", :style => "style_id", :medium => "artwork_type_id", :year => "date_end", :place_of_origin => "place_of_origin" }
    search_category = params["category"].to_sym
    search_category = categories_hash[search_category]
    @search_term = params["search_term"]

    @result_array = Array.new

    if search_category == "place_of_origin" || search_category == "artist_title"
      search_data = Aic.search("\"#{@search_term}\"")
    else
      search_data = Aic.category_search(search_category, @search_term)
    end

    if search_data.empty?
      @result_array = "There is nothing here ..."
    else
      search_data.each do |result|
        data = Aic.parse(result)
        @result_array.push(data)
      end
    end

    last_views_aicids = Array.new
    @result_array.each do |artwork|
      last_views_aicids.push(artwork.aic_id)
    end

    session[:artwork_id_1] = last_views_aicids[0]
    session[:artwork_id_2] = last_views_aicids[1]

    render({ :template => "/search/results.html.erb" })
  end

  def last_view
    @result_array = Array.new
    data_1 = Aic.getdatafromid(session[:artwork_id_1])
    data_2 = Aic.getdatafromid(session[:artwork_id_2])
    artwork_1 = Aic.parse(data_1)
    artwork_2 = Aic.parse(data_2)

    @result_array.push(artwork_1, artwork_2)
    
    render({ :template => "/search/results.html.erb" })
  end
end

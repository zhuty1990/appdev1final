class ApplicationController < ActionController::Base
  before_action(:load_current_user)
  
  # Uncomment line 5 in this file and line 3 in UserAuthenticationController if you want to force users to sign in before any other actions.
  # before_action(:force_user_sign_in)
  
  def load_current_user
    the_id = session[:user_id]
    
    @current_user = User.where({ :id => the_id }).first
  end
  
  def force_user_sign_in
    if @current_user == nil
      redirect_to("/user_sign_in", { :notice => "You have to sign in first." })
    end
  end

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

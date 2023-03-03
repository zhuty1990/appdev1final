class ApplicationController < ActionController::Base
  def test
    search_term = "women"
    test = Aic.search(search_term)
    @test_array = Array.new
    
    test.each do |result|
      data = Aic.parse(result)
      @test_array.push(data)
    end

    render({:template => "test.html.erb"})
  end
end

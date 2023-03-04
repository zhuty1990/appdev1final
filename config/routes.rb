Rails.application.routes.draw do
  
  
  get("/", {:controller => "application", :action => "test"})
  get("/:category/:search_term", {:controller => "application", :action => "search_category"})


end

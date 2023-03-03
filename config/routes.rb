Rails.application.routes.draw do
  
  
  get("/", {:controller => "application", :action => "test"})


end

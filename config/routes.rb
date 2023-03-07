Rails.application.routes.draw do

  # Routes for Search functions:

  get("/", { :controller => "search", :action => "index" })
  get("/search", { :controller => "search", :action => "search_general" })
  get("/search-last-view", { :controller => "search", :action => "last_view" })
  get("/search/:category/:search_term", { :controller => "search", :action => "search_category" })

  # Routes for the Bookmark resource:

  # CREATE
  post("/insert_bookmark", { :controller => "bookmarks", :action => "create" })

  # READ
  get("/bookmarks", { :controller => "bookmarks", :action => "index" })

  get("/bookmarks/:path_id", { :controller => "bookmarks", :action => "show" })

  # UPDATE

  post("/modify_bookmark/:path_id", { :controller => "bookmarks", :action => "update" })

  # DELETE
  get("/delete_bookmark/:path_id", { :controller => "bookmarks", :action => "destroy" })

  #------------------------------

  # Routes for the User account:

  # SIGN UP FORM
  get("/user_sign_up", { :controller => "user_authentication", :action => "sign_up_form" })
  # CREATE RECORD
  post("/insert_user", { :controller => "user_authentication", :action => "create" })

  # EDIT PROFILE FORM
  get("/edit_user_profile", { :controller => "user_authentication", :action => "edit_profile_form" })
  # UPDATE RECORD
  post("/modify_user", { :controller => "user_authentication", :action => "update" })

  # DELETE RECORD
  get("/cancel_user_account", { :controller => "user_authentication", :action => "destroy" })

  # ------------------------------

  # SIGN IN FORM
  get("/user_sign_in", { :controller => "user_authentication", :action => "sign_in_form" })
  # AUTHENTICATE AND STORE COOKIE
  post("/user_verify_credentials", { :controller => "user_authentication", :action => "create_cookie" })

  # SIGN OUT
  get("/user_sign_out", { :controller => "user_authentication", :action => "destroy_cookies" })

  #------------------------------

end

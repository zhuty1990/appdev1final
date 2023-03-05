class BookmarksController < ApplicationController
  def index
    matching_bookmarks = Bookmark.all

    @list_of_bookmarks = matching_bookmarks.order({ :created_at => :desc })

    render({ :template => "bookmarks/index.html.erb" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_bookmarks = Bookmark.where({ :id => the_id })

    @the_bookmark = matching_bookmarks.at(0)

    render({ :template => "bookmarks/show.html.erb" })
  end

  def create
    aic_id = params["aic_id"]
    title = params["title"]
    artist = params["artist"]
    image_url = params["image"]
    medium = params["medium"]
    medium_id = params["medium_id"]
    style = params["style"]
    style_id = params["style_id"]
    date_display = params["year"]
    place_of_origin = params["place_of_origin"]
    copyright_notice = params["copyright_notice"]
    the_user = User.where({:id => session[:user_id]})[0]
    
    if Artwork.where({:aic_id => aic_id})[0].blank?
      the_artwork = Artwork.new
      the_artwork.title = title
      the_artwork.artist_title = artist
      the_artwork.style = style
      the_artwork.style_id = style_id
      the_artwork.medium = medium
      the_artwork.medium_id = medium_id
      the_artwork.year = date_display
      the_artwork.place_of_origin = place_of_origin
      the_artwork.image = image_url
      the_artwork.copyright_notice = copyright_notice
      the_artwork.aic_id = aic_id

      if the_artwork.valid?
        the_artwork.save
      redirect_to("/search", { :notice => "Artwork created successfully." })
      else
      redirect_to("/search", { :alert => the_artwork.errors.full_messages.to_sentence })
      end
    end
    
    the_bookmark = Bookmark.new
    the_bookmark.user_id = session[:user_id]
    the_bookmark.artwork_id = Artwork.where({:aic_id => aic_id})[0].id
    the_bookmark.aic_id = aic_id

    if the_bookmark.valid?
      the_bookmark.save
      redirect_to("/bookmarks", { :notice => "Bookmark created successfully." })
    else
      redirect_to("/bookmarks", { :alert => the_bookmark.errors.full_messages.to_sentence })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_bookmark = Bookmark.where({ :id => the_id }).at(0)

    the_bookmark.user_id = params.fetch("query_user_id")
    the_bookmark.artwork_id = params.fetch("query_artwork_id")

    if the_bookmark.valid?
      the_bookmark.save
      redirect_to("/bookmarks/#{the_bookmark.id}", { :notice => "Bookmark updated successfully."} )
    else
      redirect_to("/bookmarks/#{the_bookmark.id}", { :alert => the_bookmark.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_bookmark = Bookmark.where({ :id => the_id }).at(0)

    the_bookmark.destroy

    redirect_to("/bookmarks", { :notice => "Bookmark deleted successfully."} )
  end
end

class ArtworksController < ApplicationController
  def index
    matching_artworks = Artwork.all

    @list_of_artworks = matching_artworks.order({ :created_at => :desc })

    render({ :template => "artworks/index.html.erb" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_artworks = Artwork.where({ :id => the_id })

    @the_artwork = matching_artworks.at(0)

    render({ :template => "artworks/show.html.erb" })
  end

  def create
    the_artwork = Artwork.new
    the_artwork.title = params.fetch("query_title")
    the_artwork.artist_title = params.fetch("query_artist_title")
    the_artwork.style = params.fetch("query_style")
    the_artwork.style_id = params.fetch("query_style_id")
    the_artwork.medium = params.fetch("query_medium")
    the_artwork.medium_id = params.fetch("query_medium_id")
    the_artwork.year = params.fetch("query_year")
    the_artwork.place_of_origin = params.fetch("query_place_of_origin")
    the_artwork.image = params.fetch("query_image")

    if the_artwork.valid?
      the_artwork.save
      redirect_to("/artworks", { :notice => "Artwork created successfully." })
    else
      redirect_to("/artworks", { :alert => the_artwork.errors.full_messages.to_sentence })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_artwork = Artwork.where({ :id => the_id }).at(0)

    the_artwork.title = params.fetch("query_title")
    the_artwork.artist_title = params.fetch("query_artist_title")
    the_artwork.style = params.fetch("query_style")
    the_artwork.style_id = params.fetch("query_style_id")
    the_artwork.medium = params.fetch("query_medium")
    the_artwork.medium_id = params.fetch("query_medium_id")
    the_artwork.year = params.fetch("query_year")
    the_artwork.place_of_origin = params.fetch("query_place_of_origin")
    the_artwork.image = params.fetch("query_image")

    if the_artwork.valid?
      the_artwork.save
      redirect_to("/artworks/#{the_artwork.id}", { :notice => "Artwork updated successfully."} )
    else
      redirect_to("/artworks/#{the_artwork.id}", { :alert => the_artwork.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_artwork = Artwork.where({ :id => the_id }).at(0)

    the_artwork.destroy

    redirect_to("/artworks", { :notice => "Artwork deleted successfully."} )
  end
end

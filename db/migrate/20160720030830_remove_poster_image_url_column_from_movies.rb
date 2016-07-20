class RemovePosterImageUrlColumnFromMovies < ActiveRecord::Migration[5.0]
  def change
    remove_column :movies, :poster_image_url
  end
end

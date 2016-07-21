class MoviesController < ApplicationController
  # Prepares the @movie object before calling the listed functions
  before_action :set_movie, only: [:show, :edit, :update, :destroy]

  def index
    p params
    @movies = Movie.all
  end

  def show
  end

  def new
    @movie = Movie.new
  end

  def create
    @movie = Movie.new(movie_params)

    if @movie.save
      redirect_to movies_path, notice: "#{@movie.title} was submitted successfully!"
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @movie.update_attributes(movie_params)
    redirect_to movie_path(@movie)
    else
      render :edit
    end
  end

  def destroy
    @movie.destroy
    redirect_to movies_path
  end
  
  protected

  def set_movie
    @movie = Movie.find(params[:id])
  end

  def movie_params
    params.require(:movie).permit(:title, :release_date, :director, :runtime_in_minutes, :image, :description
    )
  end
end

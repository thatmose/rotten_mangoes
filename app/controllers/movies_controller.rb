class MoviesController < ApplicationController
  # Prepares the @movie object before calling the listed functions
  before_action :set_movie, only: [:show, :edit, :update, :destroy]

  def index
    @movies = Movie.all
    if params[:commit] && params[:commit] == "Search"
      @movies = @movies.title_director_like(params[:q].strip) unless params[:q].strip.nil?
      case params[:duration]
      when "1"
        @movies = @movies.duration_less_than_90
      when "2"
        @movies = @movies.duration_btn_90_120
      when "3"
        @movies = @movies.duration_greater_than_120
      else
        @movies
      end
    end
    @movies = @movies.page(params[:page]).per(10)
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

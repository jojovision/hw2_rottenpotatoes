class MoviesController < ApplicationController

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    @all_ratings = Hash.new
    Movie.getRatings().each { |rating| @all_ratings[rating] = false }
    
    @userratings = params[:ratings]
    if @userratings != nil and @userratings.keys != []
        @userratings.keys.each { |rating| @all_ratings[rating] = true }
        @movies = Movie.where( :rating => @userratings.keys )
    else
        @movies = Movie.where([])
    end   
   
    @hilite="";
    @usersortby = params[:sortby] 
    if @usersortby 
      @movies = @movies.order( @usersortby ) 
      @hilite = @usersortby
    end
    
   

    
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

end

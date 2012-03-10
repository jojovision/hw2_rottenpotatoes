class MoviesController < ApplicationController

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
     @movies = Movie.all
     
     sortby = params[:sortby] # retrieve movie ID from URI route
    userratings = params[:ratings]
    if userratings != nil
      userratings = userratings.keys
      if userratings != []
        @movies = Movie.find( :all, :conditions => { :rating => userratings } )
      end
    end
    
      
   
    @hilite="";
    if sortby == 'title'
      @movies.sort_by! { |m| m.title }
      @hilite = 'title'
    elsif sortby == 'release_date'
      @hilite = 'release_date'
    end
    
    @all_ratings = Movie.getRatings()

    
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

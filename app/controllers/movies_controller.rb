class MoviesController < ApplicationController

  caches_page :show, :top, :index

  respond_to :json, :xml

  def index
    respond_with Movie.search(params[:term])
  end

  def top
    respond_with Movie.top_250
  end

  def show
    respond_with Movie.new(params[:id])
  end

end
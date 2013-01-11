class MoviesController < ApplicationController

  respond_to :json, :xml

  def index
    respond_with Movie.search(params[:term])
  end

  def show
    respond_with Movie.new(params[:id])
  end

end
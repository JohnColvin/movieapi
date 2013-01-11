class MoviesController < ApplicationController

  respond_to :json, :xml

  def index
    respond_with Movie.search(params[:term])
  end

  def top
    respond_with Movie.top_250(params[:page] || 1)
  end

  def show
    respond_with Movie.new(params[:id])
  end

end
class MoviesController < ApplicationController

  respond_to :json, :xml

  def show
    respond_with Movie.new(params[:id])
  end

end
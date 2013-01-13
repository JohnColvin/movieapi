class MoviesController < ApplicationController

  caches_action :show, :top250, :index

  respond_to :json, :xml

  def index
    respond_with Movie.search(params[:term])
  end

  def top250
    respond_to do |format|
      format.xml { respond_with [] }
      format.json { respond_with Movie.top_250 }
    end
  end

  def show
    respond_with Movie.new(params[:id])
  end

end
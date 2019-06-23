class PicsController < ApplicationController
  # index route
  def index
    render json: Pic.all
  end

  #show route
  def show
    render json: Pic.find(params["id"])
  end

  # create route
  def create
    render json: Pic.create(params["pic"])
  end

  # delete route
  def delete
    render json: Pic.delete(params["id"])
  end

  # update route
  def update
    render json: Pic.update(params["id"], params["pic"])
  end
end

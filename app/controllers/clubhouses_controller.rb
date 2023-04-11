class ClubhousesController < ApplicationController
  def new; end

  def create; end

  def index
    @clubhouses = Clubhouse.all
  end

  def show
    @clubhouse = Clubhouse.find(params[:id])
  end

  def edit; end

  def update; end

  def delete; end

  def destroy; end
end

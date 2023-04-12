class ClubhousesController < ApplicationController
  def index
    @clubhouses = Clubhouse.all
  end

  def new
    @clubhouse = Clubhouse.new
  end

  def create; end
end

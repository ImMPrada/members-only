class ClubhousesController < ApplicationController
  def index
    @clubhouses = Clubhouse.all
  end
end

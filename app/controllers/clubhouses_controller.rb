class ClubhousesController < ApplicationController
  before_action :authenticate_user!, only: %i[new create]

  def index
    @clubhouses = Clubhouse.all
  end

  def new
    @clubhouse = Clubhouse.new
  end

  def create
    @clubhouse = Clubhouse.new(clubhouse_params)

    if @clubhouse.save
      Membership.create(
        user: current_user,
        clubhouse: @clubhouse,
        role: 'owner'
      )

      redirect_to user_path(current_user)
    else
      render :new
    end
  end

  private

  def clubhouse_params
    params.require(:clubhouse).permit(:title, :description)
  end
end

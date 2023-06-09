class ClubhousesController < ApplicationController
  before_action :authenticate_user!, only: %i[new create destroy]

  def index
    @clubhouses = Clubhouse.all
  end

  def show
    @clubhouse = Clubhouse.find(params[:id])
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

      respond_to { |format| update_clubhouses_list(format) }
    else
      respond_to do |format|
        format.html { render :new, notice: 'Clubhouse was not created.' }
      end
    end
  end

  private

  def clubhouse_params
    params.require(:clubhouse).permit(:title, :description)
  end

  def update_clubhouses_list(format)
    format.turbo_stream do
      render turbo_stream: [
        turbo_stream.prepend(:clubhouses_list,
                             partial: 'partials/clubhouses/card',
                             locals: { clubhouse: @clubhouse }),
        turbo_stream.update(:new_clubhouse_form, '')
      ]
    end
    format.html { redirect_to user_path(current_user), notice: 'Clubhouse was successfully created.' }
  end
end

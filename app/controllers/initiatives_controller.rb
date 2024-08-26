# frozen_string_literal: true

class InitiativesController < ApplicationController
  before_action :set_initiative, only: %i[show destroy update]

  def index
    @initiatives = Initiative.all
  end

  # POST
  def create
    @initiative = Initiative.new(initiative_params)
    if @initiative.save
      # TODO: jbuilder partials here too?
      render json: @initiative.as_json(include: {
                                         owner: { only: [:id] },
                                         parent: { only: [:id] }
                                       }), status: :created, location: @initiative
    else
      render json: @initiative.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT
  def update
    if @initiative.update(initiative_params)
      # TODO: jbuilder partials here too?
      render json: @initiative.as_json(include: {
                                         owner: { only: [:id] },
                                         parent: { only: [:id] }
                                       })
    else
      render json: @initiative.errors, status: :unprocessable_entity
    end
  end

  # DELETE
  def destroy
    @initiative.destroy
  end

  private

  def set_initiative
    @initiative = Initiative.find(params[:id])
  end

  def initiative_params
    params
      .require(:initiative)
      .permit(:title, :description, :startdate, :owner_id, :parent_id)
  end
end

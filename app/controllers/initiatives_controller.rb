# frozen_string_literal: true

class InitiativesController < ApplicationController
  before_action :set_initiative, only: %i[show destroy update]

  def index
    render json: Initiative.all.as_json(include: {
                                          helpers: { only: [:id] },
                                          source: { only: [:id] },
                                          parent: { only: [:id] }
                                        })
  end

  def show
    render json: @initiative.as_json(include: {
                                       helpers: { only: [:id] },
                                       source: { only: [:id] },
                                       parent: { only: [:id] }
                                     })
  end

  # POST
  def create
    @initiative = Initiative.new(initiative_params)
    if @initiative.save
      render json: @initiative, status: :created, location: @initiative
    else
      render json: @initiative.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT
  def update
    if @initiative.update(initiative_params)
      render json: @initiative
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
    @initiative_id = params[:id]
    @initiative = Initiative.find(@initiative_id)
  end

  def initiative_params
    params
      .require(:initiative)
      .permit(:title, :description, :startdate, :source_id, :parent_id)
  end
end

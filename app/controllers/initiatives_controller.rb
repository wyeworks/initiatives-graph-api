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
    @initiative = Initiative.new(hydrated_params)
    if @initiative.save
      render json: @initiative, status: :created, location: @initiative
    else
      render json: @initiative.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT
  def update
    if @initiative.update(hydrated_params)
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

  def hydrated_params
    # debugger
    initiative_params = params
                        .permit(%w[title description startdate id], helpers: [:id], source: [:id], parent: [:id])
                        .except(:id)

    initiative_params[:source] &&= Wyeworker.find(initiative_params[:source][:id])

    initiative_params[:helpers] &&= Wyeworker.find(initiative_params[:helpers].map { |helper| helper[:id] })

    initiative_params[:parent] &&= Initiative.find(initiative_params[:parent[:id]])

    initiative_params.except(:id)
  end
end

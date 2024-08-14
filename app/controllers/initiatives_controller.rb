# frozen_string_literal: true

class InitiativesController < ApplicationController
  before_action :set_initiative, only: %i[show destroy update]
  before_action :explain_no_source_editing, only: %i[update]

  def index
    render json: Initiative.all
  end

  def show
    render json: @initiative
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
    initiative_params = params
                        .require(:initiative)
                        .permit(%w[title description startdate parent source id], helpers: [])
    initiative_params[:source] = Wyeworker.find(initiative_params[:source])

    initiative_params[:helpers] &&= Wyeworker.find(initiative_params[:helpers])

    initiative_params[:parent] &&= Initiative.find(initiative_params[:parent_id])

    initiative_params.except(:id)
  end

  def explain_no_source_editing
    source_url = params[:source]
    return if source_url.nil?

    render json: "Use initiatives/:initiative_id/transfer_to/:wyeworker_id to change who is the source.",
           status: :unprocessable_entity
  end
end

# frozen_string_literal: true

class InitiativesController < ApplicationController
  include RestJsonUtils

  before_action :set_initiative, only: %i[show update destroy transfer]
  before_action :explain_no_source_editing, only: %i[update]

  EXPOSED_PLAIN_ATTRIBUTES = %w[title description startdate parent_id id].freeze

  def representation_to_initiative(representation)
    Initiative.new(
      **representation,
      source: url_to_wyeworker(representation[:source]),
      helpers: representation[:helpers].map { |rh| url_to_wyeworker(rh) }
    )
  end

  def index
    render json: Initiative.all
  end

  def show
    render json: @initiative
  end

  # POST
  def create
    initiative_params = {
      **params.require(:initiative).permit(*EXPOSED_PLAIN_ATTRIBUTES),
      source: params.require(:source),
      helpers: params.require(:helpers)
    }
    initiative = representation_to_initiative(initiative_params)
    if initiative.save
      render json: initiative, status: :created, location: initiative
    else
      render json: initiative.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT
  def update
    initiative_params = params.require(:initiative).permit(*EXPOSED_PLAIN_ATTRIBUTES)
    helpers_urls = params[:helpers]

    if @initiative&.update(**initiative_params)
      render json: @initiative
    else
      render json: @initiative.errors, status: :unprocessable_entity
    end
  end

  # DELETE
  def destroy
    @initiative.destroy
  end

  # POST /transfer/:wyeworker_id
  def transfer
    @initiative.transfer_to(Wyeworker.find(params[:wyeworker_id]))
  end

  private

  def set_initiative
    @initiative_id = params[:id]
    @initiative = Initiative.find(@initiative_id)
  end

  def explain_no_source_editing
    source_url = params[:source]
    return if source_url.nil?

    render json: "Use initiatives/:initiative_id/transfer_to/:wyeworker_id to change who is the source.",
           status: :unprocessable_entity
  end
end

# frozen_string_literal: true

class InitiativesController < ApplicationController
  include RestJsonUtils

  before_action :set_initiative, only: %i[show update destroy]

  EXPOSED_PLAIN_ATTRIBUTES = %w[title description startdate id].freeze

  def initiative_to_rep(initiative)
    {
      **initiative.slice(*EXPOSED_PLAIN_ATTRIBUTES),
      source: wyeworker_to_url(initiative.source),
      helpers: initiative.helpers.map { |i| wyeworker_to_url i }
    }
  end

  def rep_to_initiative(rep)
    Initiative.new(
      **rep,
      source: url_to_wyeworker(rep[:source]),
      helpers: rep[:helpers].map { |rh| url_to_wyeworker(rh) }
    )
  end

  def render_initiative(initiative, **kwarguments)
    render json: initiative_to_rep(initiative), **kwarguments
  end

  def render_initiatives(initiatives, **kwarguments)
    render json: initiatives.map { |i| initiative_to_rep i }, **kwarguments
  end

  def index
    render_initiatives Initiative.all
  end

  def show
    render_initiative @initiative
  end

  # POST
  def create
    initiative_params = params.require(:initiative).permit(*EXPOSED_PLAIN_ATTRIBUTES)
    helpers_urls = params[:helpers]
    source_url = params[:source]

    initiative_rep = { **initiative_params, source: source_url, helpers: helpers_urls }

    initiative = rep_to_initiative(initiative_rep)
    if initiative.save
      render_initiative initiative, status: :created, location: initiative
    else
      render json: initiative.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT
  def update
    initiative_params = params.require(:initiative).permit(*EXPOSED_PLAIN_ATTRIBUTES)
    helpers_urls = params[:helpers]
    source_url = params[:source]

    initiative_rep = { **initiative_params, source: source_url, helpers: helpers_urls }

    if @initiative&.update(initiative_rep)
      render_initiative @initiative
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
end

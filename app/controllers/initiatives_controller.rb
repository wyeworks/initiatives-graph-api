# frozen_string_literal: true

class InitiativesController < ApplicationController
  before_action :set_initiative, only: %i[show update destroy]

  def initialize
    @outside_attributes = %w[title description startdate id]
    super
  end

  def shallow_url_to_id(url)
    url.sub!(%r{.*/}, "")
  end

  def url_to_wyeworker(url)
    Wyeworker.find(shallow_url_to_id(url))
  end

  def wyeworker_to_url(wyeworker)
    "#{wyeworker.is_a?(Manager) ? 'managers' : 'developers'}/#{wyeworker.id}"
  end

  def initiative_to_rep(initiative)
    {
      **initiative.slice(*@outside_attributes),
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
    initiative_params = params.require(:initiative).permit(*@outside_attributes)
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
    initiative_params = params.require(:initiative).permit(*@outside_attributes)

    if @initiative&.update(initiative_params)
      render_initiative @initiative
    else
      render json: @initiative.errors, status: :unprocessable_entity
    end
  end

  # DELETE
  def destroy
    @initiative.destroy # TODO: need to add cascade
  end

  private

  def set_initiative
    @initiative_id = params[:id]
    @initiative = Initiative.find(@initiative_id)
  end
end

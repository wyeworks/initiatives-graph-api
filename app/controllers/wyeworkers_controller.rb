# frozen_string_literal: true

class WyeworkersController < ApplicationController
  include RestJsonUtils

  before_action :set_wyeworker, only: %i[show update destroy]
  before_action :explain_no_links_editing, only: %i[create update]

  EXPOSED_PLAIN_ATTRIBUTES = %w[name id].freeze
  WyeworkerKind = Wyeworker

  def wyeworker_to_rep(wyeworker)
    {
      **wyeworker.slice(*EXPOSED_PLAIN_ATTRIBUTES),
      initiatives: wyeworker.initiatives.map { |i| initiative_to_url(i) }
    }
  end

  def rep_to_wyeworker(rep)
    self.class::WyeworkerKind.new(rep)
  end

  def render_wyeworker(wyeworker, **kwarguments)
    render json: wyeworker_to_rep(wyeworker), **kwarguments
  end

  def render_wyeworkers(wyeworkers, **kwarguments)
    render json: wyeworkers.map { |i| wyeworker_to_rep i }, **kwarguments
  end

  def index
    render_wyeworkers self.class::WyeworkerKind.all
  end

  def show
    render_wyeworker @wyeworker
  end

  # POST
  def create
    wyeworker_rep = params.require(self.class::WyeworkerKind.name.downcase.to_sym).permit(*EXPOSED_PLAIN_ATTRIBUTES)

    wyeworker = rep_to_wyeworker(wyeworker_rep)
    if wyeworker.save
      render_wyeworker wyeworker, status: :created, location: wyeworker
    else
      render json: wyeworker.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT
  def update
    wyeworker_params = params.require(self.class::WyeworkerKind.name.downcase.to_sym).permit(*EXPOSED_PLAIN_ATTRIBUTES)

    if @wyeworker&.update(**wyeworker_params)
      render_wyeworker @wyeworker
    else
      render json: @wyeworker.errors, status: :unprocessable_entity
    end
  end

  # DELETE
  def destroy
    @wyeworker.destroy
  end

  private

  def set_wyeworker
    @wyeworker = self.class::WyeworkerKind.find(params[:id])
  end

  def explain_no_links_editing
    return if params[:initiatives].nil?

    render(
      json: "Cannot set or update the initiatives of a wyeworker directly, must set or update linked entities instead.",
      status: :unprocessable_entity
    )
  end
end

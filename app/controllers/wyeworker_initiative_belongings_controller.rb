# frozen_string_literal: true

class WyeworkerInitiativeBelongingsController < ApplicationController
  include RestJsonUtils

  before_action :set_wib, only: %i[show destroy]

  EXPOSED_PLAIN_ATTRIBUTES = %w[kind id].freeze

  def wib_to_rep(wib)
    {
      **wib.slice(*EXPOSED_PLAIN_ATTRIBUTES),
      initiative: initiative_to_url(wib.initiative),
      wyeworker: wyeworker_to_url(wib.wyeworker)
    }
  end

  def rep_to_wib(rep)
    WyeworkerInitiativeBelonging.new(
      **rep,
      initiative: url_to_initiative(rep[:initiative]),
      wyeworker: url_to_initiative(rep[:wyeworker])
    )
  end

  def render_wib(wib, **kwarguments)
    render json: wib_to_rep(wib), **kwarguments
  end

  def render_wibs(wibs, **kwarguments)
    render json: wibs.map { |w| wib_to_rep w }, **kwarguments
  end

  def index
    render_wibs WyeworkerInitiativeBelonging.all
  end

  def show
    render_wib @wib
  end

  # POST
  def create
    wib_params = params.require(:wyeworker_initiative_belonging).permit(*EXPOSED_PLAIN_ATTRIBUTES)
    wib_wyeworker_param = params.require(:wyeworker)
    wib_initiative_param = params.require(:initiative)

    @wib = WyeworkerInitiativeBelonging.new({
                                              **wib_params,
                                              wyeworker: url_to_wyeworker(wib_wyeworker_param),
                                              initiative: url_to_initiative(wib_initiative_param)
                                            })
    if @wib.save
      render_wib @wib, status: :created, location: @wib
    else
      render json: @wib.errors, status: :unprocessable_entity
    end
  end

  # Can only create and delete WyeworkerInitiativeBelonging's. So no #update

  # DELETE
  def destroy
    @wib.destroy
  end

  private

  def set_wib
    @wib_id = params.extract_value(:id)
    @wib = WyeworkerInitiativeBelonging.find(@wib_id)
  end
end

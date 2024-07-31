# frozen_string_literal: true

class WyeworkerInitiativeBelongingsController < ApplicationController
  include RestJsonUtils

  before_action :set_wib, only: %i[show destroy]
  before_action :explain_no_source_editing, only: %i[create destroy]

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
      wyeworker: url_to_wyeworker(rep[:wyeworker])
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
    @wib = rep_to_wib({
                        **params.require(:wyeworker_initiative_belonging).permit(*EXPOSED_PLAIN_ATTRIBUTES),
                        wyeworker: params.require(:wyeworker),
                        initiative: params.require(:initiative)
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
    return if @wib_id.nil?

    @wib = WyeworkerInitiativeBelonging.find(@wib_id)
  end

  def explain_no_source_editing
    wib_params = params[:wyeworker_initiative_belonging]
    set_wib

    return unless wib_params&.[](:kind) == "source" || @wib&.kind == "source"

    render json: "Use initiatives/:initiative_id/transfer_to/:wyeworker_id to give and revoke source status.",
           status: :unprocessable_entity
  end
end

# frozen_string_literal: true

class WyeworkersController < ApplicationController
  before_action :set_wyeworker, only: %i[show update destroy]
  before_action :explain_no_links_editing, only: %i[create update]

  WyeworkerKind = Wyeworker

  def index
    render json: self.class::WyeworkerKind.all
  end

  def show
    render json: @wyeworker
  end

  # POST
  def create
    @wyeworker = self.class::WyeworkerKind.new(hydrated_params)
    if wyeworker.save
      render json: wyeworker, status: :created, location: wyeworker
    else
      render json: wyeworker.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT
  def update
    if @wyeworker&.update(hydrated_params)
      render json: @wyeworker
    else
      render json: @wyeworker.errors, status: :unprocessable_entity
    end
  end

  # DELETE
  def destroy
    @wyeworker.destroy
  end

  private

  def hydrated_params
    wyeworker_params = params
                       .require(self.class::WyeworkerKind.name.downcase.to_sym)
                       .permit(:name, :id, initiatives: [])
    wyeworker_params[:initiatives] = Wyeworker.find(wyeworker_params[:initiatives])
    wyeworker_params.except(:id)
  end

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

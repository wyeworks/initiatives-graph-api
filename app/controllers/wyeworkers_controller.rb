# frozen_string_literal: true

class WyeworkersController < ApplicationController
  before_action :set_wyeworker, only: %i[show update destroy]

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
    if @wyeworker.save
      render json: @wyeworker, status: :created, location: @wyeworker
    else
      render json: @wyeworker.errors, status: :unprocessable_entity
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
                       .permit(:name, :id, owner_initiatives: [], helped_initiatives: [])

    wyeworker_params[:owner_initiatives] &&= Initiative.find(wyeworker_params[:owner_initiatives])
    wyeworker_params[:helped_initiatives] &&= Initiative.find(wyeworker_params[:helped_initiatives])

    wyeworker_params.except(:id)
  end

  def set_wyeworker
    @wyeworker = self.class::WyeworkerKind.find(params[:id])
  end
end

# frozen_string_literal: true

class ManagersController < ApplicationController
  before_action :set_manager, only: %i[show update destroy]

  def index
    render json: Manager.all
  end

  def show
    render json: @manager
  end

  # POST
  def create
    @manager = Manager.new(manager_params)
    if @manager.save
      render json: @manager, status: :created
    else
      render json: @manager.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT
  def update
    if @manager.update(manager_params)
      render json: @manager
    else
      render json: @manager.errors, status: :unprocessable_entity
    end
  end

  # DELETE
  def destroy
    if @manager.destroy
      head :no_content
    else
      render json: @manager.errors, status: :unprocessable_entity
    end
  end

  private

  def manager_params
    params
      .require(:manager)
      .permit(:name)
  end

  def set_manager
    @manager = Manager.find(params[:id])
  end
end

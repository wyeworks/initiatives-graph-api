# frozen_string_literal: true

class DevelopersController < ApplicationController
  before_action :set_developer, only: %i[show update destroy]

  def index
    render json: Developer.all
  end

  def show
    render json: @developer
  end

  # POST
  def create
    @developer = Developer.new(developer_params)
    if @developer.save
      render json: @developer, status: :created
    else
      render json: @developer.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT
  def update
    if @developer.update(developer_params)
      render json: @developer
    else
      render json: @developer.errors, status: :unprocessable_entity
    end
  end

  # DELETE
  def destroy
    if @developer.destroy
      head :no_content
    else
      render json: @developer.errors, status: :unprocessable_entity
    end
  end

  private

  def developer_params
    params
      .require(:developer)
      .permit(:name)
  end

  def set_developer
    @developer = Developer.find(params[:id])
  end
end

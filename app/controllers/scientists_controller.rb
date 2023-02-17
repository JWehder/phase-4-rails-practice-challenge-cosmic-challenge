class ScientistsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
  rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_response

  def index 
    scientists = Scientist.all
    render json: scientists
  end

  def show
    scientist = Scientist.find(params[:id])
    render json: scientist, serializer: CustomScientistSerializer
  end

  def create
    scientist = Scientist.create!(scientist_params)
    render json: scientist, status: :created
  end

  def update
    scientist = Scientist.find(params[:id])
    scientist.update!(scientist_params)
    render json: scientist, status: :accepted
  end

  def destroy
    scientist = Scientist.find(params[:id])
    scientist.destroy
    head :no_content
  end

  private

  def render_unprocessable_response(invalid)
    render json: {errors: invalid.record.errors.full_messages}, status: :unprocessable_entity
  end

  def render_not_found_response
    render json: { error: "Scientist not found" }, status: :not_found
  end

  # Only allow a list of trusted parameters through.
  def scientist_params
    params.permit(:name, :field_of_study, :avatar)
  end
end

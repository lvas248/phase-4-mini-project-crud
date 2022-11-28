class SpicesController < ApplicationController

    rescue_from ActiveRecord::RecordNotFound, with: :spice_not_found

    def index
        render json: Spice.all, status: :accepted
    end

    # def show
    #     render json: find_spice, status: :accepted
    # end

    def create
        spice = Spice.create(spice_params)
        render json: spice, status: :created
    end

    def update
        spice = find_spice
        spice.update(spice_params)
        render json: spice, status: :accepted
    end

    def destroy
        find_spice.destroy
        head :no_content
    end

    private

    def find_spice
        Spice.find(params[:id])
    end

    def spice_params
        params.permit(:title, :image, :description, :notes, :rating)
    end

    def spice_not_found
        render json: { error: "Spice not found"}, status: :not_found
    end
end

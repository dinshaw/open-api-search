module V1
  class SearchesController < ApplicationController
    def create
      search = @current_user.searches.new search_params
      search.save!
      render json: { search: search }, status: :created
    end

    def destroy
      search = @current_user.searches.find params[:id]
      search.destroy
      render json: { message: 'Record destroyed.' }, status: :ok
    end

    def index
      searches = @current_user.searches
      render json: { searches: searches }, status: :ok
    end

    def show
      search = @current_user.searches.find params[:id]
      render json: { search: search }, status: :ok
    end

    private

    def search_params
      params.require(:search).permit(
        :author,
        :sort_order,
        :subject
      )
    end
  end
end

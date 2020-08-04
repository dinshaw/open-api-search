class SearchesController < ApplicationController
  def create
    search = Search.new search_params
    search.save!
    render json: { search: search }, status: :created
  end

  def destroy
    search = Search.find params[:id]
    search.destroy
    render json: { message: 'Record destroyed.' }, status: :ok
  end

  def index
    searches = Search.all
    render json: { searches: searches }, status: :ok
  end

  def show
    search = Search.find params[:id]
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

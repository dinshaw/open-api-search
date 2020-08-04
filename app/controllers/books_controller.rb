class BooksController < ApplicationController
  def index
    @books_collection = BooksCollection.new(
      subject: params[:subject],
      author: params[:author],
      sort_order: params[:sort_order],
      page: params[:page] || 1
    ).call
    render json: @books_collection.body, status: @books_collection.status
  end
end

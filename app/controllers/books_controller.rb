class BooksController < ApplicationController
  def index
    @books_collection = BooksCollection.new(
      subject: params[:subject],
      author: params[:author],
      sort_order: params[:sort_order]
    ).call
    render json: { books: @books_collection.body }, status: @books_collection.status
  end
end

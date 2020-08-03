class BooksController < ApplicationController
  def index
    @books_collection = BooksCollection.new(subject: params[:subject]).call
    render json: { books: @books_collection.body }, status: @books_collection.status
  end
end

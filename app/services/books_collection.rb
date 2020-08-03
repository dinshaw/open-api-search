class BooksCollection
  include HTTParty

  base_uri 'http://openlibrary.org'

  def initialize(subject:, sort_order: nil)
    @options = { query: { subject: subject } }
    @sort_order = sort_order
  end

  def call
    OpenStruct.new({
      status: status,
      body: sorted_books
    })
  end

  private

  def sorted_books
    @sort_order == :desc ? books.sort.reverse : books.sort
  end

  def books
    @books ||= response.parsed_response['docs'].map{ |book| book['title'] }
  end

  def response
    @response ||= self.class.get('/search.json', @options)
  end

  def status
    response.code
  end
end

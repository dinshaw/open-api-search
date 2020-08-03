class BooksCollection
  include HTTParty

  base_uri 'http://openlibrary.org'

  def initialize(subject:)
    @options = { query: { subject: subject } }
  end

  def call
    OpenStruct.new({
      status: status,
      body: books
    })
  end

  private

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

class BooksCollection
  include HTTParty

  base_uri Rails.application.config.open_library_uri

  def initialize(subject:, author: nil, sort_order: nil)
    @subject = subject
    @options = { query: { subject: subject, author: author } }
    @sort_order = sort_order
  end

  def call
    OpenStruct.new({
      status: status,
      body: body
    })
  rescue
    OpenStruct.new({
      status: 503,
      body: { error: 'The request could not be processed.'}
    })
  end

  private
  attr_reader :options, :sort_order, :subject

  def body
    valid? ? sorted_books : error
  end

  def error
    { error: 'Queries must include a subject.' }
  end

  def sorted_books
    { books: sort_order == 'desc' ? books.sort.reverse : books.sort }
  end

  def books
    @books ||= response['docs'].map{ |book| book['title'] }
  end

  def response
    Rails.cache.fetch(options.to_query, expires_in: 1.minute) do
      self.class.get('/search.json', options).to_h
    end
  end

  def status
    valid? ? response['code'] : :unprocessable_entity
  end

  def valid?
    subject.present?
  end
end

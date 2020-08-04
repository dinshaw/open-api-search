class BooksCollection
  include HTTParty

  base_uri Rails.application.config.open_library_uri

  def initialize(subject:, page:, author: nil, sort_order: nil)
    @subject = subject
    @options = { query: { subject: subject, author: author, page: page } }
    @sort_order = sort_order
  end

  def call
    OpenStruct.new({
      status: status,
      body: body
    })
  rescue => e
    OpenStruct.new({
      status: 503,
      body: { error: e.message }
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
    books.sort_by! { |book| book[:title] }
    books.reverse! if sort_order == 'asc'
    { books: books }
  end

  def books
    @books ||= response['docs'].map do |book|
      { title: book['title'], author: book['author_name'] }
    end
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

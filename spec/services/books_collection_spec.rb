RSpec.describe BooksCollection do
  let(:books_collection) { described_class.new(params) }
  let(:response) { books_collection.call }
  let(:page) { 1 }
  let(:params) do
    { subject: :swimming, page: page }
  end
  let(:title_1) { Faker::Book.title }
  let(:title_2) { Faker::Book.title }
  let(:author_1) { Faker::Book.author }
  let(:author_2) { Faker::Book.author }
  let(:expected_status) { 200 }
  let(:expected_response) do
    {
      'code' => expected_status,
      'docs' => [
        { 'title' => title_1, 'author_name' => author_1 },
        { 'title' => title_2, 'author_name' => author_2 }
      ]
    }
  end

  describe '#call' do
    before do
      allow(books_collection).to receive(:response) { expected_response }
    end

    context 'with a successful request' do
      let(:expected_books) do
        [
          { title: title_1, author: author_1 },
          { title: title_2, author: author_2 },
        ]
      end
      it 'returns #status of 200' do
        expect(response.status).to eq 200
      end

      it 'returns #body as an Array of books' do
        expect(response.body[:books]).to match_array expected_books
      end

      context 'with [sort_order]=desc' do
        let(:params) do
          { subject: :swimming, sort_order: 'desc', page: page }
        end

        it 'returns #body as an Array of books sorted by title'  do
          expect(response.body[:books]).to eq(
            expected_books.sort_by { |book| book[:title] }
          )
        end
      end

      context 'with [sort_order]=asc' do
        let(:params) do
          { subject: :swimming, sort_order: 'asc', page: page }
        end

        it 'returns #body as an Array of books sorted by title in reverse order'  do
          expect(response.body[:books]).to eq expected_books.sort_by { |book| book[:title] }.reverse
        end
      end

      context 'and an :author param' do
        let(:author) { Faker::Book.author }
        let(:params) do
          { subject: :swimming, author: author, page: page }
        end

        it 'adds :author to the @options hash' do
          expect(books_collection.send(:options)[:query][:author]).to eq author
        end
      end
    end

    context 'with a unaccessible response' do
      before do
        allow(books_collection).to receive(:response).and_raise
      end

      it 'returns a :service_unavailable' do
        expect(response.status).to eq 503
      end
    end
  end
end

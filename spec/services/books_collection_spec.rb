RSpec.describe BooksCollection do
  let(:books_collection) { described_class.new(params) }
  let(:response) { books_collection.call }
  let(:params) do
    { subject: :swimming }
  end
  let(:title_1) { Faker::Book.title }
  let(:title_2) { Faker::Book.title }
  let(:response_double) do
    instance_double HTTParty::Response, code: expected_status, parsed_response: expected_body
  end

  describe '#call' do
    context 'with a successful request' do
      let(:expected_status) { 200 }
      let(:expected_body) do
        {
        'docs' => [
          { 'title' => title_1 },
          { 'title' => title_2 }
        ]
      }
      end

      before do
        allow(books_collection).to receive(:response) { response_double }
      end

      it 'returns #status of 200' do
        expect(response.status).to eq 200
      end

      it 'returns #body as an Array of book titles' do
        expect(response.body).to eq [title_1, title_2]
      end
    end
  end
end

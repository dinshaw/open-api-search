RSpec.describe 'Books' do
  let(:user) { users(:homer) }
  let(:token) { JsonWebToken.encode(user_id: user.id) }
  let(:headers) do
    {
      "ACCEPT" => "application/json",
      'Authorization' => token
    }
  end
  let(:json) { JSON.parse(response.body) }

  before do
    Rails.cache.clear
  end

  describe 'GET /books' do
    it 'returns 200', :vcr do
      get books_path, params: { subject: 'swimming' }, headers: headers
      expect(response).to have_http_status 200
    end

    it 'returns 100 books at a time', :vcr do
      get books_path, params: { subject: 'swimming' }, headers: headers
      expect(json['books'].count).to eq 100
    end

    it 'sorts books in alphabetic order by title, by default', :vcr do
      get books_path, params: { subject: 'swimming' }, headers: headers
      expect(json['books'].first).to eq(<<~TITLE.gsub(/\n/, ' ').strip)
        A comparison of the relative effectiveness between two methods of
        teaching the whip kick to college women enrolled in beginning swimming classes
      TITLE
    end

    it 'sorts books in reverse alphabetic order', :vcr do
      get books_path, params: { subject: 'swimming', sort_order: 'desc' }, headers: headers
      expect(json['books'].first).to eq "Úszástanítás, úszástanulás"
    end

    it 'filters books by author', :vcr do
      get(
        books_path,
        params: { subject: 'swimming', author: 'Amateur Swimming Association.' },
        headers: headers
      )
      expect(json['books'].count).to eq 15
    end

    it 'paginates Books', :vcr do
      get books_path, params: { subject: 'swimming', page: 2 }, headers: headers
      expect(json['books'].first).to match 'swimming text for college me'
    end

    context 'with an invalid query', :vcr do
      it 'returns :unprocessable_entity' do
        get books_path, params: { subject: nil }, headers: headers
        expect(response).to have_http_status :unprocessable_entity
      end
    end

    context 'with an unknown error', :vcr do
      it 'returns :service_unavailable' do
        get books_path, params: { subject: 'foo' }, headers: headers
        expect(response).to have_http_status :service_unavailable
      end
    end
  end
end

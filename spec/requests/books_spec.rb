RSpec.describe 'Books' do
  let(:json) { JSON.parse(response.body) }

  describe 'GET /books' do
    it 'returns 200', :vcr do
      get books_path subject: 'swimming'
      expect(response).to have_http_status 200
    end

    it 'returns 100 books at a time', :vcr do
      get books_path subject: 'swimming'
      expect(json['books'].count).to eq 100
    end

    it 'sorts books in alphabetic order by title, by default', :vcr do
      get books_path subject: 'swimming'
      expect(json['books'].first).to eq "A comparison of the relative effectiveness between two methods of teaching the whip kick to college women enrolled in beginning swimming classes"
    end

    it 'sorts books in reverse alphabetic order', :vcr do
      get books_path subject: 'swimming', sort_order: 'desc'
      expect(json['books'].first).to eq "Úszástanítás, úszástanulás"
    end

    it 'filters books by author', :vcr do
      get books_path subject: 'swimming', author: 'Amateur Swimming Association.'
      expect(json['books'].count).to eq 15
    end

    context 'with an invalid query', :vcr do
      it 'returns :unprocessable_entity' do
        get books_path subject: nil
        expect(response).to have_http_status :unprocessable_entity
      end
    end

    context 'with an unknown error', :vcr do
      it 'returns :service_unavailable' do
        get books_path subject: 'foo'
        expect(response).to have_http_status :service_unavailable
      end
    end
  end
end

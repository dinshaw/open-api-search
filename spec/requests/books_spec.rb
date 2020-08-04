RSpec.describe 'Books' do
  describe 'GET /books' do
    it 'returns 200', :vcr do
      get books_path subject: 'swimming'
      expect(response).to have_http_status 200
    end

    it 'returns 100 books at a time', :vcr do
      get books_path subject: 'swimming'
      count = JSON.parse(response.body)['books'].count
      expect(count).to eq 100
    end

    it 'sorts books in alphabetic order by title, by default', :vcr do
      get books_path subject: 'swimming'
      first_title = JSON.parse(response.body)['books'].first
      expect(first_title).to eq "A comparison of the relative effectiveness between two methods of teaching the whip kick to college women enrolled in beginning swimming classes"
    end

    it 'sorts books in reverse alphabetic order', :vcr do
      get books_path subject: 'swimming', sort_order: 'desc'
      first_title = JSON.parse(response.body)['books'].first
      expect(first_title).to eq "Úszástanítás, úszástanulás"
    end

    it 'filters books by author', :vcr do
      get books_path subject: 'swimming', author: 'Amateur Swimming Association.'
      count = JSON.parse(response.body)['books'].count
      expect(count).to eq 15
    end
  end
end

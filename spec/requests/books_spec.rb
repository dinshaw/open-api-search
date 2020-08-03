RSpec.describe 'Books', :vcr do
  describe 'GET /books' do
    it 'returns 200' do
      get books_path subject: 'swimming'
      expect(response).to have_http_status(200)
    end

    it 'returns a :books key' do
      get books_path subject: 'swimming'
      expect(JSON.parse(response.body)['books']).not_to be nil
    end
  end
end

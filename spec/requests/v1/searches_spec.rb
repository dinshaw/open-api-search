RSpec.describe 'Searches' do
  let(:user) { users(:homer) }
  let(:token) { JsonWebToken.encode(user_id: user.id) }
  let(:headers) do
    {
      "ACCEPT" => "application/json",
      'Authorization' => token
    }
  end
  let(:search_1) { searches(:doughnuts) }
  let(:search_2) { searches(:beer) }
  let(:search_3) { searches(:skateboards) }
  let(:json) { JSON.parse(response.body) }

  describe 'POST /searches' do
    let(:subject_txt) { Faker::Lorem.word }
    let(:author) { Faker::Book.author }
    let(:sort_order) { ['asc', 'desc'].sample }
    let(:params) do
      {
        search: {
          subject: subject_txt,
          author: author,
          sort_order: sort_order
        }
      }
    end

    context 'with valid search params' do
      let(:newly_created_search) { Search.order('created_at desc').first }

      it 'return a status of 201' do
        post v1_searches_path, params: params, headers: headers
        expect(response).to have_http_status 201
      end

      it 'creates a Search' do
        expect {
          post v1_searches_path, params: params, headers: headers
        }.to change(Search, :count).by 1
      end

      it 'returns the search id' do
        post v1_searches_path, params: params, headers: headers
        expect(json['search']['id']).to eq newly_created_search.id
      end

      it 'persists Search#subject' do
        post v1_searches_path, params: params, headers: headers
        expect(json['search']['subject']).to eq subject_txt
      end

      it 'persists Search#author' do
        post v1_searches_path, params: params, headers: headers
        expect(json['search']['author']).to eq author
      end

      it 'persists Search#sort_order' do
        post v1_searches_path, params: params, headers: headers
        expect(json['search']['sort_order']).to eq sort_order
      end
    end

    context 'with duplicate params' do
      before do
        post v1_searches_path, params: params, headers: headers
      end

      it 'returns :unprocessable_entity' do
        post v1_searches_path, params: params, headers: headers
        expect(response).to have_http_status :unprocessable_entity
      end

      it 'returns an error message' do
        post v1_searches_path, params: params, headers: headers
        expect(json['error']).not_to be_nil
      end
    end

    context 'with missing :subject' do
      let(:subject_txt) { nil }

      it 'returns :unprocessable_entity' do
        post v1_searches_path, params: params, headers: headers
        expect(response).to have_http_status :unprocessable_entity
      end

      it 'returns an error message' do
        post v1_searches_path, params: params, headers: headers
        expect(json['error']).not_to be_nil
      end
    end
  end

  describe 'GET /searches' do
    let(:parsed_ids) do
      json['searches'].map { |search| search['id'] }
    end

    it 'returns JSON for all Searches belonging to the current user' do
      get v1_searches_path, headers: headers
      expect(parsed_ids).to eq [search_1.id, search_2.id]
    end
  end

  describe 'GET /searches/:id' do
    it 'returns JSON for the search' do
      get v1_search_path(search_1), headers: headers
      expect(json['search']['id']).to eq search_1.id
    end

    it 'includes the search url in the JSON' do
      get v1_search_path(search_2), headers: headers
      expect(json['search']['url']).to match Rails.application.config.base_domain
    end

    it 'returns a status of :not_found' do
      get v1_search_path(id: :foo), headers: headers
      expect(response).to have_http_status :not_found
    end

    it 'scopes the searches to the user' do
      get v1_search_path(search_3), headers: headers
      expect(response).to have_http_status :not_found
    end
  end

  describe 'DELET /searches/:id' do
    it 'destroys a search' do
      expect {
        delete v1_search_path(search_1), headers: headers
      }.to change(Search, :count).by -1
    end

    it 'destroys the requested Search' do
      delete v1_search_path(search_1), headers: headers
      expect(Search.find_by(id: search_1.id)).to be_nil
    end

    it 'scopes the searches to the user' do
      delete v1_search_path(search_3), headers: headers
      expect(response).to have_http_status :not_found
    end

    context 'with a non-existent #id' do
      it 'returns a status of :not_found' do
        delete v1_search_path(id: :foo), headers: headers
        expect(response).to have_http_status :not_found
      end
    end
  end
end

RSpec.describe Search do
  let(:search) { described_class.new(params) }
  let(:subject_txt) { Faker::Lorem.word }
  let(:author) { Faker::Book.author }
  let(:sort_order) { ['asc', 'desc'].sample }
  let(:valid_params) do
    {
      subject: subject_txt,
      author: author,
      sort_order: sort_order
    }
  end

  it { is_expected.to validate_presence_of :subject }

  context 'with a non-unique set of params' do
    let(:params) { valid_params }

    before do
      Search.create! valid_params
    end

    it 'is invalid' do
      expect(search.valid?).to be false
    end
  end

  context 'with a unique set of params' do
    let(:params) { valid_params.merge(sort_order: :foo) }

    before do
      Search.create! valid_params
    end

    it 'is invalid' do
      expect(search.valid?).to be true
    end
  end

  describe '#url' do
    let(:search) { searches(:search_2) }

    it 'returns the complete url for the search' do
      expect(search.url).to eq [
        Rails.application.config.open_library_uri,
        '/books?',
        { subject: search.subject, author: search.author }.to_query
      ].join
    end
  end
end

RSpec.describe Search do
  let(:user) { users(:homer) }
  let(:search) { described_class.new(params) }
  let(:subject_txt) { Faker::Lorem.word }
  let(:author) { Faker::Book.author }
  let(:sort_order) { ['asc', 'desc'].sample }
  let(:valid_params) do
    {
      subject: subject_txt,
      author: author,
      sort_order: sort_order,
      user: user
    }
  end

  it { is_expected.to validate_presence_of :subject }
  it { is_expected.to belong_to :user }

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
    let(:search) { searches(:beer) }

    it 'returns the complete url for the search' do
      expect(search.send(:url)).to eq [
        "#{Rails.application.config.base_domain}/#{Rails.application.config.api_version}",
        "/books?author=#{search.author}&sort_order=#{search.sort_order}&subject=#{search.subject}"
      ].join
    end
  end
end

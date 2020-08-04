RSpec.describe 'Authorization' do
  let(:user) { users(:homer) }

  describe 'POST /auth/login' do
    it 'returns a token' do
      post v1_login_path email: user.email, password: 'password'
      expect(JSON.parse(response.body)['token']).not_to be_nil
    end
  end
end

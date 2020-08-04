RSpec.describe User do
  it { is_expected.to validate_presence_of :email }
  it { is_expected.to validate_presence_of :password }
  it { is_expected.to validate_confirmation_of :password }
  it { is_expected.to have_many :searches }
end

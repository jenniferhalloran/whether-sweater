# frozen_string_literal: true

require 'rails_helper'

describe User, type: :model do
  describe 'validations' do
    subject { User.create(email: 'sample@email.com', password: 'abc') }
    it { should validate_uniqueness_of(:email) }
    it { should validate_presence_of(:password_digest) }
    it { should have_secure_password }
  end
end

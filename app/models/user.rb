# frozen_string_literal: true

class User < ApplicationRecord
  has_many :api_keys, as: :bearer 
  validates :email, uniqueness: true, presence: true
  validates_presence_of :password_digest

  has_secure_password

end

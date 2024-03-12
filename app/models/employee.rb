class Employee < ApplicationRecord
  belongs_to :team, optional: true

  validates :name, presence: true
  validates :mobile, presence: true, length: { is: 10 }, format: { with: /\A[1-9]\d*\z/ } , uniqueness: true
  validates :address, presence: true
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP } , uniqueness: true
end

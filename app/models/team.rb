class Team < ApplicationRecord
  belongs_to :manager, class_name: 'Employee', foreign_key: 'manager_id', optional: true
  has_many :employees, foreign_key: 'team_id', dependent: :nullify

  validates :name, presence: true, uniqueness: true
end

class Transaction < ApplicationRecord
  belongs_to :user
  has_many :related_transactions, foreign_key: :transaction_id, class_name: 'Transaction'

  enum status: %i(approved reversed refunded error)
  before_validation :asign_uuid, on: :create

  validates :customer_email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create }
  validates :uuid, :status, presence: true

  def asign_uuid
    self.uuid ||= SecureRandom.uuid
  end
end

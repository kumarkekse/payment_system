class RefundTransaction < Transaction
  belongs_to :related_transaction, foreign_key: :transaction_id, class_name: 'Transaction'

  validates :amount, numericality: { greater_than: 0 }
end

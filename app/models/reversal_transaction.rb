class ReversalTransaction < Transaction
  belongs_to :related_transaction, foreign_key: :transaction_id, class_name: 'Transaction'

  validates :amount, absence: true
end

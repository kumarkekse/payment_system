class ChargeTransaction < Transaction
  belongs_to :related_transaction, foreign_key: :transaction_id, class_name: 'Transaction'

  validates :amount, numericality: { greater_than: 0 }

  after_create :after_process

  private
    def after_process
      # adjust total_transaction_sum for merchant
      related_transaction.user.save
    end
end

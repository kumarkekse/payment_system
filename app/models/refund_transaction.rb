class RefundTransaction < Transaction
  belongs_to :related_transaction, foreign_key: :transaction_id, class_name: 'Transaction'

  validates :amount, numericality: { greater_than: 0 }

  after_create :refund_process

  private
    def refund_process
      # set status to refunded for related charged_transaction
      charged_transaction = related_transaction.related_transactions.charge.approved.last
      charged_transaction.update_attribute(:status, 'refunded') if charged_transaction

      # adjust total_transaction_sum for merchant
      related_transaction.user.save
    end
end

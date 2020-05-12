class ReversalTransaction < Transaction
  belongs_to :related_transaction, foreign_key: :transaction_id, class_name: 'Transaction'

  validates :amount, absence: true

  after_create :reversal_process

  private
    def reversal_process
      # set status to refunded for related authorized_transaction
      authorized_transaction = related_transaction.related_transactions.authorize.approved.last
      authorized_transaction.update_attribute(:status, 'reversed') if authorized_transaction
    end
end

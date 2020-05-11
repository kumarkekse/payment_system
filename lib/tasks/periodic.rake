namespace :periodic do
  desc 'Deletes the Transactions older than 1 hour'
  task delete_transactions: :environment do
    Transaction.where('created_at < ?', 1.hour.ago).destroy_all
  end
end

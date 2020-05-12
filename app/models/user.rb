class User < ApplicationRecord
  rolify
  has_many :transactions

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  enum status: %i(active inactive)

  after_create :assign_default_role
  before_save :cal_total_transaction_sum, if: -> { is_merchant? }

  def cal_total_transaction_sum
    self.total_transaction_sum = transactions.charge.approved.sum(:amount)
  end

  private
    def assign_default_role
      add_role(:merchant) if roles.blank?
    end
end

class User < ApplicationRecord
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  enum status: [ :active, :inactive ]

  after_create :assign_default_role

  def admin?
    has_role? :admin
  end

  def merchant?
    has_role? :merchant
  end

  private
    def assign_default_role
      add_role(:merchant) if roles.blank?
    end
end

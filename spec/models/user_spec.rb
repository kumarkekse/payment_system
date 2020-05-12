require 'rails_helper'

RSpec.describe User, type: :model do
  it { should validate_presence_of(:email) }

  subject { FactoryBot.create(:user) }
  let!(:transaction1) { FactoryBot.create(:transaction, user: subject, amount: 100, status: 'approved') }
  let!(:charge_transaction) { FactoryBot.create(:transaction, user: subject, amount: 100, status: 'approved', type: 'ChargeTransaction') }

  it { expect(subject.is_admin?).to eq(false) }
  it { expect(subject.is_merchant?).to eq(true) }
  it { expect(subject.active?).to eq(true) }
  it { should allow_values('active', 'inactive').for(:status) }
  it { should allow_value('email@addresse.foo').for(:email) }
  it { should_not allow_value('email').for(:email) }
  context 'cal_total_transaction_sum' do
    before(:each) { subject.save }

    it { expect(subject.total_transaction_sum).to eq(100) }
  end
end

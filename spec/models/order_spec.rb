RSpec.describe Order, type: :model do
  let(:order1) { FactoryBot.create(:order, :paid, :shipped, :delivered) }
  let(:order2) { FactoryBot.create(:order, :paid) }
  let(:order3) { FactoryBot.create(:order, :recent) }

  subject { described_class.new }
  it { is_expected.to respond_to(:send_invoice) }

  it 'should return all the unpaid orders' do
    expect(Order.unpaid_orders).to include(order3)
  end

  it 'should return all the paid and undelivered orders' do
    expect(Order.paid_and_undelivered_orders).to include(order2)
  end

  it 'should return all the delivered orders' do
    expect(Order.delivered).to include(order1)
  end

  it 'should return all the shipped orders' do
    expect(Order.shipped_yesterday).to include(order1)
  end

  it 'should return all the created orders' do
    expect(Order.created_yesterday).to include(order1)
  end
end

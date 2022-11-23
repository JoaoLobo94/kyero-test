require 'rails_helper'

RSpec.describe Report, type: :model do
  subject { described_class.new }

  it 'sends the report to the line manager' do
    expect(subject).to receive(:send_all)
    subject.send_to_line_manager
  end

  it 'gets all the delivered orders' do
    expect(subject).to receive(:get_all_the_delivered_orders)
    subject.send_to_line_manager
  end

  it 'gets all the shipped orders' do
    expect(subject).to receive(:get_all_the_shipped_orders)
    subject.send_to_line_manager
  end

  it 'gets all the unpaid invoices' do
    expect(subject).to receive(:get_all_the_unpaid_invoices)
    subject.send_to_line_manager
  end

  it 'returns a hash of delivered orders' do
    expect(subject.get_all_the_delivered_orders).to be_a(Hash)
  end

  it 'returns a hash of shipped orders' do
    expect(subject.get_all_the_shipped_orders).to be_a(Hash)
  end

  it 'returns a hash of unpaid invoices' do
    expect(subject.get_all_the_unpaid_invoices).to be_a(Hash)
  end
end

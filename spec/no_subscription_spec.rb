require 'spec_helper'

describe NoSubscription do
  describe '#charge' do
    it 'does not charge credit card' do
      credit_card = double('credit_card')
      allow(credit_card).to receive(:charge)
      user = User.new(credit_card: credit_card)

      user.charge

      expect(credit_card).not_to have_received(:charge)
    end
  end

  describe '#has_mentoring?' do
    it 'returns false' do
      expect(described_class.new.has_mentoring?).to eq(false)
    end
  end

  describe '#price' do
    it 'returns 0' do
      expect(described_class.new.price).to eq(0)
    end
  end
end

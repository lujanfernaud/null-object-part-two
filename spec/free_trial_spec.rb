require 'spec_helper'

describe FreeTrial do
  describe '#has_mentoring?' do
    it 'is true' do
      expect(described_class.new.has_mentoring?).to be_truthy
    end
  end

  describe '#plan_name' do
    it 'is "Free Trial"' do
      expect(described_class.new.plan_name).to eq('Free Trial')
    end
  end
end

require 'spec_helper'
require 'breaker'

describe Breaker do
  let(:code) { 1234 }
  let(:breaker) { Breaker.new code }

  describe "#try" do
    it { expect(breaker.try 1234).to eq '++++' }
    it { expect(breaker.try 1235).to eq '+++' }
    it { expect(breaker.try 1243).to eq '++--' }
  end
end

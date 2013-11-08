require 'spec_helper'
require 'breaker'

describe Breaker do
  let(:breaker) { Breaker.new code }

  describe "#try" do
    context 'code is 1234' do
      let(:code) { 1234 }
      it { expect(breaker.try 1234).to eq '++++' }
      it { expect(breaker.try 1235).to eq '+++' }
      it { expect(breaker.try 1243).to eq '++--' }
      it { expect(breaker.try 1123).to eq '+--' }
    end

    context 'code is 1123' do
      let(:code) { 1123 }
      it { expect(breaker.try 1123).to eq '++++' }
      it { expect(breaker.try 1235).to eq '+--' }
      it { expect(breaker.try 1243).to eq '++-' }
      it { expect(breaker.try 2311).to eq '----' }
    end
  end
end

require 'spec_helper'
require 'breaker'

describe Breaker do
  let(:breaker) { Breaker.new code }
  def _try(num)
    breaker.try(num).join
  end

  describe "#try" do
    context 'code is 1234' do
      let(:code) { 1234 }
      it { expect(_try 1234).to eq '++++' }
      it { expect(_try 1235).to eq '+++' }
      it { expect(_try 1243).to eq '++--' }
      it { expect(_try 1123).to eq '+--' }
    end

    context 'code is 1123' do
      let(:code) { 1123 }
      it { expect(_try 1123).to eq '++++' }
      it { expect(_try 1235).to eq '+--' }
      it { expect(_try 1243).to eq '++-' }
      it { expect(_try 2311).to eq '----' }
    end

    context 'code is 4745' do
      let(:code) { 4745 }
      it { expect(_try 4745).to eq '++++' }
      it { expect(_try 4444).to eq '++' }
    end
  end
end

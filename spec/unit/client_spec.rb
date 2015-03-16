require 'spec_helper'

describe Mws::Client do
  subject { described_class }

  it { should < Mws::Marketplace }
  it { should < Mws::Concerns::Base }
  it { should < Mws::Concerns::Connection }
  it { should < Mws::Concerns::Envelope }
  it { should < Mws::Concerns::Api }
end

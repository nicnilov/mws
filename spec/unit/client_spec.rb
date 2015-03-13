require 'spec_helper'

describe Mws::Client do
  subject { described_class }

  it { should < Mws::Concerns::Base }
  it { should < Mws::Concerns::Connection }
end

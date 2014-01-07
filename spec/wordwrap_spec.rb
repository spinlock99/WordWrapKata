require 'spec_helper'
require 'wordwrap'

describe Wordwrap do
  describe "#initialize" do
    it "instantiates" do
      expect {
        Wordwrap.new
      }.to_not raise_exception
    end
  end
end

require 'spec_helper'
require 'wordwrap'

describe Wordwrap do
  describe "#initialize" do
    subject { Wordwrap.new(wrap_length) }
    let(:wrap_length) { 4 }

    specify { expect { Wordwrap.new }.to raise_exception }
    specify { expect { subject }.to_not raise_exception }

    context "invalid parameter" do
      let(:wrap_length) { "foo" }
      specify { expect { subject }.to raise_exception }
    end
  end

  describe ".wrap" do
    subject { Wordwrap.new(wrap_length).wrap(text) }
    let(:wrap_length) { 5 }
    let(:text) { "this is text" }

    specify { expect { subject }.to_not raise_exception }

    context "invalid parameter" do
      let(:text) { [1,2,3] }
      specify { expect { subject }.to raise_exception }
    end

    context "empty string" do
      let(:text) { "" }
      it { should eq("") }
    end

    context "short word" do
      let(:text) { "word" }
      let(:wrap_length) { 6 }
      it { should eq("word") }
    end

    context "word word" do
      let(:text) { "word word" }
      let(:wrap_length) { 5 }
      it { should eq("word\nword") }
    end

    context "word word word" do
      let(:text) { "word word word" }
      let(:wrap_length) { 5 }
      it { should eq("word\nword\nword") }

      context "wrap at 10" do
        let(:wrap_length) { 10 }
        it { should eq("word word\nword") }
      end

      context "wrap at 3" do
        let(:wrap_length) { 3 }
        it { should eq("wor\nd\nwor\nd\nwor\nd") }
      end
    end

    context "wordword" do
      let(:wrap_length) { 4 }
      let(:text) { "wordword" }
      it { should eq("word\nword") }
    end
  end
end

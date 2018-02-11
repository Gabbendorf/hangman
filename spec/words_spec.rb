require 'spec_helper'
require_relative '../lib/words'

RSpec.describe Words do

  let(:words) {Words.new}

  it "contains twenty words" do
    total_words = words.get_words().size

    expect(total_words).to eq(20)
  end
end

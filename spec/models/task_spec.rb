require 'spec_helper'

describe Task do
  it "should return task" do
    Task.new(title: 'test').is_a?(Task).should be_true
  end
end
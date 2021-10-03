require_relative '../model/inventory.rb'
require 'rspec'

describe Inventory do
  it "Inventory instance should have 3 mandatory attributes." do
    expect(Inventory.new).to raise_error(ArgumentError)
  end

  it "Unique ID should be 32-character hex" do
    id = Inventory.id
    expect(id.length).to be(32)
  end
end
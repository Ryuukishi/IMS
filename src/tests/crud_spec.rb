require_relative '../controller/crud.rb'
require_relative '../controller/file.rb'
require 'rspec'

describe CRUD do
  it "Check save function" do
    expect(Inventory.new).to raise_error(ArgumentError)
  end

  it "Unique ID should be 32-character hex" do
    id = Inventory.id
    expect(id.length).to be(32)
  end
end
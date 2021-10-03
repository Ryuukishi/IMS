require_relative '../controller/file.rb'
require 'rspec'

describe Files do
    it "Running the app for the first time, there shouldn't be a save file for the app to load from." do
        expect(Files.exist).to be_falsy
    end
end
require 'spec_helper'

describe Movie do
  describe '#best_picture_winner' do
    it "creates a Movie object for the best picture in the specified year" do
      VCR.use_cassette('oscars_2011') do
        Movie.should_receive(:new).with('tt1504320')
        Movie.best_picture_winner(2011)
      end
    end
  end
end

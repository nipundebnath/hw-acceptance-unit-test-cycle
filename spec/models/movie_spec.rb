require "rails_helper"
describe Movie do
    describe '#similar_movies' do
        it 'should find movies with the same director' do
            movie1 = Movie.create! director: 'Paul Newman'
            movie2 = Movie.create! director: 'Paul Newman'
            expect(movie1.similar_movies).to include(movie2)
        end

        it 'should not find movies with the different director' do
            movie1 = Movie.create! director: 'Paul Newman'
            movie2 = Movie.create! director: 'James Cameron'
            expect(movie1.similar_movies).not_to include(movie2)
        end
    end
end 
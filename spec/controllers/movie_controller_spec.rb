require "rails_helper"

 describe MoviesController do
    describe '#director' do
        context "When the specified movie has a director" do
            it 'should find movies with the same director' do
                @movie_id = "1234"
                @movie = double('fake movie', director: 'James Cameron')

                expect(Movie).to receive(:find).with(@movie_id).and_return(@movie)
                expect(@movie).to receive(:similar_movies)

                get :director, id: @movie_id

                expect(response).to render_template(:director)
            end

        end

        context "When the specified movie doesn't have a director" do
            it 'should redirect to the home page' do
                @movie_id = "1234"
                @movie = double('fake movie').as_null_object

                 expect(Movie).to receive(:find).with(@movie_id).and_return(@movie)
                get :director, id: @movie_id
                expect(response).to redirect_to(movies_path)
            end
        end
    end

    describe '#create' do
        context 'When I add a new movie' do
            it 'should exist in the database' do
                movie_params = { title: 'The Room', rating: 'PG', description: '', release_date: 2003, director: 'Tommy Wiseau' }
                post :create, movie: movie_params
                @movie = Movie.where(title: movie_params[:title]).first
                expect(@movie).not_to be_nil
            end

            it 'should redirect me to the homepage' do
                movie_params = { title: 'The Room', rating: 'PG', description: '', release_date: 2003, director: 'Tommy Wiseau' }
                post :create, movie: movie_params
                expect(response).to redirect_to(movies_path)
            end
        end
    end

    describe '#show' do
        context 'When I view a movie' do
            it 'should look for it in the database' do
                @movie_id = "1234"
                @movie = double('fake movie')
                expect(Movie).to receive(:find).with(@movie_id).and_return(@movie)
                get :show, id: @movie_id
                expect(response).to render_template(:show)
            end
        end
    end

     describe '#destroy' do
        context 'When I delete a movie' do
            it 'should not exist in the database and redirect me to homepage' do
                movie_params = { title: 'The Room', rating: 'PG', description: '', release_date: 2003, director: 'Tommy Wiseau' }
                @movie = Movie.create! movie_params
                @movie_id = @movie.id
                post :destroy, id: @movie.id
                expect { Movie.find(@movie_id) }.to raise_error(ActiveRecord::RecordNotFound)
                expect(response).to redirect_to(movies_path)
            end
        end
    end
end 
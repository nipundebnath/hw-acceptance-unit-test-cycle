Feature: search for movies by director

  As a movie buff
  So that I can find manage movies
  I want to add, edit, and remove movies

Background: movies in database

  Given the following movies exist:
  | title        | rating | director     | release_date |
  | Star Wars    | PG     | George Lucas |   1977-05-25 |
  | Blade Runner | PG     | Ridley Scott |   1982-06-25 |
  | Alien        | R      |              |   1979-05-25 |
  | THX-1138     | R      | George Lucas |   1971-03-11 |

Scenario: edit an existing movie
  When I go to the edit page for "Alien"
  And  I fill in "Director" with "Ridley Scott"
  And  I press "Update Movie Info"
  Then the director of "Alien" should be "Ridley Scott"

Scenario: add a new movie
  Given I am on the new movie page
  And   I fill in "Title" with "The Room"
  And   I fill in "Director" with "Tommy Wiseau"
  And   I select "R" from "Rating"
  And   I press "Save"
  Then  I should be on the movies page
  When  I am on the details page for "The Room"
  Then  I should see "The Room"
  Then  I should see "R"
  Then  I should see "Tommy Wiseau"

Scenario: sort movies by title
  Given I am on the homepage
  And   I follow "Movie Title"
  Then  I should see "Alien" before "Star Wars"

Scenario: sort movies by release_date
  Given I am on the homepage
  And   I follow "Release Date"
  Then  I should see "Star Wars" before "Alien"
Feature: Users API tests

  Scenario: Validate user schema by ID
    Given url 'https://jsonplaceholder.typicode.com/users/1'
    When method get
    Then status 200
    And match response.id == 1

  Scenario: Validate JSONPlaceholder users list
    Given url 'https://jsonplaceholder.typicode.com'
    And path 'users'
    When method get
    Then status 200
    And match response[0].id == 1

  Scenario: Get full list of users
    Given url 'https://jsonplaceholder.typicode.com/users'
    When method get
    Then status 200
    And match response[0].id == 1
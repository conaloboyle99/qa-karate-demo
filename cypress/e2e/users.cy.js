/// <reference types="cypress" />

// ======================
// Users API Tests
// ======================
describe('Users API Tests', () => {

  it('should fetch a list of users from fixture', () => {
    cy.fixture('users.json').then((users) => {
      // Validate Alice and Bob
      expect(users).to.be.an('array');
      expect(users.length).to.eq(2);
      expect(users[0]).to.deep.equal({ id: 1, name: 'Alice' });
      expect(users[1]).to.deep.equal({ id: 2, name: 'Bob' });
    });
  });

});

// ======================
// Users Page / Fixture Test
// ======================
describe('Users API / Page Test', () => {

  // Prevent Cypress from failing on external uncaught exceptions
  beforeEach(() => {
    cy.on('uncaught:exception', () => false);
  });

  it('should load the Cypress homepage safely', () => {
    cy.visit('https://www.cypress.io');

    // Safe check: verify the page title contains "Cypress"
    cy.title().should('include', 'Cypress');
  });

  it('should fetch users data from fixture', () => {
    cy.fixture('users.json').then((users) => {
      expect(users.length).to.eq(2);
      cy.log('First user: ' + JSON.stringify(users[0]));
      cy.log('Second user: ' + JSON.stringify(users[1]));
    });
  });

});
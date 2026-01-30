describe('UI with Mocked API', () => {

  beforeEach(() => {
    // Optional: visit the UI page if you want to test UI elements
    cy.visit('https://example.cypress.io')
  })

  it('loads homepage', () => {
    cy.contains('Kitchen Sink').should('be.visible')
  })

  it('validates mocked API response using fixture', () => {
    // Use the fixture directly
    cy.fixture('users.json').then((users) => {
      expect(users.length).to.eq(2)             // Check there are 2 users
      expect(users[0].name).to.eq('Alice')      // Validate first user
      expect(users[1].name).to.eq('Bob')        // Validate second user
    })
  })
})
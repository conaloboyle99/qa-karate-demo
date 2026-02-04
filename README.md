Automation Project

Overview

This project demonstrates a realistic, CI-ready test automation setup covering both UI and API testing. It is intentionally designed to reflect how modern teams structure automation: clear separation of concerns, reproducibility via Docker, and execution via CI (Jenkins).

The goal is not maximum test count, but meaningful risk reduction through targeted automation.

⸻

Tech Stack
	•	Cypress – UI / end-to-end testing
	•	Karate – API testing
	•	Node.js – Cypress runtime
	•	Java / Maven – Karate runtime
	•	Docker & Docker Compose – Environment parity and reproducibility
	•	Jenkins – Continuous Integration

⸻

Project Structure

.
├── cypress/              # UI tests
│   ├── e2e/              # Cypress specs
│   ├── fixtures/         # Test data
│   └── support/          # Commands & config
├── karate/               # API tests
│   └── features/         # Karate feature files
├── docker/               # Docker-related config
├── Jenkinsfile           # CI pipeline definition
├── docker-compose.yml    # Local + CI environment orchestration
├── package.json          # Cypress dependencies & scripts
├── pom.xml               # Karate dependencies
└── README.md             # This file


⸻

Prerequisites

You need the following installed locally:
	•	Docker (and Docker Compose)
	•	Node.js (LTS recommended)
	•	Java 11+
	•	Maven

No global Cypress or Karate installation is required.

⸻

Running the Project Locally

1. Clone the repository

git clone <https://github.com/conaloboyle99/qa-karate-demo.git>.   
cd qa-karate-demo>        


⸻

2. Start the environment (recommended)

docker compose up --build

This will:
	•	Build required images
	•	Start the application under test (if applicable)
	•	Provide a consistent runtime for tests

⸻

3. Run API tests (Karate)

mvn test

or (inside Docker, if configured):

docker compose run karate-tests


⸻

4. Run UI tests (Cypress)

Headless (CI-style):

npm install
npx cypress run

Interactive mode:

npx cypress open


5. Run all tests (Karate + Cypress)

./run-tests.sh
⸻

Running in CI (Jenkins)

The Jenkinsfile defines the pipeline stages:
	1.	Checkout
	2.	Build environment (Docker)
	3.	Run API tests
	4.	Run UI tests
	5.	Publish results

Expected behaviour:
	•	A failing test fails the pipeline
	•	Logs clearly indicate whether failure is UI or API related

⸻

Test Strategy

Objectives

The automation suite aims to:
	•	Catch critical regressions early
	•	Validate core business flows, not edge-case UI details
	•	Provide fast feedback in CI
	•	Be reproducible on any machine

⸻

In Scope

API Testing (Karate)
	•	Core endpoints
	•	Happy paths and key negative cases
	•	Contract-level validation (status codes, schemas, critical fields)
	•	Authentication and authorization behaviour (where applicable)

UI Testing (Cypress)
	•	Critical user journeys (smoke tests)
	•	High-risk flows (login, submission, confirmation, navigation)
	•	Cross-page integration behaviour

⸻

Out of Scope (by design)
	•	Exhaustive UI validation (styling, pixel-perfect checks)
	•	Low-risk CRUD permutations
	•	Browser compatibility matrix
	•	Performance and load testing

These are excluded to keep tests:
	•	Stable
	•	Fast
	•	Maintainable

⸻

Test Pyramid Alignment

        UI (Cypress)
      ─────────────────
       API (Karate)
  ───────────────────────

	•	API tests provide breadth and fast feedback
	•	UI tests validate integration and user confidence

⸻

Environment Strategy
	•	Tests are environment-agnostic
	•	Configuration is externalised (env vars / config files)
	•	Docker ensures parity between local and CI runs

⸻

Failure Strategy
	•	API failures block UI execution where appropriate
	•	Failures are categorised (API vs UI)
	•	Logs and reports are preserved in CI

⸻

Design Principles
	•	Prefer clarity over cleverness
	•	Tests describe behaviour, not implementation
	•	One assertion failure should indicate one clear problem
	•	Automation supports humans — it does not replace judgment

⸻

Known Limitations / Future Improvements
	•	Expanded negative API coverage
	•	Test data management strategy
	•	Improved reporting (e.g. HTML reports)
	•	Parallel execution optimisation

These are intentional next steps, not oversights.

⸻

How This Project Should Be Evaluated

This project is not a demo of framework features.

It should be evaluated on:
	•	Structure
	•	Reproducibility
	•	CI readiness
	•	Test intent and scope discipline

⸻

Author

Conal O’Boyle


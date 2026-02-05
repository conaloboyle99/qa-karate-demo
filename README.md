Automation Project

Overview

This project demonstrates a realistic, CI-ready test automation framework covering both UI and API testing. It reflects modern automation practices with:
	•	Clear separation of concerns
	•	Reproducibility via Docker
	•	Execution via Jenkins CI/CD

The goal is meaningful risk reduction through targeted automation, rather than maximum test coverage.

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

Prerequisites

Install the following locally:
	•	Docker (and Docker Compose)
	•	Node.js (LTS recommended)
	•	Java 11+
	•	Maven

No global Cypress or Karate installation is required.

⸻

Running the Project Locally

1. Clone the repository

git clone https://github.com/conaloboyle99/qa-karate-demo.git
cd qa-karate-demo

2. Start the environment (recommended)

docker compose up --build

This will:
	•	Build required images
	•	Start the application under test (if applicable)
	•	Provide a consistent runtime for tests

3. Run all tests (Karate + Cypress)

./run-tests.sh

	•	Executes all tests inside Docker
	•	Generates reports in reports/, results/, and cypress/ folders
	•	CI-ready: exits with a failure code if any test fails

Running in CI (Jenkins)

The Jenkinsfile defines the pipeline stages:
	1.	Checkout
	2.	Build environment (Docker)
	3.	Run API tests
	4.	Run UI tests
	5.	Publish results

Expected behaviour:
	•	A failing test fails the pipeline
	•	Logs clearly indicate whether the failure is UI or API related

⸻

Test Strategy

Objectives
	•	Catch critical regressions early
	•	Validate core business flows, not edge-case UI details
	•	Provide fast feedback in CI
	•	Be reproducible on any machine

In Scope

API Testing (Karate)
	•	Core endpoints
	•	Happy paths & key negative cases
	•	Contract-level validation (status codes, schemas, critical fields)
	•	Authentication & authorization checks

UI Testing (Cypress)
	•	Critical user journeys (smoke tests)
	•	High-risk flows (login, submission, confirmation, navigation)
	•	Cross-page integration behaviour

Out of Scope (by design)
	•	Exhaustive UI validation (styling, pixel-perfect checks)
	•	Low-risk CRUD permutations
	•	Browser compatibility testing
	•	Performance/load testing

Tests are designed to be stable, fast, and maintainable.

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
	•	Configuration is externalized (env vars / config files)
	•	Docker ensures parity between local and CI runs

⸻

Failure Strategy
	•	API failures block UI execution where appropriate
	•	Failures are categorized (API vs UI)
	•	Logs and reports are preserved in CI

⸻

Design Principles
	•	Prefer clarity over cleverness
	•	Tests describe behavior, not implementation
	•	One assertion failure = one clear problem
	•	Automation supports humans, does not replace judgment

⸻

Known Limitations / Future Improvements
	•	Expanded negative API coverage
	•	Test data management strategy
	•	Improved reporting (e.g., HTML reports)
	•	Parallel execution optimization

These are intentional next steps, not oversights.

⸻

Next Steps
	•	Add tests including Root Cause Analysis
	•	Perform Fault Slippage Analysis to identify suite weaknesses
	•	Improve Defect Reporting and Debugging
	•	Ensure Cloud / GCP readiness with Dockerized setup
	•	Publish all updates to Git

⸻

How This Project Should Be Evaluated
	•	Structure
	•	Reproducibility
	•	CI readiness
	•	Test intent and scope discipline

⸻

Author

Conal O’Boyle


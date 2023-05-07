# README

This README would normally document whatever steps are necessary to get the
application up and running.

- Start a Ruby on Rails project that is purely an API app.
- Create one API endpoint that can accept both payload formats. See payloads at the end of this document.
- Your code should not require any additional headers or parameters to distinguish between the 2 payloads.
- Parse and save the payloads to a Reservation model that belongs to a Guest model. Reservation code and guest email field should be unique.
- API should be able accept changes to the reservation. e.g., change in status, check-in/out dates, number of guests, etc...
- Add a README file to the root of your repository with clear instructions on how to set up and run your app.

### Assumptions

1. All the attributes in the payload(s) have values. In order to avoid the validation for the fields.
2. Use the standard Sqlite for db instead of PostgreSQL or any other databases.

### Structure of the Project

1. Wrote the business logic into service object named 'ReservationService'
2. Created a controller's test case inside the request folder (spec/request/reservation_controller_spec.rb).

### Run the project

Goto terminal and type `rails s ` and enter

Use any API client(Postman or Thunder Client in VS code, etc).
And send a request to `http://localhost:3000/reservations` with a payload in the body

### How to run the test

Goto terminal and type ` bundle exec rspec` and enter

### Improvements

1. Use integer as data type for prices instead of decimal to avoid floating point error.
2. Move the rspec payloads into a separate files (fixtures/{json file}) for more readability.

# README

* Ruby version - 2.6.3p62

* Use docker

run following commands
  - `docker-compose up` or you can use `docker-compose up --build`

  create the database
  - `docker-compose exec server bash -c "bundle exec rails db:create"`

  to run the migrations
  - `docker-compose exec server bash -c "bundle exec rails db:migrate"`

Application has a rake task `lib/tasks/import_users.rake` that imports the users from `users.csv` file. To run the rake task execute
docker-compose exec server bash -c "rake db:import_users"

Application also runs a cron job that deletes the transactions older than 1 hour.
associated rake task can be checked in `lib/tasks/periodic.rake`

It has and API to create transactions only for an active merchant

Steps to check:
1. Get the token using following command

curl -X POST \
  'http://localhost:3000/api/v1/authenticate?email=ram@gmail.com&password=123456' \
  -H 'Postman-Token: ab33e841-c854-4686-8b52-0b7e7a57f4b7' \
  -H 'cache-control: no-cache'

2.

curl -X POST \
  'http://localhost:3000/api/v1/transactions?amount=100&customer_email=customer@test.com&customer_phone=9876453210&status=approved' \
  -H 'Authorization: Bearer eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyLCJleHBpcnkiOjE1ODkzNzM0OTF9.FKGd31Xx5hJtuhViP1ttL7I_5qoMBbTmYTPkSMfUKMw' \
  -H 'Postman-Token: f3957cab-50e1-438c-bf5c-fb07ad852129' \
  -H 'cache-control: no-cache'

response is something like this
```
{
    "id": 4,
    "uuid": "76fce098-2f91-4999-87fd-97889e402aa2",
    "amount": 100,
    "status": "approved",
    "customer_email": "customer@test.com",
    "customer_phone": "9876453210",
    "transaction_id": null,
    "user_id": 2,
    "created_at": "2020-05-12T12:44:16.508Z",
    "updated_at": "2020-05-12T12:44:16.508Z"
}
```

# Build Development Environment

## Start docker
```
docker-compose up
```

## Visit the site

http://localhost:3000

## Change admin password

```
docker-compose exec web bash

bundle exec rails c

admin = Admin.first
admin.password = '123456'
admin.password_confirmation = '123456'
admin.save
```

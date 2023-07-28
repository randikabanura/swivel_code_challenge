# Swivel Code Challenge

A application to gives APIs for CRUD operations with three models.
Models are named Vertical, Category and Course. Category have a parent called Vertical and Course have a parent called Category.

## Features

* Use Elastic Search to list items on records collection page.
* Validate uniqueness of Name of category and vertical across both models (if there is a category with name "TEST" then a vertical with name "TEST" can't be valid)
* OAuth provider to protect the API using doorkeeper

### API Documentation

APIs for CRUD functionalities for each models.
You can find the API documentation from [here](https://documenter.getpostman.com/view/7109068/2s9XxsWGVw#a69ce980-971e-4776-a198-05a3938851b2).

## Development Environment Setup

* Ruby 3.1.3
* Rails 7.0.4
* Opensearch 2.4.1
* Redis 7.0.4

### Clone Repository

Go to the folder you want to clone the repository and run the following.

```bash
$ git clone https://gitfront.io/r/banura/DKywxWd6Eh6f/swivel-code-challenge.git
```

### Database

I have created the application with traditional PostgreSQL database. Please change the `config/database.yml`
according to your local setup.


### Credentials

In Ruby on Rails applications, the `config/credentials.yml.enc` file is used to securely store sensitive information, such as API keys, passwords, and other credentials.
This encrypted file ensures that sensitive data is not exposed in version control systems like Git. With provided `master.key` file, it should be placed in the relevant directory (`config/`) of the Rails application.
This ensures that Rails can locate and use the master key to decrypt the credentials when needed.

### Starting Up the Rails Server

Please run the `db/seeds.rb` to setup the database with relevent details.

```
$ rails db:seed
```
To startup the Rails server, make sure that you are in the root of the application in the terminal and run:

```
$ rails s
```

After server has been started you can go the [localhost:3000](http://localhost:3000) to interact with the application.
Before running the server make sure above steps has been completed successfully.

## License

See [LICENSE](LICENSE) © [randikabanura](https://github.com/randikabanura/)
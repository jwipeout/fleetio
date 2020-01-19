# Fleetio Take Home

Thank you for taking the time for viewing my take home. Please let me know if you have any questions or comments. 

During my testing of the app I found it helpful to know vins that exist in fleetio. Here are some of the ones that I would use

['1234', '12345', 'JH4CC2550NC003182', '1GBJG31R611156980']

-Josh 

## Heroku

The website is being hosted on heroku as instructed. I am using [env varibles](https://github.com/jwipeout/fleetio/blob/master/config/fleetio_ruby.yml) to hide the production creditials for the api, which are acutally the same in our case. Here is the link to the website. 

https://fleetio-josh.herokuapp.com/

## Application Architecture

### Framework

I am using the latest version of Rails with Ruby 2.7.0. Some gems that were added are

- gem 'faraday' (http requests)
- gem 'rubocop' (linting)
- gem 'react-rails' (react for rails)
- gem 'rack-cors' (support for cross origin resource sharing)

### Frontend

#### React

I used React to handle the organization and management of the frontend. I followed the redux pattern of storing much of the state in a global store. I am using the newer style of React hooks along with context instead of the redux library. You may notice that React hired one of the creators of Redux Dan Abramov and he has made it possible to follow the same pattern using only the React library. 

#### Bootstrap

I have added bootstrap for styling and also a helpful library called react-bootstrap which allows you to use already made bootstrap components.

#### Axios

I am using axios to make the api requests to the rails backend. During these requests, I am using the ES6 async await for an idiomatic handling of aynchronous calls (stay away from callback hell!).

## Backend 

### Services

I am using a services Rails pattern to help to manage business logic. There are services created for what we do to vehihicles and the interacting with the Fleetio api. 

### Locales

I use a few keys to help to abstract error messages

### Configuration

I load one additional configuration file ```config/fleetio_ruby.yml``` to manage fleetio api authorization

## Testing

I chose to use rspec and factories to test the rails application. In addition I also added rubocop for linting. I was faced with the difficult decision of not writing react tests due to time constraints. At my current job we use [React Testing Library](https://github.com/testing-library/react-testing-library) which creates interactive integration tests. I have had a pretty good experience with it thus far. 


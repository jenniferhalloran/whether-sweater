
<a name="readme-top"></a>

<!-- PROJECT LOGO -->
<br />
<div align="center">
<img src="https://media.giphy.com/media/3HpSslnzl7mKx0Yzhi/giphy.gif" alt="sweaters" width="30%"/>
<h1 align="center">Whether Sweater</h3>

  <p align="center">
    Whether Sweater is a service-oriented Application that exposes API endpoints for trip planning. Endpoints include querying weather forecasts for a destination and the travel time between two destinations. Multiple API endpoints are consumed for each call, with all data filtered and integrated into the JSON body of whether-sweaters's response.
    <br />
    <br />
    <a href="https://github.com/jenniferhalloran/whether-sweater/issues">Report Bug</a>
    ·
    <a href="https://github.com/jenniferhalloran/whether-sweater/issues">Request Feature</a>
  </p>
</div>



<!-- TABLE OF CONTENTS -->
<details>
  <summary>Table of Contents</summary>
  <ol>
    <li><a href="#learning-goals">Learning Goals</a></li>
    <li><a href="#built-with">Built With</a></li>
    <li><a href="#apis-consumed">API's Consumed</a></li>
    <li><a href="#schema">Schema</a></li>
    <li>
      <a href="#endpoints">Endpoints</a>
      <ul>
        <li><a href="#retrieve-weather">Retrieve Weather</a></li>
        <li><a href="#user-registration">User Registration</a></li>
        <li><a href="#login">Login</a></li>
        <li><a href="#road-trip">Road Trip</a></li>
      </ul>
    </li>
    <li><a href="#setup">Setup</a></li>
    <li><a href="#contributing">Contributing</a></li>
    <li><a href="#contact">Contact</a></li>
  </ol>
</details>



<!-- ABOUT THE PROJECT -->
## Learning Goals
- Expose an API that aggregates data from multiple external APIs
- Expose an API that requires an authentication token
- Expose an API for CRUD functionality
- Determine completion criteria based on the needs of other developers
- Research, select, and consume an API based on your needs as a developer


<p align="right">(<a href="#readme-top">back to top</a>)</p>



### Built With

![Ruby](https://img.shields.io/badge/Ruby_on_Rails-CC0000?style=for-the-badge&logo=ruby-on-rails&logoColor=white)
![Postman](https://img.shields.io/badge/Postman-FF6C37?style=for-the-badge&logo=Postman&logoColor=white)
![Postgresql](https://img.shields.io/badge/PostgreSQL-316192?style=for-the-badge&logo=postgresql&logoColor=white)
![GitHub](https://img.shields.io/badge/GitHub-100000?style=for-the-badge&logo=github&logoColor=white)
![Heroku](https://img.shields.io/badge/Heroku-430098?style=for-the-badge&logo=heroku&logoColor=white)

<p align="right">(<a href="#readme-top">back to top</a>)</p>

## API's Consumed
- [MapQuest GeoCoding](https://developer.mapquest.com/documentation/geocoding-api/)
- [OpenWeather](https://openweathermap.org/api/one-call-api)
- [Yelp](https://www.yelp.com/developers/documentation/v3/authentication)

## Schema
![Screen Shot 2022-09-16 at 12 34 29 PM](https://user-images.githubusercontent.com/48455658/190687184-c4d19299-d970-40e4-a0a4-3ee89cb9d688.png)


## Endpoints

### Retrieve Weather
This endpoint takes in a city,state string as a query parameter. If this is an new location search, the location string is sent to the MapQuest API to convert the string into coordinates and stored in the database. If the location has been previously searched, the coordinates are retrieved from the database. The coordinates are then sent to the OpenWeather API to retrieve the weather forecast, including current weather, 8 hours of hourly weather and 5 days of daily weather. Low-Level caching is implemented to cache the weather query. If incorrect parameters are sent through, the user will receive a descriptive error and 400 - Bad Request status.
#### Request:
```
GET /api/v1/forecast?location=denver,co
Content-Type: application/json
Accept: application/json
```

#### Sample Response:
![Screen Shot 2022-08-09 at 9 46 11 AM](https://user-images.githubusercontent.com/48455658/183665343-0795ffef-7b5e-4ff4-9f6e-e7e47f6d2143.png)

### User Registration
This endpoint takes in a user's unique email and password through the JSON payload in the body of the request. The password is processed with the BCrypt gem, which securely encrypts the password through a salt and hashing and returns a password digest. The user is also assigned an API key using the SecureRandom library. The email is downcased then the email and password digest are stored in the user table, and the API key is stored in the API keys table. Each API key is associated with a user through a one to many relationship. An unsuccessful request returns the appropriate 400 level status code and a specific error explaining the issue i.e passwords do not match, email already taken, missing field. 

#### Request
```
POST /api/v1/users
Content-Type: application/json
Accept: application/json

{
  "email": "whatever@example.com",
  "password": "password",
  "password_confirmation": "password"
}
```

#### Sample Response: 
![Screen Shot 2022-08-09 at 8 09 53 AM](https://user-images.githubusercontent.com/48455658/183665051-252a2322-8258-4d57-a642-8a4a7d21c6da.png)

### Login
This endpoint takes in a user's email, password and API key through the JSON payload in the body of the request. The API key is confirmed to match, then the user is authenticated through the authenticate method provided by BCrpt and the has_secure_password method. An unsuccessful request returns a generic error message for security reasons and the appropriate 400 level status code. 
#### Request
```
POST /api/v1/sessions
Content-Type: application/json
Accept: application/json

{
  "email": "whatever@example.com",
  "password": "password"
}
```

#### Sample Response
![Screen Shot 2022-08-09 at 8 08 10 AM](https://user-images.githubusercontent.com/48455658/183665083-689817ac-e4e1-4eb6-ab0b-10c3fd54c84d.png)


### Road Trip

#### Request
```
POST /api/v1/road_trip
Content-Type: application/json
Accept: application/json

body:

{
  "origin": "Denver,CO",
  "destination": "Pueblo,CO",
  "api_key": "jgn983hy48thw9begh98h4539h4"
}
```

#### Sample Response
![Screen Shot 2022-08-09 at 8 12 06 AM](https://user-images.githubusercontent.com/48455658/183665122-c2a6628e-e20f-4ce0-917a-6fae19b4c48c.png)

<p align="right">(<a href="#readme-top">back to top</a>)</p>

## Setup
1. Clone this repository using SSH key
   ```shell
   $ git clone git@github.com:jenniferhalloran/whether-sweater.git
   ```
2. Once cloned, you will have local copies of the directories you ran the clone command in. Use `$ cd` to  navigate to the front end application directory.
   ```shell
   $ cd whether-sweater
   ```
3. Install the required gems utilizing Bundler: 
  - If Bundler is not installed, first run the following command.

    ```shell
    $ gem install bundler
    ```
   - If Bundler is already installed or after you have installed it, run the following command.

      ```shell
      $ bundle install
      ```
4. There should be be text diplayed of the installation process that looks similar to below.

    ```shell
    Fetching gem metadata from https://rubygems.org/........
    Resolving dependencies...
    Using bundler 2.1.4
    Using byebug 11.1.3
    Fetching coderay 1.1.2
    Installing coderay 1.1.2
    Using diff-lcs 1.4.4
    Using method_source 1.0.0
    Using pry 0.13.1
    Fetching pry-byebug 3.9.0
    Installing pry-byebug 3.9.0
    Fetching rspec-support 3.10.1
    Installing rspec-support 3.10.1
    Fetching rspec-core 3.10.1
    Installing rspec-core 3.10.1
    Fetching rspec-expectations 3.10.1
    Installing rspec-expectations 3.10.1
    Fetching rspec-mocks 3.10.1
    Installing rspec-mocks 3.10.1
    Fetching rspec 3.10.0
    Installing rspec 3.10.0
    Bundle complete! 3 Gemfile dependencies, 12 gems now installed.
    Use `bundle info [gemname]` to see where a bundled gem is installed.
    ```
  If there are any errors, verify that bundler, Rails, and your ruby environment are correctly setup.

  5. Figaro installation

  * Follow the [figaro](https://github.com/laserlemon/figaro) installation with the docs and get your [MapQuest Geocoding, OpenWeather, and Yelp](#apis-consumed) keys. 
  
    ```shell
    $ bundle exec figaro install
    ```
  
  6. Add the keys to your newly created `config/application.yml` file and add it to your `.gitignore` file. Be sure to read the [google API docs](https://developers.google.com/docs/api) for a deeper undestanding of the app. Your `config/application.yml` file should look something like this:

      ```ruby 
      geo_key: (YOUR CLIENT ID HERE)
      weather_key: (YOUR CLIENT SECRET HERE)
      yelp_key: (YOUR KEY HERE)
      ```

  7. Start up your local server

      ```shell
      $ rails s
      ```
  8. Send requests to "https://localhost:3000". I recommend using Postman for the requests by adding the JSON to the "raw body" of a POST request. 

<p align="right">(<a href="#readme-top">back to top</a>)</p>
<!-- CONTRIBUTING -->
## Contributing

Contributions are what make the open source community such an amazing place to learn, inspire, and create. Any contributions you make are **greatly appreciated**.

If you have a suggestion that would make this better, please fork the repo and create a pull request. You can also simply open an issue with the tag "enhancement".
Don't forget to give the project a star! Thanks again!

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

<p align="right">(<a href="#readme-top">back to top</a>)</p>


<!-- CONTACT -->
## Contact

   <td align="center"><a href="https://github.com/jenniferhalloran"><img src="https://avatars.githubusercontent.com/u/48455658?v=4" width="100px;" alt=""/><br /><sub><b>Jennifer H. (she/her)</b></sub></a><br /><a href="https://www.linkedin.com/in/jenniferlhalloran/" title ="Linked In"><img src="https://img.shields.io/badge/LinkedIn-0077B5?style=for-the-badge&logo=linkedin&logoColor=white" /></a></td>
<p align="right">(<a href="#readme-top">back to top</a>)</p>

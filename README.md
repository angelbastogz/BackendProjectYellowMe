HOST: http://localhost:3000/api/v1/

# BackendProjectYellowMe

Project to apply to a job at the company YellowMe.

### Instructions to run the project
Requeriments: Rails 5.2.0, Ruby 2.5.1

+ Clone the repository
+ Modify the database.yml file with your credentials
+ Run the following commands:
    + bundle install
    + rake db:create
    + rake db:migrate
    + rails s
+ Now your project is already running


## Urls Collection [/urls]

### List All Urls [GET]

+ Response 200 (application/json)

        [
            {
                "status": "ok",
                "urls": [
                            {
                                "id": 1,
                                "original": "https://reddit.com",
                                "generated_code": "sy22xL"
                            },
                            {
                                "id": 2,
                                "original": "https://facebook.com",
                                "generated_code": "Bi0l2t"
                            },
                            {
                                "id": 3,
                                "original": "https://instagram.com",
                                "generated_code": "oebnsO"
                            },
                    ]
            }
        ]
        
## Create Url [/generate]
### Create a New Url [POST]

You may create your own url using this action. It takes a JSON
object containing a url.

+ Request (application/json)

        {
            "url": "https://facebook.com"
        }

+ Response 200 (application/json)

    + Body

            {
                "status": "ok",
                "generated_url": "http://localhost:3000/api/v1/Bi0l2t"
            }
            
## Create Urls Collection [/generate_many_urls]
### Create many Urls [POST]

You may create your own urls using this action. It takes a JSON
object containing a collection of urls.

+ Request (application/json)

            {
                "urls":[
                    {
                        "url": "https://Instagram.com"
                    },
                    {
                        "url": "https://facebook.com"
                    },
                    {
                        "url": "https://google.com"
                    },
                    {
                        "url": "https://stackoverflow.com"
                    }
                ]
            }

+ Response 200 (application/json)

    + Body

            {
                "status":" ok"
            }
            
## Get Url [/:generated_code]
### Redirect to Url [GET]
+ Redirect to url saved
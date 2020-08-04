# Open API Search

API client exposing the [Open Library Search API](https://openlibrary.org/dev/docs/api/search) to search for books by subject and filter them by author.

The application is available at:
https://open-library-api.herokuapp.com

## Usage

#### Authenticating

Authenticate with an existing User `homer@thesimpsons.com:password`:

```
curl -s -X POST -H 'Accept: application/json' -H 'Content-Type: application/json' --data '{"email":"homer@thesimpsons.com","password":"password"}' https://open-library-api.herokuapp.com/v1/auth/login
```

Use the returned token in all requests headers as:

```

Authorization: Bearer <TOKEN>

```

#### GET '/books'

Search Books by subject:

```

curl -H 'Accept: application/json' -H "Authorization: Bearer <TOKEN>" https://open-library-api.herokuapp.com/v1/books?subject=swimming

```

Filter by author:

```

curl -H 'Accept: application/json' -H "Authorization: Bearer <TOKEN>" https://open-library-api.herokuapp.com/v1/books?subject=swimming&author=Amateur+Swimming+Association

```

Sort alphabetically:

While the Open Library Search API does not offer sorted results, you can sort your result set alphabetically in either direction by passing `sort_order=[asc|desc]`:

```

curl -H 'Accept: application/json' -H "Authorization: Bearer <TOKEN>" "https://open-library-api.herokuapp.com/v1/books?subject=swimming&author=Amateur+Swimming+Association&sort_order=asc"

```

#### POST '/searches'

Create a saved search:

```

curl -H 'Accept: application/json' -H "Authorization: Bearer <TOKEN>" -d 'search[subject]=swiming&search[author]=Amateur+Swimming+Association&search[sort_order]=asc' "https://open-library-api.herokuapp.com/v1/searches"

```

#### GET '/searches'

Get a list of all saved searches:

```

curl -H 'Accept: application/json' -H "Authorization: Bearer <TOKEN>" "https://open-library-api.herokuapp.com/v1/searches"

```

#### GET '/searches/:id'

Get one saved search by id:

```

curl -H 'Accept: application/json' -H "Authorization: Bearer <TOKEN>" "https://open-library-api.herokuapp.com/v1/searches/:id"

```

#### DELET '/searches/:id'

Destroy a saved search:

```

curl -H 'Accept: application/json' -H "Authorization: Bearer <TOKEN>" -X 'DELETE' "https://open-library-api.herokuapp.com/v1/searches/:id"

```

```

```

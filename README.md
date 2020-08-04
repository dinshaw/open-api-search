# Open API Search

API client exposing the [Open Library Search API](https://openlibrary.org/dev/docs/api/search) to search for book titles by subject and filter them by author.

## Usage

#### Authenticating

Authenticate with an existing User

```
curl -s -X POST -H 'Accept: application/json' -H 'Content --data '{"email":"homer@thesimpsons.com","password":"password"}' http://localhost:3000/auth/login
```

Use the returned token in all requests headers as:

```
Authorization <TOKEN>
```

#### GET '/books'

Search Books by subject:

```

curl -H "Authorization <ACCESS_TOKEN>" http://localhost:3000/books?subject=swimming

```

Filter by author:

```

curl -H "Authorization <ACCESS_TOKEN>" "http://localhost:3000/books?subject=swimming&author=Amateur+Swimming+Association"

```

Sort alphabetically:
While the Open Library Search API does not offer sorted results, you can sort your result set alphabetically in either direction by passing `sort_order=[asc|desc]`:

```

curl -H "Authorization <ACCESS_TOKEN>" "http://localhost:3000/books?subject=swimming&author=Amateur+Swimming+Association&sort_order=asc"

```

#### POST '/searches'

Create a saved search:

```

curl -H "Authorization <ACCESS_TOKEN>" -d 'search[subject]=swiming' http://localhost:3000/searches

```

#### GET '/searches'

Get a list of all saved searches:

```

curl -H "Authorization <ACCESS_TOKEN>" http://localhost:3000/searches

```

#### GET '/searches/:id'

Get one saved search by id:

```

curl -H "Authorization <ACCESS_TOKEN>" http://localhost:3000/searches/:id

```

#### DELET '/searches/:id'

Destroy a saved search:

```

curl -H "Authorization <ACCESS_TOKEN>" -X 'DELETE' http://localhost:3000/searches/:id

```

```

```

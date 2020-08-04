# Open API Search

API client exposing the [Open Library Search API](https://openlibrary.org/dev/docs/api/search) to search for book titles by subject and filter them by author.

## Usage

Start the server locally:

```
$ bundle
$ rails s
```

#### GET '/books'

Search Books by subject:

```
curl http://localhost:3000/books?subject=swimming
```

Filter by author:

```
curl "http://localhost:3000/books?subject=swimming&author=Amateur+Swimming+Association"
```

Sort alphabetically:
While the Open Library Search API does not offer sorted results, you can sort your result set alphabetically in either direction by passing `sort_order=[asc|desc]`:

```
curl "http://localhost:3000/books?subject=swimming&author=Amateur+Swimming+Association&sort_order=asc"

```

#### POST '/searches'

Create a saved search:

```
curl -d 'search[subject]=swiming' http://localhost:3000/searches
```

#### GET '/searches'

Get a list of all saved searches:

```
curl http://localhost:3000/searches
```

#### GET '/searches/:id'

Get one saved search by id:

```
curl http://localhost:3000/searches/:id
```

#### DELET '/searches/:id'

Destroy a saved search:

```
curl -X 'DELETE' http://localhost:3000/searches/:id
```

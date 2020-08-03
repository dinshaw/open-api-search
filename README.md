# Open API Search

API client exposing the [Open Library Search API](https://openlibrary.org/dev/docs/api/search) to search for book titles by subject and filter them by author.

## Usage

Start the server locally:

```
$ bundle
$ rails s
```

#### GET '/books'

Search by subject:

```
curl -0 http://localhost:3000/books?subject=swimming
```

Filter by author:

```
curl -0 "http://localhost:3000/books?subject=swimming&author=Amateur+Swimming+Association"
```

Sort alphabetically:
While the Open Library Search API does not offer sorted results, you can sort your result set alphabetically in either direction by passing `sort_order=[asc|desc]`:

```
curl -0 "http://localhost:3000/books?subject=swimming&author=Amateur+Swimming+Association&sort_order=asc"

```

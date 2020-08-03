# Open API Search
API client exposing a subset of the [OpenLibrary API](https://openlibrary.org/developers/api) to search for book titles by subject.

## Usage

Start the server locally
```
$ bundle
$ rails s
```

GET '/books'
```
curl -0 http://localhost:3000/books?subject=swimming
```
Expected response:
```
{"books":["Swimming instruction","The complete book of dry-land exercises for swimming",
...
```

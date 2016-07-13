# Sample Retail REST API

## Login

```
curl -X POST -H "Accept: application/json" -H "Content-Type: application/json" -d '{ "user" : { "email": "user@example.com", "password": "password" } }' "http://localhost:3000/api/v1/sessions"
```

This will return a response similar to the following

```
{
  "user": {
    "email": "user@example.com",
    "name": "Example User",
    "token": "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJleHAiOjE0Njg1MTk3ODcsInN1YiI6IjBmYzRiZGY4LTBhZGItNDQyMi1hNWZkLTA1ODgzZjkyNmYwOSJ9.HqrziF5wP5Cl80f3GaqpUVE9Qi4D0dStOV0CFd4gZ5E"
  }
}
```

This token must be used as the header for all other API calls

## User, Item, Brand and Location API

There exists a user, item, brand and location API.  Each supports basic List, Read, Create, Update and Delete operations.  All support a flexible query interface using the [ActiveHashRelation](https://github.com/kollegorna/active_hash_relation) gem.

### List all locations (first page)

```
curl -X GET -H "Accept: application/json" -H "Authorization: Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJleHAiOjE0Njg1MTk3ODcsInN1YiI6IjBmYzRiZGY4LTBhZGItNDQyMi1hNWZkLTA1ODgzZjkyNmYwOSJ9.HqrziF5wP5Cl80f3GaqpUVE9Qi4D0dStOV0CFd4gZ5E" "http://localhost:3000/api/v1/locations"
```
### List all locations (second page)

```
curl -X GET -H "Accept: application/json" -H "Authorization: Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJleHAiOjE0Njg1MTk3ODcsInN1YiI6IjBmYzRiZGY4LTBhZGItNDQyMi1hNWZkLTA1ODgzZjkyNmYwOSJ9.HqrziF5wP5Cl80f3GaqpUVE9Qi4D0dStOV0CFd4gZ5E" "http://localhost:3000/api/v1/locations?page=2"
```

### List all locations in Florida (second page)

```
curl -X GET -H "Accept: application/json" -H "Authorization: Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJleHAiOjE0Njg1MTk3ODcsInN1YiI6IjBmYzRiZGY4LTBhZGItNDQyMi1hNWZkLTA1ODgzZjkyNmYwOSJ9.HqrziF5wP5Cl80f3GaqpUVE9Qi4D0dStOV0CFd4gZ5E" "http://localhost:3000/api/v1/locations?state=FL&page=2"
```

### List all locations whose name starts with 'C' sorted by external id in ascending order
```
curl -X GET -H "Accept: application/json" -H "Authorization:  Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJleHAiOjE0Njg1MTk3ODcsInN1YiI6IjBmYzRiZGY4LTBhZGItNDQyMi1hNWZkLTA1ODgzZjkyNmYwOSJ9.HqrziF5wP5Cl80f3GaqpUVE9Qi4D0dStOV0CFd4gZ5E"  "http://localhost:3000/api/v1/locations?state=FL&name[starts_with]=C&sort[property]=external_id&sort[order]=asc"
```

### Create a new location

```
curl -X POST -H "Accept: application/json" -H "Content-Type: application/json" -H "Authorization:  Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJleHAiOjE0Njg1MTk3ODcsInN1YiI6IjBmYzRiZGY4LTBhZGItNDQyMi1hNWZkLTA1ODgzZjkyNmYwOSJ9.HqrziF5wP5Cl80f3GaqpUVE9Qi4D0dStOV0CFd4gZ5E" -d '{
  "location": {
    "external_id": 83628219,
    "name": "Margaritaville",
    "address1": "1400 Alligator Lane",
    "address2": "Suite 200",
    "city": "Margaritaville",
    "state": "FL",
    "postal_code": 33486,
    "created_at": "2016-07-11T17:56:17Z",
    "updated_at": "2016-07-11T17:56:17Z"
  }
}
' "http://localhost:3000/api/v1/locations"
```

### List items by UPC

```
curl -X GET -H "Accept: application/json" -H "Authorization: Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJleHAiOjE0Njg1MTk3ODcsInN1YiI6IjBmYzRiZGY4LTBhZGItNDQyMi1hNWZkLTA1ODgzZjkyNmYwOSJ9.HqrziF5wP5Cl80f3GaqpUVE9Qi4D0dStOV0CFd4gZ5E" "http://localhost:3000/api/v1/items?upc=100"
```

The response looks like the following
```
{
  "items": [
    {
      "id": "c245f847-c2a8-4fe2-b9a0-8f787d81e7a1",
      "upc": 100,
      "name": "Alligator Bait",
      "uom": "EA",
      "brand_id": "4d70702c-2365-4064-93ff-c45bcc9ab956",
      "created_at": "2016-07-13T18:07:31Z",
      "updated_at": "2016-07-13T18:07:31Z"
    }
  ],
  "meta": {
    "current_page": 1,
    "total_pages": 1,
    "total_count": 1
  }
}
```

The meta block includes pagination information.  It will also include a 'next_page' and/or 'prev_page' if applicable.

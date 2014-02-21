MySQL-distance-between-GPS-coordinates
======================================

This MySQL function adds `DISTANCE()` to calculate the distance between two GPS locations using the Haversine formula.


### Function Signature

/*
 * @param lat1  (double)   latitude of origin
 * @param lon1  (double)   longitude of origin
 * @param lat2  (double)   latitude of destination
 * @param lon2  (double)   longitude of destination
 * @param unit  (double)   MILE, MI for miles or KILOMETER, KM for kilometers
 * @return      (double)   Distance between the two points in the units specified.
 */
CREATE FUNCTION DISTANCE( lat1 DOUBLE, lon1 DOUBLE, lat2 DOUBLE, lon2 DOUBLE, unit ENUM( 'MILE', 'KILOMETER', 'MI', 'KM' ) )


### Example usage

Calculate the distance between San Francisco, CA and New York, NY in miles
```
mysql> SELECT DISTANCE( 37.7756, -122.4193, 40.71448, -74.00598, 'MI' );
2565.80921930121
```

Find the two closet cities (in our table) to Paris, France
```
mysql> SELECT name FROM cities ORDER BY DISTANCE( 48.856638, 2.352241, cities.lat, cities.lon, 'KM' ) LIMIT 2;
Geneva
Barcelona
```

### Caveat

This calculates the 'straight line' distance, so it will likely be shorter than the driving distance (because roads are not generally straight lines between points).


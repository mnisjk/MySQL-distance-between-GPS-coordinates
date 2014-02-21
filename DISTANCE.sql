/*
 * Calculates the straight line distance between two GPS coordinates
 *
 * @author    Jason Kruse <jason@jasonkruse.com> or @mnisjk
 * @copyright 2014
 * @license   BSD (see LICENSE)
 *
 * @param lat1  (double)   latitude of origin
 * @param lon1  (double)   longitude of origin
 * @param lat2  (double)   latitude of destination
 * @param lon2  (double)   longitude of destination
 * @param unit  (enum)     MILE, MI for miles or KILOMETER, KM for kilometers
 * @return      (double)   Distance between the two points in the units specified.
 *
 * This function is very helpful for ordering a list of results by nearst first with:
 *
 * ORDER BY DISTANCE( userInput.lat, userInput.lon, locations.lat, locations.lon ) ASC;
 */
DROP FUNCTION IF EXISTS DISTANCE;
DELIMITER $$
CREATE FUNCTION DISTANCE( lat1 DOUBLE, lon1 DOUBLE, lat2 DOUBLE, lon2 DOUBLE, unit ENUM( 'MILE', 'KILOMETER', 'MI', 'KM' ) )
RETURNS DOUBLE
BEGIN
  DECLARE dist    DOUBLE;
  DECLARE latDist DOUBLE;
  DECLARE lonDist DOUBLE;
  DECLARE a,c,r   DOUBLE;

  # earth's radius
  IF unit = 'MILE' OR unit = 'MI' THEN SET r = 3959;
  ELSE SET r = 6371;
  END IF;
  
  # Haversine formula <http://en.wikipedia.org/wiki/Haversine_formula>
  SET latDist = RADIANS( lat2 - lat1 );
  SET lonDist = RADIANS( lon2 - lon1 );
  SET a = POW( SIN( latDist/2 ), 2 ) + COS( RADIANS( lat1 ) ) * COS( RADIANS( lat2 ) ) * POW( SIN( lonDist / 2 ), 2 );
  SET c = 2 * ATAN2( SQRT( a ), SQRT( 1 - a ) );
  SET dist = r * c;  
  
  RETURN dist;
END$$
DELIMITER ;

from data_store import db

class FacilityManager:
    """ Class to manage facility page

    Returns:
        FacilityManager: A class to manage facility page
    """

    @staticmethod
    def view_facilities(user_lat, user_lon) -> list:
        """ Method to view all facilities

        Args:
            user_lat (float): The latitude of the user
            user_lon (float): The longitude of the user

        Returns:
            list: A list of all facilities
        """

        facilities = []
        for facility in db.facilities:
            facilities.append({'id': facility.get_id(),
                               'name': facility.get_name(),
                               'park': facility.get_park().get_name(),
                               'type': facility.get_type().value,
                               'avg_rating': round(facility.get_avg_rating(), 1),
                               'num_ratings': facility.get_num_ratings()
                               })

        # Sort facilities by distance from user
        for facility in facilities:
            park = [park for park in db.parks if park.get_name() == facility['park']][0]
            facility_lat = park.get_latitude()
            facility_lon = park.get_longitude()
            facility['distance'] = calculate_distance(user_lat, facility_lat, user_lon, facility_lon)

        sorted_facilities = sorted(facilities, key=lambda x: x['distance'])
        # Drop the distance key from the dictionary
        for facility in sorted_facilities:
            facility.pop('distance')
        return sorted_facilities

    @staticmethod
    def filter_facilities(facility_type, user_lat, user_lon) -> list:
        """ Method to filter facilities by type

        Args:
            facility_type (FacilityType): The type of facility
            user_lat (float): The latitude of the user
            user_lon (float): The longitude of the user

        Returns:
            list: A list of all facilities of the given type
        """
        facilities = []
        for facility in db.facilities:
            if facility.get_type() == facility_type:
                facilities.append({'id': facility.get_id(),
                                   'name': facility.get_name(),
                                   'park': facility.get_park().get_name(),
                                   'type': facility.get_type().value,
                                   'avg_rating': round(facility.get_avg_rating(), 1),
                                   'num_ratings': facility.get_num_ratings()
                                   })

        # Sort facilities by distance from user
        for facility in facilities:
            park = [park for park in db.parks if park.get_name() == facility['park']][0]
            facility_lat = park.get_latitude()
            facility_lon = park.get_longitude()
            facility['distance'] = calculate_distance(user_lat, facility_lat, user_lon, facility_lon)

        sorted_facilities = sorted(facilities, key=lambda x: x['distance'])
        # Drop the distance key from the dictionary
        for facility in sorted_facilities:
            facility.pop('distance')
        return sorted_facilities

    @staticmethod
    def view_reviews(park_name, facility_name) -> list:
        """ Method to view reviews of a facility

        Args:
            park_name (string): The name of the park
            facility_name (string): The name of the facility

        Returns:
            list: A list of reviews of the facility
        """
        reviews = []
        # Reviews does not have park and facility infomation, need to query booking first
        park = [park for park in db.parks if park.get_name() == park_name][0]
        if park is None:
            return {'error': 'Park not found'}
        facility = [facility for facility in park.get_facilities() if facility.get_name() == facility_name][0]
        if facility is None:
            return {'error': 'Facility not found'}

        profile_dict = {profile.get_id(): profile for profile in db.profiles}
        review_dict = {review.get_id(): review for review in db.reviews}

        for booking in (b for b in db.bookings if b.get_park() == park and b.get_facility() == facility):
            booker = profile_dict.get(booking.get_booker())
            if booker is None:
                return {'error': 'Booker not found'}

            review = review_dict.get(booking.get_id())

            if booker and review:
                reviews.append({'rating': review.get_rating(),
                                'comment': review.get_comment(),
                                'reviewer': booker.get_username()
                                })

        if len(reviews) == 0:
            return {'error': 'No reviews found'}

        # Sort reviews by rating, highest to lowest
        sorted_reviews = sorted(reviews, key=lambda x: x['rating'], reverse=True)
        return sorted_reviews

def calculate_distance(lat1, lat2, lon1, lon2):
        """ Method to calculate distance between two points

        Args:
            lat1 (float): The latitude of the first point
            lat2 (float): The latitude of the second point
            lon1 (float): The longitude of the first point
            lon2 (float): The longitude of the second point

        Returns:
            float: The distance between the two points
        """
        from math import radians, sin, cos, sqrt, atan2

        # Convert latitude and longitude from degrees to radians
        lat1_rad = radians(lat1)
        lat2_rad = radians(lat2)
        lon1_rad = radians(lon1)
        lon2_rad = radians(lon2)

        # Radius of the Earth in km
        R = 6373.0

        # Calculate the difference between in latitude and longitude
        dlat = abs(lat2_rad - lat1_rad)
        dlon = abs(lon2_rad - lon1_rad)

        # Calculate the distance between the two points using the Haversine formula
        a = sin(dlat / 2)**2 + cos(lat1) * cos(lat2) * sin(dlon / 2)**2
        c = 2 * atan2(sqrt(a), sqrt(1 - a))
        distance = R * c

        return distance
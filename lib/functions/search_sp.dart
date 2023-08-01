import 'dart:math' show atan2, cos, pi, sin, sqrt;

class Location {
  final double latitude;
  final double longitude;

  const Location({required this.latitude, required this.longitude});

  /// Calculates the distance (in meters) between two locations using the Haversine formula.
  double distanceTo(Location other) {
    const R = 6371e3; // Earth's radius in meters
    final phi1 = latitude * pi / 180; // Latitude of location 1 in radians
    final phi2 = other.latitude * pi / 180; // Latitude of location 2 in radians
    final deltaPhi = (other.latitude - latitude) * pi / 180; // Difference in latitudes in radians
    final deltaLambda = (other.longitude - longitude) * pi / 180; // Difference in longitudes in radians

    final a = sin(deltaPhi/2) * sin(deltaPhi/2) +
            cos(phi1) * cos(phi2) *
            sin(deltaLambda/2) * sin(deltaLambda/2);
    final c = 2 * atan2(sqrt(a), sqrt(1-a));

    return R * c;
  }
}

class ServiceProvider {
  final String email;
  final Location location;
  final List<String> services;

  const ServiceProvider({
    required this.email,
    required this.location,
    required this.services,
  });
}

// Usage:
const userLocation = Location(latitude: 40.7128, longitude: -74.0060); // Example user location
const maxDistance = 5000.0; // Maximum distance (in meters)

final serviceProviders = [
  ServiceProvider(
    email: 'sp1@example.com',
    location: Location(latitude: 40.7142, longitude: -74.0064),
    services: ['plumbing', 'electrician'],
  ),
  ServiceProvider(
    email: 'sp2@example.com',
    location: Location(latitude: 40.7125, longitude: -74.0067),
    services: ['plumbing', 'carpentry'],
  ),
  ServiceProvider(
    email: 'sp3@example.com',
    location: Location(latitude: 40.7147, longitude: -74.0089),
    services: ['electrician', 'carpentry'],
  ),
];

final closestServiceProviders = serviceProviders
  .where((sp) => userLocation.distanceTo(sp.location) <= maxDistance)
  .toList();

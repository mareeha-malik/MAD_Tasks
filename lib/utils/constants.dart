class AppConstants {
  static const String appName = 'Remember the Location';
  static const String dbName = 'locations.db';
  static const int dbVersion = 1;

  static const List<String> passwordHints = [
    'At least 6 characters',
    'Contains letters and numbers',
  ];

  static const double defaultPadding = 16.0;
  static const double defaultBorderRadius = 8.0;
}

class AppImages {
  static const String defaultLocation = 'assets/images/default_location.png';
}

class AppStrings {
  static const String registerTitle = 'Create Account';
  static const String locationsTitle = 'My Locations';
  static const String addLocationTitle = 'Add Location';
  static const String editLocationTitle = 'Edit Location';
  static const String profileTitle = 'My Profile';
}
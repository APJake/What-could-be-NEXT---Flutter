import 'package:intl/intl.dart';

/// Static helper class for DateTime conversions and formatting
class AppDateTime {
  AppDateTime._(); // Private constructor to prevent instantiation

  static DateTime get now => DateTime.now();

  static String get nowAsString => toRawString(now);

  /// Converts a DateTime to a MongoDB-compatible UTC string
  /// Format: ISO 8601 (e.g., "2024-12-02T10:30:00.000Z")
  static String toRawString(DateTime dateTime) {
    final utcDateTime = dateTime.toUtc();
    return utcDateTime.toIso8601String();
  }

  /// Parses a MongoDB UTC string and converts it to local device timezone
  /// Input format: ISO 8601 UTC string (e.g., "2024-12-02T10:30:00.000Z")
  /// Returns: DateTime in local timezone
  static DateTime parse(String rawDate) {
    final utcDateTime = DateTime.parse(rawDate);
    return utcDateTime.toLocal();
  }

  /// Generates a human-readable duration string from a past date until now
  /// Examples: "2 minutes ago", "3 hours ago", "5 days ago", "2 months ago"
  static String timeSince(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inSeconds < 60) {
      return '${difference.inSeconds} ${_pluralize(difference.inSeconds, 'second')} ago';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes} ${_pluralize(difference.inMinutes, 'minute')} ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} ${_pluralize(difference.inHours, 'hour')} ago';
    } else if (difference.inDays < 30) {
      return '${difference.inDays} ${_pluralize(difference.inDays, 'day')} ago';
    } else if (difference.inDays < 365) {
      final months = (difference.inDays / 30).floor();
      return '$months ${_pluralize(months, 'month')} ago';
    } else {
      final years = (difference.inDays / 365).floor();
      return '$years ${_pluralize(years, 'year')} ago';
    }
  }

  /// Helper method to handle singular/plural forms
  static String _pluralize(int count, String word) {
    return count == 1 ? word : '${word}s';
  }

  /// Formats a DateTime to a readable string
  /// Format: "Dec 2, 2024 10:30 AM"
  static String toReadableString(DateTime dateTime) {
    return DateFormat('MMM d, y h:mm a').format(dateTime);
  }

  /// Formats a DateTime to date only
  /// Format: "Dec 2, 2024"
  static String toDateString(DateTime dateTime) {
    return DateFormat('MMM d, y').format(dateTime);
  }

  /// Formats a DateTime to time only
  /// Format: "10:30 AM"
  static String toTimeString(DateTime dateTime) {
    return DateFormat('h:mm a').format(dateTime);
  }
}

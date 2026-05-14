import 'package:flutter/material.dart';
import 'package:mobile/utils/colors.dart';

/// Lightweight, UI-oriented company model. The backend doesn't store branding
/// fields (logo letter, brand colour, tagline copy), so we derive them on the
/// client from the backend's [CompanyResponseDto] when none is provided —
/// keeping the existing UI shape intact while the data behind it is real.
class Company {
  final String id;
  final String name;
  final String tagline;
  final String logoLetter;
  final Color brandColor;
  final double rating;
  final int routesCount;

  const Company({
    required this.id,
    required this.name,
    required this.tagline,
    required this.logoLetter,
    required this.brandColor,
    required this.rating,
    required this.routesCount,
  });

  /// Build a UI [Company] from the backend `CompanyResponseDto` JSON payload.
  /// Missing optional fields fall back to sensible defaults so the UI never
  /// renders empty cards.
  factory Company.fromBackend(Map<String, dynamic> json) {
    final id = json['id']?.toString() ?? '';
    final name = json['name']?.toString() ?? 'Unknown';
    final tagline = (json['tagline']?.toString().isNotEmpty ?? false)
        ? json['tagline'].toString()
        : 'Travel with comfort';
    final rating = (json['rating'] is num)
        ? (json['rating'] as num).toDouble()
        : 5.0;

    return Company(
      id: id,
      name: name,
      tagline: tagline,
      logoLetter: name.trim().isEmpty ? '?' : name.trim()[0].toUpperCase(),
      brandColor: _deriveBrandColor(id, name),
      rating: rating,
      // Backend doesn't surface a route count on this endpoint; default to 0
      // until /companies/{id}/routes is wired in.
      routesCount: 0,
    );
  }

  /// Deterministic brand colour from the company id (UUID). Same input always
  /// maps to the same hue so the visual identity of a company stays stable
  /// across sessions even though it isn't stored server-side.
  static Color _deriveBrandColor(String id, String name) {
    const palette = <Color>[
      DColors.primary,
      Color(0xFFE07A1F),
      Color(0xFF1E66D0),
      Color(0xFF6B4FB8),
      Color(0xFF1B8A6B),
      Color(0xFFC0392B),
      Color(0xFF2980B9),
      Color(0xFF8E44AD),
    ];
    final key = id.isNotEmpty ? id : name;
    final hash = key.codeUnits.fold<int>(0, (acc, c) => acc + c);
    return palette[hash % palette.length];
  }
}

/// Cache of companies fetched from the backend so any widget — including
/// the ticket card and booking confirmation — can resolve a company by id
/// without hitting the network again. Populated by [CompaniesNotifier].
class CompanyCache {
  CompanyCache._();
  static final Map<String, Company> _byId = {};

  static void replaceAll(List<Company> companies) {
    _byId
      ..clear()
      ..addEntries(companies.map((c) => MapEntry(c.id, c)));
  }

  static Company? byId(String? id) {
    if (id == null || id.isEmpty) return null;
    return _byId[id];
  }

  static Company fallback() => const Company(
        id: '',
        name: 'Bus Operator',
        tagline: 'Travel with comfort',
        logoLetter: 'B',
        brandColor: DColors.primary,
        rating: 5.0,
        routesCount: 0,
      );
}

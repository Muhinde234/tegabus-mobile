import 'package:flutter/material.dart';
import 'package:mobile/utils/colors.dart';

/// Lightweight, UI-only company model. Not generated with freezed because
/// nothing serializes it — it lives entirely in the dummy service layer for
/// now and will likely be replaced by a backend DTO during integration.
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
}

/// Static catalogue of dummy companies used across the app.
class DummyCompanies {
  static const volcano = Company(
    id: 'volcano',
    name: 'Volcano Express',
    tagline: 'Comfort across Rwanda',
    logoLetter: 'V',
    brandColor: DColors.primary,
    rating: 4.7,
    routesCount: 12,
  );

  static const horizon = Company(
    id: 'horizon',
    name: 'Horizon Coach',
    tagline: 'Smooth city-to-city rides',
    logoLetter: 'H',
    brandColor: Color(0xFFE07A1F),
    rating: 4.5,
    routesCount: 9,
  );

  static const ritco = Company(
    id: 'ritco',
    name: 'Ritco Star',
    tagline: 'The trusted national line',
    logoLetter: 'R',
    brandColor: Color(0xFF1E66D0),
    rating: 4.4,
    routesCount: 18,
  );

  static const virunga = Company(
    id: 'virunga',
    name: 'Virunga Travel',
    tagline: 'Long-distance specialists',
    logoLetter: 'V',
    brandColor: Color(0xFF6B4FB8),
    rating: 4.6,
    routesCount: 7,
  );

  static const trinity = Company(
    id: 'trinity',
    name: 'Trinity Liner',
    tagline: 'Cross-border luxury coaches',
    logoLetter: 'T',
    brandColor: Color(0xFF1B8A6B),
    rating: 4.8,
    routesCount: 5,
  );

  static const all = <Company>[
    volcano,
    horizon,
    ritco,
    virunga,
    trinity,
  ];

  static Company byId(String id) =>
      all.firstWhere((c) => c.id == id, orElse: () => volcano);
}

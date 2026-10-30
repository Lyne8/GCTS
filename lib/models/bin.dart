// A "model" describes the shape of the data your app works with.
// This file describes ONE waste bin.

// An enum is a fixed list of allowed values.
// A bin's status can only be one of these three.
enum BinStatus { normal, warning, full }

// A class is a blueprint. Each Bin object made from it holds one bin's data.
class Bin {
  // "final" means the value is set once and never changed afterwards.
  final String id; // unique code, e.g. 'B001'
  final String name; // readable name, e.g. 'Boma Grounds'
  final double lat; // latitude (north/south position on the map)
  final double lng; // longitude (east/west position on the map)
  final int fillLevel; // how full the bin is, from 0 to 100 (%)
  final DateTime updatedAt; // when the sensor last reported

  // The constructor: the code that builds a Bin.
  // "required" means you must provide that value when creating a Bin.
  const Bin({
    required this.id,
    required this.name,
    required this.lat,
    required this.lng,
    required this.fillLevel,
    required this.updatedAt,
  });

  // A "getter" works out a value from other values.
  // Here it turns the fill percentage into a status.
  // The ? : pattern means "if this is true, use X, otherwise use Y".
  BinStatus get status => fillLevel >= 80
      ? BinStatus.full // 80% or more
      : fillLevel >= 50
          ? BinStatus.warning // 50% to 79%
          : BinStatus.normal; // below 50%

  // Because fields are "final", we can't edit a Bin.
  // copyWith makes a NEW Bin that is identical except for the new fill level.
  // "int? fillLevel" means the value is optional.
  Bin copyWith({int? fillLevel}) => Bin(
        id: id,
        name: name,
        lat: lat,
        lng: lng,
        // "??" means: use the new value, or keep the old one if none was given.
        fillLevel: fillLevel ?? this.fillLevel,
        updatedAt: DateTime.now(), // stamp the current time
      );
}
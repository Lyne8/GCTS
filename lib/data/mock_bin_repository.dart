import 'dart:math'; // gives us Random, for making random numbers
import '../models/bin.dart';
import 'bin_repository.dart';

// "implements" means this class follows the BinRepository contract.
// "Mock" means fake: it pretends to be sensors, since you have no hardware.
class MockBinRepository implements BinRepository {
  // Random number generator. The underscore "_" makes it private,
  // so only this class can use it.
  final _rand = Random();

  // Our starting list of five bins around Fort Portal.
  // The coordinates are close approximations. You can replace them later
  // with real ones from Google Maps.
  List<Bin> _bins = [
    Bin(id: 'B001', name: 'Fort Portal Main Market', lat: 0.6710, lng: 30.2750, fillLevel: 20, updatedAt: DateTime.now()),
    Bin(id: 'B002', name: 'Boma Grounds', lat: 0.6735, lng: 30.2745, fillLevel: 55, updatedAt: DateTime.now()),
    Bin(id: 'B003', name: 'Kabarole Taxi Park', lat: 0.6690, lng: 30.2770, fillLevel: 78, updatedAt: DateTime.now()),
    Bin(id: 'B004', name: 'Central Division Office', lat: 0.6720, lng: 30.2790, fillLevel: 35, updatedAt: DateTime.now()),
    Bin(id: 'B005', name: 'North Division Junction', lat: 0.6790, lng: 30.2740, fillLevel: 10, updatedAt: DateTime.now()),
  ];

  // "@override" tells Dart we are filling in a method from the contract.
  // "async*" marks a function that sends out values one at a time.
  @override
  Stream<List<Bin>> watchBins() async* {
    // "yield" sends a value into the stream.
    // First, send the starting list straight away so the screen isn't empty.
    yield _bins;

    // "yield*" sends everything from another stream.
    // Stream.periodic runs the code below again and again, every 3 seconds.
    yield* Stream.periodic(const Duration(seconds: 3), (_) {
      // .map goes through every bin and creates an updated copy of it.
      _bins = _bins.map((b) {
        // Add a random number from 0 to 7 to the fill level,
        // pretending the sensor measured more rubbish.
        var next = b.fillLevel + _rand.nextInt(8);

        // If it went past 100%, pretend a truck emptied the bin.
        if (next > 100) next = 5;

        return b.copyWith(fillLevel: next);
      }).toList(); // turn the result back into a list

      return _bins; // this list is sent to the screen
    });
  }
}
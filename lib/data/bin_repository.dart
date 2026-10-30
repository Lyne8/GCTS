import '../models/bin.dart'; // lets us use the Bin class from the other file

// An "abstract class" is a contract. It says WHAT must be done,
// but not HOW. Any class that follows the contract must provide the
// methods listed here.
//
// Today the data comes from a fake simulator.
// Later the same contract will be followed by a Firebase class
// that reads real ESP32 sensor data. The screens won't need to change.
abstract class BinRepository {
  // A Stream is like a pipe that delivers new data over time,
  // instead of giving you one answer and stopping.
  // This one delivers a fresh list of bins every time something changes.
  Stream<List<Bin>> watchBins();
}
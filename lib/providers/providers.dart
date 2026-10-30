import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/bin_repository.dart';
import '../data/mock_bin_repository.dart';
import '../models/bin.dart';

// A "provider" is a shared place where the app gets its data.
// Any screen can ask a provider for what it needs.

// This provider hands out the data source.
// It's the ONE place to swap MockBinRepository for a real one later.
final binRepositoryProvider =
    Provider<BinRepository>((ref) => MockBinRepository());

// This provider turns the data source's stream into something screens
// can watch. Whenever the stream sends new bins, every screen watching
// this provider updates by itself.
final binsProvider = StreamProvider<List<Bin>>(
  (ref) => ref.watch(binRepositoryProvider).watchBins(),
);
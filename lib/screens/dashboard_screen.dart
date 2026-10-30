import 'package:flutter/material.dart'; // Flutter's ready-made UI widgets
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/bin.dart';
import '../providers/providers.dart';

// In Flutter, everything on screen is a "widget".
// A ConsumerWidget is a widget that can listen to providers
// and rebuild itself when their data changes.
class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  // Helper: picks a colour for each status.
  Color _color(BinStatus s) => switch (s) {
        BinStatus.normal => Colors.green,
        BinStatus.warning => Colors.orange,
        BinStatus.full => Colors.red,
      };

  // build() describes what the screen looks like.
  // Flutter calls it again every time the data changes.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // "ref.watch" listens to the provider.
    // The result is an AsyncValue: loading, error, or data.
    final bins = ref.watch(binsProvider);

    // Scaffold is the basic page layout (top bar + body).
    return Scaffold(
      appBar: AppBar(title: const Text('GCTS – Bin Monitor')),

      // .when lets us say what to show in each of the three situations.
      body: bins.when(
        // 1. Still waiting for the first data: show a spinner.
        loading: () => const Center(child: CircularProgressIndicator()),

        // 2. Something went wrong: show the error text.
        error: (e, _) => Center(child: Text('Error: $e')),

        // 3. Data arrived: build a scrolling list of bins.
        data: (list) => ListView.separated(
          padding: const EdgeInsets.all(12), // space around the list
          itemCount: list.length, // how many rows
          separatorBuilder: (_, __) => const SizedBox(height: 8), // gap between rows

          // itemBuilder runs once for each bin. "i" is its position (0, 1, 2...).
          itemBuilder: (_, i) {
            final b = list[i]; // the bin for this row

            // A Card is a box with a shadow and rounded corners.
            return Card(
              child: Padding(
                padding: const EdgeInsets.all(12),
                // Column stacks its children from top to bottom.
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start, // align left
                  children: [
                    // Row puts its children side by side.
                    Row(
                      // push name to the left and percentage to the right
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(b.name,
                            style: Theme.of(context).textTheme.titleMedium),
                        // ${...} puts a value inside text
                        Text('${b.fillLevel}%',
                            style: TextStyle(
                                color: _color(b.status),
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                    const SizedBox(height: 8), // small vertical gap

                    // The progress bar. "value" is between 0.0 and 1.0,
                    // so we divide the percentage by 100.
                    LinearProgressIndicator(
                      value: b.fillLevel / 100,
                      color: _color(b.status),
                      minHeight: 8,
                    ),

                    // "if" inside a list: only show this warning
                    // when the bin is full.
                    if (b.status == BinStatus.full)
                      const Padding(
                        padding: EdgeInsets.only(top: 6),
                        child: Text('⚠ Needs collection',
                            style: TextStyle(color: Colors.red)),
                      ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
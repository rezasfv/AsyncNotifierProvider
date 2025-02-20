import 'package:async1/pages/counter/counter_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CounterPage extends ConsumerWidget {
  const CounterPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final counter = ref.watch(counterProvider);
    print(counter);
    return Scaffold(
      appBar: AppBar(title: const Text('Counter')),
      body: Center(
        child: counter.when(
          skipLoadingOnRefresh: false,
          data: (count) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('$count'),
                SizedBox(height: 20),
                Row(
                  children: [
                    FloatingActionButton(
                      onPressed: () {
                        ref.read(counterProvider.notifier).decrement();
                      },
                      child: Icon(Icons.remove),
                    ),

                    FloatingActionButton(
                      onPressed: () {
                        ref.read(counterProvider.notifier).increment();
                      },
                      child: Icon(Icons.add),
                    ),
                  ],
                ),
              ],
            );
          },
          error:
              (e, st) => Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(e.toString()),
                  SizedBox(height: 20),
                  OutlinedButton(
                    onPressed: () {
                      ref.invalidate(counterProvider);
                    },
                    child: Text('Refresh'),
                  ),
                ],
              ),

          loading: () => CircularProgressIndicator(),
        ),
      ),
    );
  }
}

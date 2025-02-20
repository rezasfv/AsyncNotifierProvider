import 'dart:math';

import 'package:async1/models/activity.dart';
import 'package:async1/pages/async_activity/async_activity_provider.dart';
import 'package:bulleted_list/bulleted_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AsyncActivityPage extends ConsumerWidget {
  const AsyncActivityPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activityState = ref.watch(asyncActivityProvider);
    print('asyncActivityProvider');
    return Scaffold(
      appBar: AppBar(title: Text('asyncActivityProvider')),
      body: Center(
        child: activityState.when(
          skipLoadingOnRefresh: false,
          data: (activity) => ActivityWidget(activity: activity),
          error:
              (e, st) => Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Text(e.toString())],
              ),

          loading: () => CircularProgressIndicator(),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          final randomNumber = Random().nextInt(activityTypes.length);
          ref
              .read(asyncActivityProvider.notifier)
              .fetchActivity(activityTypes[randomNumber]);
        },
        label: Text('New'),
      ),
    );
  }
}

class ActivityWidget extends StatelessWidget {
  const ActivityWidget({super.key, required this.activity});

  final Activity activity;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(25),

      child: Column(
        children: [
          Text(
            activity.type,

            style: Theme.of(context).textTheme.headlineMedium,
          ),

          const Divider(),

          BulletedList(
            bullet: const Icon(Icons.check, color: Colors.green),

            listItems: [
              'activity: ${activity.activity}',

              'availability: ${activity.availability}',

              'participants: ${activity.participants}',

              'price: ${activity.price}',

              'accessibility: ${activity.accessibility}',

              'duration: ${activity.duration}',

              'link: ${activity.link.isEmpty ? 'no link' : activity.link}',

              'kidFriendly: ${activity.kidFriendly}',

              'key: ${activity.key}',
            ],

            style: Theme.of(context).textTheme.titleLarge,
          ),
        ],
      ),
    );
  }
}

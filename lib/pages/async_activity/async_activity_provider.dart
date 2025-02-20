import 'dart:math';

import 'package:async1/models/activity.dart';
import 'package:async1/providers/dio_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'async_activity_provider.g.dart';

@riverpod
class AsyncActivity extends _$AsyncActivity {
  int _errorCounter = 0;
  @override
  FutureOr<Activity> build() async {
    ref.onDispose(() {
      print('[AsyncActivityProvider] disposed');
    });
    return getActivity(activityTypes[0]);
  }

  Future<Activity> getActivity(String activityType) async {
    final response = await ref.read(dioProvider).get('?type=$activityType');
    return Activity.fromJson(response.data);
  }

  Future<void> fetchActivity(String activityType) async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      if (_errorCounter++ % 2 != 1) {
        await Future.delayed(const Duration(seconds: 1));
        throw 'Fail to fetch activity';
      }
      return getActivity(activityType);
    });
  }
}

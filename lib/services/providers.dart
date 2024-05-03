import 'package:bayad_test/model/api_state.dart';
import 'package:bayad_test/services/api_service.dart';
import 'package:bayad_test/services/data_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final apiProvider = Provider<DioUtil>((ref) => DioUtil());

final apiNotifierProvider = StateNotifierProvider<ApiNotifier, ApiState>((ref) {
  return ApiNotifier(DioUtil());
});

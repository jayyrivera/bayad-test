import 'package:bayad_test/model/data_model.dart';

class ApiState {
  final bool isLoading;
  final List<DataModel>? data;
  final String? errorMessage;

  ApiState({this.isLoading = false, this.data, this.errorMessage});

  ApiState copyWith(
      {bool? isLoading, List<DataModel>? data, String? errorMessage}) {
    return ApiState(
      isLoading: isLoading ?? this.isLoading,
      data: data ?? this.data,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

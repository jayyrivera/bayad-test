import 'package:bayad_test/model/api_state.dart';
import 'package:bayad_test/model/data_model.dart';
import 'package:bayad_test/services/api_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ApiNotifier extends StateNotifier<ApiState> {
  final DioUtil _dioUtil;

  ApiNotifier(this._dioUtil) : super(ApiState()) {
    fetchData();
  }

  Future<void> fetchData() async {
    state = state.copyWith(isLoading: true);
    try {
      var response = await _dioUtil.call(
          '/api/5289c453cc1945c7a08590abc964cd4f/movies',
          method: MethodRequest.get,
          request: {});
      var list = (response?.data as List)
          .map((item) => DataModel.fromJson(item))
          .toList();

      state = state.copyWith(isLoading: false, data: list);
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }

  Future<void> updateData(DataModel model) async {
    state = state.copyWith(isLoading: true);
    try {
      // Attempt to update the movie on the server
      var response = await _dioUtil.call(
          '/api/5289c453cc1945c7a08590abc964cd4f/movies/${model.sId}',
          method: MethodRequest.put,
          request: {
            'movie_title': model.movieTitle,
            'movie_subtitle': model.movieSubtitle,
            'image_url': model.imageUrl,
            'read': 1
          });

      // Check if the server returned a successful response
      if (response != null && response.statusCode == 200) {
        // Assuming state.data is a list of DataModel objects
        List<DataModel> updatedList = state.data!.map((movie) {
          // Find the movie with the matching ID and update its 'read' status

          if (movie.sId == model.sId) {
            return DataModel(
                sId: movie.sId, // keep the same id
                movieTitle: movie.movieTitle, // keep the same movie title
                movieSubtitle: movie.movieSubtitle, // keep the same subtitle
                imageUrl: movie.imageUrl, // keep the same image URL
                read: 1 // update the 'read' status
                );
          }
          return movie;
        }).toList();

        // Update the state with the modified list
        state = state.copyWith(isLoading: false, data: updatedList);
      } else {
        // If the server response is not successful, handle it accordingly
        throw Exception('Failed to update the data');
      }
    } catch (e) {
      // Update the state to reflect the error
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }

  Future<void> deleteData({required String id}) async {
    state = state.copyWith(isLoading: true);
    try {
      var response = await _dioUtil.call(
          '/api/5289c453cc1945c7a08590abc964cd4f/movies/$id',
          method: MethodRequest.delete,
          request: {});
      if (response != null && response.statusCode == 200) {
        // Check if deletion was successful
        List<DataModel> updatedList =
            state.data!.where((item) => item.sId != id).toList();
        state = state.copyWith(isLoading: false, data: updatedList);
      } else {
        throw Exception('Failed to delete the data');
      }
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }
}

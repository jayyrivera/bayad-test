import 'package:dio/dio.dart';

enum MethodRequest { post, get, put, delete, special, patch }

class DioUtil {
  static final Dio _dio = Dio();

  DioUtil() {
    _initializeDio();
  }

  Future<void> _initializeDio() async {
    _dio.options.baseUrl = 'https://crudcrud.com';
    _dio.options.connectTimeout = const Duration(seconds: 90);
    _dio.options.receiveTimeout = const Duration(seconds: 30);
    _dio.options.headers = {'Accept': 'application/json'};

    _dio.interceptors.add(
        LogInterceptor(request: true, requestBody: true, responseBody: true));
  }

  Future<Response?> call(String url,
      {MethodRequest method = MethodRequest.post,
      required Map<String, dynamic> request,
      Map<String, String>? header,
      String? token,
      bool useFormData = false,
      Interceptor? interceptor}) async {
    if (interceptor != null) {
      _dio.interceptors.add(interceptor);
    }

    if (header != null) {
      _dio.options.headers = header;
    }
    if (token != null) {
      if (header != null) {
        header.addAll({'Authorization': 'Bearer $token'});
        _dio.options.headers = header;
      } else {
        _dio.options.headers = {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        };
      }
      if (method == MethodRequest.put) {
        _dio.options.headers = {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/x-www-form-urlencoded'
        };
      }
    }

    try {
      Response response;
      switch (method) {
        case MethodRequest.get:
          response = await _dio.get(
            url,
            queryParameters: request,
          );
          break;
        case MethodRequest.put:
          response = await _dio.put(
            url,
            data: request,
          );
          break;
        case MethodRequest.patch:
          response = await _dio.patch(
            url,
            data: request,
          );
          break;
        case MethodRequest.delete:
          response = await _dio.delete(
            url,
            data: useFormData ? FormData.fromMap(request) : request,
          );
          break;

        case MethodRequest.special:
          response = await _dio.post(
            url,
            queryParameters: request,
          );
          break;
        default:
          response = await _dio.post(
            url,
            data: useFormData ? FormData.fromMap(request) : request,
          );
      }

      return response;
    } on DioException catch (e) {
      return _handleError(e);
    }
  }

  Response _handleError(DioException error) {
    Map<String, dynamic> responseBody;

    if (error.type == DioExceptionType.connectionTimeout) {
      responseBody = {
        'failure': true,
        'code': 2000,
        'message': 'Connection Timeout',
      };
    } else if (error.type == DioExceptionType.receiveTimeout) {
      responseBody = {
        'failure': true,
        'code': 3000,
        'message': 'Receive Timeout',
      };
    } else if (error.response == null) {
      responseBody = {
        'failure': true,
        'code': 3000,
        'message': 'Failed to Connect'
      };
    } else if (error.response?.statusCode == 401) {
      responseBody = {'failure': true, 'code': 401, 'message': 'Unauthorized'};
    } else if (error.response?.statusCode == 502) {
      responseBody = {
        'failure': true,
        'code': 502,
        'message': '502 Server Error',
        ...error.response!.data
      };
    } else {
      responseBody = {'failure': true, ...error.response!.data};
    }

    return Response(
      requestOptions: error.requestOptions,
      data: responseBody,
      statusCode: responseBody['code'],
    );
  }
}

class CustomInterceptors extends Interceptor {
  @override
  Future onResponse(
      Response response, ResponseInterceptorHandler handler) async {
    return super.onResponse(response, handler);
  }

  @override
  Future onError(DioException err, ErrorInterceptorHandler handler) async {
    return handler.next(err);
  }
}

// ex_dio.dart
import 'package:dio/dio.dart';

class ExDio {
  final Dio _dio = Dio(); // Tạo một instance của Dio

  CancelToken _cancelToken = CancelToken(); // Token để hủy yêu cầu

  ExDio() {
    // Thêm Interceptor để log các yêu cầu, response, và errors
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          print('Request: ${options.method} ${options.path}');
          return handler.next(options); // Tiếp tục với request
        },
        onResponse: (response, handler) {
          print('Response: ${response.statusCode} ${response.data}');
          return handler.next(response); // Tiếp tục với response
        },
        onError: (DioError e, handler) {
          print('Error: ${e.message}');
          return handler.next(e); // Tiếp tục với error
        },
      ),
    );

    // Đặt thời gian chờ cho yêu cầu
    _dio.options.connectTimeout = const Duration(seconds: 5);
    _dio.options.receiveTimeout = const Duration(seconds: 3);
  }

  // Phương thức để fetch dữ liệu từ một API
  Future<Map<String, dynamic>> fetchData() async {
    try {
      final response = await _dio.get(
        'https://jsonplaceholder.typicode.com/posts/1',
        cancelToken: _cancelToken, // Sử dụng cancel token để hủy yêu cầu
      );
      return response.data;
    } catch (e) {
      print('Error fetching data: $e');
      return {};
    }
  }

  // Phương thức để upload file lên một API
  Future<Map<String, dynamic>> uploadFile(String filePath) async {
    try {
      FormData formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(filePath, filename: 'upload.jpg'),
      });

      final response = await _dio.post(
        'https://example.com/upload',
        data: formData,
        cancelToken: _cancelToken,
      );

      return response.data;
    } catch (e) {
      print('Error uploading file: $e');
      return {};
    }
  }

  // Phương thức để hủy các yêu cầu đang thực thi
  void cancelRequests() {
    _cancelToken.cancel('Request cancelled');
    _cancelToken = CancelToken(); // Tạo một token mới cho các yêu cầu tiếp theo
  }
}

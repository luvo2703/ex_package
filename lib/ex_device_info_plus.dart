import 'package:flutter/material.dart';
import 'ex_dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:device_info_plus/device_info_plus.dart';

class DeviceInfoPlus extends StatefulWidget {
  const DeviceInfoPlus({Key? key}) : super(key: key);

  @override
  State<DeviceInfoPlus> createState() => _DeviceInfoPlusState();
}

class _DeviceInfoPlusState extends State<DeviceInfoPlus> {
  Map<String, dynamic> _data = {}; // Dữ liệu từ API được lưu vào _data
  final ExDio _exDio = ExDio(); // Instance của ExDio để thực hiện các tác vụ API

  @override
  void initState() {
    super.initState();
    _fetchData(); // Fetch dữ liệu khi widget được khởi tạo
    _getDeviceInfo(); // Lấy thông tin thiết bị khi widget được khởi tạo
  }

  // Phương thức để fetch dữ liệu từ API
  Future<void> _fetchData() async {
    final data = await _exDio.fetchData(); // Fetch dữ liệu từ API sử dụng ExDio
    setState(() {
      _data = data; // Cập nhật dữ liệu thu được vào _data để hiển thị trên giao diện
    });
  }

  // Phương thức để lấy thông tin của thiết bị
  Future<void> _getDeviceInfo() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    try {
      if (Theme.of(context).platform == TargetPlatform.android) {
        AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
        print('Device Info: ${androidInfo.toString()}');
      } else if (Theme.of(context).platform == TargetPlatform.iOS) {
        IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
        print('Device Info: ${iosInfo.toString()}');
      }
    } catch (e) {
      print('Error getting device info: $e');
    }
  }

  // Phương thức để upload file
  Future<void> _uploadFile() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final result = await _exDio.uploadFile(pickedFile.path); // Upload file được chọn từ thư viện hình ảnh
      print('Upload result: $result');
    }
  }

  void _cancelRequest() {
    _exDio.cancelRequests(); // Hủy yêu cầu đang thực hiện bởi ExDio
  }
c
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Device Info Plus'),
      ),
      body: _data.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Title: ${_data['title']}'),
            const SizedBox(height: 8.0),
            Text('Body: ${_data['body']}'),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _uploadFile,
              child: const Text('Upload File'),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _cancelRequest,
              child: const Text('Cancel Request'),
            ),
          ],
        ),
      ),
    );
  }
}

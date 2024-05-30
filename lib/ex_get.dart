// ex_get.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart'; // Import package GetX

// Controller để quản lý trạng thái
class CounterController extends GetxController {
  var count = 0.obs; // Sử dụng Rx (reactive) để theo dõi sự thay đổi của count

  void increment() {
    count++; // Tăng giá trị count
  }
}


class ExGetApp extends StatelessWidget {
  const ExGetApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'GetX Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

// Trang chính của ứng dụng
class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CounterController counterController = Get.put(CounterController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('GetX Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Obx(
                  () => Text(
                'Count: ${counterController.count}',
                style: Theme.of(context).textTheme.headlineMedium,
                    //đảm bảo rằng kiểu chữ được sử dụng cho văn bản này
                    // sẽ phù hợp với thiết lập giao diện người dùng hiện tại
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                counterController.increment();
              },
              child: const Text('Increment'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Get.to(() => const SecondPage());
              },
              child: const Text('Go to Second Page'),
            ),
          ],
        ),
      ),
    );
  }
}

// Trang thứ hai của ứng dụng
class SecondPage extends StatelessWidget {
  const SecondPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CounterController counterController = Get.find();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Second Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Obx(
                  () => Text(
                'Count: ${counterController.count}',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Get.back();
              },
              child: const Text('Back to Home Page'),
            ),
          ],
        ),
      ),
    );
  }
}

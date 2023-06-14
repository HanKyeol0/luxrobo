import 'package:flutter/material.dart';
import 'package:luxrobo/main.dart';
import 'package:luxrobo/styles.dart';
import 'package:luxrobo/widgets/button.dart';
import 'package:luxrobo/widgets/field.dart';
import 'package:luxrobo/services/api_data.dart';

class Setting02 extends StatefulWidget {
  const Setting02({Key? key}) : super(key: key);

  @override
  State<Setting02> createState() => _Setting02State();
}

class _Setting02State extends State<Setting02> {
  GlobalData globalData = GlobalData();

  @override
  Widget build(BuildContext context) {
    return LuxroboScaffold(
      currentIndex: 3,
      body: Column(
        children: [
          const SizedBox(height: 91),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                Row(
                  children: [
                    GoBack(
                      onPressed: () =>
                          Navigator.pushNamed(context, '/setting01'),
                    ),
                    const SizedBox(width: 15),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        '차량 번호 등록',
                        style: titleText(),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 52),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '차량 번호',
                    style: fieldTitle(fontSize: 16),
                  ),
                ),
                const SizedBox(height: 10),
                const CarRegisterField(),
                const SizedBox(height: 30),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '현재 등록된 차량',
                    style: fieldTitle(fontSize: 16),
                  ),
                ),
                const SizedBox(height: 10),
                FutureBuilder(
                  future: globalData.carNumbersFuture,
                  builder: (context, carList) {
                    if (carList.hasData) {
                      return ListView();
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:multipleprojects/widgets/appbar.dart';

class DeviceInfoHomeScreen extends StatefulWidget {
  const DeviceInfoHomeScreen({Key? key}) : super(key: key);

  @override
  _DeviceInfoHomeScreenState createState() => _DeviceInfoHomeScreenState();
}

class _DeviceInfoHomeScreenState extends State<DeviceInfoHomeScreen> {
  static const platform =
      MethodChannel('com.mehmettezcan.multipleprojects/device');
  String _batteryLevel = 'Unknown battery level.';
  String manufacturer = 'Not available';
  String deviceModel = 'Not available';
  String systemName = 'Not available';
  String systemVersion = 'Not available';

  Future<void> _getDeviceInfo() async {
    try {
      if (Platform.isAndroid) {
        manufacturer = await platform.invokeMethod('getManufacturer');
      }

      if (Platform.isIOS) {
        systemVersion = await platform.invokeMethod('receiveSystemVersion');

        systemName = await platform.invokeMethod('receiveSystemName');
      }
      deviceModel = await platform.invokeMethod('getModel');

      String batteryLevel;
      final int result = await platform.invokeMethod('getBatteryLevel');

      batteryLevel = 'Battery level at $result % .';
      _batteryLevel = batteryLevel;
    } catch (e) {
      print(e.toString());
    } finally {
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    _getDeviceInfo();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: PrimaryAppBarWithText(
          'Device Info',
          showBackButton: true,
        ),
        body: Container(
          padding: const EdgeInsets.all(12),
          child: _buildBody(context),
        ),
      ),
    );
  }

  _buildBody(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildAreas(
          'Model',
          deviceModel,
        ),
        _buildAreas(
          'Battery Level',
          _batteryLevel,
        ),
        if (Platform.isAndroid)
          _buildAreas(
            'Manufacturer',
            manufacturer,
          ),
        if (Platform.isIOS)
          _buildAreas(
            'System Name',
            systemName,
          ),
        if (Platform.isIOS)
          _buildAreas(
            'System Version',
            systemVersion,
          ),
      ],
    );
  }

  Container _buildAreas(
    String label,
    String content,
  ) {
    return Container(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 4.0, bottom: 12),
            child: Text(content),
          ),
          Divider(),
        ],
      ),
    );
  }
}

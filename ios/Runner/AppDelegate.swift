import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
     let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
    let methodChannel = FlutterMethodChannel(name: "com.mehmettezcan.multipleprojects/device",
                                              binaryMessenger: controller.binaryMessenger)
    methodChannel.setMethodCallHandler({
      [weak self] (call: FlutterMethodCall, result: FlutterResult) -> Void in
      // Note: this method is invoked on the UI thread.
      if (call.method == "getBatteryLevel" ) {
        self?.receiveBatteryLevel(result: result)
        return
      } else if(call.method == "getModel"){
        self?.receiveDeviceName(result: result)
      } else if(call.method == "receiveSystemName"){
        self?.receiveSystemName(result: result)
      } else if(call.method == "receiveSystemVersion"){
        self?.receiveSystemVersion(result: result)
      } else {
        result(FlutterMethodNotImplemented)
        return
      }
      
    })

    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  private func receiveBatteryLevel(result: FlutterResult) {
    let device = UIDevice.current
    device.isBatteryMonitoringEnabled = true
    if device.batteryState == UIDevice.BatteryState.unknown {
      result(FlutterError(code: "UNAVAILABLE",
                          message: "Battery info unavailable",
                          details: nil))
    } else {
      result(Int(device.batteryLevel * 100))
    }
  }

  private func receiveDeviceName(result: FlutterResult) {
    let device = UIDevice.current
    let deviceName = device.name 
    result(String(deviceName))
  }

  private func receiveDeviceModel(result: FlutterResult) {
    let device = UIDevice.current
    let deviceModel = device.model 
    result(String(deviceModel))
  }

   private func receiveSystemName(result: FlutterResult) {
    let device = UIDevice.current
    let deviceSystemName = device.systemName 
    result(String(deviceSystemName))
  }
  private func receiveSystemVersion (result: FlutterResult) {
    let device = UIDevice.current
    let deviceSystemVersion = device.systemVersion 
    result(String(deviceSystemVersion))
  }
}

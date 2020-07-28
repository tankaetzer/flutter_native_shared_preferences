import Flutter
import UIKit

let SUCCESS = "SUCCESS"
let FAILED = "FAILED"

let STATUS = "status"
let DATA = "data"
let ERROR_MESSAGE = "errorMessage"
let ERROR_CODE = "errorCode"

public class SwiftFlutterNativeSharedPreferencesPlugin: NSObject, FlutterPlugin {
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "flutter_native_shared_preferences", binaryMessenger: registrar.messenger())
        let instance = SwiftFlutterNativeSharedPreferencesPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "getPlatformVersion":
            result("")
            break;
        case "getPortfolioName":
            result([STATUS: SUCCESS, DATA: ""])
            break;
        case "portfolioAllocationList":
            result([STATUS: SUCCESS, DATA: "[]"])
            break;
        case "setPortfolioName":
            result([STATUS: SUCCESS, DATA: ""])
            break;
        default:
            result(FlutterMethodNotImplemented)
        }
    }
}

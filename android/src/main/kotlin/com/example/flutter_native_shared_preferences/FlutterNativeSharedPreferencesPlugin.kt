package com.example.flutter_native_shared_preferences

import android.app.Activity
import android.content.Context
import androidx.annotation.NonNull

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry.Registrar

const val SUCCESS = "SUCCESS"
const val FAILED = "FAILED"
const val STATUS = "status"
const val DATA = "data"
const val SETTING_PREFERENCES = "setting"
const val SHARED_PREFERENCE_DEFAULT_PORTFOLIONAME = "PortfolioName"
const val SHARED_PREFERENCE_PORTFOLIO_ALLOCATION = "portfolio"

/** FlutterNativeSharedPreferencesPlugin */
public class FlutterNativeSharedPreferencesPlugin : FlutterPlugin, MethodCallHandler, ActivityAware {
    /// The MethodChannel that will the communication between Flutter and native Android
    ///
    /// This local reference serves to register the plugin with the Flutter Engine and unregister it
    /// when the Flutter Engine is detached from the Activity
    private lateinit var channel: MethodChannel
    private var activity: Activity? = null

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.getFlutterEngine().getDartExecutor(), "flutter_native_shared_preferences")
        channel.setMethodCallHandler(this)
    }

    // This static function is optional and equivalent to onAttachedToEngine. It supports the old
    // pre-Flutter-1.12 Android projects. You are encouraged to continue supporting
    // plugin registration via this function while apps migrate to use the new Android APIs
    // post-flutter-1.12 via https://flutter.dev/go/android-project-migration.
    //
    // It is encouraged to share logic between onAttachedToEngine and registerWith to keep
    // them functionally equivalent. Only one of onAttachedToEngine or registerWith will be called
    // depending on the user's project. onAttachedToEngine or registerWith must both be defined
    // in the same class.
    companion object {
        @JvmStatic
        fun registerWith(registrar: Registrar) {
            val channel = MethodChannel(registrar.messenger(), "flutter_native_shared_preferences")
            channel.setMethodCallHandler(FlutterNativeSharedPreferencesPlugin())
        }
    }

    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
        try {
            when (call.method) {
                "getPlatformVersion" -> {
                    result.success("Android ${android.os.Build.VERSION.RELEASE}")
                }
                "getPortfolioName" -> {
                    if (activity == null) {
                        result.success(mapOf(STATUS to FAILED))
                        return
                    }
                    val sharedPref = activity?.getSharedPreferences(SETTING_PREFERENCES, Context.MODE_PRIVATE)
                    result.success(mapOf(STATUS to SUCCESS, DATA to sharedPref?.getString(SHARED_PREFERENCE_DEFAULT_PORTFOLIONAME, "")))
                }
                "getPortfolioAllocationList" -> {
                    if (activity == null) {
                        result.success(mapOf(STATUS to FAILED))
                        return
                    }
                    val sharedPref = activity?.getSharedPreferences(SHARED_PREFERENCE_PORTFOLIO_ALLOCATION, Context.MODE_PRIVATE)
                    result.success(mapOf(STATUS to SUCCESS, DATA to sharedPref?.getString(SHARED_PREFERENCE_PORTFOLIO_ALLOCATION, "[]")))
                }
                else -> {
                    result.notImplemented()
                }
            }
        } catch (e: Exception) {
            e.printStackTrace()
            result.success(mapOf(STATUS to FAILED))
        }
    }

    override fun onDetachedFromActivity() {
        activity = null
    }

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
        activity = binding.activity
    }

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        activity = binding.activity
    }

    override fun onDetachedFromActivityForConfigChanges() {
        activity = null
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }
}

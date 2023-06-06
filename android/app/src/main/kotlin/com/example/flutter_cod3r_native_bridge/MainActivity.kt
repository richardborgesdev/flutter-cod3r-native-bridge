package com.example.flutter_cod3r_native_bridge

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {
    private val CHANNEL = "cod3r.com.br/nativo"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger,CHANNEL)
            .setMethodCallHandler {
                call, result ->

                if (call.method == "calcSum") {
                    var num1 = call.argument<Int>("num1")?.toInt() ?: 0
                    var num2 = call.argument<Int>("num2")?.toInt() ?: 0

                    result.success(num1 + num2)
                } else {
                    result.notImplemented()
                }
            }
    }
}

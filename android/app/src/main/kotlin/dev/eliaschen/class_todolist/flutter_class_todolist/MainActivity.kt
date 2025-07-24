package dev.eliaschen.class_todolist.flutter_class_todolist

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import java.io.File

const val channelName = "dev.eliaschen.class_todolist.flutter_class_todolist/method"

class MainActivity : FlutterActivity() {
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        val file = File(getExternalFilesDir(null),"data.json")
        if(!file.exists()){
            file.writeText("[]")
        }
        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            channelName
        ).setMethodCallHandler { call, result ->
            when (call.method) {
                "write" -> {
                    file.writeText(call.arguments as String)
                    result.success(null)
                }

                "get" -> {
                    result.success(file.readText())
                }
            }
        }
    }
}

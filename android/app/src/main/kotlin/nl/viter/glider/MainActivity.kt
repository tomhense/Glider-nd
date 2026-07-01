package nl.viter.glider

import android.app.Activity
import android.content.Intent
import android.os.Bundle
import android.view.WindowManager
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    private val backupPickerChannel = "nl.viter.glider/backup_picker"
    private val backupPickerRequestCode = 1001
    private var pendingBackupPickerResult: MethodChannel.Result? = null

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        window.attributes.preferredRefreshRate = 120f
        window.addFlags(WindowManager.LayoutParams.FLAG_KEEP_SCREEN_ON)
    }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, backupPickerChannel)
            .setMethodCallHandler { call, result ->
                when (call.method) {
                    "pickBackupFile" -> {
                        if (pendingBackupPickerResult != null) {
                            result.error(
                                "busy",
                                "A backup picker is already open.",
                                null,
                            )
                            return@setMethodCallHandler
                        }

                        pendingBackupPickerResult = result
                        startActivityForResult(
                            Intent(Intent.ACTION_OPEN_DOCUMENT).apply {
                                addCategory(Intent.CATEGORY_OPENABLE)
                                addFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION)
                                type = "*/*"
                                putExtra(
                                    Intent.EXTRA_MIME_TYPES,
                                    arrayOf("application/json", "text/plain"),
                                )
                            },
                            backupPickerRequestCode,
                        )
                    }
                    else -> result.notImplemented()
                }
            }
    }

    @Suppress("DEPRECATION")
    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)

        if (requestCode != backupPickerRequestCode) {
            return
        }

        val result = pendingBackupPickerResult ?: return
        pendingBackupPickerResult = null

        if (resultCode != Activity.RESULT_OK || data?.data == null) {
            result.success(null)
            return
        }

        try {
            contentResolver.openInputStream(data.data!!)?.use { input ->
                result.success(input.readBytes())
            } ?: result.error("read_error", "Unable to open the selected file.", null)
        } catch (exception: Exception) {
            result.error("read_error", exception.message, null)
        }
    }
}

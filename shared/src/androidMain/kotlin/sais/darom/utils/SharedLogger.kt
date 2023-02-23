package sais.darom.utils

import sais.darom.utils.StringUtils.indexOfOrStart
import android.util.Log

actual object LogWriter {
    private const val TAG = "DP"
    private const val messageSize = 4000 // logcat ring buffer is 64Kb, max entry is 4096b, max payload is 4076b
    private const val maxMessages = 5

    actual fun printToSystemLog(message: String, level: LogLevel) {
        processLargeLog(message, level)
    }

    private fun printLog(message: String, level: LogLevel): Int = when (level) {
        LogLevel.VERBOSE -> Log.v(TAG, message)
        LogLevel.DEBUG -> Log.d(TAG, message)
        LogLevel.INFO -> Log.i(TAG, message)
        LogLevel.WARN -> Log.w(TAG, message)
        LogLevel.ERROR -> Log.e(TAG, message)
    }

    /**
     * Break large log in several pieces recursively
     */
    private fun processLargeLog(message: String, level: LogLevel, stackSize: Int = 0) {
        when {
            // Short message, print as is
            message.length < messageSize -> printLog(message, level)

            // Process large log string
            stackSize < maxMessages -> {
                val chunkCount: Int = message.length / messageSize
                for (i in 0..chunkCount) {
                    val max = messageSize * (i + 1)
                    if (max >= message.length) {
                        printLog(message.substring(messageSize * i), level)
                    } else {
                        printLog(message.substring(messageSize * i, max), level)
                    }
                }
                return
            }

            // Add tail
            else -> {
                val tailStartIndex = message.length - messageSize
                val pos = message.indexOfOrStart('\n', tailStartIndex)

                printLog("*****\nLOG IS TRUNCATED\n*****", level)
                printLog(message.substring(pos), level)
            }
        }
    }
}
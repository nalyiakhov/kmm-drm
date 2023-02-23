package sais.darom.utils

actual object LogWriter {
    actual fun printToSystemLog(message: String, level: LogLevel) = println("$level: $message")
}
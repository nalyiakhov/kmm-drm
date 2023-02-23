package sais.darom.utils

expect object LogWriter {
    fun printToSystemLog(message: String, level: LogLevel)
}

enum class LogLevel {
    // Debug level logging
    VERBOSE,
    DEBUG,

    // Simple level logging
    INFO,
    WARN,
    ERROR
}

object SharedLogger {
    fun verbose(message: String) = processLogMessage(message, LogLevel.VERBOSE)
    fun verbose(e: Throwable) = processException(e, LogLevel.VERBOSE)
    fun verbose(e: Throwable, message: String) = processException(e, message, LogLevel.VERBOSE)

    fun debug(message: String) = processLogMessage(message, LogLevel.DEBUG)
    fun debug(e: Throwable) = processException(e, LogLevel.DEBUG)
    fun debug(e: Throwable, message: String) = processException(e, message, LogLevel.DEBUG)

    fun info(message: String) = processLogMessage(message, LogLevel.INFO)
    fun info(e: Throwable) = processException(e, LogLevel.INFO)
    fun info(e: Throwable, message: String) = processException(e, message, LogLevel.INFO)

    fun warning(message: String) = processLogMessage(message, LogLevel.WARN)
    fun warning(e: Throwable) = processException(e, LogLevel.WARN)
    fun warning(e: Throwable, message: String) = processException(e, message, LogLevel.WARN)

    fun error(message: String) = processLogMessage(message, LogLevel.ERROR)
    fun error(e: Throwable) = processException(e, LogLevel.ERROR)
    fun error(e: Throwable, message: String) = processException(e, message, LogLevel.ERROR)

    private fun processException(error: Throwable, message: String, level: LogLevel) = printStackTrace(error, level, message)
    private fun processException(error: Throwable, level: LogLevel) = printStackTrace(error, level)
    private fun processLogMessage(message: String, level: LogLevel) = LogWriter.printToSystemLog(message, level)

    private fun printStackTrace(throwable: Throwable, level: LogLevel, message: String? = null) {
        val stackTrace = throwable.stackTraceToString()
        val errorMessage = message ?: "<No message provided>"
        val log = "ErrorMessage: $errorMessage \n StackTrace:\n$stackTrace"
        LogWriter.printToSystemLog(log, level)
    }
}
package sais.darom.utils

import io.ktor.http.*

object StringUtils {
    fun String.indexOfOrStart(char: Char, startIndex: Int = 0, ignoreCase: Boolean = false): Int {
        val index = this.indexOf(char, startIndex, ignoreCase)
        return if (index < 0) startIndex // not found, return initial value
        else index + 1 // consume separator
    }
}
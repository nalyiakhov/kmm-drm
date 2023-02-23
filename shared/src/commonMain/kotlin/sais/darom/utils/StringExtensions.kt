package sais.darom.utils

object StringExtensions {
	fun isNullOrEmpty(string: String?): Boolean {
		return string == null || string.isEmpty()
	}

	fun capitalizeFirstLetter(input: String): String {
		return input.substring(0, 1).uppercase() + input.substring(1)
	}

	private fun isMatch(value: String, pattern: String): Boolean {
		return try {
			pattern.toRegex().matches(value)
		} catch (e: RuntimeException) {
			false
		}
	}
}
package sais.darom.settings

expect class SettingsProvider(preferencesName: String) {

    fun putInt(key: String, value: Int)
    fun getInt(key: String, defaultValue: Int): Int
    fun getInt(key: String): Int?

    fun putFloat(key: String, value: Float)
    fun getFloat(key: String, defaultValue: Float): Float
    fun getFloat(key: String): Float?

    fun putLong(key: String, value: Long)
    fun getLong(key: String, defaultValue: Long): Long
    fun getLong(key: String): Long?

    fun putString(key: String, value: String?)
    fun getString(key: String, defaultValue: String? = null): String?

    fun putBoolean(key: String, value: Boolean)
    fun getBoolean(key: String, defaultValue: Boolean): Boolean
    fun getBoolean(key: String): Boolean?

    fun remove(key: String)
    fun clear()
    fun hasKey(key: String): Boolean
}
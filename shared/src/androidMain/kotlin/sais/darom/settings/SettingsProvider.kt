package sais.darom.settings

import android.annotation.SuppressLint
import android.content.Context
import android.content.SharedPreferences

actual class SettingsProvider actual constructor(preferencesName: String) {

    private var sharedPreferences: SharedPreferences = application.getSharedPreferences("sais.darom_preferences", Context.MODE_PRIVATE)

    actual fun putInt(key: String, value: Int) {
        sharedPreferences.edit().putInt(key, value).apply()
    }

    actual fun getInt(key: String, defaultValue: Int): Int {
        return sharedPreferences.getInt(key, defaultValue)
    }

    actual fun getInt(key: String): Int? {
        return if (hasKey(key)) sharedPreferences.getInt(key, 0)
        else null
    }


    actual fun putFloat(key: String, value: Float) {
        sharedPreferences.edit().putFloat(key, value).apply()
    }

    actual fun getFloat(key: String, defaultValue: Float): Float {
        return sharedPreferences.getFloat(key, defaultValue)
    }

    actual fun getFloat(key: String): Float? {
        return if (hasKey(key)) sharedPreferences.getFloat(key, 0f)
        else null
    }


    actual fun putLong(key: String, value: Long) {
        sharedPreferences.edit().putLong(key, value).apply()
    }

    actual fun getLong(key: String, defaultValue: Long): Long {
        return sharedPreferences.getLong(key, defaultValue)
    }

    actual fun getLong(key: String): Long? {
        return if (hasKey(key)) sharedPreferences.getLong(key, 0)
        else null
    }


    actual fun putString(key: String, value: String?) {
        sharedPreferences.edit().putString(key, value).apply()
    }

    actual fun getString(key: String, defaultValue: String?): String? {
        return sharedPreferences.getString(key, defaultValue) ?: defaultValue
    }


    actual fun getBoolean(key: String, defaultValue: Boolean): Boolean {
        return sharedPreferences.getBoolean(key, defaultValue)
    }

    actual fun getBoolean(key: String): Boolean? {
        return if (hasKey(key)) sharedPreferences.getBoolean(key, false)
        else null
    }

    actual fun putBoolean(key: String, value: Boolean) {
        sharedPreferences.edit().putBoolean(key, value).apply()
    }

    actual fun hasKey(key: String): Boolean = sharedPreferences.contains(key)

    actual fun clear() {
        sharedPreferences.edit().clear().apply()
    }

    actual fun remove(key: String) {
        if (hasKey(key)) {
            sharedPreferences.edit().remove(key).apply()
        }
    }

    private val application: Context
        get() = appContext ?: initAndGetAppCtxWithReflection()

    private var appContext: Context? = null

    /**
     * This methods is only run if [appCtx] is accessed while [AppCtxInitProvider] hasn't been
     * initialized. This may happen in case you're accessing it outside the default process, or in case
     * you are accessing it in a [ContentProvider] with a higher priority than [AppCtxInitProvider]
     * (900 at the time of writing this doc).
     *
     * If you don't want this code that uses reflection to ever run, see [injectAsAppCtx].
     */
    @SuppressLint("PrivateApi", "DiscouragedPrivateApi")
    private fun initAndGetAppCtxWithReflection(): Context {
        // Fallback, should only run once per non default process.
        val activityThread = Class.forName("android.app.ActivityThread")
        val ctx = activityThread.getDeclaredMethod("currentApplication").invoke(null) as Context
        appContext = ctx
        return ctx
    }
}
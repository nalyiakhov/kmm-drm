package sais.darom.settings

import io.ktor.client.*

interface ISettings {
    var refreshToken: String?
    var token: String?
    var apnsToken: String?
    var isPinSet: Boolean
    var isBiometric: Boolean
    var favoriteImages: List<String>
}

class Settings : ISettings {
    companion object {
        private const val preferencesKey = "sharedPreferences"

        private const val refreshTokenKey = "refreshTokenKey"
        private const val tokenKey = "tokenKey"
        private const val apnsTokenKey = "apnsTokenKey"
        private const val isPinSetKey = "pinSetKey"
        private const val isBiometricKey = "biometricKey"

        private const val favoriteImagesKey = "favoriteImagesKey"
    }

    private val prefs = SettingsProvider(preferencesKey)

    override var token: String?
        get() = prefs.getString(tokenKey)
        set(value) = prefs.putString(tokenKey, value)

    override var refreshToken: String?
        get() = prefs.getString(refreshTokenKey)
        set(value) = prefs.putString(refreshTokenKey, value)

    override var apnsToken: String?
        get() = prefs.getString(apnsTokenKey)
        set(value) = prefs.putString(apnsTokenKey, value)

    override var isPinSet: Boolean
        get() = prefs.getBoolean(isPinSetKey, false)
        set(value) = prefs.putBoolean(isPinSetKey, value)

    override var isBiometric: Boolean
        get() = prefs.getBoolean(isBiometricKey, true)
        set(value) = prefs.putBoolean(isBiometricKey, value)

    override var favoriteImages: List<String>
        get() = prefs.getStrings(favoriteImagesKey) ?: listOf()
        set(value) = prefs.putStrings(favoriteImagesKey, value)
}
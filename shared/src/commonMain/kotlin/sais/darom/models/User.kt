package sais.darom.models

import kotlinx.serialization.SerialName
import kotlinx.serialization.Serializable
import kotlinx.serialization.json.Json
import sais.darom.utils.Base64URL
import com.soywiz.klock.DateTime

@Serializable
data class User(
	@SerialName("id")
	val id: Int = 0,
	@SerialName("email")
	val email: String = "",
	@SerialName("firstName")
	val firstName: String = "",
	@SerialName("lastName")
	val lastName: String = ""
) {
	companion object {
		fun get(token: String?) : User? {
			if (token != null) {
				val tokens = token.split(".")
				try {
					val claimsString = tokens.get(1)
					val claims = Base64URL.decoder.decode(claimsString.encodeToByteArray()).decodeToString()
					val user = Json {
						ignoreUnknownKeys = true
					}.decodeFromString(User.serializer(), claims)
					return user
				} catch (ex: Exception) {
					return null
				}
			} else {
				return null
			}
		}
	}
}
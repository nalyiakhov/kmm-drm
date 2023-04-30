package sais.darom.models

import kotlinx.serialization.SerialName
import kotlinx.serialization.Serializable

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
)
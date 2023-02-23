package sais.darom.utils

import kotlinx.serialization.SerialName

class Tuple<T1, T2> (
	@SerialName("key")
	var key: T1,
	@SerialName("value")
	var value: T2)
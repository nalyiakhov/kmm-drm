package sais.darom.serialization.types

import com.soywiz.klock.DateException
import com.soywiz.klock.DateTime
import kotlinx.serialization.KSerializer
import kotlinx.serialization.descriptors.PrimitiveKind
import kotlinx.serialization.descriptors.PrimitiveSerialDescriptor
import kotlinx.serialization.encoding.Decoder
import kotlinx.serialization.encoding.Encoder

class DateTimeSerializer : KSerializer<DateTime> {
    override val descriptor = PrimitiveSerialDescriptor("DateTime", PrimitiveKind.STRING)

    override fun deserialize(decoder: Decoder): DateTime {
        throw DateException("Trying to deserialize DateTime class instead of CrossDateTime")
    }

    override fun serialize(encoder: Encoder, value: DateTime) {
        throw DateException("Trying to deserialize DateTime class instead of CrossDateTime")
    }
}
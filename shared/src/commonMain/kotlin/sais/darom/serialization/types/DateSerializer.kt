package sais.darom.serialization.types

import com.soywiz.klock.Date
import com.soywiz.klock.DateException
import kotlinx.serialization.KSerializer
import kotlinx.serialization.descriptors.PrimitiveKind
import kotlinx.serialization.descriptors.PrimitiveSerialDescriptor
import kotlinx.serialization.encoding.Decoder
import kotlinx.serialization.encoding.Encoder

class DateSerializer : KSerializer<Date> {
    override val descriptor = PrimitiveSerialDescriptor("Date", PrimitiveKind.STRING)

    override fun deserialize(decoder: Decoder): Date {
        throw DateException("Trying to deserialize Date class instead of CrossDateTime")
    }

    override fun serialize(encoder: Encoder, value: Date) {
        throw DateException("Trying to deserialize Date class instead of CrossDateTime")
    }
}
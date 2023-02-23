package sais.darom.serialization.types

import sais.darom.dataTypes.CrossDateTime
import com.soywiz.klock.PatternDateFormat
import com.soywiz.klock.parseUtc
import kotlinx.serialization.KSerializer
import kotlinx.serialization.SerializationException
import kotlinx.serialization.descriptors.PrimitiveKind
import kotlinx.serialization.descriptors.PrimitiveSerialDescriptor
import kotlinx.serialization.encoding.Decoder
import kotlinx.serialization.encoding.Encoder

class CrossDateTimeSerializer : KSerializer<CrossDateTime> {
    override val descriptor = PrimitiveSerialDescriptor("CrossDateTime", PrimitiveKind.STRING)

    override fun deserialize(decoder: Decoder): CrossDateTime {
        return parse(decoder.decodeString())
    }

    override fun serialize(encoder: Encoder, value: CrossDateTime) {
        return encoder.encodeString(value.toString(newtonSoftJsonDefaultFormat))
    }

    companion object {
        // Klock uses [.S] as (\d{1,6}) when parsing, but just S (single digit) when writing.
        // Json.net can put up to 7 digits: yyyy-MM-ddThh:mm:ss.FFFFFFFK
        //2021-04-30T11:12:13.456Z
        private val newtonSoftJsonDefaultFormat = PatternDateFormat("yyyy-MM-ddTHH:mm[:ss[.S[S[S]]]]").withOptional()

        private fun parse(date: String): CrossDateTime {
            try {
                return CrossDateTime(newtonSoftJsonDefaultFormat.parseUtc(date), CrossDateTime.CrossDateTimeKind.UTC)
            } catch (e: Throwable) {
                throw SerializationException("Invalid datetime format DatetimeValue=$date")
            }
        }
    }
}
package sais.darom.serialization.types

import sais.darom.dataTypes.CrossTimeSpan
import kotlinx.serialization.KSerializer
import kotlinx.serialization.descriptors.PrimitiveKind
import kotlinx.serialization.descriptors.PrimitiveSerialDescriptor
import kotlinx.serialization.encoding.Decoder
import kotlinx.serialization.encoding.Encoder

class CrossTimeSpanSerializer : KSerializer<CrossTimeSpan> {
    override val descriptor = PrimitiveSerialDescriptor("TimeSpan", PrimitiveKind.STRING)

    override fun deserialize(decoder: Decoder): CrossTimeSpan {
        return CrossTimeSpan.parse(decoder.decodeString())
    }

    override fun serialize(encoder: Encoder, value: CrossTimeSpan) {
        return encoder.encodeString(value.toString())
    }
}
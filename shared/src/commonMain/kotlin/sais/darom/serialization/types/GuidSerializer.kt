package sais.darom.serialization.types

import sais.darom.dataTypes.Guid
import sais.darom.dataTypes.Guid.Companion.toGuid
import kotlinx.serialization.KSerializer
import kotlinx.serialization.descriptors.PrimitiveKind
import kotlinx.serialization.descriptors.PrimitiveSerialDescriptor
import kotlinx.serialization.encoding.Decoder
import kotlinx.serialization.encoding.Encoder

class GuidSerializer : KSerializer<Guid> {
    override val descriptor = PrimitiveSerialDescriptor("Guid", PrimitiveKind.STRING)

    override fun deserialize(decoder: Decoder): Guid {
        return decoder.decodeString().toGuid()
    }

    override fun serialize(encoder: Encoder, value: Guid) {
        return encoder.encodeString(value.toString())
    }
}
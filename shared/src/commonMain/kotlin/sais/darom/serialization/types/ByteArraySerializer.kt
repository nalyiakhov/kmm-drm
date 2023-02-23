package sais.darom.serialization.types

import sais.darom.utils.Base64.fromBase64
import sais.darom.utils.Base64.toBase64
import kotlinx.serialization.KSerializer
import kotlinx.serialization.descriptors.PrimitiveKind
import kotlinx.serialization.descriptors.PrimitiveSerialDescriptor
import kotlinx.serialization.encoding.Decoder
import kotlinx.serialization.encoding.Encoder

class ByteArraySerializer : KSerializer<ByteArray> {
    override val descriptor = PrimitiveSerialDescriptor("byte[]", PrimitiveKind.STRING)

    override fun deserialize(decoder: Decoder): ByteArray {
        return decoder.decodeString().fromBase64()
    }

    override fun serialize(encoder: Encoder, value: ByteArray) {
        return encoder.encodeString(value.toBase64())
    }
}
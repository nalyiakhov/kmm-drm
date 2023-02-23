package sais.darom.utils

/**
 * Kotlin Base64 encoder and decoder, extracted from korio library (MIT License)
 * https://github.com/korlibs/korio
 */
object Base64 {
    //@SharedImmutable
    private val TABLE = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/="

    //@SharedImmutable
    private val DECODE = IntArray(0x100).apply {
        for (n in 0..255) this[n] = -1
        for (n in TABLE.indices) this[TABLE[n].code] = n
    }

    fun decode(str: String): ByteArray {
        val dst = ByteArray((str.length * 4) / 3 + 4)
        return dst.copyOf(
            decodeInline(
                dst,
                str.length
            ) { str[it].code and 0xFF })
    }

    fun decode(src: ByteArray, dst: ByteArray): Int =
        decodeInline(
            dst,
            src.size
        ) { (src[it].toInt() and 0xFF) }

    private inline fun decodeInline(dst: ByteArray, size: Int, get: (n: Int) -> Int): Int {
        var m = 0
        var n = 0
        while (n < size) {
            val d = DECODE[get(n)]
            if (d < 0) {
                n++
                continue // skip character
            }
            val b0 = DECODE[get(n++)]
            val b1 = DECODE[get(n++)]
            val b2 = DECODE[get(n++)]
            val b3 = DECODE[get(n++)]
            dst[m++] = (b0 shl 2 or (b1 shr 4)).toByte()
            if (b2 < 64) {
                dst[m++] = (b1 shl 4 or (b2 shr 2)).toByte()
                if (b3 < 64) {
                    dst[m++] = (b2 shl 6 or b3).toByte()
                }
            }
        }
        return m
    }

    @ExperimentalStdlibApi
    fun encode(src: String): String =
        encode(src.encodeToByteArray())

    fun encode(src: ByteArray): String =
        encode(src, 0, src.size)

    @Suppress("UNUSED_CHANGED_VALUE")
    fun encode(src: ByteArray, start: Int, size: Int): String {
        val out = StringBuilder((size * 4) / 3 + 4)
        var ipos = start
        val iend = start + size
        val extraBytes = size % 3
        while (ipos < iend - 2) {
            val num = src.readU24BE(ipos)
            ipos += 3
            out.append(TABLE[(num ushr 18) and 0x3F])
            out.append(TABLE[(num ushr 12) and 0x3F])
            out.append(TABLE[(num ushr 6) and 0x3F])
            out.append(TABLE[(num ushr 0) and 0x3F])
        }
        if (extraBytes == 1) {
            val num = src.readU8(ipos++)
            out.append(TABLE[num ushr 2])
            out.append(TABLE[(num shl 4) and 0x3F])
            out.append('=')
            out.append('=')
        } else if (extraBytes == 2) {
            val tmp = (src.readU8(ipos++) shl 8) or src.readU8(ipos++)
            out.append(TABLE[tmp ushr 10])
            out.append(TABLE[(tmp ushr 4) and 0x3F])
            out.append(TABLE[(tmp shl 2) and 0x3F])
            out.append('=')
        }
        return out.toString()
    }

    fun String.fromBase64(): ByteArray = decode(this)
    fun ByteArray.toBase64(): String = encode(this)
    fun String.fromBase64IgnoreSpaces(): ByteArray =
        decode(
            this.replace(" ", "")
                .replace("\n", "")
                .replace("\r", "")
        )

    private fun ByteArray.u8(o: Int): Int = this[o].toInt() and 0xFF
    private fun ByteArray.readU8(o: Int): Int = u8(o)
    private fun ByteArray.readU24BE(o: Int): Int = read24BE(o)
    private fun ByteArray.read24BE(o: Int): Int = (u8(o + 2) shl 0) or (u8(o + 1) shl 8) or (u8(o + 0) shl 16)
}

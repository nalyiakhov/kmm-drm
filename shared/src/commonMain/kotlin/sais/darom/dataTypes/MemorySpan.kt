package sais.darom.dataTypes

data class MemorySpan(val totalBytes: Double): Comparable<MemorySpan> {
    companion object {
        const val BYTES_IN_KILOBYTE: Long = 1024
        const val BYTES_IN_MEGABYTE: Long = 1024 * BYTES_IN_KILOBYTE
        const val BYTES_IN_GIGABYTE: Long = 1024 * BYTES_IN_MEGABYTE

        fun fromBytes(bytes: Double): MemorySpan {
            return MemorySpan(bytes)
        }

        fun fromKiloBytes(kiloBytes: Double): MemorySpan {
            return MemorySpan(kiloBytes * BYTES_IN_KILOBYTE)
        }

        fun fromMegaBytes(megaBytes: Double): MemorySpan {
            return MemorySpan(megaBytes * BYTES_IN_MEGABYTE)
        }

        fun fromGigaBytes(gigaBytes: Double): MemorySpan {
            return MemorySpan(gigaBytes * BYTES_IN_GIGABYTE)
        }
    }

    val totalKilobytes: Double
        get() = totalBytes / BYTES_IN_KILOBYTE

    val totalMegabytes: Double
        get() = totalBytes / BYTES_IN_MEGABYTE

    val totalGigabytes: Double
        get() = totalBytes / BYTES_IN_GIGABYTE

    override fun compareTo(other: MemorySpan): Int {
        return totalBytes.compareTo(other.totalBytes)
    }
}
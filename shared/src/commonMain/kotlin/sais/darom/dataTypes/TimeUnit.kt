package sais.darom.dataTypes

/**
 * Converted from Java TimeUnit
 */
@Suppress("PARAMETER_NAME_CHANGED_ON_OVERRIDE")
enum class TimeUnit {
    /**
     * Time unit representing one thousandth of a microsecond.
     */
    NANOSECONDS {
        override fun toNanos(d: Long): Long = d
        override fun toMicros(d: Long): Long = d / (C1 / C0)
        override fun toMillis(d: Long): Long = d / (C2 / C0)
        override fun toSeconds(d: Long): Long = d / (C3 / C0)
        override fun toMinutes(d: Long): Long = d / (C4 / C0)
        override fun toHours(d: Long): Long = d / (C5 / C0)
        override fun toDays(d: Long): Long = d / (C6 / C0)
        override fun convert(d: Long, u: TimeUnit): Long = u.toNanos(d)
        override fun excessNanos(d: Long, m: Long): Int = (d - m * C2).toInt()
    },

    /**
     * Time unit representing one thousandth of a millisecond.
     */
    MICROSECONDS {
        override fun toNanos(d: Long): Long = x(d, C1 / C0, MAX / (C1 / C0))
        override fun toMicros(d: Long): Long = d
        override fun toMillis(d: Long): Long = d / (C2 / C1)
        override fun toSeconds(d: Long): Long = d / (C3 / C1)
        override fun toMinutes(d: Long): Long = d / (C4 / C1)
        override fun toHours(d: Long): Long = d / (C5 / C1)
        override fun toDays(d: Long): Long = d / (C6 / C1)
        override fun convert(d: Long, u: TimeUnit): Long = u.toMicros(d)
        override fun excessNanos(d: Long, m: Long): Int = (d * C1 - m * C2).toInt()
    },

    /**
     * Time unit representing one thousandth of a second.
     */
    MILLISECONDS {
        override fun toNanos(d: Long): Long = x(d, C2 / C0, MAX / (C2 / C0))
        override fun toMicros(d: Long): Long = x(d, C2 / C1, MAX / (C2 / C1))
        override fun toMillis(d: Long): Long = d
        override fun toSeconds(d: Long): Long = d / (C3 / C2)
        override fun toMinutes(d: Long): Long = d / (C4 / C2)
        override fun toHours(d: Long): Long = d / (C5 / C2)
        override fun toDays(d: Long): Long = d / (C6 / C2)
        override fun convert(d: Long, u: TimeUnit): Long = u.toMillis(d)
        override fun excessNanos(d: Long, m: Long): Int = 0
    },

    /**
     * Time unit representing one second.
     */
    SECONDS {
        override fun toNanos(d: Long): Long = x(d, C3 / C0, MAX / (C3 / C0))
        override fun toMicros(d: Long): Long = x(d, C3 / C1, MAX / (C3 / C1))
        override fun toMillis(d: Long): Long = x(d, C3 / C2, MAX / (C3 / C2))
        override fun toSeconds(d: Long): Long = d
        override fun toMinutes(d: Long): Long = d / (C4 / C3)
        override fun toHours(d: Long): Long = d / (C5 / C3)
        override fun toDays(d: Long): Long = d / (C6 / C3)
        override fun convert(d: Long, u: TimeUnit): Long = u.toSeconds(d)
        override fun excessNanos(d: Long, m: Long): Int = 0
    },

    /**
     * Time unit representing sixty seconds.
     * @since 1.6
     */
    MINUTES {
        override fun toNanos(d: Long): Long = x(d, C4 / C0, MAX / (C4 / C0))
        override fun toMicros(d: Long): Long = x(d, C4 / C1, MAX / (C4 / C1))
        override fun toMillis(d: Long): Long = x(d, C4 / C2, MAX / (C4 / C2))
        override fun toSeconds(d: Long): Long = x(d, C4 / C3, MAX / (C4 / C3))
        override fun toMinutes(d: Long): Long = d
        override fun toHours(d: Long): Long = d / (C5 / C4)
        override fun toDays(d: Long): Long = d / (C6 / C4)
        override fun convert(d: Long, u: TimeUnit): Long = u.toMinutes(d)
        override fun excessNanos(d: Long, m: Long): Int = 0
    },

    /**
     * Time unit representing sixty minutes.
     * @since 1.6
     */
    HOURS {
        override fun toNanos(d: Long): Long = x(d, C5 / C0, MAX / (C5 / C0))
        override fun toMicros(d: Long): Long = x(d, C5 / C1, MAX / (C5 / C1))
        override fun toMillis(d: Long): Long = x(d, C5 / C2, MAX / (C5 / C2))
        override fun toSeconds(d: Long): Long = x(d, C5 / C3, MAX / (C5 / C3))
        override fun toMinutes(d: Long): Long = x(d, C5 / C4, MAX / (C5 / C4))
        override fun toHours(d: Long): Long = d
        override fun toDays(d: Long): Long = d / (C6 / C5)
        override fun convert(d: Long, u: TimeUnit): Long = u.toHours(d)
        override fun excessNanos(d: Long, m: Long): Int = 0
    },

    /**
     * Time unit representing twenty four hours.
     * @since 1.6
     */
    DAYS {
        override fun toNanos(d: Long): Long = x(d, C6 / C0, MAX / (C6 / C0))
        override fun toMicros(d: Long): Long = x(d, C6 / C1, MAX / (C6 / C1))
        override fun toMillis(d: Long): Long = x(d, C6 / C2, MAX / (C6 / C2))
        override fun toSeconds(d: Long): Long = x(d, C6 / C3, MAX / (C6 / C3))
        override fun toMinutes(d: Long): Long = x(d, C6 / C4, MAX / (C6 / C4))
        override fun toHours(d: Long): Long = x(d, C6 / C5, MAX / (C6 / C5))
        override fun toDays(d: Long): Long = d
        override fun convert(d: Long, u: TimeUnit): Long = u.toDays(d)
        override fun excessNanos(d: Long, m: Long): Int = 0
    };

    /**
     * Converts the given time duration in the given unit to this unit.
     * Conversions from finer to coarser granularities truncate, so
     * lose precision. For example, converting `999` milliseconds
     * to seconds results in `0`. Conversions from coarser to
     * finer granularities with arguments that would numerically
     * overflow saturate to `Long.MIN_VALUE` if negative or
     * `Long.MAX_VALUE` if positive.
     *
     *
     * For example, to convert 10 minutes to milliseconds, use:
     * `TimeUnit.MILLISECONDS.convert(10L, TimeUnit.MINUTES)`
     *
     * @param sourceDuration the time duration in the given `sourceUnit`
     * @param sourceUnit the unit of the `sourceDuration` argument
     * @return the converted duration in this unit,
     * or `Long.MIN_VALUE` if conversion would negatively
     * overflow, or `Long.MAX_VALUE` if it would positively overflow.
     */
    abstract fun convert(sourceDuration: Long, sourceUnit: TimeUnit): Long

    /**
     * Equivalent to
     * [NANOSECONDS.convert(duration, this)][.convert].
     * @param duration the duration
     * @return the converted duration,
     * or `Long.MIN_VALUE` if conversion would negatively
     * overflow, or `Long.MAX_VALUE` if it would positively overflow.
     */
    abstract fun toNanos(duration: Long): Long

    /**
     * Equivalent to
     * [MICROSECONDS.convert(duration, this)][.convert].
     * @param duration the duration
     * @return the converted duration,
     * or `Long.MIN_VALUE` if conversion would negatively
     * overflow, or `Long.MAX_VALUE` if it would positively overflow.
     */
    abstract fun toMicros(duration: Long): Long

    /**
     * Equivalent to
     * [MILLISECONDS.convert(duration, this)][.convert].
     * @param duration the duration
     * @return the converted duration,
     * or `Long.MIN_VALUE` if conversion would negatively
     * overflow, or `Long.MAX_VALUE` if it would positively overflow.
     */
    abstract fun toMillis(duration: Long): Long

    /**
     * Equivalent to
     * [SECONDS.convert(duration, this)][.convert].
     * @param duration the duration
     * @return the converted duration,
     * or `Long.MIN_VALUE` if conversion would negatively
     * overflow, or `Long.MAX_VALUE` if it would positively overflow.
     */
    abstract fun toSeconds(duration: Long): Long

    /**
     * Equivalent to
     * [MINUTES.convert(duration, this)][.convert].
     * @param duration the duration
     * @return the converted duration,
     * or `Long.MIN_VALUE` if conversion would negatively
     * overflow, or `Long.MAX_VALUE` if it would positively overflow.
     * @since 1.6
     */
    abstract fun toMinutes(duration: Long): Long

    /**
     * Equivalent to
     * [HOURS.convert(duration, this)][.convert].
     * @param duration the duration
     * @return the converted duration,
     * or `Long.MIN_VALUE` if conversion would negatively
     * overflow, or `Long.MAX_VALUE` if it would positively overflow.
     * @since 1.6
     */
    abstract fun toHours(duration: Long): Long

    /**
     * Equivalent to
     * [DAYS.convert(duration, this)][.convert].
     * @param duration the duration
     * @return the converted duration
     * @since 1.6
     */
    abstract fun toDays(duration: Long): Long

    /**
     * Utility to compute the excess-nanosecond argument to wait,
     * sleep, join.
     * @param d the duration
     * @param m the number of milliseconds
     * @return the number of nanoseconds
     */
    abstract fun excessNanos(d: Long, m: Long): Int

    companion object {
        // Handy constants for conversion methods
        const val C0 = 1L
        const val C1 = C0 * 1000L
        const val C2 = C1 * 1000L
        const val C3 = C2 * 1000L
        const val C4 = C3 * 60L
        const val C5 = C4 * 60L
        const val C6 = C5 * 24L

        const val MAX = Long.MAX_VALUE

        /**
         * Scale d by m, checking for overflow.
         * This has a short name to make above code more readable.
         */
        fun x(d: Long, m: Long, over: Long): Long {
            if (d > +over) return Long.MAX_VALUE
            return if (d < -over) Long.MIN_VALUE else d * m
        }
    }
}
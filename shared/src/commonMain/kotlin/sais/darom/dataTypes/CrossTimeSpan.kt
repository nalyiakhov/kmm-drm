@file:Suppress("unused", "MemberVisibilityCanBePrivate")

package sais.darom.dataTypes

import com.soywiz.klock.TimeSpan
import kotlin.math.abs

class CrossTimeSpan : Comparable<CrossTimeSpan?> {
    object TimeHelper {
        private const val MILLISECONDS_IN_SEC: Long = 1000
        private const val MILLISECONDS_IN_MIN: Long = 60 * MILLISECONDS_IN_SEC
        private const val MILLISECONDS_IN_HOUR: Long = 60 * MILLISECONDS_IN_MIN
        private const val MILLISECONDS_IN_DAY: Long = 24 * MILLISECONDS_IN_HOUR

        fun fromSeconds(seconds: Long): Long {
            return seconds * MILLISECONDS_IN_SEC
        }

        fun fromSeconds(seconds: Double): Double {
            return seconds * MILLISECONDS_IN_SEC
        }

        fun fromMinutes(seconds: Long): Long {
            return seconds * MILLISECONDS_IN_MIN
        }

        fun fromMinutes(seconds: Double): Double {
            return seconds * MILLISECONDS_IN_MIN
        }

        fun fromHours(seconds: Long): Long {
            return seconds * MILLISECONDS_IN_HOUR
        }

        fun fromHours(seconds: Double): Double {
            return seconds * MILLISECONDS_IN_HOUR
        }

        fun fromDays(seconds: Long): Long {
            return seconds * MILLISECONDS_IN_DAY
        }

        fun fromDays(seconds: Double): Double {
            return seconds * MILLISECONDS_IN_DAY
        }
    }

    companion object {
        val ZERO = CrossTimeSpan(0)

        // Format: [-][d':']h':'mm':'ss'.'FFFFFFF   1      2         3      4      5          6
        private val timeSpanRegex = Regex("(-)?(?:(\\d+).)?(\\d+):(\\d+):(\\d+)(?:.(\\d+))?")

        /**
         * Compares two TimeSpan objects.
         *
         * @param first  first TimeSpan to use in the compare.
         * @param second second TimeSpan to use in the compare.
         * @return a negative integer, zero, or a positive integer as the first
         * TimeSpan is less than, equal to, or greater than the second
         * TimeSpan.
         */
        fun compare(first: CrossTimeSpan, second: CrossTimeSpan): Int {
            return compareValues(first.millis, second.millis)
        }

        fun parse(value: String): CrossTimeSpan {
            val matcher = timeSpanRegex.matchEntire(value)
            if (!timeSpanRegex.matches(value) || matcher == null) throw NumberFormatException(value)

            val isNegative = matcher.groupValues[1].isNotEmpty()
            val days = if (matcher.groupValues[2].isEmpty()) 0 else matcher.groupValues[2].toLong()
            val hours = matcher.groupValues[3].toLong()
            val minutes = matcher.groupValues[4].toLong()
            val seconds = matcher.groupValues[5].toLong()
            val ticks = if (matcher.groupValues[6].isEmpty()) 0 else matcher.groupValues[6].padEnd(7, '0').toLong()
            val msec = ticks / 10000

            var millis = (msec
                    + TimeUnit.SECONDS.toMillis(seconds)
                    + TimeUnit.MINUTES.toMillis(minutes)
                    + TimeUnit.HOURS.toMillis(hours)
                    + TimeUnit.DAYS.toMillis(days))

            if (isNegative) millis = -millis
            return CrossTimeSpan(millis)
        }

        fun fromMilliSeconds(milliSeconds: Long) = CrossTimeSpan(milliSeconds)
        fun fromSeconds(seconds: Long) = CrossTimeSpan(TimeHelper.fromSeconds(seconds))
        fun fromMinutes(minutes: Long) = CrossTimeSpan(TimeHelper.fromMinutes(minutes))
        fun fromHours(hours: Long) = CrossTimeSpan(TimeHelper.fromHours(hours))
        fun fromDays(days: Long) = CrossTimeSpan(TimeHelper.fromDays(days))

        fun CrossTimeSpan.toKlockTimeSpan(): TimeSpan {
            return TimeSpan(millis.toDouble())
        }
    }

    /**
     * The time.
     */
    var millis: Long = 0
        private set

    /**
     * Creates a new instance of TimeSpan based on the number of milliseconds
     * entered.
     *
     * @param millis the number of milliseconds for this TimeSpan.
     */
    constructor(millis: Long) {
        this.millis = millis
    }

    /**
     * Creates a new TimeSpan object based on the unit and value entered.
     *
     * @param unit  the type of unit to use to create a TimeSpan instance.
     * @param value the number of units to use to create a TimeSpan instance.
     */
    constructor(unit: TimeUnit, value: Long) {
        millis = unit.toMillis(value)
    }

    /**
     * Compares this object with the specified object for order. Returns a
     * negative integer, zero, or a positive integer as this object is less
     * than, equal to, or greater than the specified object. Comparison is based
     * on the number of milliseconds in this TimeSpan.
     *
     * @param other the Object to be compared.
     * @return a negative integer, zero, or a positive integer as this object is
     * less than, equal to, or greater than the specified object.
     */
    override fun compareTo(other: CrossTimeSpan?): Int {
        return compareValues(millis, other?.millis)
    }

    /**
     * Indicates whether some other object is "equal to" this one. Comparison is
     * based on the number of milliseconds in this TimeSpan.
     *
     * @param other the reference object with which to compare.
     * @return if the obj argument is a TimeSpan object with the exact same
     * number of milliseconds. otherwise.
     */
    override fun equals(other: Any?): Boolean {
        if (this === other) return true
        if (other !is CrossTimeSpan) return false
        return millis == other.millis
    }

    /**
     * Returns a hash code value for the object. This method is supported for
     * the benefit of hashtables such as those provided by
     * <code>java.util.Hashtable</code>. The method uses the same algorithm as
     * found in the Long class.
     *
     * @return a hash code value for this object.
     * see Object#equals(Object)
     * see java.util.Hashtable
     */
    override fun hashCode(): Int {
        return millis.hashCode()
    }

    /**
     * Indicates whether the value of the TimeSpan is positive.
     *
     * @return if the value of the TimeSpan is greater than
     * zero.  otherwise.
     */
    fun isPositive(): Boolean {
        return millis > 0
    }

    /**
     * Indicates whether the value of the TimeSpan is negative.
     *
     * @return if the value of the TimeSpan is less than zero.
     * otherwise.
     */
    fun isNegative(): Boolean {
        return millis < 0
    }

    /**
     * Indicates whether the value of the TimeSpan is zero.
     *
     * @return if the value of the TimeSpan is equal to zero.
     * otherwise.
     */
    fun isZero(): Boolean {
        return millis == 0L
    }

    /**
     * Gets the number of milliseconds.
     *
     * @return the number of milliseconds.
     */
    fun getMilliseconds(): Long {
        return TimeUnit.MILLISECONDS.toMillis(millis) - TimeUnit.SECONDS.toMillis(
            TimeUnit.MILLISECONDS.toSeconds(
                millis
            )
        )
    }

    /**
     * Gets the number of milliseconds.
     *
     * @return the number of milliseconds.
     */
    fun getTotalMilliseconds(): Long {
        return millis
    }

    /**
     * Gets the number of seconds (truncated).
     *
     * @return the number of seconds.
     */
    fun getSeconds(): Long {
        return TimeUnit.MILLISECONDS.toSeconds(millis) - TimeUnit.MINUTES.toSeconds(
            TimeUnit.MILLISECONDS.toMinutes(
                millis
            )
        )
    }

    /**
     * Gets the number of seconds including fractional seconds.
     *
     * @return the number of seconds.
     */
    fun getTotalSeconds(): Long {
        return TimeUnit.MILLISECONDS.toSeconds(millis)
    }

    /**
     * Gets the number of minutes (truncated).
     *
     * @return the number of minutes.
     */
    fun getMinutes(): Long {
        return TimeUnit.MILLISECONDS.toMinutes(millis) - TimeUnit.HOURS.toMinutes(
            TimeUnit.MILLISECONDS.toHours(
                millis
            )
        )
    }

    /**
     * Gets the number of minutes including fractional minutes.
     *
     * @return the number of minutes.
     */
    fun getTotalMinutes(): Long {
        return TimeUnit.MILLISECONDS.toMinutes(millis)
    }

    /**
     * Gets the number of hours (truncated).
     *
     * @return the number of hours.
     */
    fun getHours(): Long {
        return TimeUnit.MILLISECONDS.toHours(millis) - TimeUnit.DAYS.toHours(
            TimeUnit.MILLISECONDS.toDays(
                millis
            )
        )
    }

    /**
     * Gets the number of hours including fractional hours.
     *
     * @return the number of hours.
     */
    fun getTotalHours(): Long {
        return TimeUnit.MILLISECONDS.toHours(millis)
    }

    /**
     * Gets the number of days (truncated).
     *
     * @return the number of days.
     */
    fun getDays(): Long {
        return TimeUnit.MILLISECONDS.toDays(millis)
    }

    /**
     * Gets the number of days including fractional days.
     *
     * @return the number of days.
     */
    fun getTotalDays(): Long {
        return TimeUnit.MILLISECONDS.toDays(millis)
    }

    /**
     * Adds a TimeSpan to this TimeSpan.
     *
     * @param timespan the TimeSpan to add to this TimeSpan.
     */
    fun add(timespan: CrossTimeSpan) {
        add(TimeUnit.MILLISECONDS, timespan.millis)
    }

    /**
     * Adds a number of units to this TimeSpan.
     *
     * @param unit  the type of unit to add to this TimeSpan.
     * @param value the number of units to add to this TimeSpan.
     */
    fun add(unit: TimeUnit, value: Long) {
        millis += unit.toMillis(value)
    }

    /**
     * Returns a TimeSpan whose value is the absolute value of this TimeSpan.
     *
     * @return a TimeSpan whose value is the absolute value of this TimeSpan.
     */
    fun duration(): CrossTimeSpan {
        return CrossTimeSpan(abs(millis))
    }

    /**
     * Returns a TimeSpan whose value is the negated value of this TimeSpan.
     *
     * @return a TimeSpan whose value is the negated value of this TimeSpan.
     */
    fun negate(): CrossTimeSpan {
        return CrossTimeSpan(-millis)
    }

    /**
     * Subtracts a TimeSpan from this TimeSpan.
     *
     * @param timeSpan the TimeSpan to subtract from this TimeSpan.
     */
    fun subtract(timeSpan: CrossTimeSpan) {
        subtract(TimeUnit.MILLISECONDS, timeSpan.millis)
    }

    /**
     * Subtracts a number of units from this TimeSpan.
     *
     * @param unit  the type of unit to subtract from this TimeSpan.
     * @param value the number of units to subtract from this TimeSpan.
     */
    fun subtract(unit: TimeUnit, value: Long) {
        add(unit, -value)
    }

    operator fun plus(delta: CrossTimeSpan): CrossTimeSpan {
        add(delta)
        return this
    }

    operator fun minus(delta: CrossTimeSpan): CrossTimeSpan {
        subtract(delta)
        return this
    }

    operator fun unaryPlus(): CrossTimeSpan {
        millis = +millis
        return this
    }

    operator fun unaryMinus(): CrossTimeSpan {
        millis = -millis
        return this
    }

    /**
     * Returns a string representation of the object in the format.
     * "[-]d.hh:mm:ss.ff" where "-" is an optional sign for negative TimeSpan
     * values, the "d" component is days, "hh" is hours, "mm" is minutes, "ss"
     * is seconds, and "ff" is milliseconds
     *
     * @return a string containing the number of milliseconds.
     */
    override fun toString(): String {
        val sb = StringBuilder()
        var millis = millis
        if (millis < 0) {
            sb.append("-")
            millis = -millis
        }
        val day = TimeUnit.MILLISECONDS.toDays(millis)
        if (day != 0L) {
            sb.append(day) //d
            sb.append(".")
        }
        val hours = TimeUnit.MILLISECONDS.toHours(millis) - TimeUnit.DAYS.toHours(TimeUnit.MILLISECONDS.toDays(millis))
        sb.append(hours.padded(2))
        sb.append(":")

        val minutes = TimeUnit.MILLISECONDS.toMinutes(millis) - TimeUnit.HOURS.toMinutes(TimeUnit.MILLISECONDS.toHours(millis))
        sb.append(minutes.padded(2))
        sb.append(":")

        val seconds = TimeUnit.MILLISECONDS.toSeconds(millis) - TimeUnit.MINUTES.toSeconds(TimeUnit.MILLISECONDS.toMinutes(millis))
        sb.append(seconds.padded(2))

        val msec = TimeUnit.MILLISECONDS.toMillis(millis) - TimeUnit.SECONDS.toMillis(TimeUnit.MILLISECONDS.toSeconds(millis))
        if (msec != 0L) {
            sb.append(".")
            sb.append(msec.padded(3)) //ff
        }
        return sb.toString()
    }

    fun toMinSecString(): String {
        val sb = StringBuilder()

        val minutes = TimeUnit.MILLISECONDS.toMinutes(millis) - TimeUnit.HOURS.toMinutes(TimeUnit.MILLISECONDS.toHours(millis))
        sb.append(minutes.padded(2))
        sb.append(":")

        val seconds = TimeUnit.MILLISECONDS.toSeconds(millis) - TimeUnit.MINUTES.toSeconds(TimeUnit.MILLISECONDS.toMinutes(millis))
        sb.append(seconds.padded(2))

        return sb.toString()
    }

    private fun Long.padded(size: Int) = this.toString().padStart(size, '0')
}
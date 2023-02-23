@file:Suppress("unused", "MemberVisibilityCanBePrivate")

package sais.darom.dataTypes

import sais.darom.dataTypes.CrossTimeSpan.Companion.toKlockTimeSpan
import com.soywiz.klock.*

class CrossDateTime(private var dateTime: DateTime, var dateTimeKind: CrossDateTimeKind) : Comparable<CrossDateTime> {
    enum class CrossDateTimeKind {
        UTC,
        LOCAL
    }

    companion object {
        val EMPTY = CrossDateTime(DateTime(0, 1, 2), CrossDateTimeKind.UTC) //0000-01-02 to prevent an exception when changing timezone in IOS

        fun nowUtc() = CrossDateTime(DateTime.now(), CrossDateTimeKind.UTC)
        fun todayUtc() = CrossDateTime(DateTime(DateTime.now().date), CrossDateTimeKind.UTC)
        fun now() = CrossDateTime(DateTime.now(), CrossDateTimeKind.LOCAL).toLocalDateTime()
        fun today() = CrossDateTime(DateTime.now(), CrossDateTimeKind.LOCAL).toLocalDate().dateOnly

        fun parseAsUtc(value: String) = CrossDateTime(isoDateTimeFormat.parseUtc(value), CrossDateTimeKind.UTC)
        fun parseAsUtc(value: String, formatString: String) = CrossDateTime(DateFormat(formatString).parseUtc(value), CrossDateTimeKind.UTC)
        fun parseAsUtc(value: String, format: DateFormat) = CrossDateTime(format.parseUtc(value), CrossDateTimeKind.UTC)
        fun parse(value: String) = CrossDateTime(isoDateTimeFormat.parseUtc(value), CrossDateTimeKind.LOCAL)
        fun parse(value: String, formatString: String) = CrossDateTime(DateFormat(formatString).parseUtc(value), CrossDateTimeKind.LOCAL)
        fun parse(value: String, format: DateFormat) = CrossDateTime(format.parseUtc(value), CrossDateTimeKind.LOCAL)

        fun fromDateTime(dateTime: DateTime) = CrossDateTime(dateTime, CrossDateTimeKind.UTC)
        fun fromUnixTimeUtc(timeMillis: Long) = CrossDateTime(DateTime.fromUnix(timeMillis), CrossDateTimeKind.UTC)
        fun fromUnixTime(timeMillis: Long) = CrossDateTime(DateTime.fromUnix(timeMillis), CrossDateTimeKind.LOCAL)

        private val isoDateTimeFormat = DateFormat("yyyy-MM-dd HH:mm:ss.SSS")
        private val russianDateTimeFormat = DateFormat("dd.MM.yyyy HH:mm:ss")
        private val russianDateTimeMsFormat = DateFormat("dd.MM.yyyy HH:mm:ss.SSS")

        fun createUtc(year: Int, month: Int, day: Int, hour: Int, minute: Int, second: Int, millisecond: Int): CrossDateTime {
            return CrossDateTime(DateTime(year, month, day, hour, minute, second, millisecond), CrossDateTimeKind.UTC)
        }

        fun createUtc(year: Int, month: Int, day: Int, hour: Int, minute: Int, second: Int): CrossDateTime {
            return CrossDateTime(DateTime(year, month, day, hour, minute, second), CrossDateTimeKind.UTC)
        }

        fun createUtc(year: Int, month: Int, day: Int): CrossDateTime {
            return CrossDateTime(DateTime(year, month, day), CrossDateTimeKind.UTC)
        }

        fun create(year: Int, month: Int, day: Int, hour: Int, minute: Int, second: Int, millisecond: Int): CrossDateTime {
            return CrossDateTime(DateTime(year, month, day, hour, minute, second, millisecond), CrossDateTimeKind.LOCAL)
        }

        fun create(year: Int, month: Int, day: Int, hour: Int, minute: Int, second: Int): CrossDateTime {
            return CrossDateTime(DateTime(year, month, day, hour, minute, second), CrossDateTimeKind.LOCAL)
        }

        fun create(year: Int, month: Int, day: Int): CrossDateTime {
            return CrossDateTime(DateTime(year, month, day), CrossDateTimeKind.LOCAL)
        }
    }

    val unixTimeDouble: Double
        get() = dateTime.unixMillis

    val unixTimeLong: Long
        get() = dateTime.unixMillisLong

    val dateOnly: CrossDateTime
        get() = fromDateTime(DateTime(dateTime.date))

    val timeOnly: CrossTimeSpan
        get() = CrossTimeSpan(dateTime.time.encoded.millisecondsLong)

    val year: Int
        get() = dateTime.yearInt

    val month: Int
        get() = dateTime.month1

    val monthJava: Int
        get() = dateTime.month0

    val day: Int
        get() = dateTime.dayOfMonth

    val hour: Int
        get() = dateTime.hours

    val minute: Int
        get() = dateTime.minutes

    val second: Int
        get() = dateTime.seconds

    val millisecond: Int
        get() = dateTime.milliseconds

    val localOffsetMinutes: Int
        get() = dateTime.localOffset.totalMinutesInt

    override fun toString() = dateTime.format(isoDateTimeFormat)
    fun toString(stringPattern: String) = dateTime.toString(stringPattern)
    fun toString(format: DateFormat) = dateTime.toString(format)

    fun toRussianCultureString() = dateTime.toString(russianDateTimeFormat)
    fun toRussianCultureMsString() = dateTime.toString(russianDateTimeMsFormat)

    val russianMonths = arrayOf("ЯНВ", "ФЕВ", "МАР", "АПР", "МАЙ", "ИЮН", "ИЮЛ", "АВГ", "СЕН", "ОКТ", "НОЯ", "ДЕК")
    fun toRussianShortString(): String {
        return "${day} ${russianMonths.get(month - 1)} ${year}"
    }

    val russianFullMonths = arrayOf("ЯНВАРЬ", "ФЕВРАЛЬ", "МАРТ", "АПРЕЛЬ", "МАЙ", "ИЮНЬ", "ИЮЛЬ", "АВГУСТ", "СЕНТЯБРЬ", "ОКТЯБРЬ", "НОЯБРЬ", "ДЕКАБРЬ")
    fun toRussianString(): String {
        return "${day} ${russianFullMonths.get(month - 1)} ${year}"
    }

    fun toRussianMonthString(): String {
        return "${day} ${russianFullMonths.get(month - 1).lowercase()}"
    }

    fun toUtcDateTime(): CrossDateTime {
        if (dateTimeKind == CrossDateTimeKind.UTC)
            return this

        val dateTimeDiff = CrossTimeSpan.fromMinutes(localOffsetMinutes.toLong())
        val result = this - dateTimeDiff
        result.specifyKind(CrossDateTimeKind.UTC)
        return result
    }

    fun toLocalDate(): CrossDateTime {
        if (dateTimeKind == CrossDateTimeKind.LOCAL)
            return this

        val localVal = dateTime.local
        val result = DateTime(localVal.year, localVal.month, localVal.dayOfMonth)
        return CrossDateTime(result, CrossDateTimeKind.LOCAL)
    }

    fun toLocalDateTime(): CrossDateTime {
        if (dateTimeKind == CrossDateTimeKind.LOCAL)
            return this

        val localVal = dateTime.local
        val result = DateTime(
            localVal.year,
            localVal.month,
            localVal.dayOfMonth,
            localVal.hours,
            localVal.minutes,
            localVal.seconds,
            localVal.milliseconds
        )

        return CrossDateTime(result, CrossDateTimeKind.LOCAL)
    }

    fun specifyKind(kind: CrossDateTimeKind) {
        dateTimeKind = kind
    }

    fun trimSeconds(): CrossDateTime {
        return create(year, month, day, hour, minute, 0)
    }

    fun trimMilliSeconds(): CrossDateTime {
        return create(year, month, day, hour, minute, second, 0)
    }

    fun addYears(years: Int) = CrossDateTime(dateTime.add(MonthSpan(years * 12), TimeSpan(0.0)), dateTimeKind)
    fun addMonths(months: Int) = CrossDateTime(dateTime.add(MonthSpan(months), TimeSpan(0.0)), dateTimeKind)
    fun addDays(days: Long) = CrossDateTime(dateTime.add(MonthSpan(0), CrossTimeSpan.fromDays(days).toKlockTimeSpan()), dateTimeKind)
    fun addHours(hours: Long) = CrossDateTime(dateTime.add(MonthSpan(0), CrossTimeSpan.fromHours(hours).toKlockTimeSpan()), dateTimeKind)
    fun addMinutes(minutes: Long) = CrossDateTime(dateTime.add(MonthSpan(0), CrossTimeSpan.fromMinutes(minutes).toKlockTimeSpan()), dateTimeKind)
    fun addSeconds(seconds: Long) = CrossDateTime(dateTime.add(MonthSpan(0), CrossTimeSpan.fromSeconds(seconds).toKlockTimeSpan()), dateTimeKind)
    fun addMilliSeconds(milliSeconds: Long) = CrossDateTime(dateTime.add(MonthSpan(0), CrossTimeSpan.fromMilliSeconds(milliSeconds).toKlockTimeSpan()), dateTimeKind)
    fun addTime(timeSpan: CrossTimeSpan) = CrossDateTime(dateTime.add(MonthSpan(0), timeSpan.toKlockTimeSpan()), dateTimeKind)

    operator fun plus(delta: MonthSpan) = CrossDateTime(dateTime.add(delta.totalMonths, 0.0), dateTimeKind)
    operator fun plus(delta: DateTimeSpan) = CrossDateTime(dateTime.add(delta.totalMonths, delta.totalMilliseconds), dateTimeKind)
    operator fun plus(delta: TimeSpan) = CrossDateTime(dateTime.add(0, delta.milliseconds), dateTimeKind)
    operator fun plus(delta: CrossTimeSpan) = CrossDateTime(dateTime.add(0, delta.millis.toDouble()), dateTimeKind)
    operator fun plus(delta: CrossDateTime) = CrossDateTime(dateTime.add(0, delta.unixTimeDouble), dateTimeKind)
    operator fun plus(delta: DateTime) = CrossDateTime(dateTime.add(0, delta.unixMillis), dateTimeKind)
    operator fun plus(delta: Long) = CrossDateTime(dateTime.add(0, delta.toDouble()), dateTimeKind)

    operator fun minus(delta: MonthSpan) = this + -delta
    operator fun minus(delta: DateTimeSpan) = this + -delta
    operator fun minus(delta: TimeSpan) = this + -delta
    operator fun minus(delta: CrossTimeSpan) = this + -delta.getTotalMilliseconds()
    operator fun minus(delta: CrossDateTime) = this + -delta.unixTimeLong
    operator fun minus(delta: DateTime) = this + -delta.unixMillisLong
    operator fun minus(delta: Long) = this + -delta

    override fun compareTo(other: CrossDateTime): Int = dateTime.unixMillis.compareTo(other.dateTime.unixMillis)

    override fun equals(other: Any?): Boolean {
        if (this === other) return true
        if (other == null || this::class != other::class) return false
        other as CrossDateTime
        if (dateTime != other.dateTime) return false
        return true
    }

    override fun hashCode(): Int {
        return dateTime.unixMillisDouble.hashCode()
    }
}


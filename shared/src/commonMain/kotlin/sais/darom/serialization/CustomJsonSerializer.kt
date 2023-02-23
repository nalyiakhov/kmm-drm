package sais.darom.serialization

import sais.darom.serialization.types.*
import sais.darom.dataTypes.CrossDateTime
import sais.darom.dataTypes.CrossTimeSpan
import sais.darom.dataTypes.Guid
import com.benasher44.uuid.Uuid
import com.soywiz.klock.Date
import com.soywiz.klock.DateTime
import kotlinx.serialization.json.Json
import kotlinx.serialization.modules.SerializersModule

object CustomJsonSerializer {
    val customSerializer = Json {
        encodeDefaults = false // remove nulls and default values
        ignoreUnknownKeys = true
        isLenient = true // because of SignalR (JsonDecodingException: String literal for key 'result' should be quoted)
        coerceInputValues = true // use default values in case of null input for non-null variable and unknown enum values

        serializersModule = SerializersModule {
            contextual(Uuid::class, UuidSerializer())
            contextual(Guid::class, GuidSerializer())
            contextual(CrossDateTime::class, CrossDateTimeSerializer())
            contextual(CrossTimeSpan::class, CrossTimeSpanSerializer())

            // Notify if using non-common Date object
            contextual(Date::class, DateSerializer())
            contextual(DateTime::class, DateTimeSerializer())
        }
    }
}
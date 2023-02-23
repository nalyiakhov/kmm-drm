package sais.darom.dataTypes

import com.benasher44.uuid.Uuid
import com.benasher44.uuid.uuid4
import com.benasher44.uuid.uuidFrom

//Wrapper type because SQLDelight does not support expect/actual objects
class Guid(var uuid: Uuid) : Comparable<Guid> {
    companion object {
        val empty = Guid(Uuid(0, 0))
        fun newGuid(): Guid = Guid(uuid4())
        fun parse(from: String) = uuidFrom(from)

        fun String.toGuid(): Guid {
            return Guid(Guid.parse(this))
        }
    }

    fun toUuid(): Uuid {
        return uuid
    }

    override fun compareTo(other: Guid): Int {
        return uuid.compareTo(other.uuid)
    }

    override fun equals(other: Any?): Boolean {
        if (this === other) return true
        if (other == null || this::class != other::class) return false
        other as Guid
        if (uuid != other.uuid) return false
        return true
    }

    override fun hashCode(): Int {
        return uuid.hashCode()
    }

    operator fun compareTo(other: Uuid) : Int {
        return uuid.compareTo(other)
    }

    override fun toString(): String {
        return uuid.toString()
    }
}

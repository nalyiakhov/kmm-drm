package sais.darom.extensions

import dev.icerock.moko.resources.PluralsResource
import dev.icerock.moko.resources.StringResource
import dev.icerock.moko.resources.desc.*

//make additional extension methods for access from ios native code
//https://github.com/icerockdev/moko-resources#usage
object MokoResourcesExtensions {
	fun StringResource.asLocalizedString(): String {
		return this.desc().localized()
	}

	fun StringResource.asLocalizedString(args: List<String>): String {
		return StringDesc.ResourceFormatted(this, args).localized()
	}

	fun PluralsResource.asLocalizedPlural(quantity: Int): String {
		return StringDesc.Plural(this, quantity).localized()
	}

	fun PluralsResource.asLocalizedPlural(quantity: Int, args: List<String>): String {
		return StringDesc.PluralFormatted(this, quantity, args).localized()
	}
}
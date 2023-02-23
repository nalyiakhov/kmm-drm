package sais.darom.models

import kotlinx.serialization.SerialName
import kotlinx.serialization.Serializable
import sais.darom.Constants

@Serializable
data class Item(
    @SerialName("categoryId")
    val categoryId: Int = 0,
    @SerialName("completed")
    val completed: Int = 0,
    @SerialName("confirmed")
    val confirmed: Int = 0,
    @SerialName("created")
    val created: Long = 0,
    @SerialName("deadline")
    val deadline: Long = 0,
    @SerialName("delivery")
    val delivery: Long = 0,
    @SerialName("description")
    val descr: String? = null,
    @SerialName("id")
    val id: Long = 0,
    @SerialName("images")
    val images: String? = null,
    @SerialName("isUsed")
    val isUsed: Int? = null,
    @SerialName("location")
    val location: Long = 0,
    @SerialName("preview")
    val preview: String? = null,
    @SerialName("price")
    val price: Long = 0L,
    @SerialName("published")
    val published: Int = 0,
    @SerialName("purchased")
    val purchased: Long = 0,
    @SerialName("raters")
    val raters: Long = 0,
    @SerialName("rating")
    val rating: String? = null,
    @SerialName("reserved")
    val reserved: Long = 0,
    @SerialName("tickets")
    val tickets: Long = 0,
    @SerialName("title")
    val title: String = "",
    @SerialName("userId")
    val userId: Long = 0,
    @SerialName("username")
    val username: String = "",
    @SerialName("vendorCode")
    val vendorCode: String? = ""
) {
    val previewImages: List<String>
        get() { return images?.split(",") ?: listOf(Constants.PREVIEW_EMPTY) }
    val priceString: String
        get() { return price.toString() + "₽" }
    fun getDescriptions(): Map<String, String> {
        val descriptions: MutableMap<String, String> = mutableMapOf()
        if (isUsed != null) {
            descriptions["Состояние"] = if (isUsed == 0) "Новый" else "Б\\у"
        }
        if (vendorCode != null) {
            descriptions["Код"] = vendorCode
        }
        descriptions["Доставка"] = if (delivery == 0L) { "Бесплатная доставка" } else { if (delivery == 1L) "За счет покупателя" else "Самовывоз" }
        descriptions.entries.sortedBy { it.key }
        return descriptions
    }
}
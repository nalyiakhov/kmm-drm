package sais.darom.services

import kotlinx.coroutines.async
import sais.darom.UserData
import sais.darom.customCoroutineScope
import sais.darom.models.Item

class ItemsService {
	@Throws(Exception::class)
	suspend fun loadItems(): List<Item> {
		val itemsTask = customCoroutineScope.async { UserData.webClient.getItems() }
		return itemsTask.await()
	}
}
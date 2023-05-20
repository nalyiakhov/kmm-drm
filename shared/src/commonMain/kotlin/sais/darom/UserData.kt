package sais.darom

import sais.darom.services.ItemsService
import sais.darom.settings.Settings

object UserData {
    val webClient = WebClient()
    val itemsService = ItemsService()
    var settings: Settings = Settings()
}
package sais.darom.utils

import io.ktor.client.*

expect fun httpClient(config: HttpClientConfig<*>.() -> Unit = {}): HttpClient
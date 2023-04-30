package sais.darom

import sais.darom.serialization.CustomJsonSerializer
import io.ktor.client.*
import io.ktor.client.call.*
import io.ktor.client.network.sockets.*
import io.ktor.client.plugins.*
import io.ktor.client.plugins.contentnegotiation.*
import io.ktor.client.plugins.logging.*
import io.ktor.client.plugins.logging.LogLevel
import io.ktor.client.request.*
import io.ktor.client.statement.*
import io.ktor.http.*
import io.ktor.serialization.kotlinx.json.*
import io.ktor.utils.io.charsets.*
import kotlinx.coroutines.*
import sais.darom.dataTypes.CrossTimeSpan
import sais.darom.models.Item
import sais.darom.utils.SharedLogger
import sais.darom.utils.httpClient

class WebClient {
    @OptIn(ExperimentalCoroutinesApi::class)
    private val refreshTokenContext = newSingleThreadContext("RefreshTokenContext")
    private var isRefreshing: Boolean = false
    var context: Any? = null
    var onUnauthorizedExceptionCaught: () -> Unit = {}
    var onServiceUnavailableExceptionCaught: () -> Unit = {}

    private var httpClient: HttpClient = httpClient { //HttpClient {
        install(HttpTimeout) {
            connectTimeoutMillis = CrossTimeSpan.TimeHelper.fromSeconds(10)
            socketTimeoutMillis = CrossTimeSpan.TimeHelper.fromSeconds(30)
            requestTimeoutMillis = CrossTimeSpan.TimeHelper.fromSeconds(30)
        }

        install(ContentNegotiation) {
            json(CustomJsonSerializer.customSerializer)
        }

        if (Constants.IS_TEST) {
            install(Logging) {
                logger = HttpLogger()
                level = LogLevel.ALL
            }
        }

        expectSuccess = true
        followRedirects = true
    }

    class HttpLogger : Logger {
        override fun log(message: String) {
            SharedLogger.debug(message)
        }
    }

    @Suppress("NON_PUBLIC_CALL_FROM_PUBLIC_INLINE")
    @Throws(Exception::class)
    suspend inline fun <reified T>customGetRequest(path: String): T {
        try {
            return httpClient.get(path) {
                //addToken()
            }.body()
        } catch (exception: Exception) {
            println("CUSTOM ERROR ! " + exception.message)
            throw exception
        }
    }

    @Suppress("NON_PUBLIC_CALL_FROM_PUBLIC_INLINE")
    @Throws(Exception::class)
    suspend inline fun <reified T>customPostRequest(path: String, body: Any?): T {
        try {
            return httpClient.post(path) {
                setJsonContentType()
                //addToken()
                setBody(body)
            }.body()
        } catch (exception: Exception) {
            throw exception
        }
    }

    @Throws(Exception::class)
    suspend fun getItems(): List<Item> {
        return customGetRequest(Constants.API_BASE + Constants.ITEMS)
    }

    private fun HttpRequestBuilder.setJsonContentType() = header(HttpHeaders.ContentType, ContentType.Application.Json)
}
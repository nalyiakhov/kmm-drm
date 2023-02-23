package sais.darom.utils

import io.ktor.client.*
import io.ktor.client.engine.okhttp.*
import okhttp3.OkHttpClient
import sais.darom.Constants
import java.security.cert.X509Certificate
import javax.net.ssl.HostnameVerifier
import javax.net.ssl.SSLContext
import javax.net.ssl.TrustManager
import javax.net.ssl.X509TrustManager

actual fun httpClient(config: HttpClientConfig<*>.() -> Unit) = HttpClient(OkHttp) {
	config(this)

	if (Constants.IS_TEST) {
		engine {
			preconfigured = getUnsafeOkHttpClient()
		}
	}
}

private fun getUnsafeOkHttpClient(): OkHttpClient {
	val trustAllCerts = arrayOf<TrustManager>(object : X509TrustManager {
		override fun checkClientTrusted(chain: Array<out X509Certificate>?, authType: String?) {}
		override fun checkServerTrusted(chain: Array<out X509Certificate>?, authType: String?) {}
		override fun getAcceptedIssuers() = arrayOf<X509Certificate>()
	})

	val sslContext = SSLContext.getInstance("SSL")
	//sslContext.init(null, trustAllCerts, java.security.SecureRandom())
	sslContext.init(null, trustAllCerts, java.security.SecureRandom())
	val sslSocketFactory = sslContext.socketFactory

	val builder = OkHttpClient.Builder()
		.sslSocketFactory(sslSocketFactory, trustAllCerts[0] as X509TrustManager)
		.hostnameVerifier ( hostnameVerifier = HostnameVerifier{ _, _ -> true })
	return builder.build()
	//.hostnameVerifier { _, _ -> true }.build()
}
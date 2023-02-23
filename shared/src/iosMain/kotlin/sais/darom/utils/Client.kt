package sais.darom.utils

import io.ktor.client.*
import io.ktor.client.engine.darwin.*
import platform.Foundation.NSURLCredential
import platform.Foundation.NSURLSessionAuthChallengeUseCredential
import platform.Foundation.create
import platform.Foundation.serverTrust
import sais.darom.Constants

actual fun httpClient(config: HttpClientConfig<*>.() -> Unit) = HttpClient(Darwin) {
	config(this)
	engine {
		configureRequest {
			setAllowsCellularAccess(true)
			if (Constants.IS_TEST) {
				handleChallenge { session, task, challenge, completionHandler ->
					val serverTrust = challenge.protectionSpace.serverTrust
					val credential = NSURLCredential.create(serverTrust)
					completionHandler(NSURLSessionAuthChallengeUseCredential, credential)
				}
			}
		}
	}
}
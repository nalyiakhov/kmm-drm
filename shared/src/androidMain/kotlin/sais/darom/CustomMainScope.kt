package sais.darom

import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.Job
import kotlin.coroutines.CoroutineContext

actual class CustomMainScope : CoroutineScope {
    private val dispatcher = Dispatchers.Default
    private val job = Job()

    override val coroutineContext: CoroutineContext
        get() = dispatcher + job
}
package sais.darom

import kotlinx.coroutines.CoroutineScope

expect class CustomMainScope() : CoroutineScope

val customCoroutineScope: CustomMainScope
    get() = CustomMainScope()
package sais.darom

class Greeting {
    fun greeting(): String {
        return "Hello, ${Platform().platform}!"
    }
}
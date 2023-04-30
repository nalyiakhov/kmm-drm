buildscript {
    var kotlinVersion: String by extra
    var ktorVersion: String by extra
    var serializationVersion: String by extra
    var mokoResourcesVersion: String by extra

    kotlinVersion = "1.8.0"
    ktorVersion = "2.2.2"
    serializationVersion = "1.4.1"
    mokoResourcesVersion = "0.21.1"

    repositories {
        gradlePluginPortal()
        google()
        mavenCentral()
    }
    dependencies {
        classpath("org.jetbrains.kotlin:kotlin-gradle-plugin:$kotlinVersion")
        classpath("com.android.tools.build:gradle:7.4.2")
        classpath("org.jetbrains.kotlin:kotlin-serialization:$kotlinVersion")
        classpath("com.google.gms:google-services:4.3.14")
        classpath("com.google.firebase:firebase-crashlytics-gradle:2.9.2")
        classpath("dev.icerock.moko:resources-generator:$mokoResourcesVersion")
    }
}

allprojects {
    repositories {
        google()
        jcenter()
        mavenCentral()
        maven { url = uri("https://jitpack.io") }
    }
}

tasks.register("clean", Delete::class) {
    delete(rootProject.buildDir)
}
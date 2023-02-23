import org.jetbrains.kotlin.gradle.plugin.mpp.KotlinNativeTarget

plugins {
    kotlin("multiplatform")
    kotlin("native.cocoapods")
    id("com.android.library")
    id("org.jetbrains.kotlin.plugin.serialization")
}

version = "1.0"

kotlin {
    android()

    val ktorVersion = "2.0.0"
    val iosTarget: (String, KotlinNativeTarget.() -> Unit) -> KotlinNativeTarget =
        if (System.getenv("SDK_NAME")?.startsWith("iphoneos") == true)
            ::iosArm64
        else
            ::iosX64

    iosTarget("ios") {}

    cocoapods {
        summary = "Some description for the Shared Module"
        homepage = "Link to the Shared Module homepage"
        ios.deploymentTarget = "14.1"
        podfile = project.file("../iosApp/Podfile")
        framework {
            baseName = "shared"
            isStatic = true
        }
    }

    sourceSets {
        val commonMain by getting {
            dependencies {
                //Network
                implementation("io.ktor:ktor-client-core:$ktorVersion")
                implementation("com.soywiz.korlibs.klock:klock:2.4.5")
                implementation("com.benasher44:uuid:0.3.1")
                implementation("org.kodein.di:kodein-di:7.10.0")
                implementation("org.kodein.di:kodein-di-conf:7.10.0")

                implementation("io.ktor:ktor-client-json:$ktorVersion")
                implementation("io.ktor:ktor-client-logging:$ktorVersion")
                implementation("io.ktor:ktor-client-auth:$ktorVersion")
                implementation("io.ktor:ktor-client-content-negotiation:$ktorVersion")
                implementation("io.ktor:ktor-serialization-kotlinx-json:$ktorVersion")
            }
        }
        val androidMain by getting {
            dependencies {
                //Network
                //implementation("io.ktor:ktor-client-okhttp:$ktorVersion")
                implementation("io.ktor:ktor-client-okhttp:2.1.1")
                implementation("org.jetbrains.kotlinx:kotlinx-serialization-json:1.3.2")
                implementation("org.kodein.di:kodein-di-framework-android-x:7.10.0")
            }
        }
        val iosMain by getting {
            dependencies {
                //Network
                implementation("io.ktor:ktor-client-ios:$ktorVersion")
            }
        }
    }
}

android {
    compileSdk = 33
    sourceSets["main"].manifest.srcFile("src/androidMain/AndroidManifest.xml")
    defaultConfig {
        minSdk = 26
        targetSdk = 33
    }
}
plugins {
    kotlin("multiplatform")
    kotlin("native.cocoapods")
    id("com.android.library")
    id("org.jetbrains.kotlin.plugin.serialization")
    id("dev.icerock.mobile.multiplatform-resources")
}

version = "1.0"

val ktorVersion: String by rootProject.extra
val serializationVersion: String by rootProject.extra
val mokoResourcesVersion: String by rootProject.extra

kotlin {
    android {
        compilations.all {
            kotlinOptions {
                jvmTarget = "1.8"
            }
        }
    }

    listOf(
        iosX64(),
        iosArm64(),
        iosSimulatorArm64()
    ).forEach {
        it.binaries.framework {
            baseName = "shared"
            export("dev.icerock.moko:resources:$mokoResourcesVersion")
            export("dev.icerock.moko:graphics:0.9.0") // toUIColor here
        }
    }

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
        val commonMain by getting
        val androidMain by getting
        val iosX64Main by getting
        val iosArm64Main by getting
        val iosSimulatorArm64Main by getting
        val iosMain by creating {
            dependsOn(commonMain)
            iosX64Main.dependsOn(this)
            iosArm64Main.dependsOn(this)
            iosSimulatorArm64Main.dependsOn(this)

            dependencies {
                implementation("io.ktor:ktor-client-ios:$ktorVersion")
            }
        }
        val iosX64Test by getting
        val iosArm64Test by getting
        val iosSimulatorArm64Test by getting
    }
}

dependencies {
    commonMainApi("com.soywiz.korlibs.klock:klock:2.4.13")
    commonMainApi("com.benasher44:uuid:0.3.1")
    commonMainApi("org.kodein.di:kodein-di:7.10.0")
    commonMainApi("org.kodein.di:kodein-di-conf:7.10.0")

    //Network
    commonMainApi("io.ktor:ktor-client-core:$ktorVersion")
    commonMainApi("io.ktor:ktor-client-json:$ktorVersion")
    commonMainApi("io.ktor:ktor-client-logging:$ktorVersion")
    commonMainApi("io.ktor:ktor-client-auth:$ktorVersion")
    commonMainApi("io.ktor:ktor-client-content-negotiation:$ktorVersion")
    commonMainApi("io.ktor:ktor-serialization-kotlinx-json:$ktorVersion")

    commonMainApi("dev.icerock.moko:resources:$mokoResourcesVersion")


    commonTestApi(kotlin("test"))
    commonTestApi("dev.icerock.moko:resources-test:$mokoResourcesVersion")

    api("io.ktor:ktor-client-okhttp:$ktorVersion")
    api("org.jetbrains.kotlinx:kotlinx-serialization-json:$serializationVersion")
    api("org.kodein.di:kodein-di-framework-android-x:7.10.0")


    api(kotlin("test-junit"))
    api("junit:junit:4.13.2")
}

multiplatformResources {
    multiplatformResourcesPackage = "sais.drm" // required
    multiplatformResourcesClassName = "SharedRes" // optional, default MR
    iosBaseLocalizationRegion = "ru" // optional, default "en"
    multiplatformResourcesSourceSet = "commonMain"  // optional, default "commonMain"
    disableStaticFrameworkWarning = true
}

android {
    compileSdk = 33
    sourceSets["main"].manifest.srcFile("src/androidMain/AndroidManifest.xml")
    defaultConfig {
        minSdk = 26
        targetSdk = 33
    }
    namespace = "sais.darom"
}
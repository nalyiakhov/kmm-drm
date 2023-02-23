plugins {
    id("com.android.application")
    kotlin("android")
    kotlin("plugin.serialization")
}

android {
    compileSdk = 33
    defaultConfig {
        applicationId = "sais.darom.android"
        minSdk = 26
        targetSdk = 33
        versionCode = 1
        versionName = "1.0"
    }
    buildTypes {
        getByName("release") {
            isMinifyEnabled = false
        }
    }
    buildFeatures {
        viewBinding = true
    }
}

dependencies {
    implementation(project(":shared"))
    implementation("com.google.android.material:material:1.7.0")

    //adnroidx
    implementation("androidx.appcompat:appcompat:1.6.0-rc01")
    implementation("androidx.constraintlayout:constraintlayout:2.1.4")
    implementation("androidx.navigation:navigation-fragment:2.5.3")
    implementation("androidx.navigation:navigation-ui-ktx:2.5.3")
    implementation("androidx.fragment:fragment-ktx:1.5.4")
    implementation("androidx.activity:activity:1.6.0")
    implementation("androidx.biometric:biometric:1.1.0")

    implementation("com.basgeekball:awesome-validation:4.2")
    implementation("com.facebook.shimmer:shimmer:0.5.0")
    implementation("me.dm7.barcodescanner:zxing:1.9.13")
    implementation("in.srain.cube:grid-view-with-header-footer:1.0.12")
    implementation("com.soywiz.korlibs.klock:klock:2.4.5")
    implementation("org.jetbrains.kotlinx:kotlinx-serialization-json:1.3.2")
    implementation("com.google.guava:guava:31.0.1-jre")
    implementation("com.github.barteksc:android-pdf-viewer:2.8.2")
    implementation("com.squareup.picasso:picasso:2.8")
    implementation("org.imaginativeworld.whynotimagecarousel:whynotimagecarousel:2.1.0")
}
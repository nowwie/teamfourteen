 buildscript {
    repositories {
        google()
        mavenCentral()
    }
 dependencies {
        // Gradle Plugin Android (pastikan versinya sesuai dengan Flutter dan proyek kamu)
        classpath("com.android.tools.build:gradle:7.4.0")
        
        // Flutter plugin (sesuaikan dengan versi Flutter yang digunakan)
        classpath("dev.flutter.plugins:plugin-loader:1.0.0")
        
        // Tambahkan dependensi lain jika diperlukan
    }
}

allprojects {
    repositories {
        google()
        mavenCentral()
 	maven { url = uri("https://storage.googleapis.com/download.flutter.io") }
    }
}

val newBuildDir: Directory = rootProject.layout.buildDirectory.dir("../../build").get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
}
subprojects {
    project.evaluationDependsOn(":app")
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}

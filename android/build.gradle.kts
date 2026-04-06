allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

val newBuildDir: Directory = rootProject.layout.projectDirectory.dir("../build")
rootProject.layout.buildDirectory.set(newBuildDir)

subprojects {
    // Only redirect the build directory for the 'app' project.
    // Plugins will use their default internal build directories (often on C:),
    // which prevents the "different roots" error while keeping the APK in the project's build/ folder.
    if (project.name == "app") {
        val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
        project.layout.buildDirectory.set(newSubprojectBuildDir)
    }
    
    // Disable unit tests for subprojects (primarily plugins) 
    // to prevent Gradle from attempting to create cross-drive relative paths for test tasks.
    afterEvaluate {
        if (project.hasProperty("android")) {
            val android = project.extensions.getByName("android")
            if (android is com.android.build.gradle.BaseExtension) {
                android.testOptions.unitTests.all {
                    it.isEnabled = false
                }
            }
        }
    }
}
subprojects {
    project.evaluationDependsOn(":app")
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}

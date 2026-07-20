plugins {
  `java-library`
  `maven-publish`
}

extra["runapiSlug"] = "flux-2"

description = "RunAPI Flux 2 Java SDK for Flux 2 workflows."

java {
  withSourcesJar()
  withJavadocJar()
}

dependencies {
  api("ai.runapi:runapi-core:0.2.2")

  testImplementation(platform("org.junit:junit-bom:5.10.3"))
  testImplementation("org.junit.jupiter:junit-jupiter")
}

publishing {
  publications {
    create<MavenPublication>("mavenJava") {
      from(components["java"])
      artifactId = "runapi-flux-2"
      pom {
        name = "RunAPI Flux 2 Java SDK"
        description = "RunAPI Flux 2 Java SDK for Flux 2 workflows."
        url = "https://runapi.ai/models/flux-2"
        licenses {
          license {
            name = "Apache License, Version 2.0"
            url = "https://www.apache.org/licenses/LICENSE-2.0"
          }
        }
        developers {
          developer {
            id = "runapi"
            name = "RunAPI"
            email = "contact@runapi.ai"
          }
        }
        scm {
          url = "https://github.com/runapi-ai/flux-2-sdk"
          connection = "scm:git:https://github.com/runapi-ai/flux-2-sdk.git"
          developerConnection = "scm:git:ssh://git@github.com/runapi-ai/flux-2-sdk.git"
        }
      }
    }
  }
}

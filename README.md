# DuckDuckDefine - iOS


An iOS MVC project ripped apart then put back together with MVP, sharing common business logic between iOS and Android app architectures.

My inspiration for this project was to refamiliarise my understanding of iOS development, bringing across refined architecture concepts and workflows used for developing Android apps, to bridge my knowledge-gap of iOS development. I was unable to find a boilerplate project which combined MVP with Rx, Dependency Injection, near-auto JSON serialisation, and image loading & caching, all of which is mandatory in the Android apps I develop.

This project will benefit those who develop for either Android or iOS, and intend to transition to the other at some stage. I have created an Android-alterative to this project with common libraries found in production apps today. Both projects share the same business logic and will aid in understanding the differences between Swift & Java syntax, and iOS & Android frameworks, learning through example.

[The Java-Android-alternative project can be found here](https://github.com/teeeeeegz/DuckDuckDefine-Android)

[The Kotlin-Android-alternative project can be found here](https://github.com/teeeeeegz/DuckDuckDefine-KotlinAndroid)


### Libraries:
The following libraries were used, most of which have an Android alternative:
 * [RxSwift](https://github.com/ReactiveX/RxSwift) to provide a reactive programming standard VERY similar to [RxJava](https://github.com/ReactiveX/RxJava) implementation
 * [Alamofire](https://github.com/Alamofire/Alamofire) for API communication. Alternative to [OkHttp](https://github.com/square/okhttp)/[Retrofit](https://github.com/square/retrofit)
 * [RxAlamofire](https://github.com/RxSwiftCommunity/RxAlamofire) to Rxify network streams. Retrofit has Rx plugs baked in
 * [SwiftyJSON](https://github.com/SwiftyJSON/SwiftyJSON) to parse Alamofire 'Data' response to JSON
 * [Gloss](https://github.com/hkellaway/Gloss) to serialise JSON to POSO(?)'s, and vice-versa. Alternative to [Moshi](https://github.com/square/moshi)
 * [Swinject](https://github.com/Swinject/Swinject) for dependency injection. Alternative to [Dagger](https://github.com/google/dagger)
 * [SwinjectStoryboard](https://github.com/Swinject/SwinjectStoryboard) to provide singleton class/struct injection's into business logic classes/view controllers
 * [Kingfisher](https://github.com/onevcat/Kingfisher) for image caching and loading. Alternative to [Picasso](https://github.com/square/picasso)
 * [Carthage](https://github.com/Carthage/Carthage), not a library, but I use it due to its similarity of simplicity when adding dependencies to your [build.gradle file](https://docs.gradle.org/current/userguide/artifact_dependencies_tutorial.html)


Original iOS project downloaded from Ray Wenderlich's site, [here](https://www.raywenderlich.com/109330/carthage-tutorial-getting-started).

# PokemonTCGProject_Ajaib - Abdiel Chris Tanto

### Installation

Dependencies in this project are provided via Cocoapods. Please install all dependecies with

`
pod install
`

### Overview

This project contains clean architecture with MVVM pattern.
I'm using RxSwift as reactive programming tools for this apps.
For networking , This project used alamofire. And Snapkit as the tool for autolayout (without xib) User Interface.

For the foldering , I will explain shortly.
4 main folder :
1. Presentation : Contains -> View (User Interface) and ViewModel(View Logic)
2. Domain: Contains -> Use Case (Business Logic , bridges from presentation to data) , entities (Model Data for view) , Interfaces (protocol)
3. Data: Contains -> Repositories (bridges to networking), URL(contains url for fetch the data), Data Mapping (For mapping response)
4. Infrastructure: Contains -> Network Service



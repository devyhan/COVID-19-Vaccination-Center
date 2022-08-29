# COVID-19 Vaccination Center
  ## Useage
  ```
  $ pod install && xed .
  ```
  Project Root directory에서 pod install 실행 후 Pods.xcodeproj의 의존성이 있는 COVID-19-vaccination-center.xcworkspace를 실행하여 프로젝트를 실행합니다. 

    
  ## Libraries
  |Name|Description|
  |---|---|
  |SnapKit|Auto Layout을 쉽게 만듭니다.|
  |RxSwift|관찰 가능한 시퀀스를 사용하여 비동기 및 이벤트 기반 프로그램을 구성하기 위한 라이브러리입니다.|
  |RxCocoa|Cocoa Framework에 Rx기능을 합친 RxSwift 래퍼 입니다.|
  |RxCoreLocation|Core Location에 Rx기능을 합친 RxSwift 래퍼 입니다|
  |RxMKMapView|MapKit에 Rx기능을 합친 RxSwift 래퍼 입니다.|
 
  ## Project
   ### App
   - App의 시작점인 @main, Project Asset이 포함됩니다.
  
   ### Model
   - Domain, DataAccess layer가 포함됩니다.
    
   ### View
   - ViewController, View, TouchEvent, Animation등이 포함됩니다.
   
   ### ViewModel
   - Model과 의존하여 View에서 전달된 요청을 처리합니다.
   
   ### Utils 
   - Assets과 연결된 Namespace, Extension등이 포함됩니다.

  ## Tree

```
COVID-19-vaccination-center
├── App
│   └── Assets
│       ├── Assets.xcassets
│       │   ├── AccentColor.colorset
│       │   │   └── Contents.json
│       │   ├── AppIcon.appiconset
│       │   │   └── Contents.json
│       │   ├── Contents.json
│       │   ├── colors
│       │   │   ├── Contents.json
│       │   │   ├── blue.colorset
│       │   │   │   └── Contents.json
│       │   │   ├── gray.colorset
│       │   │   │   └── Contents.json
│       │   │   └── red.colorset
│       │   │       └── Contents.json
│       │   └── images
│       │       ├── Contents.json
│       │       ├── building.imageset
│       │       │   ├── Contents.json
│       │       │   └── building.png
│       │       ├── chat.imageset
│       │       │   ├── Contents.json
│       │       │   └── chat.png
│       │       ├── hospital.imageset
│       │       │   ├── Contents.json
│       │       │   └── hospital.png
│       │       ├── placeholder.imageset
│       │       │   ├── Contents.json
│       │       │   └── placeholder.png
│       │       ├── telephone.imageset
│       │       │   ├── Contents.json
│       │       │   └── telephone.png
│       │       └── top-alignment.imageset
│       │           ├── Contents.json
│       │           └── top-alignment.png
│       ├── Base.lproj
│       │   └── LaunchScreen.storyboard
│       └── Info.plist
├── AppDelegate.swift
├── Model
│   ├── Data
│   │   └── Network
│   │       ├── APIClient
│   │       │   └── APIClient.swift
│   │       ├── HTTPMethod.swift
│   │       └── RequestBuilder
│   │           └── RequestBuilder.swift
│   └── Domain
│       ├── Entities
│       │   └── CenterListDTO.swift
│       └── Usecase
│           └── VaccinationCenter.swift
├── README.md
├── Utils
│   └── Namespace.swift
├── View
│   ├── Cell
│   │   └── CenterCell.swift
│   ├── CustomVIew
│   │   └── ItemInfoView.swift
│   └── ViewController
│       ├── VaccinationCenterDetailVC.swift
│       ├── VaccinationCenterMapVC.swift
│       └── VaccinationCenterVC.swift
└── ViewModel
    └── VaccinationCenterVM.swift
```

//
//  VaccinationCenterMapVC.swift
//  COVID-19-vaccination-center
//
//  Created by YHAN on 2022/08/26.
//

import UIKit
import MapKit
import RxSwift
import RxCoreLocation
import RxMKMapView

final class VaccinationCenterMapVC: UIViewController {
  var center: Center?
  
  private var disposeBag = DisposeBag()
  private let locationManager = CLLocationManager()
  
  private let mapView: MKMapView = {
    let mapView = MKMapView()
    return mapView
  }()
  
  private let setUserLocationButton: UIButton = {
    let button = UIButton()
    button.backgroundColor = ColorSet.blue
    button.setTitle("현재위치로", for: .normal)
    button.layer.cornerRadius = 5
    return button
  }()
  
  private let setVaccinationCenterLocationButton: UIButton = {
    let button = UIButton()
    button.backgroundColor = ColorSet.red
    button.setTitle("접종센터로", for: .normal)
    button.layer.cornerRadius = 5
    return button
  }()
  
  private lazy var vStackView: UIStackView = {
    let stackView = UIStackView(arrangedSubviews: [setUserLocationButton, setVaccinationCenterLocationButton])
    stackView.axis = .vertical
    stackView.spacing = 10
    stackView.distribution = .fillEqually
    return stackView
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = .white
    
    setNavigation()
    setConstraints()
    setAuthentication()
    setAnnotationAndBindings()
  }
  
  private func setNavigation() {
    self.title = "지도"
    let navigationAppearance = UINavigationBarAppearance()
    navigationAppearance.backgroundEffect = .init(style: .light)
    self.navigationController?.navigationBar.scrollEdgeAppearance = navigationAppearance
  }
  
  private func setConstraints() {
    let guid = view.safeAreaLayoutGuide
  
    [mapView, vStackView].forEach {
      self.view.addSubview($0)
    }
    
    mapView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
    
    vStackView.snp.makeConstraints { make in
      make.horizontalEdges.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20))
      make.bottom.equalTo(guid).offset(-30)
      make.height.equalTo(100)
    }
  }
  
  private func setAnnotationAndBindings() {
    let annotation = MKPointAnnotation()
    let latitude = CLLocationDegrees(center?.lat ?? "0.0")
    let longitude = CLLocationDegrees(center?.lng ?? "0.0")
    let centerCoordinate = CLLocationCoordinate2D(latitude: latitude ?? 0.0, longitude: longitude ?? 0.0)
    let span = MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
    
    annotation.title = center?.centerName ?? ""
    annotation.coordinate = centerCoordinate
    
    self.mapView.addAnnotation(annotation)
    self.mapView.region.span = span
    self.mapView.setCenter(centerCoordinate, animated: false)
    
    let updateUserLocation = mapView.rx.didUpdateUserLocation.take(1)
    let userLocationButton = setUserLocationButton.rx.tap
    
    Observable.combineLatest(updateUserLocation, userLocationButton)
      .bind { userLocation, _ in
        self.mapView.setCenter(userLocation.coordinate, animated: false)
        self.mapView.region.span = span
      }
      .disposed(by: disposeBag)
    
    setVaccinationCenterLocationButton.rx.tap
      .bind {
        self.mapView.setCenter(centerCoordinate, animated: false)
        self.mapView.region.span = span
      }
      .disposed(by: disposeBag)
  }
  
  private func setAuthentication() {
    self.locationManager.requestAlwaysAuthorization()
    self.locationManager.requestWhenInUseAuthorization()
    self.locationManager.startUpdatingLocation()
    self.mapView.showsUserLocation = true
  }
}

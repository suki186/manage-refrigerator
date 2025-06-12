//
//  MapViewController.swift
//  manageRefrigerator
//
//  Created by suki on 6/1/25.
//

import UIKit
import NMapsMap
import CoreLocation

class MapViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var mapView: NMFNaverMapView!
    
    let locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()

        // 네이버 지도 초기화 설정
        mapView.showZoomControls = true
        mapView.showLocationButton = true
        
        // 위치 권한 요청
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        // 위치 추적모드 활성화
        mapView.mapView.positionMode = .normal
    
    }
    
    // 위치 업데이트 콜백
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        
        let coord = NMGLatLng(lat: location.coordinate.latitude, lng: location.coordinate.longitude)

        let cameraUpdate = NMFCameraUpdate(scrollTo: coord, zoomTo: 16.0)
        cameraUpdate.animation = .easeIn
        mapView.mapView.moveCamera(cameraUpdate)
        
        // 한 번만 받아오고 중단
        locationManager.stopUpdatingLocation()
    }

}

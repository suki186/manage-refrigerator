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

        let cameraUpdate = NMFCameraUpdate(scrollTo: coord, zoomTo: 14.0)
        cameraUpdate.animation = .easeIn
        mapView.mapView.moveCamera(cameraUpdate)
        
        // 한 번만 받아오고 중단
        locationManager.stopUpdatingLocation()
        
        // 주변 마트 검색
        searchNearbyMartsFromKakao(lat: coord.lat, lng: coord.lng)
    }
    
    func searchNearbyMartsFromKakao(lat: Double, lng: Double) {
        let query = "마트"
        let urlString = "https://dapi.kakao.com/v2/local/search/keyword.json?query=\(query)&x=\(lng)&y=\(lat)&radius=1000"

        guard let encoded = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let url = URL(string: encoded) else {
            print("❌ URL 인코딩 실패")
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("KakaoAK 477d328e18d6f62aff8ea22d326cc0e4", forHTTPHeaderField: "Authorization")

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("요청 실패: \(error)")
                return
            }
            
            guard let data = data,
                  let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
                  let documents = json["documents"] as? [[String: Any]] else {
                print("JSON 파싱 실패")
                return
            }
            

            DispatchQueue.main.async {
                for doc in documents {
                    guard let name = doc["place_name"] as? String,
                          let latStr = doc["y"] as? String,
                          let lngStr = doc["x"] as? String,
                          let lat = Double(latStr),
                          let lng = Double(lngStr) else {
                        continue
                    }

                    // 마커 생성
                    let marker = NMFMarker()
                    let image = NMFOverlayImage(name: "marker")
                    marker.position = NMGLatLng(lat: lat, lng: lng)
                    marker.captionText = name
                    marker.width = 30
                    marker.height = 50
                    marker.iconImage = image
                    marker.mapView = self.mapView.mapView
                    print("마커 생성: \(name) @ \(lat), \(lng)")
                }
            }
        }.resume()
    }

    
    @IBAction func currentLocationTapped(_ sender: UIButton) {
        guard let location = locationManager.location else {
            print("⚠️ 현재 위치를 가져올 수 없습니다.")
            return
        }

        let coord = NMGLatLng(lat: location.coordinate.latitude, lng: location.coordinate.longitude)

        let cameraUpdate = NMFCameraUpdate(scrollTo: coord, zoomTo: 16.0)
        cameraUpdate.animation = .easeIn
        mapView.mapView.moveCamera(cameraUpdate)

        // 위치 추적 모드
        mapView.mapView.positionMode = .direction
    }
    

}

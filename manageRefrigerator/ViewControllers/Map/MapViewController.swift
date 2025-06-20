//
//  MapViewController.swift
//  manageRefrigerator
//
//  Created by suki on 6/1/25.
//

import UIKit
import NMapsMap
import CoreLocation

struct MartInfo {
    let name: String
    let address: String
    let phone: String?
    let placeURL: String
}

class MapViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var mapView: NMFNaverMapView!
    @IBOutlet weak var infoCardView: UIView!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    
    let locationManager = CLLocationManager()
    var currentMartInfo: MartInfo?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        infoCardView.layer.cornerRadius = 12
        infoCardView.layer.masksToBounds = true
        infoCardView.isHidden = true

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
        guard let apiKey = Bundle.main.infoDictionary?["KakaoAPIKey"] as? String else {
            print("❌ Kakao API Key 로딩 실패")
            return
        }
        let query = "마트"
        let urlString = "https://dapi.kakao.com/v2/local/search/keyword.json?query=\(query)&x=\(lng)&y=\(lat)&radius=1000"

        guard let encoded = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let url = URL(string: encoded) else {
            print("❌ URL 인코딩 실패")
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("KakaoAK \(apiKey)", forHTTPHeaderField: "Authorization")

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
                    //print("마커 생성: \(name) @ \(lat), \(lng)")
                    
                    let address = doc["road_address_name"] as? String ?? "주소 없음"
                    let phoneRaw = doc["phone"] as? String
                    let phone = (phoneRaw?.isEmpty == false) ? phoneRaw : "-"
                    let placeURL = doc["place_url"] as? String ?? "https://map.kakao.com"

                    let info = MartInfo(
                        name: name,
                        address: address,
                        phone: phone,
                        placeURL: placeURL
                    )
                    
                    marker.userInfo["info"] = info
                    
                    // 마커 클릭 시
                    marker.touchHandler = { [weak self] _ in
                        guard let self = self else { return true }
                        
                        let update = NMFCameraUpdate(scrollTo: marker.position, zoomTo: 17)
                        update.animation = .easeIn
                        self.mapView.mapView.moveCamera(update)

                        print("infoCardView 보이기")
                        if let info = marker.userInfo["info"] as? MartInfo {
                            self.nameLabel.text = info.name
                            self.addressLabel.text = info.address
                            self.phoneLabel.text = info.phone ?? "-"
                            self.currentMartInfo = info
                            
                            print("🧩 카드 내용 바인딩 완료")
                            self.infoCardView.alpha = 1
                            self.infoCardView.isHidden = false
                            print("📦 infoCardView 보여지도록 설정")
                        }

                        return true
                    }
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
    
    @IBAction func openPlaceInBrowser(_ sender: UIButton) {
        if let urlString = currentMartInfo?.placeURL,
           let url = URL(string: urlString) {
            UIApplication.shared.open(url)
        }
    }
    
    @IBAction func closeInfoCard(_ sender: UIButton) {
        infoCardView.isHidden = true
    }
    
}

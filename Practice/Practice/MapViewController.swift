//
//  MapViewController.swift
//  Practice
//
//  Created by TomoKikuchi on 2021/06/21.
//
import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate{
    let view_width = UIScreen.main.bounds.width
    let view_height = UIScreen.main.bounds.height
    var locationMgr = CLLocationManager()
    var map_permission = false
    var map_exact_permission = false
    
    lazy var mapView: MKMapView = {
        let view = MKMapView.init()
        view.frame = CGRect(x:0, y:0, width: view_width, height: view_height)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        locationManagerDidChangeAuthorization(locationMgr)
        locationMgr.startUpdatingLocation()
        locationMgr.requestWhenInUseAuthorization()
        mapView.mapType = MKMapType.hybrid
        
        mapView.userTrackingMode = MKUserTrackingMode.follow
        mapView.userTrackingMode = MKUserTrackingMode.followWithHeading
        view.addSubview(mapView)
        
        if !map_permission || !map_exact_permission {
            let dialog = UIAlertController(title: "位置情報", message: "Appを利用するためには許可が必要です", preferredStyle: .alert)
            dialog.addAction(UIAlertAction(title: "設定を開く", style: .default, handler: nil))
            self.present(dialog, animated: true, completion: nil)
        }
       
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let region = MKCoordinateRegion(center: mapView.userLocation.coordinate, span: span)
        print("mapView.userLocation.coordinate：\(mapView.userLocation.coordinate)")
        mapView.region = region
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        let map_permission_status = manager.authorizationStatus
        switch map_permission_status {
        case .authorizedAlways, .authorizedWhenInUse:
            map_permission = true
            break
        case .notDetermined, .denied, .restricted:
            manager.requestWhenInUseAuthorization()
            map_permission = false
            break
        default:
            manager.requestWhenInUseAuthorization()
            map_permission = false
            break
        }
        
        let map_exact_permission_status = manager.accuracyAuthorization
        switch map_exact_permission_status {
        case .reducedAccuracy:
            map_exact_permission = false
            break
        case .fullAccuracy:
            map_exact_permission = true
            break
        default:
            map_exact_permission = false
        }
        
        print("map exact permission : \(self.map_exact_permission)")
        print("map       permission : \(self.map_permission)")
    }
}

//extension ViewController: MKMapViewDelegate {
    
//}

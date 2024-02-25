//
//  MapViewController.swift
//  RideSharer
//
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    let locationManager = CLLocationManager()
    
    struct Stadium { //Model Object
        var name: String
        var lattitude: CLLocationDegrees
        var longtitude: CLLocationDegrees
    }
    
    let stadiumsData = [Stadium(name: "Emirates Stadium", lattitude: 51.5549, longtitude: -0.108436),
                            Stadium(name: "Stamford Bridge", lattitude: 51.4816, longtitude: -0.191034),
                            Stadium(name: "White Hart Lane", lattitude: 51.6033, longtitude: -0.065684),
                            Stadium(name: "Olympic Stadium", lattitude: 51.5383, longtitude: -0.016587),
                            Stadium(name: "Old Trafford", lattitude: 53.4631, longtitude: -2.29139),
                            Stadium(name: "Anfield", lattitude: 53.4308, longtitude: -2.96096)]
    
    @IBOutlet weak var mapView: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        checkLocationServices()
        
//        Request Location permission
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
        
//        Configure Map View
        mapView.delegate = self
        mapView.showsUserLocation = true
        
        fetchStadiumsOnMap(stadiumsData)
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkLocationServices()
    }
//    This method can cause UI unresponsiveness if invoked on the main thread. Instead, consider waiting for the `-locationManagerDidChangeAuthorization:` callback and checking `authorizationStatus` first.
    func checkLocationServices() {
//        Check if location services are enabled
        if CLLocationManager.locationServicesEnabled(){
            checkLocationAuthorization()
        } else {
            print("Location services are not enabled")
        }
    }
    
    func checkLocationAuthorization() {
        switch CLLocationManager.authorizationStatus(){
            case .authorizedWhenInUse:
//                locationManager.requestWhenInUseAuthorization()
                mapView.showsUserLocation = true
            case .denied:
                let alert = UIAlertController(title: "Location Access Denied", message: "Please enable location access in Settings to use this feature", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            case .notDetermined:
                locationManager.requestWhenInUseAuthorization()
//                mapView.showsUserLocation = true
            case .restricted: break
            case .authorizedAlways: break
            @unknown default:
                break
        }
    }
    
    func fetchStadiumsOnMap(_ stadiumsData: [Stadium]){
        for stadium in stadiumsData {
            let annotations = MKPointAnnotation()
            annotations.title = stadium.name
            annotations.coordinate = CLLocationCoordinate2D(latitude: stadium.lattitude, longitude: stadium.longtitude)
            mapView.addAnnotation(annotations)
        }
    }
    

}

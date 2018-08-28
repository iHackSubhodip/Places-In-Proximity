//
//  PlaceMapsViewController.swift
//  PlacesInProximity
//
//  Created by Banerjee, Subhodip on 25/08/18.
//  Copyright © 2018 Subhodip. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class PlaceMapsViewController: UIViewController, MKMapViewDelegate {

    var presentLocation:CLLocationCoordinate2D?
    var places:[Places] = []
    var index:Int = -1
    fileprivate var annotation: MKAnnotation!
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard index >= 0, places.count > 0 else {
            return
        }
        
        let place = places[index]
        let lat = place.locationValue?.latitude ?? 1.310844
        let lng = place.locationValue?.longitude ?? 103.866048
        
        let center = CLLocationCoordinate2D(latitude: lat, longitude: lng)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        self.mapView.setRegion(region, animated: true)
        
        addSwipeGesture()
        didSelect(place: place)
        if presentLocation != nil {
            addMarkerAtCurrentLocation(presentLocation!)
        }
    }
    
    func addSwipeGesture() {
        let directions: [UISwipeGestureRecognizerDirection] = [.right, .left]
        for direction in directions {
            let gesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(sender:)))
            gesture.direction = direction
            self.bottomView.addGestureRecognizer(gesture)
        }
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "pin")
        annotationView.canShowCallout = true
        return annotationView
    }
    
    @objc func handleSwipe(sender: UISwipeGestureRecognizer) {
        
        guard index >= 0, places.count > 0 else {
            return
        }
        
        if sender.direction == .left {
            if index < places.count - 2 {
                index += 1
                didSelect(place: places[index])
            }
        } else if sender.direction == .right {
            if index > 1 {
                index -= 1
                didSelect(place: places[index])
            }
        }
    }
    
    func addMarkerAtCurrentLocation(_ userLocation: CLLocationCoordinate2D)  {
        let pointAnnotation = MKPointAnnotation()
        pointAnnotation.coordinate = CLLocationCoordinate2D(latitude: userLocation.latitude, longitude: userLocation.longitude)
        pointAnnotation.title = "Your location"
        mapView.addAnnotation(pointAnnotation)
    }
    
    func didSelect(place: Places) {
        
        guard let coordinates = place.locationValue else {
            return
        }
        
        if self.mapView.annotations.count != 0 {
            annotation = self.mapView.annotations[0]
            self.mapView.removeAnnotation(annotation)
        }
        
        let pointAnnotation = MKPointAnnotation()
        pointAnnotation.coordinate = coordinates
        pointAnnotation.title = place.name
        mapView.addAnnotation(pointAnnotation)
        
        // update bottom info panel view
        let desc = place.getDescription()
        descriptionLabel.text = desc.count > 0 ? desc : "-"
        distanceLabel.text = "-"
        
        // update distance
        if presentLocation != nil {
            let dist = distance(from: presentLocation!, to: coordinates)
            distanceLabel.text = String.init(format: "Distance %.2f meters", dist)
        }
        
        title = place.name
    }
    
    // distance between two coordinates
    func distance(from: CLLocationCoordinate2D, to: CLLocationCoordinate2D) -> CLLocationDistance {
        let from = CLLocation(latitude: from.latitude, longitude: from.longitude)
        let to = CLLocation(latitude: to.latitude, longitude: to.longitude)
        return from.distance(from: to)
    }

}

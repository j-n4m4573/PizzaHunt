//
//  ViewController.swift
//  PizzaHunt
//
//  Created by Jamar Gibbs on 2/3/16.
//  Copyright © 2016 M1ndful M3d1a. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit


class ViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    var items = [MKMapItem]()
    
    @IBOutlet weak var textView: UITextView!
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
    }
    
    @IBAction func stopViolatingPrivacy(sender: AnyObject) {
        
        locationManager.startUpdatingLocation()
        self.textView.text = "finding Pizza Locations"
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError){
        print(error)
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.first
        if location?.verticalAccuracy < 1000 && location?.horizontalAccuracy < 1000 {
            textView.text = "Location found. Retrieving Pizza Places😱"

            reverseGeocode(location!)
            locationManager.stopUpdatingLocation()
        }
    }
    
    func reverseGeocode(location: CLLocation) {
        
        let geoCoder = CLGeocoder()
        geoCoder.reverseGeocodeLocation(location) { (placemarks:[CLPlacemark]?,error:NSError?) -> Void in
            let placemark = placemarks?.first
            let address = "\(placemark!.subThoroughfare) \(placemark!.thoroughfare) \n \(placemark!.locality)"
            self.textView.text = "Found you: \(address)"
            self.findPizzaNear(location)
        }
        
        
    }
    
    func findPizzaNear(location : CLLocation)
        
    {
        
        let request = MKLocalSearchRequest()
        request.naturalLanguageQuery = "pizza"
        request.region = MKCoordinateRegionMake(location.coordinate, MKCoordinateSpanMake(1,1))
        let search = MKLocalSearch(request: request)
        search.startWithCompletionHandler { (response, error) -> Void in
            let mapItems = response?.mapItems
            let mapItem = mapItems?.first!
            
            
                        for item in mapItems! {
            
                            while (self.items.count <= 5){
                            self.items.append(item)
                        }
                            
            //             let pizzaItems = self.items.forEach(mapItem)
            //
            //                print(pizzaItems!.name!)
            //            }
            //
            self.textView.text = "Go directly to" + mapItem!.name!
            //            self.getDirectionsTo(mapItem!)
            
        }
        
    }
    
    //        func getDirectionsTo (destinationItem: MKMapItem) {
    //
    //            let request = MKDirectionsRequest()
    //            request.source = MKMapItem.mapItemForCurrentLocation()
    //            request.destination = destinationItem
    //            let directions = MKDirections(request: request)
    //            directions.calculateDirectionsWithCompletionHandler { (response, error) -> Void in
    //                let routes = response?.routes
    //                let route = routes?.first
    //                var counter = 1
    //                var str = ""
    //                for step: MKRouteStep in route!.steps {
    //                    str = str.stringByAppendingString("\(counter):" + step.instructions + "\n")
    //                    counter += 1
    //                }
    //                    
    //                    self.textView.text = str
    //                }
    //            }
    //
}

}


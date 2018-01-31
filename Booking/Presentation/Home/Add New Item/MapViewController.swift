//
//  MapViewController.swift
//  Booking
//
//  Created by Ahmad Ragab on 1/31/18.
//  Copyright © 2018 Ahmad Ragab. All rights reserved.
//

import UIKit
import MapKit

protocol LocationProtocol {
    func setItemLocation(location: [String])
}

class MapViewController: UIViewController, UISearchBarDelegate {

    //MARK: Outlets
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var mapView: MKMapView!
    
    //MARK: Locals
    var choosenLocation : LocationProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.searchBar.delegate = self
        self.searchBar.returnKeyType = .done
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        var resultLocation = [String]()
        resultLocation.append("")
        resultLocation.append("")
        
        choosenLocation?.setItemLocation(location: resultLocation)
    }
    
    // MARK: SearchBar Functions
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        
        UIApplication.shared.beginIgnoringInteractionEvents()
        
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.activityIndicatorViewStyle = .gray
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
        
        self.view.addSubview(activityIndicator)
        
        let searchRequest = MKLocalSearchRequest()
        searchRequest.naturalLanguageQuery = searchBar.text
        
        let activeSearch = MKLocalSearch(request: searchRequest)
        activeSearch.start(completionHandler: {
            (response, error) in
            
            activityIndicator.stopAnimating()
            UIApplication.shared.endIgnoringInteractionEvents()
            
            if error == nil {
                let annotations = self.mapView.annotations
                self.mapView.removeAnnotations(annotations)
                
                let lat = response?.boundingRegion.center.latitude
                let lng = response?.boundingRegion.center.longitude
                
                var resultLocation = [String]()
                resultLocation.append("\(lat!)")
                resultLocation.append("\(lng!)")
                
                self.choosenLocation?.setItemLocation(location: resultLocation)
                
                let annotation = MKPointAnnotation()
                annotation.title = searchBar.text
                annotation.coordinate = CLLocationCoordinate2DMake(lat!, lng!)
                self.mapView.addAnnotation(annotation)
                
                let coordinate : CLLocationCoordinate2D = CLLocationCoordinate2DMake(lat!, lng!)
                let span = MKCoordinateSpanMake(0.1, 0.1)
                let region = MKCoordinateRegionMake(coordinate, span)
                
                self.mapView.setRegion(region, animated: true)
            } else {
                let errorAlertController = Utilities.showAlertWithTitle(ERROR, withMessage: (error?.localizedDescription)!)
                self.present(errorAlertController, animated: true, completion: nil)
            }
        })
    }
}

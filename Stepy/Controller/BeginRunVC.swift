//
//  FirstViewController.swift
//  Stepy
//
//  Created by Sherif Kamal on 11/5/18.
//  Copyright © 2018 Sherif Kamal. All rights reserved.
//

import UIKit
import MapKit

class BeginRunVC: LocationVC {

    // MARK: Outlets
    @IBOutlet weak var mapView: MKMapView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkLocationStatus()
        mapView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        manager?.delegate = self
        manager?.startUpdatingLocation()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        manager?.stopUpdatingLocation()
    }
    
    @IBAction func locationCenterBtnPressed(_ sender: Any) {
        
    }
    
}

extension BeginRunVC: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkLocationStatus()
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
    }
}

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
    @IBOutlet weak var paceLbl: UILabel!
    @IBOutlet weak var distanceLbl: UILabel!
    @IBOutlet weak var durationLbl: UILabel!
    @IBOutlet weak var lastRunBGView: UIView!
    @IBOutlet weak var lastRunStack: UIStackView!
    @IBOutlet weak var lastRunCloseBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkLocationStatus()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        mapView.delegate = self
        manager?.delegate = self
        manager?.startUpdatingLocation()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupMapView()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        manager?.stopUpdatingLocation()
    }
    
    func setupMapView() {
        if let overlay = addLastRunToMap() {
            if mapView.overlays.count > 0 {
                mapView.removeOverlays(mapView.overlays)
            }
            mapView.addOverlay(overlay)
            lastRunStack.isHidden = false
            lastRunBGView.isHidden = false
            lastRunCloseBtn.isHidden = false
        } else {
            lastRunStack.isHidden = true
            lastRunBGView.isHidden = true
            lastRunCloseBtn.isHidden = true
        }
    }
    
    func addLastRunToMap() -> MKPolyline? {
        guard let lastRun = Run.getAllRuns()?.first else { return nil }
        paceLbl.text = lastRun.pace.formatDurationToString()
        distanceLbl.text = "\(lastRun.distance.metersToMiles(places: 2)) mi"
        durationLbl.text = lastRun.duration.formatDurationToString()
        var coordinates = [CLLocationCoordinate2D]()
        for location in lastRun.locations {
            coordinates.append(CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude))
        }
        return MKPolyline(coordinates: coordinates, count: lastRun.locations.count)
    }
   
    @IBAction func locationCenterBtnPressed(_ sender: Any) {
        
    }
    
    @IBAction func closeBtnPressed(_ sender: Any) {
        lastRunStack.isHidden = true
        lastRunBGView.isHidden = true
        lastRunCloseBtn.isHidden = true
    }
}

extension BeginRunVC: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkLocationStatus()
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let polyLine = overlay as! MKPolyline
        let renderer = MKPolylineRenderer(polyline: polyLine)
        renderer.strokeColor = #colorLiteral(red: 0.1764705926, green: 0.01176470611, blue: 0.5607843399, alpha: 1)
        renderer.lineWidth = 4
        return renderer
    }
}

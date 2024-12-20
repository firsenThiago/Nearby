//
//  HomeViewController.swift
//  Nearby
//
//  Created by Thiago Firsen on 10/12/24.
//

import UIKit
import MapKit

class HomeViewController: UIViewController {
    private var places: [Place] = []
    private let homeView: HomeView
    private var homeViewModel = HomeViewModel()
    
    init(homeView: HomeView) {
        self.homeView = homeView
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = homeView
        homeView.mapView.delegate = self
        homeView.configureTableViewDelegate(self, dataSource: self)
        defineInitialLocation()
        homeViewModel.fetchInitialData { [weak self] categories in
            guard let self = self else { return }
            self.homeView.updateFilterButtons(with: categories) { selectedCategory in
                self.filterPlaces(by: selectedCategory)
            }
        }
        
        self.addAnnotationsToMap()
        homeViewModel.didUpdatePlaces = { [weak self] in
            DispatchQueue.main.async {
                self?.places = self?.homeViewModel.places ?? []
                self?.homeView.reloadTableViewData()
                self?.addAnnotationsToMap()
            }
        }
    }
    
    private func defineInitialLocation() {
        let initialLocation = CLLocationCoordinate2D(latitude: homeViewModel.userLatitude, longitude: homeViewModel.userLongitude)
        homeView.mapView.setRegion(MKCoordinateRegion(center: initialLocation,
                                                      span: MKCoordinateSpan(latitudeDelta: 0.1,
                                                                             longitudeDelta: 0.1)),
                                   animated: false)
    }
    
    private func addAnnotationsToMap() {
        homeView.mapView.removeAnnotations(homeView.mapView.annotations)
        let annotations = places.map { PlaceAnnotation(place: $0) }
        homeView.mapView.addAnnotations(annotations)
        if let firstAnnotation = annotations.first {
            homeView.mapView.setRegion(MKCoordinateRegion(center: firstAnnotation.coordinate,
                                                          span: MKCoordinateSpan(latitudeDelta: 0.05,
                                                                                 longitudeDelta: 0.05)),
                                       animated: true)
        }
    }
    
    private func filterPlaces(by category: Category) {
        let currentCenter = homeView.mapView.region.center
        homeViewModel.fetchPlaces(for: category.id, userLocation: currentCenter)
    }
}

extension HomeViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard !(annotation is MKUserLocation) else { return nil }
        
        var identifier = "CustomPin"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKAnnotationView
        
        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true
            annotationView?.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
            
            if let pinImage = UIImage(named: "map") {
                annotationView?.image = pinImage
                annotationView?.frame.size = CGSize(width: 28, height: 32)
            }
        } else {
            annotationView?.annotation = annotation
            
        }
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        guard let annotaion = view.annotation as? PlaceAnnotation else { return }
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return places.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PlaceTableViewCell.identifier, for: indexPath) as? PlaceTableViewCell else {
            return UITableViewCell()
        }
        
        cell.configure(with: places[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

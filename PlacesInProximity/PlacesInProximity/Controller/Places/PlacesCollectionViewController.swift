//
//  PlacesCollectionViewController.swift
//  PlacesInProximity
//
//  Created by Banerjee, Subhodip on 25/08/18.
//  Copyright © 2018 Subhodip. All rights reserved.
//

import UIKit
import CoreLocation

private let reuseIdentifier = "PlacesCell"
class PlacesCollectionViewController: UICollectionViewController {
    
    var category : PlacesCategory?
    var presentLocation: CLLocationCoordinate2D?
    var places: [Places] = []
    var response: PlacesResponse?
    var isLoading = false
    var locationManager: CLLocationManager?
    var radius = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        category?.markView()
        getMyPresentLocation()
    }
    
    func setupCollectionView(){
        self.title = category?.name
        collectionView?.contentInset = UIEdgeInsets.init(top: 0, left: 15.0, bottom: 0, right: 15.0)
    }
    
    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: AppConstants.SegueIdentifier.mapSegueIdentifier, sender: indexPath)
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return places.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? PlacesCollectionViewCell else {
            fatalError("could not dequeue cell")
        }
        let place = places[indexPath.row]
        cell.update(place: place)
    
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == AppConstants.SegueIdentifier.mapSegueIdentifier && sender is IndexPath {
            if let vc = segue.destination as? PlaceMapsViewController {
                vc.index = (sender as! IndexPath).row
                vc.places = places
                vc.presentLocation = presentLocation
            }
        }
    }
}

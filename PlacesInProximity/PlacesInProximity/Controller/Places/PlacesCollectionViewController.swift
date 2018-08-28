//
//  PlacesCollectionViewController.swift
//  PlacesInProximity
//
//  Created by Banerjee, Subhodip on 25/08/18.
//  Copyright © 2018 Subhodip. All rights reserved.
//

import UIKit
import CoreLocation
import AVFoundation

private let reuseIdentifier = "PlacesCell"
class PlacesCollectionViewController: UICollectionViewController {
    
    var category : PlacesCategory?
    var presentLocation: CLLocationCoordinate2D?
    var places: [Places] = []
    var response: PlacesResponse?
    var locationManager: CLLocationManager?
    var radius = 0
    var activityIndicatorView: UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        places.removeAll()
        activityIndicatorView.startAnimating()
        determinePrestntLocation()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        category?.markView()
    }
    
    func setupCollectionView(){
        self.title = category?.name.uppercased()
        collectionView?.contentInset = UIEdgeInsets.init(top: 0, left: 30.0, bottom: 0, right: 30.0)
        activityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        collectionView?.backgroundView = activityIndicatorView
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

// MARK: 'UICollectionViewDelegate'
extension PlacesCollectionViewController{
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: AppConstants.SegueIdentifier.mapSegueIdentifier, sender: indexPath)
    }
}


// MARK: 'UICollectionViewDataSource'
extension PlacesCollectionViewController{
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return places.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //Make it generic
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? PlacesCollectionViewCell else {
            fatalError("could not dequeue cell")
        }
        let place = places[indexPath.row]
        cell.update(place: place)
        
        return cell
    }
    
}

// MARK: 'UICollectionViewDelegateFlowLayout'
extension PlacesCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let cellPadding: CGFloat = 20.0
        let columnWidth:CGFloat = 250
        let labelWidth = columnWidth - cellPadding * 2
        let annotationHeight = heightForAnnotationAtIndexPath(indexPath: indexPath, withWidth: labelWidth)
        return CGSize(width: collectionView.frame.width/3, height: annotationHeight * 2)
    }

    
    // MARK: Calculates the height label
    func heightForAnnotationAtIndexPath(indexPath: IndexPath, withWidth width: CGFloat) -> CGFloat {
        
        let place = places[indexPath.row]
        let annotationPadding = CGFloat(5)
        
        let font = UIFont.systemFont(ofSize: 15)
        let commentHeight = place.heightForComment(font, width: width)
        
        let height = annotationPadding + commentHeight + annotationPadding
        
        return height
    }
    
}

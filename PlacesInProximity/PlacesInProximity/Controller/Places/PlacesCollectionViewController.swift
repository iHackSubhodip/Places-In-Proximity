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
    }
    
    func setupCollectionView(){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else{
            return
        }
        appDelegate.locationManager.delegate = self
        self.title = category?.name
        collectionView?.contentInset = UIEdgeInsets.init(top: 0, left: 15.0, bottom: 0, right: 15.0)
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
extension PlacesCollectionViewController{
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 15.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let cellPadding: CGFloat = 20.0
        let columnWidth:CGFloat = 250
        let imageWidth = columnWidth
        let labelWidth = columnWidth - cellPadding * 2
        
        let photoHeight = heightForPhotoAtIndexPath(indexPath: indexPath, withWidth: imageWidth)
        let annotationHeight = heightForAnnotationAtIndexPath(indexPath: indexPath, withWidth: labelWidth)
        let height = photoHeight + annotationHeight
        
        return CGSize.init(width: columnWidth, height: height)
    }
    
    // MARK: Calculates the height of photo
    func heightForPhotoAtIndexPath(indexPath: IndexPath,
                                   withWidth width: CGFloat) -> CGFloat {
        
        var size = CGSize.init(width: CGFloat(MAXFLOAT), height: 1)
        let place = places[indexPath.row]
        
        guard let photo = place.photos?.first, place.photos?.first?.photoRefKey != nil, let widthP = photo.width, let heightP = photo.height else {
            return 0
        }
        
        size = CGSize.init(width: CGFloat(widthP), height: CGFloat(heightP))
        
        let boundingRect =  CGRect(x: 0, y: 0, width: width, height: CGFloat(MAXFLOAT))
        let rect  = AVMakeRect(aspectRatio: size, insideRect: boundingRect)
        
        return rect.size.height
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

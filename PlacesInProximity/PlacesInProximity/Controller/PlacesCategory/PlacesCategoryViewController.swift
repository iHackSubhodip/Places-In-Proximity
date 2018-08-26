//
//  PlacesCategoryViewController.swift
//  PlacesInProximity
//
//  Created by Banerjee, Subhodip on 26/08/18.
//  Copyright © 2018 Subhodip. All rights reserved.
//

import UIKit

class PlacesCategoryViewController: UIViewController {

    @IBOutlet weak var radiusTextField: UITextField!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var searchButton: UIButton!{
        didSet{
            searchButton.isEnabled = false
            searchButton.alpha = 0.5
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Places In Proximity"
        [radiusTextField, searchTextField].forEach({ $0.addTarget(self, action: #selector(editingChanged), for: .editingChanged) })
    }

    @IBAction func searchButtonAction(_ sender: UIButton) {
        
        self.performSegue(withIdentifier: AppConstants.SegueIdentifier.categorySegueIdentifier, sender: PlacesCategory(name: searchTextField.text!))
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == AppConstants.SegueIdentifier.categorySegueIdentifier {
            guard let category = sender as? PlacesCategory else {
                return
            }
            if let vc = segue.destination as? PlacesCollectionViewController {
                vc.category = category
                vc.radius = Int(radiusTextField.text!)!
            }
        }
    }
    
}

extension PlacesCategoryViewController{
    
    @objc func editingChanged(_ textField: UITextField) {
        if textField.text?.count == 1 {
            if textField.text?.first == " " {
                textField.text = ""
                return
            }
        }
        guard
            let radius = radiusTextField.text, !radius.isEmpty,
            let search = searchTextField.text, !search.isEmpty
            else {
                self.searchButton.isEnabled = false
                self.searchButton.alpha = 0.5
                return
        }
        searchButton.isEnabled = true
        searchButton.alpha = 1.0
    }
}

//
//  HomeViewController.swift
//  WASP
//
//  Created by Madhavi  Solanki on 16/03/19.
//  Copyright © 2019 Madhavi  Solanki. All rights reserved.
//

import UIKit
import GooglePlacePicker

class HomeViewController: UIViewController,GMSPlacePickerViewControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
				print("home")
        // Do any additional setup after loading the view.
    }
	
	@IBAction func pickPlace(_ sender: UIButton) {
		let config = GMSPlacePickerConfig(viewport: nil)
		let placePicker = GMSPlacePickerViewController(config: config)
		placePicker.delegate = self
		present(placePicker, animated: true, completion: nil)
	}
	
	// To receive the results from the place picker 'self' will need to conform to
	// GMSPlacePickerViewControllerDelegate and implement this code.
	func placePicker(_ viewController: GMSPlacePickerViewController, didPick place: GMSPlace) {
		// Dismiss the place picker, as it cannot dismiss itself.
		viewController.dismiss(animated: true, completion: nil)
		
		print("Place name \(place.name)")
		print("Place address \(place.formattedAddress)")
		print("Place attributions \(place.attributions)")
	}
	
	func placePickerDidCancel(_ viewController: GMSPlacePickerViewController) {
		// Dismiss the place picker, as it cannot dismiss itself.
		viewController.dismiss(animated: true, completion: nil)
		
		print("No place selected")
	}

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

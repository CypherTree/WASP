//
//  RegistrationViewController.swift
//  WASP
//
//  Created by Madhavi  Solanki on 16/03/19.
//  Copyright © 2019 Madhavi  Solanki. All rights reserved.
//

import UIKit
import FirebaseDatabase

class RegistrationViewController: UIViewController {

	var user: User?
	@IBOutlet weak var textFieldName: UITextField!
	@IBOutlet weak var textFieldEmail: UITextField!
	@IBOutlet weak var imageViewProfile: UIImageView!

	
	override func viewDidLoad() {
		do {
////			imageViewProfile.image =  try UIImage(data: try Data.init(contentsOf: URL(fileURLWithPath: "https://platform-lookaside.fbsbx.com/platform/profilepic/?asid=10157510758207448&height=100&width=100&ext=1555327030&hash=AeRc0BuZurvSQiKI")))
//		} catch {
//			print("JSON Processing Failed")
		}
		textFieldName.text = user?.name
		textFieldEmail.text = user?.email
		var ref: DatabaseReference!
		
		ref = Database.database().reference()
		ref.child("users").child(user?.uid ?? "sdsdsd23").setValue(["name": user?.name, "email": user?.email, "profile_pic": user?.profileURL?.absoluteString])
		moveToHomeScreen()
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
	
	func moveToHomeScreen() {
		let viewControllerToPresent = self.storyboard?.instantiateViewController(withIdentifier:"HomeViewController") as! HomeViewController
		self.present(viewControllerToPresent, animated: true, completion: nil)
		
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

//
//  LoginViewController.swift
//  WASP
//
//  Created by Madhavi  Solanki on 16/03/19.
//  Copyright © 2019 Madhavi  Solanki. All rights reserved.
//

import UIKit
import FacebookLogin
import FacebookCore
import Firebase
import FirebaseDatabase

class LoginViewController: UIViewController {
	

  override func viewDidLoad() {
		// Add a custom login button to your app
		let myLoginButton = LoginButton(readPermissions: [ .publicProfile, .email ])
		myLoginButton.backgroundColor = UIColor.darkGray
		myLoginButton.frame = CGRect.init(x: 0, y: 0, width: 180, height: 40)
		myLoginButton.center = view.center
		myLoginButton.delegate = self
		// Handle clicks on the button
		
		// Add the button to the view
		view.addSubview(myLoginButton)
		super.viewDidLoad()

	}
	
    // Do any additional setup after loading the view, typically from a nib.
}

extension LoginViewController: LoginButtonDelegate {
	
	
	func loginButtonDidCompleteLogin(_ loginButton: LoginButton, result: LoginResult) {
			switch result {
			case .failed(let error):
				print(error)
		case .cancelled:
			print("User cancelled login.")
		case .success( _, _, let accessToken):
			print("Success")
			print(accessToken.authenticationToken.description)
			let credential = FacebookAuthProvider.credential(withAccessToken: accessToken.authenticationToken)
			Auth.auth().signInAndRetrieveData(with: credential) { (authResult, error) in
				print(authResult?.user.displayName)
				if let error = error {
					print("ERROR FIREBASE")
					print(error.localizedDescription)
					return
				}else{
					let userID = Auth.auth().currentUser!.uid

					self.getUserDetailsFromFacebook(token: accessToken, uid: userID as NSString)

					print("Firebase success")
				}
			}
			print(result)
		}

	}
	func loginButtonDidLogOut(_ loginButton: LoginButton) {
		
	}
	
	func getUserDetailsFromFacebook(token: AccessToken, uid: NSString){
		let connection = GraphRequestConnection()
		connection.add(GraphRequest.init(graphPath: "/me", parameters: ["fields": "id, name, first_name, last_name, email,picture"], accessToken: token, httpMethod: .GET, apiVersion: .defaultVersion)) { httpResponse, result in
			switch result {
			case .success(let response):
				let dict: [String : Any] = response.dictionaryValue?["picture"] as! [String : Any]
				let dictURL: [String : Any] = dict["data"] as! [String : Any] 
				let user = User(name:response.dictionaryValue?["name"]! as? String, profileURL: URL(fileURLWithPath: dictURL["url"]! as! String), email: response.dictionaryValue?["email"]! as! String, uid: uid as String)
				print(user)
				print("Graph Request Succeeded: \(response)")
				self.moveToRegistrationScreen(user: user)
			case .failed(let error):
				print("Graph Request Failed: \(error)")
			}
		}
		connection.start()
	}
	
	func moveToRegistrationScreen(user:User){
		let viewControllerToPresent = self.storyboard?.instantiateViewController(withIdentifier:"RegistrationViewController") as! RegistrationViewController
		viewControllerToPresent.user = user
		self.navigationController?.pushViewController(viewControllerToPresent, animated: true)

	}
}



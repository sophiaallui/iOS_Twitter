//
//  LoginViewController.swift
//  Twitter
//
//  Created by Sophia Lui on 4/27/21.
//  Copyright © 2021 Dan. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        // page showed up >> check the note, default is set to userLoggedIn msg
        if UserDefaults.standard.bool(forKey: "userLoggedIn") == true{
            
            self.performSegue(withIdentifier: "loginToHome", sender: self)
        }
    }

    // Action to button,
    @IBAction func onLoginButton(_ sender: Any) {
        let myURL = "https://api.twitter.com/oauth/request_token"
        // API Caller
        TwitterAPICaller.client?.login(url: myURL, success: {
            // Note in memory, user logged in and verified
            // logged in = true
            UserDefaults.standard.set(true, forKey: "userLoggedIn")
            
            //login to home screen
            // perform a segue to loginToHome
            self.performSegue(withIdentifier: "loginToHome", sender: self)
        }, failure: { (Error) in
            print("could not login")
        })
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

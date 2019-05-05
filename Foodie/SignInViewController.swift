//
//  SignInViewController.swift
//  Foodie
//
//  Created by HAIYING WENG on 5/4/19.
//  Copyright © 2019 Hack Challenge. All rights reserved.
//

import UIKit
import SnapKit
import GoogleSignIn

class SignInViewController: UIViewController, GIDSignInUIDelegate{
    
    var signInButton: GIDSignInButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(red:1, green:0.45, blue:0.42, alpha:0.9)
        
        GIDSignIn.sharedInstance().uiDelegate = self
        
        signInButton = GIDSignInButton()
        signInButton.style = .wide
        signInButton.colorScheme = .light
        view.addSubview(signInButton)
        
        setupConstraints()
    }
    
    func setupConstraints() {
        signInButton.snp.makeConstraints { make in
            make.centerX.centerY.equalTo(view)
        }
    }
}

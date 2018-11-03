//
//  UIStuff.swift
//  Test
//
//  Created by Lucca Paletta on 11/3/18.
//  Copyright © 2018 Lucca Paletta. All rights reserved.
//

import Foundation
import UIKit
import WebKit

extension ViewController {
    
    func noGoogle(){
        DispatchQueue.main.async {
        self.labelTop.text = "This image is not recognized. Please try again"
        self.learnMoreOutlet.isHidden = true
        self.buttonToCamOutlet.isHidden = false
        }
    }
    
    func noData(name : String, message : String){
        DispatchQueue.main.async {
            self.labelTop.text = name
            self.labelBottom.text = "This product is not in our database"
            self.learnMoreOutlet.isHidden = true
            self.buttonToCamOutlet.isHidden = false
        }


    }
    
    func success(score : Int, name : String, company : String){
        DispatchQueue.main.async {
        self.labelTop.text = "\(name), \(company)"
        self.labelBottom.text = "Score: \(score)"
        self.learnMoreOutlet.isHidden = false
        self.buttonToCamOutlet.isHidden = false
        }
    }
    
    func beginningState(){
        learnMoreOutlet.isHidden = true
        labelTop.text = ""
        labelBottom.text = ""
        
    }
    
    func loading(){
        buttonToCamOutlet.isHidden = true
        learnMoreOutlet.isHidden = true
        labelTop.text = "Loading"
        labelBottom.text = ""
    }
    
    
//    override func loadView() {
//        let webConfiguration = WKWebViewConfiguration()
//        webView = WKWebView(frame: .zero, configuration: webConfiguration)
//        webView.uiDelegate = self
//        view = webView
//    }
    
    
    
}

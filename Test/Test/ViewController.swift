//
//  ViewController.swift
//  Test
//
//  Created by Lucca Paletta on 11/2/18.
//  Copyright © 2018 Lucca Paletta. All rights reserved.
//

import UIKit
import WebKit

struct picture : Codable{
    var picture : Data
}

struct forGoogs : Codable{
    var requests : thing
}

struct thing : Codable{
    var image : thing2
    var features : thing3
}

struct thing2 : Codable{
    var content : String
}

struct thing3 : Codable{
    var type : String
    var maxResults : Int
}

struct fromEmily : Decodable {
    var food_name : String
    var success : Bool
    var score : Int
    var message : String
    var company : String
}




class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, WKUIDelegate {
    
    @IBAction func ButtonToCam(_ sender: UIButton) {
        openCamera()
    }
    
    var webView : WKWebView!
    
    @IBAction func LearnMore(_ sender: Any) {
//        let myURL = URL(string:"http://ec2-54-84-135-159.compute-1.amazonaws.com/green_food/display.html")
//        let myRequest = URLRequest(url: myURL!)
//        webView.load(myRequest)
        
    }
    

    
    @IBOutlet weak var learnMoreOutlet: UIButton!
    
    @IBOutlet weak var buttonToCamOutlet: UIButton!
    
    @IBOutlet weak var labelTop: UILabel!
    
    @IBOutlet weak var labelBottom: UILabel!
    
    @IBOutlet weak var image: UIImageView!
    
    
    
    let privateKey = "AIzaSyANCyMQ8kuYgI__a4Bn9hweGwnqywYNZUo"
    let imagePicker = UIImagePickerController()
    var imageFromCam : UIImage?
    
    override func viewDidLoad() {
        
        beginningState()
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //openCamera()
        
        
        
    }
    
    func openCamera(){
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            imagePicker.sourceType = .camera
            imagePicker.delegate = (self as UIImagePickerControllerDelegate & UINavigationControllerDelegate)
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true)
        }
        else{
            print("SOURCE NOT AVAILABLE")
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imageFromCam = info[.originalImage] as? UIImage
        picker.dismiss(animated: true, completion: {
            
            self.loading()
            
            //BELOW LINE IS FOR TESTING
            //           self.imageFromCam = UIImage(named: "tarts.jpg")
            //            print("size of imagefromFile for debug \(self.imageFromCam?.size)")
            //done testing lines
            
            
            self.imageFromCam = self.imageFromCam?.resizeUIImage(size: CGSize(width: 480, height: 640))
            
            self.image.image = self.imageFromCam
            
            
            
            
            let URLString = "https://vision.googleapis.com/v1/images:annotate?key=\(self.privateKey)"
            
            let url2 = URL(string: URLString )
            
            
            
            self.imageUploaderGOOGZ(imageView: self.image, url: url2!)
        })
    }
    
    func imageUploaderGOOGZ(imageView : UIImageView, url: URL){
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        
        let image = imageView.image
        print("IMAGE SIZE IS \(image?.size)")
        let imageData = image?.pngData()
        let base64Image = imageData?.base64EncodedString()
        
        let pic = forGoogs(requests: thing(image: thing2(content: base64Image!), features: thing3(type: "LOGO_DETECTION", maxResults: 1)))
        
        
        
        
        var headers = request.allHTTPHeaderFields ?? [:]
        headers["Content-Type"] = "application/json"
        request.allHTTPHeaderFields = headers
        
        
        let encoder = JSONEncoder()
        
        do {
            let jsonData = try encoder.encode(pic)
            print("JSONDATA IS")
            print(jsonData)
            request.httpBody = jsonData
        } catch{
            print("Didn't work")
        }
        
        
        
        
        
        
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        let task = session.dataTask(with: request) { (responseData, response, responseError) in
            
            
            if responseError != nil{
                print(responseError)
            }
            
            if let data = responseData, let utf8Representation = String(data: data, encoding: .utf8) {
                print("response: ", utf8Representation)
            }
            
            
            self.sendingToServer(data: responseData!, url: URL(string: "http://ec2-54-84-135-159.compute-1.amazonaws.com/~emily/green_food/test.php")!)
            
        }
        task.resume()
        
        
    }
    
    
    //------------------------------------------------------------------------------------------------
    
    func sendingToServer(data : Data, url: URL){
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        
        
        var headers = request.allHTTPHeaderFields ?? [:]
        headers["Content-Type"] = "application/json"
        request.allHTTPHeaderFields = headers
        
        
        
        let encoder = JSONEncoder()
        
        var namet = ""
        var scoret = 0
        var successt = false
        var messaget = ""
        var companyt = ""
        
        
        request.httpBody = data
        
        
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        let task = session.dataTask(with: request) { (responseData, response, responseError) in
            if responseError != nil{
                print("ERROR: NO RESPONSE DATA FROM SERVER")
                print(responseError)
            }
            
            if let data = responseData, let utf8Representation = String(data: data, encoding: .utf8) {
                print("response: ", utf8Representation)
                //attempting to regular expression
                var myString = String(bytes: data, encoding: .utf8)!
                let expression = try? NSRegularExpression(pattern: "{.*}", options: [])
                
                var str = expression?.matches(in: myString, options: [], range: NSMakeRange(0,myString.count))
                
                //                str?.sort(by: {(a,b) in
                //                    let range = myString.index()
                //                    myString.substring(with: range)
                //                })
                //
                
                
                
                
                
                
                print("CUT JSON IS AS FOLLOWS")
                print(expression)
                var serialjson = try? JSONSerialization.jsonObject(with: data, options: [])
                print("SERIALJSON \(serialjson)")
                
                // end regular expression
                
                
                
                let decoder = JSONDecoder()
                
                
                
                
                do{
                    let data2 = try decoder.decode(fromEmily.self, from: responseData!)
                    print(data2.score)
                    namet = data2.food_name
                    scoret = data2.score
                    successt = data2.success
                    messaget = data2.message
                    companyt = data2.company
                    
                    
                } catch {
                    print("didn't work down here RECIEVING FROM SERVER")
                    
                    self.noGoogle()
                    return
                    
                    
                }
                
            } else {
                print("no readable data received in response")
            }
            
            print(messaget)
            print(namet)
            print(companyt)
            print(successt)
            
            
            
            
            if successt{
                self.success(score : scoret, name: namet, company : companyt)
                return
            }
                
            else{
                self.noData(name : namet, message : messaget)
                print("NoDataCasa")
                return
                
            }
            
            
        }
        task.resume()
        
        
    }
    
    
    
    
    
    
    
    
    
    public func imagePickerControllerDidCancel(_ picker: UIImagePickerController){
        print("IMAGE PICKER CANCLEED")
    }
    
    
    
}



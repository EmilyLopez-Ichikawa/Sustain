//
//  ViewController.swift
//  Test
//
//  Created by Lucca Paletta on 11/2/18.
//  Copyright © 2018 Lucca Paletta. All rights reserved.
//

import UIKit

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
}

struct fromGoogz : Decodable {
   // responses : thing4
}


class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBAction func ButtonToCam(_ sender: UIButton) {
        openCamera()
        
        
    }
    
    @IBOutlet weak var image: UIImageView!
    
    
    
    let privateKey = "AIzaSyANCyMQ8kuYgI__a4Bn9hweGwnqywYNZUo"
    let imagePicker = UIImagePickerController()
    var imageFromCam : UIImage?
    
   override func viewDidLoad() {
        
    
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
            
            //BELOW LINE IS FOR TESTING
            
            
            self.imageFromCam = UIImage(named: "tarts.jpg")
            print("size of imagefromFile for debug \(self.imageFromCam?.size)")
            //done testing lines
            
            
            //UNCOMMENT OUT: RESIZING LINE  self.imageFromCam = self.imageFromCam?.resizeUIImage(size: CGSize(width: 480, height: 640))
            
            self.image.image = self.imageFromCam
            

            
            
            let URLString = "https://vision.googleapis.com/v1/images:annotate?key=\(self.privateKey)"
            
            let url2 = URL(string: URLString )
            
            
            
            self.imageUploaderGOOGZ(imageView: self.image, url: url2!)
            })
    }
    
    func imageUploaderGOOGZ(imageView : UIImageView, url: URL){
        // let request = NSMutableURLRequest(url: url)
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        
        let image = imageView.image
        print("IMAGE SIZE IS \(image?.size)")
        let imageData = image?.pngData()
        let base64Image = imageData?.base64EncodedString()
        
       // let pic = picture(picture: base64Image!)
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
//          // print(responseData)
//            print("test")
            if let data = responseData, let utf8Representation = String(data: data, encoding: .utf8) {
                print("response: ", utf8Representation)
                }
//
//
//
//            } else {
//                print("no readable data received in response")
//            }
//
//            let json = try? JSONSerialization.jsonObject(with: responseData!, options: []) as! [String : Any]
//
//            print(json!["responses"])
            
            
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
        
        //let variable : [String : Any]
        
//        do {
//            print("DATA IS\(data)")
//            let jsonData = try encoder.encode(data)
////            print("JSONDATA IS")
////            print(jsonData)
//            request.httpBody = jsonData
//        } catch{
//            print(error)
//            print("Didn't work SENDING TO SERVER")
//        }
        
        
        

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
                
                let decoder = JSONDecoder()
                
                do{
                    let data2 = try decoder.decode(fromEmily.self, from: responseData!)
                print(data2.score)
                
                    
                } catch {
                    print("didn't work down here RECIEVING FROM SERVER")
                }
                    
            } else {
                print("no readable data received in response")
            }
        }
        task.resume()
            
            
    }
    
    
    

    
    
     public func imagePickerControllerDidCancel(_ picker: UIImagePickerController){
        print("IMAGE PICKER CANCLEED")
    }
        
        
        
}
        


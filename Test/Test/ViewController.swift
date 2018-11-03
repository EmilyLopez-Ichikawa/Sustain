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
    var success : Bool
    var user : String
}

class ViewController: UIViewController {

    @IBOutlet weak var image: UIImageView!
    let privateKey = "AIzaSyANCyMQ8kuYgI__a4Bn9hweGwnqywYNZUo"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let url = URL(string: "http://ec2-54-84-135-159.compute-1.amazonaws.com/~emily/green_food/test.php")
        let URLString = "https://vision.googleapis.com/v1/images:annotate?key=\(privateKey)"
        print(URLString)
        let url2 = URL(string: URLString )
        //imageUploaderEmily(imageView: image, url: url!)
        
        imageUploaderGOOGZ(imageView: image, url: url2!)
        
    }

    
    func imageUploaderGOOGZ(imageView : UIImageView, url: URL){
        // let request = NSMutableURLRequest(url: url)
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        
        let image = imageView.image
        //print(image)
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
           print(responseData)
            print("test")
            if let data = responseData, let utf8Representation = String(data: data, encoding: .utf8) {
                print("response: ", utf8Representation)
                

                
            } else {
                print("no readable data received in response")
            }
        }
        task.resume()
        
        
    }
    
    
    //------------------------------------------------------------------------------------------------
    
    func imageUploaderEmily(imageView : UIImageView, url: URL){
       // let request = NSMutableURLRequest(url: url)
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        
        let image = imageView.image
        //print(image)
        let imageData = image?.pngData()
        let base64Image = imageData?.base64EncodedData()
        
        let pic = picture(picture: base64Image!)
        
        print("pic=")
        print(pic)
        
        
       
        
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
            print(responseData)
            print("test")
            if let data = responseData, let utf8Representation = String(data: data, encoding: .utf8) {
                print("response: ", utf8Representation)
                
                let decoder = JSONDecoder()
                
                do{
                    let data2 = try decoder.decode(fromEmily.self, from: responseData!)
                print(data2.user)
                
                    
                } catch {
                    print("didn't work down here")
                }
                    
            } else {
                print("no readable data received in response")
            }
        }
        task.resume()
            
            
    }
        
        
        
}
        


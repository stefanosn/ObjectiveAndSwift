//
//  getUserToken.swift
//  ObjectiveAndSwift
//
//  Created by Stefanos Neofytidis on 31/12/21.
//

import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

@objc public class ObjectiveAndSwift:NSObject{
    //start of class
    @objc func getToken() -> String{


        let parameters = [
  [
    "key": "grant_type",
    "value": "password",
    "type": "text"
  ],
  [
    "key": "client_id",
    "value": "mobile.client",
    "type": "text"
  ],
  [
    "key": "client_secret",
    "value": "secret",
    "type": "text"
  ],
  [
    "key": "username",
    "value": "uk20@test.com",
    "type": "text"
  ],
  [
    "key": "password",
    "value": "Q12345",
    "type": "text"
  ],
  [
    "key": "scope",
    "value": "openid users.api campaigns.api offline_access",
    "type": "text"
  ]] as [[String : Any]]
       
        var body = ""
        let boundary = "Boundary-\(UUID().uuidString)"
        body=setBodyOfRequest(parameters1:parameters,boundary1:boundary)
        
        let postData = body
        let responseData = setURLQuery(postData1: postData, boundary1: boundary)

        return responseData;
}
    
    func setURLQuery(postData1:String,boundary1:String) -> String{
        let semaphore = DispatchSemaphore (value: 0)
        
        var request = URLRequest(url: URL(string: "https://api-uat.test.aws.the8app.com/eightauthapi/connect/token")!,timeoutInterval: Double.infinity)
        request.addValue("multipart/form-data; boundary=\(boundary1)", forHTTPHeaderField: "Content-Type")

        request.httpMethod = "POST"
        request.httpBody = postData1.data(using: .utf8)

        var response1 = ""
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
          guard let data = data else {
            print(String(describing: error))
            semaphore.signal()
            return
          }
          print(String(data: data, encoding: .utf8)!)
            response1 = String(data: data, encoding: .utf8)!
          semaphore.signal()
        }

        task.resume()
        semaphore.wait()
        return response1
    }
    
    
    func setBodyOfRequest(parameters1:[[String : Any]],boundary1:String) -> String{
        var body = ""
        //var error: Error? = nil
        for param in parameters1 {
          if param["disabled"] == nil{
            let paramName = param["key"]!
            body += "--\(boundary1)\r\n"
            body += "Content-Disposition:form-data; name=\"\(paramName)\""
            if param["contentType"] != nil {
              body += "\r\nContent-Type: \(param["contentType"] as! String)"
            }
            let paramType = param["type"] as! String
            if paramType == "text" {
              let paramValue = param["value"] as! String
              body += "\r\n\r\n\(paramValue)\r\n"
            } else {
              let paramSrc = param["src"] as! String
               
                do {
                    let fileData = try NSData(contentsOfFile:paramSrc, options:[]) as Data
 
              let fileContent = String(data: fileData, encoding: .utf8)!
              body += "; filename=\"\(paramSrc)\"\r\n"
                + "Content-Type: \"content-type header\"\r\n\r\n\(fileContent)\r\n"
                } catch {
                    print("Unexpected error")
                }
            }
          }
        }
        body += "--\(boundary1)--\r\n";
        return body
    }
    //end of class
}

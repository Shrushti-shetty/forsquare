//
//  NetworkManager.swift
//  FOURSQUAREAPP
//
//  Created by Shrushti Shetty on 04/01/23.
//
import UIKit
import Foundation

class NetworkManager{
    func postData(url: String,parameters: [String:Any]?,header: [String: String]?,completion: @escaping(Any?, HTTPURLResponse , Error?) -> Void) {
        var request = URLRequest(url: URL(string: url)!)
        
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = header
        if let parameters = parameters {
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            do {
                let data = try JSONSerialization.data(withJSONObject: parameters, options: [])
                request.httpBody = data
            } catch {
                print("Error: cannot create JSON from data")
                return
            }
        }
        
        
        URLSession.shared.dataTask(with: request) { responseData, response, error in
            print(type(of: responseData))
            if let response = response as? HTTPURLResponse {
                print("Response", response.statusCode)
                let body = String(data: responseData!, encoding: .utf8)
                print("Response body: \(String(describing: body))")
                if let data =  responseData{
                    do
                    {
                        
                        if let jsonData = try JSONSerialization.jsonObject(with:data, options: .mutableContainers) as? [String:Any]{
                            completion(jsonData,response,nil)
                        }
                        else{
                            print(" networkfailed")
                        }
                    }
                    catch{
                        print(error.localizedDescription)
                    }
                    
                }
                else{
                    print(error!.localizedDescription)
                }
            }
            if error != nil {
                print(error?.localizedDescription as Any, "error")
                completion(nil,response as! HTTPURLResponse,error)
            }
        }.resume()
    }
    
    func getData(at url: NSMutableURLRequest, completion: @escaping (Any?,Error?) -> Void) {
        
        let task = URLSession.shared.dataTask(with: url as URLRequest) {
            data, response, error in
            print("Reponse", response)
            if let apiData = data {
                do {
                    //                    if let jsonData = try JSONSerialization.jsonObject(with: apiData, options: .mutableContainers)
                    //                        as? Any{
                    //                        print(jsonData)
                    //                        completion(jsonData,nil)
                    //                    }
                    //                    else{
                    //                        print("networkfailed")
                    //
                    //                    }
                    let jsonData = try JSONSerialization.jsonObject(with: apiData, options: .mutableContainers)
                    print(jsonData)
                    completion(jsonData,nil)
                }
                catch{
                    print(error.localizedDescription, "this error")
                }
            }
        }
        task.resume()
    }
    //    func postReview(imagesToSend: [UIImage],placeIdToSend: String, reviewText: String,token: String, completion: @escaping((Bool,Error?) -> ())) {
    //
    //        guard let url = URL(string:"https://app-foursquare-230104103641.azurewebsites.net/user/review") else{
    //            return
    //        }
    //
    //            var request = URLRequest(url: url)
    //
    //            request.httpMethod = "POST"
    //
    //            let boundary = "Boundary-\(UUID().uuidString)"
    //            request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
    //            request.setValue("\(token)", forHTTPHeaderField: "Authorization")
    //
    //            let data = NSMutableData()
    //
    //        let fieldName = "files"
    //        for image in imagesToSend{
    //            if let imageData = image.jpegData(compressionQuality: 1) {
    //                data.append("--\(boundary)\r\n".data(using: .utf8) ?? data as Data)
    //                data.append("Content-Disposition: form-data; name=\"\(fieldName)\"; filename=\"image.jpg\"\r\n".data(using: .utf8) ?? data as Data)
    //                data.append("Content-Type: image/jpeg\r\n\r\n".data(using: .utf8) ?? data as Data)
    //                data.append(imageData)
    //                data.append("\r\n".data(using: .utf8) ?? data as Data)
    //            }
    //        }
    //
    //
    //        let review = "review"
    //            data.append("--\(boundary)\r\n".data(using: .utf8) ?? data as Data)
    //            data.append("Content-Disposition: form-data; name=\"\(review)\"\r\n\r\n".data(using: .utf8) ?? data as Data)
    //            data.append(reviewText.data(using: .utf8) ?? data as Data)
    //            data.append("\r\n".data(using: .utf8) ?? data as Data)
    //
    //            data.append("--\(boundary)--\r\n".data(using: .utf8) ?? data as Data)
    //        let placeId = "placeId"
    //            data.append("--\(boundary)\r\n".data(using: .utf8) ?? data as Data)
    //            data.append("Content-Disposition: form-data; name=\"\(placeId)\"\r\n\r\n".data(using: .utf8) ?? data as Data)
    //            data.append(placeIdToSend.data(using: .utf8) ?? data as Data)
    //            data.append("\r\n".data(using: .utf8) ?? data as Data)
    //
    //            data.append("--\(boundary)--\r\n".data(using: .utf8) ?? data as Data)
    //
    //
    //            request.httpBody = data as Data
    //
    //        let task = URLSession.shared.dataTask(with: request, completionHandler: { data, responce, error in
    //
    //            guard let data = data, error == nil else{
    //                print("\(String(describing: error?.localizedDescription))")
    //                return
    //            }
    //
    //            if let responsIs = responce as? HTTPURLResponse{
    //
    //                print("Profile api responce",responsIs.statusCode)
    //                if (responsIs.statusCode == 200 || responsIs.statusCode == 201){
    //
    //                    do{
    //                        let _ = try? JSONSerialization.jsonObject(with: data, options: .allowFragments)
    //
    //                        completion(true,nil)
    //
    //                    }
    //                }else if (responsIs.statusCode == 400) {
    //                    print(responce?.description)
    //
    //                    completion(false,error)
    //                }else{
    //
    //                    completion(false,error)
    //                }
    //
    //            }
    //
    //        })
    //
    //        task.resume()
    //
    //
    //
    //    }
    func postReview(images: [UIImage],  placeId: String, review: String, completion: @escaping (Bool,Error?) -> Void) {
        let url = URL(string: "https://example.com/api/submit")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        let boundary = "Boundary-\(UUID().uuidString)"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        var data = Data()
        
        // add token field
        data.append("--\(boundary)\r\n".data(using: .utf8) ?? data as Data)
        data.append("Content-Disposition: form-data; name=\"token\"\r\n\r\n".data(using: .utf8) ?? data as Data)
        data.append("\(token)\r\n".data(using: .utf8) ?? data as Data)
        
        // add placeId field
        data.append("--\(boundary)\r\n".data(using: .utf8) ?? data as Data)
        data.append("Content-Disposition: form-data; name=\"placeId\"\r\n\r\n".data(using: .utf8) ?? data as Data)
        data.append("\(placeId)\r\n".data(using: .utf8) ?? data as Data)
        
        // add review field
        data.append("--\(boundary)\r\n".data(using: .utf8) ?? data as Data)
        data.append("Content-Disposition: form-data; name=\"review\"\r\n\r\n".data(using: .utf8) ?? data as Data)
        data.append("\(review)\r\n".data(using: .utf8) ?? data as Data)
        
        // add images field
        data.append("--\(boundary)\r\n".data(using: .utf8) ?? data as Data)
        data.append("Content-Disposition: form-data; name=\"files\"\r\n\r\n".data(using: .utf8) ?? data as Data)
        for image in images {
            if let imageData = image.jpegData(compressionQuality: 1) {
                data.append("--\(boundary)\r\n".data(using: .utf8) ?? data as Data)
                data.append("Content-Disposition: form-data; name=\"files\"; filename=\"image.jpg\"\r\n".data(using: .utf8) ?? data as Data)
                data.append("Content-Type: image/jpeg\r\n\r\n".data(using: .utf8) ?? data as Data)
                data.append(imageData)
                data.append("\r\n".data(using: .utf8) ?? data as Data)
            }
        }
        
        data.append("--\(boundary)--\r\n".data(using: .utf8) ?? data as Data)
        
        request.httpBody = data
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("fail")
                completion(false,error)
                return
            }
            
            if let data = data {
                print(response,"11111")
                completion(true,nil)
            }
        }
        task.resume()
    }
    
}

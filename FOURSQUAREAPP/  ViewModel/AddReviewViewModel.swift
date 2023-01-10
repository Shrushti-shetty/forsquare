//
//  AddReviewViewModel.swift
//  FOURSQUAREAPP
//
//  Created by Shrushti Shetty on 09/01/23.
//

import Foundation
import UIKit
var token = "Bearer eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJzaGV0dHlzaHJ1c2h0aTE0M0BnbWFpbC5jb20iLCJleHAiOjE2NzMzNTc1ODEsImlhdCI6MTY3MzMyMTU4MX0.LRt_NSQDtYtozScdoFvpEydYiGemjIMYm76cPzfaQWYjhGIXy1M3j_gWgE9Kb5u-50ri-GqjjAygTgXxpfKOgA"
class AddReviewViewModel {
    var imageList: [UIImage] = [#imageLiteral(resourceName: "login_bg"),#imageLiteral(resourceName: "CK")]
    var placeId: String = "1"
    var reviewText: String = "Hello"
    
    func addReview(completion: @escaping(Bool , Error?) -> Void) {
        NetworkManager().postReview(images: imageList, placeId: placeId, review: reviewText) { success,error  in
            
            if success {
                print("succcess")
                completion(true,nil)
            }
            else {
                completion(false,nil)
            }
        }
    }}

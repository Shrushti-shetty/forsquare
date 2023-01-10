//
//  ReviewViewController.swift
//  FOURSQUAREAPP
//
//  Created by Shrushti Shetty on 04/01/23.
//

import UIKit

class ReviewViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    var suggestion = ["Top Pick", "Lunch","Coffee","Dinner","NearYou"]
    var placeimg: [UIImage] = [#imageLiteral(resourceName: "favourite_icon_selected"), #imageLiteral(resourceName: "rating_icon_unselected"),#imageLiteral(resourceName: "rating_icon_unselected"),#imageLiteral(resourceName: "rating_icon_unselected"),#imageLiteral(resourceName: "rating_icon_unselected")]
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addReviewButton: UIButton!
    @IBOutlet weak var placeName: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
    }
    
    @IBAction func onClickReview(_ sender: Any) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "AddReviewViewController") as? AddReviewViewController{
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    
    @IBAction func onClickBackButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? ReviewTableViewCell
        cell?.userReview.text = suggestion[indexPath.row]
        cell?.userProfile.image = placeimg[indexPath.row]
        return cell!
    }
    
}

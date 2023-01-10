//
//  ContentTableViewCell.swift
//  FOURSQUAREAPP
//
//  Created by Shrushti Shetty on 30/12/22.
//

import UIKit

class ContentTableViewCell: UITableViewCell {
    @IBOutlet weak var placeName: UILabel!
    @IBOutlet weak var placeRatings: UILabel!
    @IBOutlet weak var placeImage: UIImageView!
    @IBOutlet weak var placeType: UILabel!
    @IBOutlet weak var placeAdress: UILabel!
    @IBOutlet weak var placeDistance: UILabel!
    @IBOutlet weak var expense: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    func configure(place: Place) {
        placeName.text = place.placeName
        placeRatings.text = String(place.ratings)
       // placeImage.image
        placeType.text = place.placeType
        placeAdress.text = place.address
        placeDistance.text = String(place.distance)
        //expense.text = place.
    }
}

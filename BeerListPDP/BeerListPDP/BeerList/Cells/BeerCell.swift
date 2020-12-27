//
//  BeerCell.swift
//  BeerListPDP
//
//  Created by Ramiro Neto on 27/12/20.
//

import UIKit
import CommonPackage

class BeerCell: UITableViewCell {
    @IBOutlet weak var beerImg: UIImageView!
    @IBOutlet weak var beerName: UILabel!
    @IBOutlet weak var beerABV: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    internal func config(beer: Beer) {
        beerName.text = beer.name
        if let beerImgStr = beer.imageURL {
            beerImg.loadImageFromURLString(urlStr: beerImgStr)
        } else {
            beerImg.image = #imageLiteral(resourceName: "beer-mug")
        }
        if let abv = beer.abv {
            beerABV.text = "\(abv) %"
        } else {
            beerABV.text = "Sem álcool"
        }

    }

}

extension BeerCell {
    static func getCellName() -> String {
        return String(describing: BeerCell.self)
    }
}

//
//  BeerDetailController.swift
//  BeerListPDP
//
//  Created by Ramiro Neto on 27/12/20.
//

import UIKit
import CommonPackage

class BeerDetailController: UIViewController, Storyboarded {
    @IBOutlet weak var beerImgView: UIImageView!
    @IBOutlet weak var tagLineLabel: UILabel!
    @IBOutlet weak var teorAlcoolicoLabel: UILabel!
    @IBOutlet weak var escalaAmargorLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!

    private var viewModel: BeerDetailViewModelProtocol? {
        guard let viewModel = BeerListModule.shared.container.container.resolve(BeerDetailViewModelProtocol.self) else {
            return nil
        }
        return viewModel
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
    }

    private func configView() {
        let beer = viewModel?.beer
        setScaledTitle(title: beer?.name ?? "")
        if let imageUrl = beer?.imageURL {
            beerImgView.loadImageFromURLString(urlStr: imageUrl)
        }
        if let tagLine = beer?.tagline {
            tagLineLabel.text = tagLine
        }
        teorAlcoolicoLabel.text = beer?.teorAlcoolico
        if let ibu = beer?.ibu {
            escalaAmargorLabel.text = "\(ibu)"
        }
        if let description = beer?.description {
            descriptionTextView.text = description
        }
    }

    private func setScaledTitle(title: String) {
        let navbarTitle = UILabel()
        navbarTitle.text = title
        navbarTitle.minimumScaleFactor = 0.35
        navbarTitle.adjustsFontSizeToFitWidth = true
        navigationItem.titleView = navbarTitle
    }

}

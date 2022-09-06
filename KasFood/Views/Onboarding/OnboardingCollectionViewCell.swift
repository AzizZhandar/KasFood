//
//  OnboardingCollectionViewCell.swift
//  KasFood
//
//  Created by Aziz Zhandar on 27.06.2022.
//

import UIKit

class OnboardingCollectionViewCell: UICollectionViewCell {
    
    static let idetifier = String(describing: OnboardingCollectionViewCell.self)
    
    @IBOutlet weak var slideImageView: UIImageView!
    @IBOutlet weak var slideTitleLbl: UILabel!
    @IBOutlet weak var slideDescriptionLbl: UILabel!
    
    func setup(_ slide: OnboardingSlide) {
        slideImageView.image = slide.image
        slideTitleLbl.text = slide.title
        slideDescriptionLbl.text = slide.description
    }
}

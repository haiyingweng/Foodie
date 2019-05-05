//
//  FilterCell.swift
//  Foodie
//
//  Created by HAIYING WENG on 4/22/19.
//  Copyright © 2019 Hack Challenge. All rights reserved.
//

import UIKit
import SnapKit

class FilterCell: UICollectionViewCell {
    
    var filterView: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        filterView = UILabel()
        filterView.layer.borderWidth = 1
        filterView.layer.borderColor = UIColor(red: 0.36, green: 0.36, blue: 0.36, alpha: 1).cgColor
        filterView.layer.cornerRadius = 10
        filterView.textColor = UIColor(red: 0.36, green: 0.36, blue: 0.36, alpha: 1) 
        filterView.font = UIFont(name: "AvenirNext-Medium", size: 13)
        filterView.textAlignment = .center
        contentView.addSubview(filterView)
        
        isSelected = false
        
        setUpConstraint()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpConstraint() {
        filterView.snp.makeConstraints { make in
            make.top.bottom.left.right.equalTo(contentView)
        }
    }
    
    func configure(for filter: String) {
        filterView.text = filter
    }
    
    override var isSelected: Bool {
        didSet {
            super.isSelected = isSelected
            if isSelected {
                filterView.layer.borderColor = UIColor(red:1, green:0.45, blue:0.42, alpha:1.0).cgColor
                filterView.textColor = UIColor(red:1, green:0.45, blue:0.42, alpha:1.0)
            } else {
                filterView.layer.borderColor = UIColor(red: 0.36, green: 0.36, blue: 0.36, alpha: 1).cgColor
                filterView.textColor = UIColor(red: 0.36, green: 0.36, blue: 0.36, alpha: 1)
            }
            setNeedsDisplay()
        }
    }
    
    func selected() {
        filterView.textColor = UIColor(red:1, green:0.45, blue:0.42, alpha:1.0)
        filterView.layer.borderColor = UIColor(red:1, green:0.45, blue:0.42, alpha:1.0).cgColor
    }
    
    func deselected() {
        filterView.layer.borderColor = UIColor(red: 0.36, green: 0.36, blue: 0.36, alpha: 1).cgColor
        filterView.textColor = UIColor(red: 0.36, green: 0.36, blue: 0.36, alpha: 1)
    }
}

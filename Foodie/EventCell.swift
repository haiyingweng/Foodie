//
//  EventCell.swift
//  Foodie
//
//  Created by HAIYING WENG on 4/20/19.
//  Copyright © 2019 Hack Challenge. All rights reserved.
//

import UIKit
import SnapKit

class EventCell: UICollectionViewCell {
    var title: UILabel!
    var location: UILabel!
    var locationDetail: UILabel!
    var date: UILabel!
    var time: UILabel!
    var picture: UIImageView!
    var starIcon: UIButton!
    
    var locationIcon: UIImageView!
    var timeIcon: UIImageView!
    
    weak var delegate: FavoriteDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.clipsToBounds = false
        contentView.layer.masksToBounds = false
        contentView.layer.cornerRadius = 20
        contentView.layer.backgroundColor = UIColor.white.cgColor
        contentView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        contentView.layer.shadowOpacity = 0.8
        contentView.layer.shadowRadius = 5
        contentView.layer.shadowOffset = CGSize(width: -5, height: 5)
        contentView.layer.shadowPath = UIBezierPath(roundedRect:(contentView.bounds), cornerRadius:20).cgPath
        
        title = UILabel()
        title.textColor = .black
        title.font = UIFont(name: "AvenirNext-Medium", size: 19)
        contentView.addSubview(title)
        
        location = UILabel()
        location.textColor = .gray
        location.font = UIFont(name: "AvenirNext-Medium", size: 18)
        contentView.addSubview(location)
        
        locationDetail = UILabel()
        locationDetail.textColor = .gray
        locationDetail.font = UIFont(name: "AvenirNext-Medium", size: 15)
        contentView.addSubview(locationDetail)
        
        date = UILabel()
        date.textColor = .gray
        date.font = UIFont(name: "AvenirNext-Medium", size: 16)
        contentView.addSubview(date)
        
        time = UILabel()
        time.textColor = .gray
        time.font = UIFont(name: "AvenirNext-Medium", size: 16)
        contentView.addSubview(time)
        
        picture = UIImageView()
        picture.clipsToBounds = true
        picture.contentMode = .scaleAspectFill
        picture.layer.masksToBounds = true
        contentView.addSubview(picture)
        
        starIcon = UIButton()
        starIcon.setImage(UIImage(named: "star2"), for: .normal)
        starIcon.addTarget(self, action: #selector(changeStar), for: .touchUpInside)
        contentView.addSubview(starIcon)
        
        locationIcon = UIImageView(image: UIImage(named:"locationIcon"))
        locationIcon.tintColor = .gray
        locationIcon.contentMode = .scaleAspectFit
        contentView.addSubview(locationIcon)
        
        timeIcon = UIImageView(image: UIImage(named:"timeIcon"))
        timeIcon.tintColor = .gray
        timeIcon.contentMode = .scaleAspectFit
        contentView.addSubview(timeIcon)
        
        setUpConstraints()
        
    }
    
    func setUpConstraints() {
        
        starIcon.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).offset(20)
            make.left.equalTo(title.snp.right).offset(2)
            make.height.equalTo(20)
            make.width.equalTo(20)
        }
        
        title.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).offset(20)
            make.left.equalTo(contentView.snp.left).offset(20)
            make.right.equalTo(contentView.snp.right).offset(-30)
        }
        
        locationIcon.snp.makeConstraints { make in
            make.top.equalTo(title.snp.bottom).offset(8)
            make.left.equalTo(contentView.snp.left).offset(20)
            make.height.equalTo(20)
            make.width.equalTo(20)
        }
        
        location.snp.makeConstraints { make in
            make.top.equalTo(title.snp.bottom).offset(5)
            make.left.equalTo(locationIcon.snp.right).offset(10)
            make.right.equalTo(contentView.snp.right).offset(-30)
        }
        
        locationDetail.snp.makeConstraints { make in
            make.top.equalTo(location.snp.bottom)
            make.left.equalTo(locationIcon.snp.right).offset(10)
            make.right.equalTo(contentView.snp.right).offset(-30)
        }
        
        timeIcon.snp.makeConstraints { make in
            make.top.equalTo(locationDetail.snp.bottom).offset(5)
            make.left.equalTo(contentView.snp.left).offset(20)
            make.height.equalTo(20)
            make.width.equalTo(20)
        }
        
        date.snp.makeConstraints { make in
            make.top.equalTo(locationDetail.snp.bottom).offset(5)
            make.left.equalTo(timeIcon.snp.right).offset(10)
        }
        
        time.snp.makeConstraints { make in
            make.top.equalTo(locationDetail.snp.bottom).offset(5)
            make.left.equalTo(date.snp.right).offset(5)
        }
        
        picture.snp.makeConstraints { make in
            make.top.equalTo(time.snp.bottom).offset(10)
            make.left.equalTo(contentView).offset(20)
            make.width.equalTo(contentView.frame.width-40)
            make.bottom.equalTo(contentView.snp.bottom).offset(-20)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(for event: Event) {
        title.text = event.eventTitle
        location.text = event.eventLocation
        locationDetail.text = event.eventLocationDetail
        date.text = event.date
        time.text  = "@ \(event.startTime) to \(event.endTime)"
        picture.image = event.photo
        var tagsText: String = ""
        for tag in event.tags {
            tagsText += "#\(tag) "
        }
        
        if event.isFavorite {
            starIcon.setImage(UIImage(named: "star"), for: .normal)
        } else {
            starIcon.setImage(UIImage(named: "star2"), for: .normal)
        }
    }
    
    @objc func changeStar(){
        delegate?.favoritePressed(for: self)
    }
    
}

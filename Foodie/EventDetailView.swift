//
//  EventDetailView.swift
//  Foodie
//
//  Created by HAIYING WENG on 4/25/19.
//  Copyright © 2019 Hack Challenge. All rights reserved.
//

import UIKit
import SnapKit

class EventDetailView: UIViewController {

    var eventTitle: UITextView!
    var eventDetail: UITextView!
    var location: UILabel!
    var locationDetail: UILabel!
    var date: UILabel!
    var time: UILabel!
    var picture: UIImageView!
    var tags: UITextView!
    
    var titleText: String
    var detailText: String
    var locationText: String
    var locationDetailText: String
    var dateText: String
    var timeText: String
    var photo: UIImage
    var tagsText: String
    
    var locationIcon: UIImageView!
    var timeIcon: UIImageView!
    
    init (titleText: String, detailText: String, locationText: String, locationDetailText: String, dateText: String, timeText: String, photo: UIImage, tagsText: String) {
        self.titleText = titleText
        self.detailText = detailText
        self.locationText = locationText
        self.locationDetailText = locationDetailText
        self.dateText = dateText
        self.timeText = timeText
        self.photo = photo
        self.tagsText = tagsText
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        title = "Event"
        
        navigationController?.navigationBar.backIndicatorImage = UIImage(named:"backArrow")
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(named:"backArrow")
        navigationController?.navigationBar.tintColor = .white
        
        eventTitle = UITextView()
        eventTitle.textColor = .black
        eventTitle.text = titleText
        eventTitle.isEditable = false
        eventTitle.isScrollEnabled = false
        eventTitle.sizeToFit()
        eventTitle.font = UIFont(name: "AvenirNext-Medium", size: 20)
        view.addSubview(eventTitle)
        
        eventDetail = UITextView()
        eventDetail.textColor = .gray
        eventDetail.text = detailText
        eventDetail.isEditable = false
        eventDetail.isScrollEnabled = false
        eventDetail.sizeToFit()
        eventDetail.font = UIFont(name: "AvenirNext-Regular", size: 16)
        view.addSubview(eventDetail)
        
        location = UILabel()
        location.textColor = .gray
        location.text = locationText
        location.font = UIFont(name: "AvenirNext-Medium", size: 18)
        view.addSubview(location)
        
        locationDetail = UILabel()
        locationDetail.textColor = .gray
        locationDetail.text = locationDetailText
        locationDetail.font = UIFont(name: "AvenirNext-Medium", size: 15)
        view.addSubview(locationDetail)
        
        date = UILabel()
        date.textColor = .gray
        date.text = dateText
        date.font = UIFont(name: "AvenirNext-Medium", size: 17)
        view.addSubview(date)
        
        time = UILabel()
        time.textColor = .gray
        time.text = timeText
        time.font = UIFont(name: "AvenirNext-Medium", size: 17)
        view.addSubview(time)
        
        picture = UIImageView()
        picture.image = photo
        picture.clipsToBounds = true
        picture.contentMode = .scaleAspectFit
        view.addSubview(picture)
        
        tags = UITextView()
        tags.textColor = .gray
        tags.text = tagsText
        tags.font = UIFont(name: "AvenirNext-Medium", size: 16)
        tags.isEditable = false
        tags.isScrollEnabled = false
        tags.sizeToFit()
        view.addSubview(tags)
        
        locationIcon = UIImageView(image: UIImage(named:"locationIcon"))
        locationIcon.tintColor = .gray
        locationIcon.contentMode = .scaleAspectFit
        view.addSubview(locationIcon)
        
        timeIcon = UIImageView(image: UIImage(named:"timeIcon"))
        timeIcon.tintColor = .gray
        timeIcon.contentMode = .scaleAspectFit
        view.addSubview(timeIcon)
        
        
        setUpConstraints()
    }
    
    func setUpConstraints() {

        eventTitle.snp.makeConstraints { make in
            make.top.equalTo(view).offset(30)
            make.left.equalTo(view).offset(25)
            make.right.equalTo(view).offset(-30)
        }
        
        locationIcon.snp.makeConstraints { make in
            make.top.equalTo(eventTitle.snp.bottom).offset(8)
            make.left.equalTo(view).offset(30)
            make.height.equalTo(20)
            make.width.equalTo(20)
        }
        
        location.snp.makeConstraints { make in
            make.top.equalTo(eventTitle.snp.bottom).offset(5)
            make.left.equalTo(locationIcon.snp.right).offset(10)
            make.right.equalTo(view).offset(-30)
        }
        
        locationDetail.snp.makeConstraints { make in
            make.top.equalTo(location.snp.bottom)
            make.left.equalTo(locationIcon.snp.right).offset(10)
            make.right.equalTo(view).offset(-30)
        }
        
        timeIcon.snp.makeConstraints { make in
            make.top.equalTo(locationDetail.snp.bottom).offset(5)
            make.left.equalTo(view).offset(30)
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
        
        eventDetail.snp.makeConstraints { make in
            make.top.equalTo(date.snp.bottom).offset(10)
            make.left.equalTo(view).offset(30)
            make.right.equalTo(view).offset(-30)
        }
        
        tags.snp.makeConstraints { make in
            make.top.equalTo(picture.snp.bottom).offset(10)
            make.left.equalTo(view).offset(30)
            make.right.equalTo(view).offset(-30)
            make.height.equalTo(60)
        }
        
        picture.snp.makeConstraints { make in
            make.top.equalTo(eventDetail.snp.bottom).offset(10)
            make.left.equalTo(view).offset(35)
            make.right.equalTo(view).offset(-35)
            make.height.equalTo(view.frame.width-70)
        }
    }


}

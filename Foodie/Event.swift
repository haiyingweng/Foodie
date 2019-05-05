//
//  Event.swift
//  Foodie
//
//  Created by HAIYING WENG on 4/20/19.
//  Copyright © 2019 Hack Challenge. All rights reserved.
//

import Foundation
import UIKit

class Event{
    
    var eventTitle: String
    var eventLocation: String
    var eventLocationDetail: String
    var date: String
    var startTime: String
    var endTime: String
    var tags: [String]
    var eventDetails: String
    var photo: UIImage!
    var isFavorite: Bool
    
    init(eventTitle: String, eventLocation: String, eventLocationDetail: String, date: String, startTime: String, endTime: String, tags: [String], eventDetails: String, photo:UIImage) {
        self.eventTitle = eventTitle
        self.eventLocation = eventLocation
        self.eventLocationDetail = eventLocationDetail
        self.date = date
        self.startTime = startTime
        self.endTime = endTime
        self.tags = tags
        self.eventDetails = eventDetails
        self.photo = photo
        self.isFavorite = false
    }

}

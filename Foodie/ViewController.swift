//
//  ViewController.swift
//  Foodie
//
//  Created by HAIYING WENG on 4/18/19.
//  Copyright © 2019 Hack Challenge. All rights reserved.
//

import UIKit
import SnapKit

protocol AddEventDelegate: class {
    func addNewEvent(to title: String, to location: String, to locationDetail: String, to date: String, to fromTime: String, to toTime: String, to eventDetail: String, to tags: [String], to photo: UIImage?)
}

protocol FavoriteDelegate: class {
    func favoritePressed(for cell: EventCell)
}

class ViewController: UIViewController {
    
    var eventCollectionView: UICollectionView!
    var refreshControl: UIRefreshControl!
    
    var topView: UIView!
    var createButton: UIButton!
    var filterButton: UIButton!
    var upcomingButton: UIButton!
    var starredButton: UIButton!
    var whiteBarOne: UIView!
    var whiteBarTwo: UIView!
   
    var searchBar: UISearchBar!
    var noSearchResultLabel: UILabel!
    var isSearching = false
    
    var filterView: UIView!
    var filterLabel: UILabel!
    var filterCollectionView: UICollectionView!
    
    var selectedLocationFilter: [String]! = []
    var selectedFoodFilter: [String]! = []
    var locationFilter:[String]!
    var foodFilter:[String]!
    
    var events = [Event]()
    var filteredEvents: [Event]! = []
    var starredEvents: [Event]! = []
    var searchedEvents: [Event]! = []

    let eventReuseIdentifier = "eventReuseIdentifier"
    let filterReuseIdentifier = "filterReuseIdentifier"
    let padding: CGFloat = 13
    let filterPadding: CGFloat = 5
    
    var state = "upcoming"
    var wasFiltering = false
    
    let defaults = UserDefaults.standard
    struct Key {
        static let starredEvents = "starredEvents"
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationFilter = ["North", "West", "Central", "South", "East"]
        foodFilter = ["meals", "snacks", "desserts", "drinks"]
        
        title = "Foodie"
        navigationController?.navigationBar.barTintColor = UIColor(red:1, green:0.45, blue:0.42, alpha:1.0)
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white, .font: UIFont(name: "AvenirNext-DemiBold", size: 23)!]
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: " ", style: .plain, target: nil, action: nil)
        view.backgroundColor = .white
        
        let eventLayout = UICollectionViewFlowLayout()
        eventLayout.scrollDirection = .vertical
        eventLayout.minimumInteritemSpacing = padding
        eventLayout.minimumLineSpacing = padding
        eventCollectionView = UICollectionView(frame: .zero, collectionViewLayout: eventLayout)
        eventCollectionView.backgroundColor = .white
        eventCollectionView.showsVerticalScrollIndicator = false
        eventCollectionView.dataSource = self
        eventCollectionView.delegate = self
        eventCollectionView.refreshControl = refreshControl
        eventCollectionView.register(EventCell.self, forCellWithReuseIdentifier: eventReuseIdentifier)
        view.addSubview(eventCollectionView)
        
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(pulledToRefresh), for: .valueChanged)
        eventCollectionView.addSubview(refreshControl)
        
        topView = UIView()
        topView.backgroundColor = UIColor(red:1, green:0.45, blue:0.42, alpha:1.0)
        topView.layer.masksToBounds = false
        topView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        topView.layer.shadowOpacity = 0.5
        topView.layer.shadowOffset = CGSize(width: 0, height: 6)
        topView.layer.shadowRadius = 3
        view.addSubview(topView)
        
        createButton = UIButton()
        createButton.setTitle("CREATE AN EVENT", for: .normal)
        createButton.setTitleColor(UIColor(red:1, green:0.45, blue:0.42, alpha:1.0), for: .normal)
        createButton.titleLabel?.font =  UIFont(name: "AvenirNext-Medium", size: 16)
        createButton.backgroundColor = .white
        createButton.addTarget(self, action: #selector(creatAnEvent), for: .touchUpInside)
        createButton.layer.masksToBounds = false
        createButton.layer.cornerRadius = 20
        createButton.layer.borderWidth = 2
        createButton.layer.borderColor = UIColor(red:1, green:0.45, blue:0.42, alpha:1.0).cgColor
        createButton.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        createButton.layer.shadowOpacity = 0.5
        createButton.layer.shadowRadius = 3
        createButton.layer.shadowOffset = CGSize(width: -6, height: 6)
        view.addSubview(createButton)
        
        filterButton = UIButton()
        filterButton.setImage(UIImage(named: "whitefilter"), for: .normal)
        filterButton.addTarget(self, action: #selector(filterPressed), for: .touchUpInside)
        view.addSubview(filterButton)
        
        upcomingButton = UIButton()
        upcomingButton.setTitle("Upcoming", for: .normal)
        upcomingButton.setTitleColor(.white, for: .normal)
        upcomingButton.titleLabel?.font =  UIFont(name: "AvenirNext-DemiBold", size: 20)
        upcomingButton.titleLabel?.textAlignment = .center
        upcomingButton.addTarget(self, action: #selector(upcoming), for: .touchUpInside)
        view.addSubview(upcomingButton)
        
        starredButton = UIButton()
        starredButton.setTitle("Starred", for: .normal)
        starredButton.setTitleColor(UIColor(red: 0.90, green: 0.90, blue: 0.90, alpha: 1), for: .normal)
        starredButton.titleLabel?.textAlignment = .center
        starredButton.titleLabel?.font =  UIFont(name: "AvenirNext-DemiBold", size: 20)
        starredButton.addTarget(self, action: #selector(starred), for: .touchUpInside)
        view.addSubview(starredButton)
        
        whiteBarOne = UIView()
        whiteBarOne.backgroundColor = .white
        whiteBarOne.isHidden = false
        view.addSubview(whiteBarOne)
        
        whiteBarTwo = UIView()
        whiteBarTwo.backgroundColor = .white
        whiteBarTwo.isHidden = true
        view.addSubview(whiteBarTwo)
        
        searchBar = UISearchBar()
        searchBar.searchBarStyle = .prominent
        searchBar.placeholder = " Search..."
        searchBar.sizeToFit()
        searchBar.backgroundImage = UIImage()
        searchBar.delegate = self
        searchBar.returnKeyType = .done
        searchBar.isTranslucent = false
        searchBar.layer.cornerRadius = 10
        searchBar.layer.masksToBounds = true
        view.addSubview(searchBar)
        
        noSearchResultLabel = UILabel()
        noSearchResultLabel.textColor = .gray
        noSearchResultLabel.font = UIFont(name: "AvenirNext-Medium", size: 19)
        noSearchResultLabel.isHidden = true
        view.addSubview(noSearchResultLabel)
        
        filterView = UIView()
        filterView.isHidden = true
        filterView.translatesAutoresizingMaskIntoConstraints = false
        filterView.backgroundColor = UIColor(red: 0.93, green: 0.93, blue: 0.93, alpha: 1)
        view.addSubview(filterView)
        
        let filterLayout = UICollectionViewFlowLayout()
        filterLayout.scrollDirection = .vertical
        filterLayout.minimumInteritemSpacing = filterPadding
        filterLayout.minimumLineSpacing = filterPadding
        filterLayout.sectionInset = UIEdgeInsets(top: 8.0, left: 0.0, bottom: 0.0, right: 0.0)
        filterCollectionView = UICollectionView(frame: .zero, collectionViewLayout: filterLayout)
        filterCollectionView.translatesAutoresizingMaskIntoConstraints = false
        filterCollectionView.backgroundColor = .clear
        filterCollectionView.allowsMultipleSelection = true
        filterCollectionView.dataSource = self
        filterCollectionView.delegate = self
        filterCollectionView.register(FilterCell.self, forCellWithReuseIdentifier: filterReuseIdentifier)
        filterView.addSubview(filterCollectionView)
        
        filterLabel = UILabel()
        filterLabel.translatesAutoresizingMaskIntoConstraints = false
        filterLabel.text = "Filter By:"
        filterLabel.textColor = .black
        filterLabel.font = UIFont(name: "AvenirNext-DemiBold", size: 15)
        filterView.addSubview(filterLabel)
        
        setUpConstraints()
        setUpEvents { (success) -> Void in
            if success {
                self.setFaveEvents()
            }
        }
    }
    
    func setUpConstraints() {
    
        topView.snp.makeConstraints { make in
            make.left.right.equalTo(view)
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.height.equalTo(90)
        }
        
        createButton.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.top.equalTo(topView.snp.bottom).offset(15)
            make.size.equalTo(CGSize(width: 200, height: 40))
        }
        
        filterButton.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(11)
            make.height.equalTo(30)
            make.width.equalTo(30)
            make.right.equalTo(view).offset(-13)
        }
        
        upcomingButton.snp.makeConstraints { make in
            make.width.equalTo(view.bounds.width/3)
            make.bottom.equalTo(topView.snp.bottom).offset(-3)
            make.centerX.equalTo(view).offset(-(view.bounds.width/5))
        }
        
        starredButton.snp.makeConstraints { make in
            make.width.equalTo(view.bounds.width/3)
            make.bottom.equalTo(topView.snp.bottom).offset(-3)
            make.centerX.equalTo(view).offset(view.bounds.width/5)
        }
        
        whiteBarOne.snp.makeConstraints { make in
            make.bottom.equalTo(topView.snp.bottom)
            make.height.equalTo(4)
            make.width.equalTo(view.bounds.width/3)
            make.centerX.equalTo(view).offset(-(view.bounds.width/5))
        }
        
        whiteBarTwo.snp.makeConstraints { make in
            make.bottom.equalTo(topView.snp.bottom)
            make.height.equalTo(4)
            make.width.equalTo(view.bounds.width/3)
            make.centerX.equalTo(view).offset(view.bounds.width/5)
        }
        
        searchBar.snp.makeConstraints {make in
            make.left.equalTo(view).offset(20)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            make.right.equalTo(view).offset(-45)
            make.height.equalTo(30)
        }
        
        noSearchResultLabel.snp.makeConstraints { make in
            make.top.equalTo(createButton.snp.bottom).offset(20)
            make.centerX.equalTo(view)
            make.height.equalTo(25)
        }
        
        eventCollectionView.snp.makeConstraints { make in
            make.top.equalTo(createButton.snp.bottom).offset(10)
            make.bottom.equalTo(view.snp.bottom)
            make.left.equalTo(view.snp.left)
            make.right.equalTo(view.snp.right)
        }
    }
    
    func setUpEvents(complete:@escaping (_ success: Bool) -> Void) {
        let endpoint = "https://foodies.leoliang.com/api/foods/"
        let url = URL(string: endpoint)
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        let task = URLSession.shared.dataTask(with: request, completionHandler: {(data, response, error) in
            if let data = data {
                let decoder = JSONDecoder()
                let foods = try! decoder.decode(FoodJSON.self, from: data)
                if (!foods.success) {
                    print(error!)
                } else {
                    self.events = foods.data.map { Event(eventTitle: $0.title, eventLocation: $0.location, eventLocationDetail: $0.location_detail, date: $0.date, startTime: $0.start_time, endTime: $0.end_time, tags: $0.tags, eventDetails: $0.description, photo: {(image : String) -> UIImage in
                        if (image == "") {
                            return UIImage(named: "white")!
                        } else {
                            let d = Data(base64Encoded: image)!
                            return UIImage(data: d)!
                        }
                    }($0.image)) }
                    complete(true)
                    DispatchQueue.main.async {
                        self.eventCollectionView.reloadData()
                    }
                }
            } else {
                print(error!)
            }
        })
        task.resume()
    }
    
    @objc func creatAnEvent() {
        let addEvent = NewEvent()
        addEvent.delegate = self
        navigationController?.pushViewController(addEvent, animated: true)
    }
    
    @objc func filterPressed() {
        if !(filterView.isHidden) {
            filterView.isHidden = true
            filterButton.setImage(UIImage(named: "whitefilter"), for: .normal)
            createButton.snp.remakeConstraints { make in
                make.centerX.equalTo(view)
                make.top.equalTo(topView.snp.bottom).offset(15)
                make.size.equalTo(CGSize(width: 200, height: 40))
            }
        } else {
            filterView.isHidden = false
            state = "filtering"
            filterEvents()
            presentFilterView()
        }
    }
    
    func presentFilterView() {
        filterButton.setImage(UIImage(named: "grayfilter"), for: .normal)
        
        filterView.snp.makeConstraints { make in
            make.top.equalTo(topView.snp.bottom)
            make.left.right.equalTo(view)
            make.height.equalTo(105)
        }
        
        filterLabel.snp.makeConstraints { make in
            make.left.equalTo(view).offset(20)
            make.top.equalTo(topView.snp.bottom).offset(15)
            make.height.equalTo(20)
            make.width.equalTo(100)
        }
        
        filterCollectionView.snp.makeConstraints { make in
            make.top.equalTo(filterLabel.snp.bottom)
            make.height.equalTo(130)
            make.left.equalTo(view).offset(20)
            make.right.equalTo(view).offset(-20)
        }
        
        createButton.snp.remakeConstraints { make in
            make.centerX.equalTo(view)
            make.top.equalTo(filterView.snp.bottom).offset(15)
            make.size.equalTo(CGSize(width: 200, height: 40))
        }
    }
    
    @objc func upcoming() {
        if wasFiltering {
            state = "filtering"
            filterEvents()
        }
        if state != "filtering"{
            state = "upcoming"
        }
        isSearching = false
        searchBar.text = ""
        upcomingButton.setTitleColor(.white, for: .normal)
        starredButton.setTitleColor(UIColor(red: 0.90, green: 0.90, blue: 0.90, alpha: 1), for: .normal)
        getSearchedEvents(events: starredEvents, searchText: searchBar.text!)
        createButton.isHidden = false
        createButton.snp.remakeConstraints { make in
            make.centerX.equalTo(view)
            make.top.equalTo(topView.snp.bottom).offset(15)
            make.size.equalTo(CGSize(width: 200, height: 40))
        }
        eventCollectionView.snp.remakeConstraints { make in
            make.top.equalTo(createButton.snp.bottom).offset(20)
            make.bottom.equalTo(view.snp.bottom)
            make.left.equalTo(view.snp.left)
            make.right.equalTo(view.snp.right)
        }
        whiteBarOne.isHidden = false
        whiteBarTwo.isHidden = true
        filterButton.isHidden = false
        filterView.isHidden = true
        searchBar.snp.remakeConstraints {make in
            make.left.equalTo(view).offset(20)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            make.right.equalTo(view).offset(-45)
            make.height.equalTo(30)
        }
        eventCollectionView.reloadData()
    }
    
    @objc func starred() {
        if state == "filtering" {
            wasFiltering = true
        }
        state = "starred"
        isSearching = false
        searchBar.text = ""
        checkEmptyFavorite()
        getSearchedEvents(events: starredEvents, searchText: searchBar.text!)
        upcomingButton.setTitleColor(UIColor(red: 0.90, green: 0.90, blue: 0.90, alpha: 1), for: .normal)
        starredButton.setTitleColor(.white, for: .normal)
        createButton.isHidden = true
        eventCollectionView.snp.remakeConstraints { make in
            make.top.equalTo(topView.snp.bottom).offset(10)
            make.bottom.equalTo(view.snp.bottom)
            make.left.equalTo(view.snp.left)
            make.right.equalTo(view.snp.right)
        }
        whiteBarOne.isHidden = true
        whiteBarTwo.isHidden = false
        filterButton.isHidden = true
        filterView.isHidden = true
        searchBar.snp.remakeConstraints {make in
            make.left.equalTo(view).offset(20)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            make.right.equalTo(view).offset(-20)
            make.height.equalTo(30)
        }
        eventCollectionView.reloadData()
    }
    
    func checkEmptyFavorite() {
        if starredEvents.isEmpty {
            noSearchResultLabel.isHidden = false
            noSearchResultLabel.text = "You have no favorite event"
        }
    }
    
    @objc func pulledToRefresh() {
        setUpEvents { (success) -> Void in
            DispatchQueue.main.async {
                self.setFaveEvents()
                self.refreshControl.endRefreshing()
            }
        }
    }
    
    func setFaveEvents() {
        if let favoriteEvents = defaults.value(forKey: Key.starredEvents) as? [String] {
            for title in favoriteEvents {
                for event in events {
                    if(title == event.eventTitle) {
                        event.isFavorite = true
                    }
                }
            }
        }
        for event in events{
            if event.isFavorite {
                if !(starredEvents.contains(where: { $0.eventTitle == event.eventTitle })) {
                    starredEvents.append(event)
                }
            }
        }
        DispatchQueue.main.async {
            self.eventCollectionView.reloadData()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == eventCollectionView {
            var event: Event!
            if isSearching {
                event = searchedEvents[indexPath.item]
            } else if state == "upcoming" {
                event = events[indexPath.item]
            } else if state == "starred" {
                event = starredEvents[indexPath.item]
            } else {
                event = filteredEvents[indexPath.item]
            }
            let time = "@ \(event.startTime) to \(event.endTime)"
            var tagsText: String = ""
            for tag in event.tags {
                tagsText += "#\(tag) "
            }
            let detailView = EventDetailView(titleText: event.eventTitle, detailText: event.eventDetails, locationText: event.eventLocation, locationDetailText: event.eventLocationDetail, dateText: event.date, timeText: time , photo: event.photo, tagsText: tagsText)
            navigationController?.pushViewController(detailView, animated: true)
        } else {
            if indexPath.section == 0 {
                let currentFilter = foodFilter[indexPath.item]
                updateFilter(filter: currentFilter, needRemoved: false)
                eventCollectionView.reloadData()
            } else {
                let currentFilter = locationFilter[indexPath.item]
                updateFilter(filter: currentFilter, needRemoved: false)
                eventCollectionView.reloadData()
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if collectionView == filterCollectionView {
            if indexPath.section == 0 {
                let currentFilter = foodFilter[indexPath.item]
                updateFilter(filter: currentFilter, needRemoved: true)
                eventCollectionView.reloadData()
            } else {
                let currentFilter = locationFilter[indexPath.item]
                updateFilter(filter: currentFilter, needRemoved: true)
                eventCollectionView.reloadData()
            }
        }
    }
    
    func updateFilter(filter: String?, needRemoved: Bool = false) {
        if foodFilter.contains(filter!) {
            if let food = filter {
                if needRemoved {
                    selectedFoodFilter.remove(at: (selectedFoodFilter.firstIndex(of: food)!))
                } else {
                    selectedFoodFilter.append(food)
                }
            }
        }
        if locationFilter.contains(filter!) {
            if let location = filter {
                if needRemoved {
                    selectedLocationFilter.remove(at: (selectedLocationFilter.firstIndex(of: location)!))
                } else {
                    selectedLocationFilter.append(location)
                }
            }
        }
        filterEvents()
    }
    
    func filterEvents() {
        if selectedFoodFilter.count == 0 && selectedLocationFilter.count == 0 {
            filteredEvents = events
            return
        }
        filteredEvents = events.filter( { event in
            
            var foodFilteredOut = selectedFoodFilter.count > 0
            if selectedFoodFilter.count > 0 {
                for tag in event.tags {
                    if selectedFoodFilter.contains(tag) {
                        foodFilteredOut = false
                    }
                }
            }
            var locationFilteredOut = selectedLocationFilter.count > 0
            if selectedLocationFilter.count > 0 {
                for tag in event.tags {
                    if selectedLocationFilter.contains(tag) {
                        locationFilteredOut = false
                    }
                }
            }
            return !(foodFilteredOut || locationFilteredOut)
        })
    }
}

extension ViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if collectionView == filterCollectionView {
            return 2
        } else {
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == eventCollectionView {
            if isSearching {
                return searchedEvents.count
            } else if state == "upcoming" {
                return events.count
            } else if state == "starred" {
                return starredEvents.count
            } else {
                return filteredEvents.count
            }
        } else {
            if section == 0 {
                return foodFilter.count
            } else {
                return locationFilter.count
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == eventCollectionView {
            noSearchResultLabel.isHidden = true
            let eventCell = collectionView.dequeueReusableCell(withReuseIdentifier: eventReuseIdentifier, for: indexPath) as! EventCell
            var event:Event!
            if isSearching {
                event = searchedEvents[indexPath.item]
            } else if state == "upcoming" {
                event = events[indexPath.item]
            } else if state == "starred" {
                event = starredEvents[indexPath.item]
            } else {
                event = filteredEvents[indexPath.item]
            }
            eventCell.configure(for: event)
            eventCell.delegate = self
            return eventCell
        } else {
            let filterCell = collectionView.dequeueReusableCell(withReuseIdentifier: filterReuseIdentifier, for: indexPath) as! FilterCell
            if indexPath.section == 0 {
                let food = foodFilter[indexPath.item]
                filterCell.configure(for: food)
            } else {
                let location = locationFilter[indexPath.item]
                filterCell.configure(for: location)
            }
            return filterCell
        }
    } 
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == eventCollectionView {
            let width: CGFloat = collectionView.frame.width - 2 * padding
            let height: CGFloat = 220
            return CGSize(width: width, height: height)
        } else {
            let width: CGFloat = 60
            let height: CGFloat = 20
            return CGSize(width: width, height: height)
        }
    }
}

extension ViewController: FavoriteDelegate {
    func favoritePressed(for cell: EventCell) {
        let favoriteCellIndex = eventCollectionView.indexPath(for: cell)
        var event: Event!
        if isSearching {
            event = searchedEvents[favoriteCellIndex!.item]
        } else if state == "upcoming" {
            event = events[favoriteCellIndex!.item]
        } else if state == "starred" {
            event = starredEvents[favoriteCellIndex!.item]
        } else {
            event = filteredEvents[favoriteCellIndex!.item]
        }
        
        event.isFavorite = !event.isFavorite
    
        // setup User Default
        if defaults.value(forKey: Key.starredEvents) == nil {
            defaults.set([], forKey: Key.starredEvents)
            defaults.synchronize()
        }
        if event.isFavorite {
            if var favoriteEvents = defaults.value(forKey: Key.starredEvents) as? [String] {
                favoriteEvents.append(event.eventTitle)
                defaults.set(favoriteEvents, forKey: Key.starredEvents)
                defaults.synchronize()
            }
        } else {
            if var favoriteEvents = defaults.value(forKey: Key.starredEvents) as? [String] {
                favoriteEvents = favoriteEvents.filter {$0 != event.eventTitle}
                defaults.set(favoriteEvents, forKey: Key.starredEvents)
                defaults.synchronize()
            }
        }
        print (UserDefaults.standard.value(forKey: Key.starredEvents)!)

        // add/remove events to starredEvents if starred/unstarred
        if event.isFavorite {
            if !(starredEvents.contains(where: { $0.eventTitle == event.eventTitle })) {
                starredEvents.append(event)
            }
        } else {
            starredEvents = starredEvents.filter {$0.eventTitle != event.eventTitle}
        }
        eventCollectionView.reloadData()
    }
}

extension ViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == nil || searchBar.text == "" {
            isSearching = false
            view.endEditing(true)
            eventCollectionView.reloadData()
        } else {
            isSearching = true
            if state == "upcoming" {
                getSearchedEvents(events: events, searchText: searchText)
            } else if state == "starred"{
                getSearchedEvents(events: starredEvents, searchText: searchText)
            } else {
                getSearchedEvents(events: filteredEvents, searchText: searchText)
            }
            eventCollectionView.reloadData()
            if searchedEvents.isEmpty {
                noSearchResultLabel.isHidden = false
                noSearchResultLabel.text = "No Result for '\(searchText)'"
            }
        }
    }
    
    func getSearchedEvents(events: [Event], searchText: String) {
        searchedEvents = []
        var searchingEvents:[Event]! = []
        if state == "upcoming" {
            searchingEvents = events
        } else if state == "starred"{
            searchingEvents = starredEvents
        } else {
            searchingEvents = filteredEvents
        }
        for event in searchingEvents {
            let title = event.eventTitle.lowercased()
            let detail = event.eventDetails.lowercased()
            let location = event.eventLocation.lowercased()
            let locDetail = event.eventLocationDetail.lowercased()
            let text = searchText.lowercased()
            if title.contains(text) || detail.contains(text) || location.contains(text) || locDetail.contains(text) {
                searchedEvents.append(event)
            }
        }
    }
}

extension ViewController: AddEventDelegate {
    
    func successMessage() {
        let alert = UIAlertController(title: "Success!", message: "Post is Added.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel))
        self.present(alert, animated: true, completion: nil)
    }
    
    func failureMessage() {
        let alert = UIAlertController(title: "Error:", message: "Post Cannot be Added. Please Try Again!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel))
        self.present(alert, animated: true, completion: nil)
    }
    
    func addNewEvent(to title: String, to location: String, to locationDetail: String, to date: String, to fromTime: String, to toTime: String, to eventDetail: String, to tags: [String], to photo: UIImage?) {
        let endpoint = "https://foodies.leoliang.com/api/foods/"
        let url = URL(string: endpoint)
        var request = URLRequest(url: url!)
        let image = photo?.jpegData(compressionQuality: 0.8)?.base64EncodedString() ?? ""
        let creation = FoodCreate(start_time: fromTime, description: eventDetail, title: title, location_detail: locationDetail, end_time: toTime, location: location, date: date, tags: tags, image: image)
        let jsonData = try! JSONEncoder().encode(creation)
        let jsonString = String(data: jsonData, encoding:. utf8)!
        let data = jsonString.data(using: .utf8)!
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = data
        request.httpMethod = "POST"
        let task = URLSession.shared.dataTask(with: request, completionHandler: {(data, response, error) in
            if let data = data {
                let decoder = JSONDecoder()
                let foods = try! decoder.decode(Result.self, from: data)
                self.pulledToRefresh()
                if (!foods.success) {
                    DispatchQueue.main.async {
                        self.failureMessage()}
                } else {
                    DispatchQueue.main.async {
                        self.successMessage()}
                }
            } else {
                DispatchQueue.main.async {
                    self.failureMessage()}
            }
        })
        task.resume()
    }
}

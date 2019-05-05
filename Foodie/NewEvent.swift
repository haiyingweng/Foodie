//
//  NewEvent.swift
//  Foodie
//
//  Created by HAIYING WENG on 4/19/19.
//  Copyright © 2019 Hack Challenge. All rights reserved.
//

import UIKit
import SnapKit 

class NewEvent: UIViewController {
    
    var scrollView:UIScrollView!
    
    var rules:UILabel!
    var whatLabel: UILabel!
    var whatTextField: UITextField!
    var whereLabel: UILabel!
    var locationTextField: UITextField!
    var locDetailTextField: UITextField!
    var whenLabel: UILabel!
    var dateTextField: UITextField!
    var timeLabel: UILabel!
    var fromTimeTextField: UITextField!
    var toTimeTextField: UITextField!
    var moreDetailLabel: UILabel!
    var moreDetailTextView: UITextView!
    var addTagsLabel: UILabel!
    var photoLabel: UILabel!
    var photo: UIImageView!
    var postButton: UIButton!
    var uploadPhotoButton: UIButton!
    var photoView: UIImageView!
    var photoPicker: UIImagePickerController!
    
    var filterCollectionView: UICollectionView!
    let filterReuseIdentifier = "filterReuseIdentifier"
    let filterPadding: CGFloat = 5
    var selectedFilter:[String]! = []
    var selectedLocationFilter: [String]! = []
    var selectedFoodFilter: [String]! = []
    var locationFilter:[String]!
    var foodFilter:[String]!
    
    var datePicker: UIDatePicker!
    var fromTimePicker: UIDatePicker!
    var toTimePicker: UIDatePicker!
    
    let textFieldHeight = 40
    
    weak var delegate: AddEventDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "New Event"
        view.backgroundColor = .white
        
        locationFilter = ["North", "West", "Central", "South", "East"]
        foodFilter = ["meals", "snacks", "desserts", "drinks"]
        
        navigationController?.navigationBar.backIndicatorImage = UIImage(named:"backArrow")
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(named:"backArrow")
        navigationController?.navigationBar.tintColor = .white
        
        scrollView = UIScrollView()
        scrollView.backgroundColor = .white
        scrollView.contentSize.height = view.bounds.height + 350
        view.addSubview(scrollView)
        
        rules = UILabel()
        rules.text = "Rules: \n 1. entrance must be free \n 2. it must have food/drink"
        rules.textAlignment = .center
        rules.textColor = UIColor(red:1, green:0.45, blue:0.42, alpha:0.9)
        rules.font = UIFont(name: "AvenirNext-DemiBold", size: 15)
        rules.lineBreakMode = .byWordWrapping
        rules.numberOfLines = 0
        scrollView.addSubview(rules) 
        
        whatLabel = UILabel()
        whatLabel.text = "what? (max 50 characters)"
        whatLabel.textColor = .black
        whatLabel.font = UIFont(name: "AvenirNext-Regular", size: 18)
        scrollView.addSubview(whatLabel)
        
        whatTextField = UITextField()
        whatTextField.placeholder = " a short, one line description"
        whatTextField.backgroundColor = UIColor(red: 0.93, green: 0.93, blue: 0.93, alpha: 1)
        whatTextField.font = UIFont(name: "AvenirNext-Regular", size: 17)
        whatTextField.borderStyle = .none
        whatTextField.textColor = .darkGray
        whatTextField.layer.cornerRadius = 10
        whatTextField.clearButtonMode = .always
        scrollView.addSubview(whatTextField)
        
        whereLabel = UILabel()
        whereLabel.text = "where?"
        whereLabel.textColor = .black
        whereLabel.font = UIFont(name: "AvenirNext-Regular", size: 18)
        scrollView.addSubview(whereLabel)
        
        locationTextField = UITextField()
        locationTextField.placeholder = " location"
        locationTextField.backgroundColor = UIColor(red: 0.93, green: 0.93, blue: 0.93, alpha: 1)
        locationTextField.font = UIFont(name: "AvenirNext-Regular", size: 17)
        locationTextField.borderStyle = .none
        locationTextField.textColor = .darkGray
        locationTextField.layer.cornerRadius = 10
        locationTextField.clearButtonMode = .always
        scrollView.addSubview(locationTextField)
        
        locDetailTextField = UITextField()
        locDetailTextField.placeholder = " location details (e.g. room number)"
        locDetailTextField.backgroundColor = UIColor(red: 0.93, green: 0.93, blue: 0.93, alpha: 1)
        locDetailTextField.font = UIFont(name: "AvenirNext-Regular", size: 17)
        locDetailTextField.borderStyle = .none
        locDetailTextField.textColor = .darkGray
        locDetailTextField.layer.cornerRadius = 10
        locDetailTextField.clearButtonMode = .always
        scrollView.addSubview(locDetailTextField)
        
        whenLabel = UILabel()
        whenLabel.text = "when?"
        whenLabel.textColor = .black
        whenLabel.font = UIFont(name: "AvenirNext-Regular", size: 18)
        view.addSubview(whenLabel)
        scrollView.addSubview(whenLabel)
        
        dateTextField = UITextField()
        dateTextField.placeholder = " mm/dd/yyyy"
        dateTextField.backgroundColor = UIColor(red: 0.93, green: 0.93, blue: 0.93, alpha: 1)
        dateTextField.font = UIFont(name: "AvenirNext-Regular", size: 16)
        dateTextField.borderStyle = .none
        dateTextField.textColor = .darkGray
        dateTextField.layer.cornerRadius = 10
        dateTextField.clearButtonMode = .always
        scrollView.addSubview(dateTextField)
        
        timeLabel = UILabel()
        timeLabel.text = "time"
        timeLabel.textColor = .black
        timeLabel.font = UIFont(name: "AvenirNext-Regular", size: 18)
        scrollView.addSubview(timeLabel)
        
        fromTimeTextField = UITextField()
        fromTimeTextField.placeholder = " from"
        fromTimeTextField.backgroundColor = UIColor(red: 0.93, green: 0.93, blue: 0.93, alpha: 1)
        fromTimeTextField.font = UIFont(name: "AvenirNext-Regular", size: 16)
        fromTimeTextField.borderStyle = .none
        fromTimeTextField.textColor = .darkGray
        fromTimeTextField.layer.cornerRadius = 10
        fromTimeTextField.clearButtonMode = .always
        scrollView.addSubview(fromTimeTextField)
        
        toTimeTextField = UITextField()
        toTimeTextField.placeholder = " to"
        toTimeTextField.backgroundColor = UIColor(red: 0.93, green: 0.93, blue: 0.93, alpha: 1)
        toTimeTextField.font = UIFont(name: "AvenirNext-Regular", size: 16)
        toTimeTextField.borderStyle = .none
        toTimeTextField.textColor = .darkGray
        toTimeTextField.layer.cornerRadius = 10
        toTimeTextField.clearButtonMode = .always
        scrollView.addSubview(toTimeTextField)
        
        moreDetailLabel = UILabel()
        moreDetailLabel.text = "event details (e.g. types of food)"
        moreDetailLabel.textColor = .black
        moreDetailLabel.font = UIFont(name: "AvenirNext-Regular", size: 18)
        scrollView.addSubview(moreDetailLabel)
        
        moreDetailTextView = UITextView()
        moreDetailTextView.isEditable = true
        moreDetailTextView.backgroundColor = UIColor(red: 0.93, green: 0.93, blue: 0.93, alpha: 1)
        moreDetailTextView.textColor = .darkGray
        moreDetailTextView.layer.cornerRadius = 10
        moreDetailTextView.font = UIFont(name: "AvenirNext-Regular", size: 17)
        scrollView.addSubview(moreDetailTextView)
        
        addTagsLabel = UILabel()
        addTagsLabel.text = "tags"
        addTagsLabel.textColor = .black
        addTagsLabel.font = UIFont(name: "AvenirNext-Regular", size: 18)
        scrollView.addSubview(addTagsLabel)
        
        photoLabel = UILabel()
        photoLabel.text = "add photo"
        photoLabel.textColor = .black
        photoLabel.font = UIFont(name: "AvenirNext-Regular", size: 18)
        scrollView.addSubview(photoLabel)
        
        postButton = UIButton()
        postButton.setTitle("POST", for: .normal)
        postButton.setTitleColor(UIColor(red:1, green:0.45, blue:0.42, alpha:1.0), for: .normal)
        postButton.titleLabel?.font =  UIFont(name: "AvenirNext-Medium", size: 18)
        postButton.backgroundColor = .white
        postButton.addTarget(self, action: #selector(post), for: .touchUpInside)
        postButton.layer.masksToBounds = false
        postButton.layer.cornerRadius = 20
        postButton.layer.borderWidth = 2
        postButton.layer.borderColor = UIColor(red:1, green:0.45, blue:0.42, alpha:1.0).cgColor
        scrollView.addSubview(postButton)
        
        uploadPhotoButton = UIButton()
        uploadPhotoButton.setTitle("Upload Photo", for: .normal)
        uploadPhotoButton.setTitleColor(UIColor(red:1, green:0.45, blue:0.42, alpha:1.0), for: .normal)
        uploadPhotoButton.titleLabel?.font =  UIFont(name: "AvenirNext-Medium", size: 18)
        uploadPhotoButton.addTarget(self, action: #selector(photoUpload), for: .touchUpInside)
        scrollView.addSubview(uploadPhotoButton)
        
        photoView = UIImageView()
        photoView.contentMode = .scaleAspectFit
        photoView.backgroundColor = UIColor(red: 0.93, green: 0.93, blue: 0.93, alpha: 1)
        photoView.layer.cornerRadius = 10
        scrollView.addSubview(photoView)
        
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
        scrollView.addSubview(filterCollectionView)
        
        datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
            
        fromTimePicker = UIDatePicker()
        fromTimePicker.datePickerMode = .time
        
        toTimePicker = UIDatePicker()
        toTimePicker.datePickerMode = .time
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(NewEvent.donePicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(NewEvent.cancelPicker))
        toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)
        
        dateTextField.inputView = datePicker
        dateTextField.inputAccessoryView = toolbar
        
        fromTimeTextField.inputView = fromTimePicker
        fromTimeTextField.inputAccessoryView = toolbar
        
        toTimeTextField.inputView = toTimePicker
        toTimeTextField.inputAccessoryView = toolbar
        
        setUpConstraints()
    }
    
    func setUpConstraints() {
        
        scrollView.snp.makeConstraints { make in
            make.left.top.bottom.right.equalTo(view)
        }

        rules.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.top.equalTo(self.scrollView.snp.top).offset(10)
        }
        
        whatLabel.snp.makeConstraints { make in
            make.left.equalTo(view).offset(35)
            make.top.equalTo(rules.snp.bottom).offset(15)
        }
        
        whatTextField.snp.makeConstraints { make in
            make.left.equalTo(view).offset(30)
            make.right.equalTo(view).offset(-30)
            make.top.equalTo(whatLabel.snp.bottom).offset(5)
            make.height.equalTo(textFieldHeight)
        }
        
        whereLabel.snp.makeConstraints { make in
            make.left.equalTo(view).offset(35)
            make.top.equalTo(whatTextField.snp.bottom).offset(25)
        }
        
        locationTextField.snp.makeConstraints { make in
            make.left.equalTo(view).offset(30)
            make.right.equalTo(view).offset(-30)
            make.top.equalTo(whereLabel.snp.bottom).offset(5)
            make.height.equalTo(textFieldHeight)
        }
        
        locDetailTextField.snp.makeConstraints { make in
            make.left.equalTo(view).offset(30)
            make.right.equalTo(view).offset(-30)
            make.top.equalTo(locationTextField.snp.bottom).offset(5)
            make.height.equalTo(textFieldHeight)
        }
        
        whenLabel.snp.makeConstraints { make in
            make.left.equalTo(view).offset(35)
            make.top.equalTo(locDetailTextField.snp.bottom).offset(25)
        }
        
        dateTextField.snp.makeConstraints { make in
            make.left.equalTo(view).offset(30)
            make.top.equalTo(whenLabel.snp.bottom).offset(5)
            make.height.equalTo(textFieldHeight)
            make.width.equalTo(125)
        }
        
        timeLabel.snp.makeConstraints { make in
            make.left.equalTo(view).offset(35)
            make.top.equalTo(dateTextField.snp.bottom).offset(25)
        }
        
        fromTimeTextField.snp.makeConstraints { make in
            make.left.equalTo(view).offset(30)
            make.top.equalTo(timeLabel.snp.bottom).offset(5)
            make.height.equalTo(textFieldHeight)
            make.width.equalTo(100)
        }
        
        toTimeTextField.snp.makeConstraints { make in
            make.left.equalTo(fromTimeTextField.snp.right).offset(10)
            make.top.equalTo(timeLabel.snp.bottom).offset(5)
            make.height.equalTo(textFieldHeight)
            make.width.equalTo(100)
        }
        
        moreDetailLabel.snp.makeConstraints { make in
            make.left.equalTo(view).offset(35)
            make.top.equalTo(fromTimeTextField.snp.bottom).offset(25)
        }
        
        moreDetailTextView.snp.makeConstraints { make in
            make.left.equalTo(view).offset(30)
            make.right.equalTo(view).offset(-30)
            make.top.equalTo(moreDetailLabel.snp.bottom).offset(5)
            make.height.equalTo(120)
        }
        
        addTagsLabel.snp.makeConstraints { make in
            make.left.equalTo(view).offset(35)
            make.top.equalTo(moreDetailTextView.snp.bottom).offset(25)
        }
        
        filterCollectionView.snp.makeConstraints { make in
            make.top.equalTo(addTagsLabel.snp.bottom).offset(5)
            make.height.equalTo(60)
            make.left.equalTo(view).offset(30)
            make.right.equalTo(view).offset(-20)
        }
        
        photoLabel.snp.makeConstraints { make in
            make.left.equalTo(view).offset(35)
            make.top.equalTo(filterCollectionView.snp.bottom).offset(25)
        }
        
        postButton.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.top.equalTo(uploadPhotoButton.snp.bottom).offset(20)
            make.size.equalTo(CGSize(width: 100, height: 40))
        }
        
        uploadPhotoButton.snp.makeConstraints { make in
            make.left.equalTo(view).offset(60)
            make.top.equalTo(photoView.snp.bottom).offset(5)
            make.height.equalTo(40)
        }
        
        photoView.snp.makeConstraints { make in
            make.left.equalTo(view).offset(30)
            make.top.equalTo(photoLabel.snp.bottom).offset(5)
            make.size.equalTo(CGSize(width: 200, height: 200))
        }
        
    }
    
    func makeAlert() {
        let alert = UIAlertController(title: "Post Cannot Be Added:", message: "Please fill out all areas", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel))
        self.present(alert, animated: true, completion: nil)
    }
    
    func maxCharacterAlert() {
        let alert = UIAlertController(title: "Post Cannot Be Added:", message: "Yor short event description is over 50 characters", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel))
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc func post() {
        if let title = whatTextField.text, let location = locationTextField.text, let locationDetail = locDetailTextField.text, let date = dateTextField.text, let fromTime = fromTimeTextField.text, let toTime = toTimeTextField.text, let eventDetail = moreDetailTextView.text {
            if title == "" || location == "" || locationDetail == "" || date == "" || fromTime == "" || toTime == "" || eventDetail == "" {
                makeAlert()
            } else if title.count > 50 {
                maxCharacterAlert()
            } else {
                if photoView.image == nil {
                    delegate?.addNewEvent(to: title, to: location, to: locationDetail, to: date, to: fromTime, to: toTime, to: eventDetail, to: selectedFilter, to: nil)
                } else {
                    delegate?.addNewEvent(to: title, to: location, to: locationDetail, to: date, to: fromTime, to: toTime, to: eventDetail, to: selectedFilter, to: photoView.image!)
                }
            }
        }
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func photoUpload() {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            photoPicker = UIImagePickerController()
            photoPicker.delegate = self
            photoPicker.sourceType = .photoLibrary
            photoPicker.allowsEditing = true
            present(photoPicker, animated: true, completion: nil)
        } else {
            print ("unable to access photo library")
        }
    }
    
    @objc func donePicker(){
        if dateTextField.isEditing {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM/dd/yyyy"
            dateTextField.text = dateFormatter.string(from: datePicker.date)
            self.view.endEditing(true)
        } else if fromTimeTextField.isEditing {
            let fromTimeFormatter = DateFormatter()
            fromTimeFormatter.dateFormat = "h:mm a"
            fromTimeTextField.text = fromTimeFormatter.string(from: fromTimePicker.date)
            self.view.endEditing(true)
        } else {
            let toTimeFormatter = DateFormatter()
            toTimeFormatter.dateFormat = "h:mm a"
            toTimeTextField.text = toTimeFormatter.string(from: toTimePicker.date)
            self.view.endEditing(true)
        }
    }
    
    @objc func cancelPicker(){
        self.view.endEditing(true)
    }
}

extension NewEvent: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let photo = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            photoView.image = photo
        }
        dismiss(animated: true, completion: nil)
    }
}


extension NewEvent: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            let currentFilter = foodFilter[indexPath.item]
            updateFilter(filter: currentFilter, needRemoved: false)
        } else {
            let currentFilter = locationFilter[indexPath.item]
            updateFilter(filter: currentFilter, needRemoved: false)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
         if indexPath.section == 0 {
            let currentFilter = foodFilter[indexPath.item]
            updateFilter(filter: currentFilter, needRemoved: true)
        
        } else {
            let currentFilter = locationFilter[indexPath.item]
            updateFilter(filter: currentFilter, needRemoved: true)
        }
    }
    
    func updateFilter(filter: String?, needRemoved: Bool = false) {
        if needRemoved {
            selectedFilter.remove(at: (selectedFilter.firstIndex(of: filter!)!))
        } else {
            if !(selectedFilter.contains(filter!)) {
                selectedFilter.append(filter!)
            }
        }
    }
}

extension NewEvent: UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return foodFilter.count
        } else {
            return locationFilter.count
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
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

extension NewEvent: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = 60
        let height: CGFloat = 20
        return CGSize(width: width, height: height)
    }
}

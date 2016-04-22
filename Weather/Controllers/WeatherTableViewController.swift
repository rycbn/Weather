//
//  WeatherTableViewController.swift
//  Weather
//
//  Created by Roger Yong on 31/03/2016.
//  Copyright © 2016 rycbn. All rights reserved.
//

import UIKit
import CoreData

class WeatherTableViewController: UITableViewController {
    // MARK:- Properties
    @IBOutlet weak var cityImageView: UIImageView!
    var pickerView: UIPickerView!
    var doneButton: UIButton!
    var backgroundView: UIView!
    var headerView: UIView!
    var city: City!
    var cityIdSelected: NSNumber!
    var cityNameSelected: String!
    var cityImageSelected: String!
    var cloudImage: UIImage!
    
    var tableData = [AnyObject]()
    var pickerData = [City]()
    var selectedIndex = NSInteger()
    var spinner = CustomSpinner()
    var weather = Weather()

    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIApplicationDidBecomeActiveNotification, object: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureInit()
        configureRightBarButton()
        configureData()
        configureHeaderView()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
// MARK:- UI Configuration
extension WeatherTableViewController {
    func configureInit() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector(Selectors.ReceivedNotification.Weather), name: UIApplicationDidBecomeActiveNotification, object: nil)
        
        tableView.tableFooterView = UIView(frame: CGRectZero)

        cityIdSelected = getDefaultCity().found ? getDefaultCity().id! : ConstantKeys.DefaultCityId
        cityNameSelected = getDefaultCity().found ? getDefaultCity().name! : ConstantKeys.DefaultCityName
        title = isNetworkOrCellularCoverageReachable() ? cityNameSelected : Translation.Weather
    }
    func configureData() {
        if isNetworkOrCellularCoverageReachable() {
            addSpinner()
            weather.delegate = self
            weather.getWeather(cityId: cityIdSelected)
            
            let stringSort = NSSortDescriptor(key: "name", ascending: true)
            let fetchRequestExchange = NSFetchRequest(entityName: EntityName.City)
            
            fetchRequestExchange.sortDescriptors = [stringSort]
            let asyncFetchRequestExchange = NSAsynchronousFetchRequest(fetchRequest: fetchRequestExchange, completionBlock: { (result: NSAsynchronousFetchResult!) -> Void in
                self.pickerData = result.finalResult as! [City]
                self.city = self.pickerData.first!
                for (index, city) in self.pickerData.enumerate() {
                    if city.name == self.cityNameSelected {
                        self.selectedIndex = index
                        self.cityImageSelected = city.imageName ?? ImageName.Default
                        self.cityImageView.image = UIImage(named: city.imageName ?? ImageName.Default)
                        break
                    }
                }
            })
            do {
                try objContext().executeRequest(asyncFetchRequestExchange)
            }
            catch {
                displayAlertWithTitle(Translation.Sorry, message: Translation.FetchDataErrorMessage, viewController: self)
                //print("Could not fetch \(error), \(error.userInfo)")
            }
        }
        else {
            dispatch_async(dispatch_get_main_queue(), {
                self.cityImageView.image = UIImage(named: ImageName.Default)
                self.tableView.reloadData()
                displayAlertWithTitle(Translation.NetworkErrorTitle, message: Translation.NetworkErrorMessage, viewController: self)
            })
        }
    }
    func configureHeaderView() {
        headerView = tableView.tableHeaderView
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.tableHeaderView = nil
        tableView.addSubview(headerView)

        tableView.contentInset = UIEdgeInsetsMake(Height.TableHeader, 0, 0, 0)
        tableView.contentOffset = CGPoint(x: 0, y: -Height.TableHeader)
        updateHeaderView()
    }
    func configureRightBarButton() {
        navigationItem.rightBarButtonItem = geographyBarButtonItem(target: self)
    }
    func configureBackgroundView() {
        backgroundView = UIView()
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        backgroundView.backgroundColor = UIColor.colorFromHexRGB(Color.SlateGray)
        backgroundView.alpha = 0.50
        parentViewController!.view.addSubview(backgroundView)

        backgroundView.topAnchor.constraintEqualToAnchor(super.view.topAnchor).active = true
        backgroundView.leadingAnchor.constraintEqualToAnchor(super.view.leadingAnchor).active = true
        super.view.trailingAnchor.constraintEqualToAnchor(backgroundView.trailingAnchor).active = true
        super.view.bottomAnchor.constraintEqualToAnchor(backgroundView.bottomAnchor).active = true
    }
    func configurePickerView() {
        pickerView = UIPickerView()
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        pickerView.dataSource = self
        pickerView.delegate = self
        pickerView.showsSelectionIndicator = true
        pickerView.selectRow(selectedIndex, inComponent: 0, animated: true)
        pickerView.backgroundColor = UIColor.colorFromHexRGB(Color.Gray)
        pickerView.layer.borderColor = UIColor.colorFromHexRGB(Color.Gray).CGColor
        pickerView.layer.borderWidth = 1.0
        pickerView.layer.cornerRadius = 5.0
        parentViewController!.view.addSubview(pickerView)
        
        pickerView.centerXAnchor.constraintEqualToAnchor(view.centerXAnchor).active = true
        pickerView.centerYAnchor.constraintEqualToAnchor(view.centerYAnchor).active = true
        pickerView.widthAnchor.constraintEqualToConstant(Width.PickerView).active = true
    }
    func configureDoneButton() {
        doneButton = UIButton(type: .Custom)
        doneButton.translatesAutoresizingMaskIntoConstraints = false
        doneButton.exclusiveTouch = true
        doneButton.setTitle(Translation.Done, forState: .Normal)
        doneButton.setTitle(Translation.Done, forState: .Highlighted)
        doneButton.setTitleColor(UIColor.colorFromHexRGB(Color.Blue), forState: .Normal)
        doneButton.setTitleColor(UIColor.colorFromHexRGB(Color.Blue), forState: .Highlighted)
        doneButton.backgroundColor = UIColor.colorFromHexRGB(Color.Gray)
        doneButton.titleLabel?.font = UIFont(name: FontNameHelveticaNeue.Bold, size: FontSize.Small)
        doneButton.layer.borderWidth = 1.0
        doneButton.layer.borderColor = UIColor.colorFromHexRGB(Color.Gray).CGColor
        doneButton.layer.cornerRadius = 5.0
        doneButton.isAccessibilityElement = true
        doneButton.addTarget(self, action: Selector(Selectors.Done), forControlEvents: .TouchUpInside)
        parentViewController!.view.addSubview(doneButton)
        
        doneButton.topAnchor.constraintEqualToAnchor(pickerView.bottomAnchor, constant: Padding.Top.Regular).active = true
        doneButton.centerXAnchor.constraintEqualToAnchor(super.view.centerXAnchor).active = true
        doneButton.heightAnchor.constraintEqualToConstant(Height.Button).active = true
        doneButton.widthAnchor.constraintEqualToConstant(Width.LongButton).active = true
    }
}
// MARK:- Internal Action
extension WeatherTableViewController {
    func receivedNotificationWeather(notification: NSNotification) {
        if notification.name == UIApplicationDidBecomeActiveNotification {
            configureInit()
            configureData()
        }
    }
    func updateHeaderView() {
        var headerRect = CGRect(x: 0, y: -Height.TableHeader, width: tableView.bounds.width, height: Height.TableHeader)
        if tableView.contentOffset.y < -Height.TableHeader {
            headerRect.origin.y = tableView.contentOffset.y
            headerRect.size.height = -tableView.contentOffset.y
        }
        headerView.frame = headerRect
    }
    func addSpinner() {
        spinner.runSpinnerWithIndicator(parentViewController!.view)
        spinner.start()
    }
    func removeSpinner() {
        spinner.stop()
    }
    func cityPicker(sender: UIBarButtonItem) {
        if isNetworkOrCellularCoverageReachable() {
            configureBackgroundView()
            configurePickerView()
            configureDoneButton()
        }
        else {
            displayAlertWithTitle(Translation.NetworkErrorTitle, message: Translation.NetworkErrorMessage, viewController: self)
        }
    }
    func done(sender: UIButton) {
        if isNetworkOrCellularCoverageReachable() {
            if cityIdSelected != nil && cityNameSelected != nil && cityImageSelected != nil {
                addSpinner()
                NSUserDefaults.standardUserDefaults().setValue(cityNameSelected, forKey: UserDefaults.CityName)
                NSUserDefaults.standardUserDefaults().setValue(cityIdSelected, forKey: UserDefaults.CityId)
                NSUserDefaults.standardUserDefaults().synchronize()
                
                weather.getWeather(cityId: cityIdSelected)
                cityImageView.image = UIImage(named: cityImageSelected)
                cityImageView!.layer.addAnimation(imageTransition(), forKey: nil)
                title = cityNameSelected
            }
        }
        else {
            displayAlertWithTitle(Translation.NetworkErrorTitle, message: Translation.NetworkErrorMessage, viewController: self)
        }
        pickerView.removeFromSuperview()
        doneButton.removeFromSuperview()
        backgroundView.removeFromSuperview()
    }
}
// MARK:- UITableViewDataSource
extension WeatherTableViewController {
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count: Int!
        count = isNetworkOrCellularCoverageReachable() ? tableData.count : 1
        return count
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .Subtitle, reuseIdentifier: Identifier.TableCell)
        cell.imageView!.image = UIImage(named: ImageName.Cloud)
        if isNetworkOrCellularCoverageReachable() {
            let list = tableData[indexPath.row] as! List
            if let imageUrl = list.imageUrl {
                TaskConfig().taskForGETImage(imageUrl, completionHandler: { (imageData, error) in
                    if let imageData = imageData {
                        if let image = UIImage(data: imageData) {
                            dispatch_async(dispatch_get_main_queue(), {
                                cell.imageView!.image = image
                                cell.imageView!.layer.addAnimation(imageTransition(), forKey: nil)
                            })
                        }
                    }
                })
            }
            if let timeInterval = list.timeInterval {
                cell.textLabel?.text = NSDate(timeIntervalSince1970: timeInterval).toStringInHHMMDDslashMMslashYYYY()
            }
            else {
                cell.textLabel?.text = Translation.DataNotAvailable
            }
            cell.detailTextLabel?.text = list.information ?? Translation.DataNotAvailable
        }
        else {
            cell.textLabel?.text = Translation.DataNotAvailable
            cell.detailTextLabel?.text = Translation.DataNotAvailable
        }
        cell.textLabel?.adjustsFontSizeToFitWidth = true
        cell.detailTextLabel?.adjustsFontSizeToFitWidth = true
        cell.selectionStyle = .None
        return cell
    }
}
// MARK:- UITableViewDelegate
extension WeatherTableViewController {
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    override func tableView(tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}
// MARK:- UIScrollViewDelegate
extension WeatherTableViewController {
    override func scrollViewDidScroll(scrollView: UIScrollView) {
        updateHeaderView()
    }
}
// MARK:- UIPickerViewDataSource
extension WeatherTableViewController: UIPickerViewDataSource {
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
}
// MARK:- UIPickerViewDelegate
extension WeatherTableViewController: UIPickerViewDelegate {
    func pickerView(pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return Width.PickerView
    }
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        city = pickerData[row]
        return city.name!
    }
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        city = pickerData[row]
        selectedIndex = row
        cityIdSelected = city.id!
        cityNameSelected = city.name!
        cityImageSelected = city.imageName!
        NSUserDefaults.standardUserDefaults().setValue(cityNameSelected, forKey: UserDefaults.CityName)
        NSUserDefaults.standardUserDefaults().setValue(cityIdSelected, forKey: UserDefaults.CityId)
        NSUserDefaults.standardUserDefaults().synchronize()
    }
}
// MARK:- WeatherDelegate
extension WeatherTableViewController: WeatherDelegate {
    func weatherData(data: [List]) {
        tableData = data
        tableView.reloadData()
        removeSpinner()
    }
    func ApiError() {
        removeSpinner()
        displayAlertWithTitle(Translation.ApiErrorTitle, message: Translation.ApiErrorMessage, viewController: self)
    }
}

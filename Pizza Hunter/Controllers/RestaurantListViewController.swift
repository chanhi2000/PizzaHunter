//
//  ViewController.swift
//  Pizza Hunter
//
//  Created by 전정철 on 29/05/2018.
//  Copyright © 2018 MarkiiimarK. All rights reserved.
//

import UIKit
import Siesta

class RestaurantListViewController: UITableViewController {
    static let locations = ["Atlanta", "Boston", "Chicago", "Los Angeles", "New York", "San Francisco"]
    
//    private var restaurants: [[String: Any]] = [] {
    private var restaurants: [Restaurant] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    var restaurantListResource: Resource? {
        didSet {
            oldValue?.removeObservers(ownedBy: self)
            restaurantListResource?
                .addObserver(self)
                .addObserver(statusOverlay, owner: self)
                .loadIfNeeded()
        }
    }
    
    var currentLocation: String! {
        didSet {
            restaurantListResource = YelpAPI.sharedInstance.restaurantList(for: currentLocation)
        }
    }
    
//    private var statusOverlay = ResourceStatusOverlay()
    private lazy var statusOverlay: ResourceStatusOverlay = {
        let sts = ResourceStatusOverlay()
        sts.embed(in: self)
        return sts
    }()
    
    let cellId = "RestaurantListTableViewCell"
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        statusOverlay.positionToCoverParent()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Pizza Hunter"
//        statusOverlay.embed(in: self)
        currentLocation = RestaurantListViewController.locations[0]
        tableView.register(RestaurantListTableViewCell.self, forCellReuseIdentifier: cellId)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension RestaurantListViewController {
    // MARK: - UITableViewDataSource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return restaurants.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! RestaurantListTableViewCell
        
        guard indexPath.item <= restaurants.count else { return cell }
        
        let restaurant = restaurants[indexPath.item]
//        cell.nameLabel.text = restaurant["name"] as? String
        cell.nameLabel.text = restaurant.name
//        cell.iconIV.imageURL = restaurant["image_url"] as? String
        cell.iconIV.imageURL = restaurant.imageUrl
        return cell
    }
    
    // MARK: - UITableViewDelegate
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = RestaurantListTableViewHeader(frame: .zero)
        headerView.delegate = self
        headerView.location = currentLocation
        return headerView
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return headerHeight + 2*viewPadding
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return listItemHeight
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard indexPath.item <= restaurants.count else { return }
        let vc = RestaurantDetailsViewController()
        vc.restaurantId = restaurants[indexPath.item].id
        navigationController?.pushViewController(vc, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension RestaurantListViewController: RestaurantListTableViewHeaderDelegate {
    func didTapHeaderButton(_ headerView: RestaurantListTableViewHeader) {
        let locationPicker = UIAlertController(title: "Select location", message: nil, preferredStyle: .actionSheet)
        for location in RestaurantListViewController.locations {
            locationPicker.addAction(UIAlertAction(title: location, style: .default) { [weak self] action in
                guard let `self` = self else { return }
                self.currentLocation = action.title
                self.tableView.reloadData()
            })
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        locationPicker.addAction(cancelAction)
        present(locationPicker, animated: true)
    }
}

extension RestaurantListViewController: ResourceObserver {
    func resourceChanged(_ resource: Resource, event: ResourceEvent) {
//        restaurants = resource.jsonDict["businesses"] as? [[String: Any]] ?? []
        restaurants = resource.typedContent() ?? []
    }
}


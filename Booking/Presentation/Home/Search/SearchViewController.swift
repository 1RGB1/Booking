//
//  SearchViewController.swift
//  Booking
//
//  Created by Ahmad Ragab on 1/3/18.
//  Copyright © 2018 Ahmad Ragab. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    //MARK: Outlets
    @IBOutlet weak var searchCriteriaControl: UISegmentedControl!
    @IBOutlet weak var categoriesView: UIView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchItemsTableView: UITableView!
    
    @IBOutlet weak var dropDownListHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var searchBarHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet var categoriesButtons: [FancyButton]!
    
    //MARK: Locals
    var isInSearchMode = false
    var dropDownListHieght = CGFloat()
    var searchBarHieght = CGFloat()
    var dropDownListYposition = CGFloat()
    
    var availableItems = [ItemModel]()
    var filteredAvailableItems = [ItemModel]()
    let itemsNetwork = ItemsNetwork()
    
    //MARK: View Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dropDownListHieght = self.dropDownListHeightConstraint.constant
        searchBarHieght = self.searchBarHeightConstraint.constant
        dropDownListYposition = self.categoriesView.frame.origin.y
    
        self.searchBarHeightConstraint.constant = 0.0
        
        self.searchItemsTableView.delegate = self
        self.searchItemsTableView.dataSource = self
        
        self.searchBar.delegate = self
        self.searchBar.returnKeyType = .done
        
        self.searchItemsTableView.register(UINib(nibName: "ItemTableViewCell", bundle: nil), forCellReuseIdentifier: "ItemCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    //MARK: Buttons Actions
    @IBAction func logoutPressed(_ sender: Any) {
        Utilities.saveAndDeleteUser(model: nil)
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let loginViewController = storyboard.instantiateViewController(withIdentifier: "LoginViewController")
        self.present(loginViewController, animated: true, completion: nil)
    }
    
    @IBAction func searchCriteriaValueChanged(_ sender: Any) {
        self.availableItems.removeAll()
        self.searchItemsTableView.reloadData()
        
        switch self.searchCriteriaControl.selectedSegmentIndex {
        case 0:
            self.hideSearchBar()
            break
        case 1:
            self.hideMenu()
            break
        default:
            break
        }
    }
    
    func hideMenu() {
        self.searchBarHeightConstraint.constant = self.searchBarHieght
        
        self.categoriesButtons.forEach {
            (category) in

            UIView.animate(withDuration: 0.5, animations: {
                category.isHidden = true
                self.dropDownListHeightConstraint.constant -= 41
                self.view.layoutIfNeeded()
            })
        }

        self.categoriesView.isHidden = true
    }
    
    func hideSearchBar() {
        self.categoriesView.isHidden = false
        
        self.categoriesButtons.forEach {
            (category) in

            UIView.animate(withDuration: 0.75, animations: {
                category.isHidden = false
                self.dropDownListHeightConstraint.constant += 41
                self.view.layoutIfNeeded()
            })
        }
        
        self.searchBarHeightConstraint.constant = 0
    }
    
    @IBAction func categoryButtonPressed(_ sender: UIButton) {
        self.getItemsBy(categoryId: sender.tag)
    }
    
    func getItemsBy(categoryId: Int) {
        itemsNetwork.getAvailableItemsBy(categoryId: Category(rawValue: categoryId)!) {
            (availableItemsModel, error) in
            
            if error == SUCCESS {
                self.availableItems = (availableItemsModel?.availableItems)!
                self.searchItemsTableView.reloadData()
                
                if availableItemsModel?.availableItems?.count == 0 {
                    let errorAlertController = Utilities.showAlertWithTitle(INFO, withMessage: NO_AVAILABLE_ITEMS)
                    self.present(errorAlertController, animated: true, completion: nil)
                }
            } else {
                let errorAlertController = Utilities.showAlertWithTitle(ERROR, withMessage: error!)
                self.present(errorAlertController, animated: true, completion: nil)
            }
        }
    }
    
    // MARK: SearchBar Functions
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        //self.getItemsBy(categoryId: 0)
        self.filteredAvailableItems.removeAll()
        
        if searchBar.text == nil || searchBar.text == "" {
            isInSearchMode = false
            self.searchItemsTableView.reloadData()
            view.endEditing(true)
        } else {
            isInSearchMode = true
            
            itemsNetwork.searchWith(query: searchBar.text!, completionHandler: {
                (availableItemsModel, error) in

                if error == SUCCESS {
                    self.availableItems = (availableItemsModel?.availableItems)!
                    
                    if self.availableItems.count == 0 {
                        let errorAlertController = Utilities.showAlertWithTitle(INFO, withMessage: NO_AVAILABLE_ITEMS)
                        self.present(errorAlertController, animated: true, completion: nil)
                    } else {
                        let lower = searchBar.text!.lowercased()
                        self.filteredAvailableItems = self.availableItems.filter({ $0.title?.lowercased().range(of: lower) != nil })
                    }
                    
                    self.searchItemsTableView.reloadData()
                } else {
                    let errorAlertController = Utilities.showAlertWithTitle(ERROR, withMessage: error!)
                    self.present(errorAlertController, animated: true, completion: nil)
                }
            })
        }
    }
    
    // MARK: Tableview Functions
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if self.filteredAvailableItems.count != 0 {
            return self.filteredAvailableItems.count
        }
        
        return self.availableItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as! ItemTableViewCell
        
        if self.filteredAvailableItems.count != 0 {
            let item = self.filteredAvailableItems[indexPath.row]
            cell.setModel(model: item, withImages: item.images)
            return cell
        }
        
        let item = self.availableItems[indexPath.row]
        cell.setModel(model: item, withImages: item.images)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var itemModel : ItemModel?
        
        if self.filteredAvailableItems.count != 0 {
            itemModel = self.filteredAvailableItems[indexPath.row]
        } else {
            itemModel = self.availableItems[indexPath.row]
        }
        
        performSegue(withIdentifier: "searchSegue", sender: itemModel)
    }
    
    //MARK: Navigation Segue Actions
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "searchSegue" {
            let itemInfoViewController = segue.destination as! ItemInfoViewController
            let itemModel = sender as! ItemModel
            
            itemInfoViewController.itemModel = itemModel
            itemInfoViewController.images = itemModel.images
            itemInfoViewController.mainButtonAction = ReservationsActions.Request
            itemInfoViewController.subButtonAction = nil
        }
    }
}

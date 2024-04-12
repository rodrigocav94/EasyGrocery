//
//  ViewController.swift
//  EasyGrocery
//
//  Created by Rodrigo Cavalcanti on 12/04/24.
//

import UIKit

class ViewController: UITableViewController {
    var shoppingList = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
    }
    
    func setupNavBar() {
        title = "EasyGrocery"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let addButton = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(onTapAddItem)
        )
        
        let wipeButton = UIBarButtonItem(
            barButtonSystemItem: .trash,
            target: self,
            action: #selector(wipeList)
        )
        
        navigationItem.rightBarButtonItems = [addButton, wipeButton]
    }
    
    @objc func onTapAddItem() {
        let ac = UIAlertController(title: "Add a new item", message: nil, preferredStyle: .alert)
        ac.addTextField()
        ac.addAction(
            UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        )
        ac.addAction(
            UIAlertAction(title: "Add", style: .default, handler: {[weak self] _ in
                guard let item = ac.textFields?[0].text else {return}
                self?.shoppingList.insert(item, at: 0)
                self?.tableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: .automatic)
            })
        )
        present(ac, animated: true)
    }
    
    @objc func wipeList() {
        shoppingList = []
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        shoppingList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = shoppingList[indexPath.row]
        return cell
    }
}


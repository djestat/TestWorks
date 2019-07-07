//
//  ByeController.swift
//  iShop
//
//  Created by Igor on 04/07/2019.
//  Copyright © 2019 Igorlab. All rights reserved.
//

import UIKit

extension Notification.Name {
    static let reload = Notification.Name("reload")
}

class ByeController: UITableViewController {
    
    var productList = [Product]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    
        readFromJSON()
        NotificationCenter.default.addObserver(self, selector: #selector(reloadData), name: .reload, object: nil)

    }
    
    @objc func reloadData(_ notification : Notification) {
        readFromJSON()
        tableView.reloadData()
    }
    
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return productList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ProductByeCell.reuseID, for: indexPath) as? ProductByeCell else { fatalError("Cell cannot be dequeued") }

        // Configure the cell...
        
        cell.productImageView.image = UIImage(named: productList[indexPath.row].image)
        cell.nameProductLabel.text = String(productList[indexPath.row].name)
        cell.priceLabel.text = String("₽ \(productList[indexPath.row].price)")

        return cell
    }
    

    func readFromJSON() {
        
        let storage = FileManager.default
        let fm = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let file = fm.appendingPathComponent("ProductDB.json")
        
        let jsonPath = Bundle.main.path(forResource: "ProductDB", ofType: "json")
        print(jsonPath!)
        let url = URL(fileURLWithPath: jsonPath!)
        print("\(url)  🔗")
        
        if storage.fileExists(atPath: file.path) == false {
            
            do {
                try! storage.copyItem(atPath: url.path, toPath: file.path)
                print(file)
            }
            
        }
        
        do {
            let data = try! Data(contentsOf: file)
            print("\(data)  📊")
            let db = try JSONDecoder().decode(JSONDB.self, from: data)
            productList = db.products
            print("\(db)  🎈")
        } catch {
            print("error 🎈")
        }
        
        print(productList)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "InfoSegue",
            let infoVC = segue.destination as? InfoController,
            let indexPath = tableView.indexPathForSelectedRow {
            
            infoVC.title = productList[indexPath.row].name
            
            infoVC.infoProduct = productList[indexPath.row]
            print(productList[indexPath.row])
 
        }
    }
    
    
    
    /*
    func updater() {

        let timer = Timer.scheduledTimer(withTimeInterval: 2, repeats: true) { timer in
            self.readFromJSON()
            self.tableView.reloadData()
            print("Timer: \(timer) - working! \(Date().description))")
        }

    } */
    
}



//
//  TableViewController.swift
//  gradient in tableview
//
//  Created by Ajay Vandra on 1/29/20.
//  Copyright © 2020 Ajay Vandra. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController{

    var arr = [Category]()
    
    var filepath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("add.plist")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(filepath!)
        loadData()
       }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arr.count
        
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellView", for: indexPath)
        let cellvalue = arr[indexPath.row].value
        
        if arr[indexPath.row].done == false{
            cell.accessoryType = .checkmark
        }
        else{
            cell.accessoryType = .none
        }
            
        
        cell.textLabel?.text = cellvalue
        
        return cell
        
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
            arr[indexPath.row].done = !arr[indexPath.row].done
               
               saveData()
               
               tableView.deselectRow(at: indexPath, animated: true)
    }
    

    @IBAction func btnClick(_ sender: UIBarButtonItem) {
        
        var textfield = UITextField()
        
        let alert = UIAlertController(title: "add", message: "Add Favourite", preferredStyle: .alert)
        let action = UIAlertAction(title: "add", style: .default) { (UIAlertAction) in
            let new = Category()
            new.value = textfield.text!
            self.arr.append(new)
            self.saveData()
        }
        alert.addTextField { (alertTextfield) in
            alertTextfield.placeholder = "write here"
            textfield = alertTextfield
        }
        alert.addAction(action)
        present(alert,animated: true,completion: nil)
        
    }
    func saveData(){
        let encode = PropertyListEncoder()
        do{
            let ec = try? encode.encode(arr)
            try ec?.write(to: filepath!)
        }
        catch{
            print(error)
        }
        self.tableView.reloadData()
    }
    func loadData(){
        
        if let data = try? Data(contentsOf: filepath!){
            do{
                let decode = PropertyListDecoder()
                arr = try! decode.decode([Category].self, from: data)
            }
            catch{
                print(error)
            }
        }
        
    }
}

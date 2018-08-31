//
//  RootViewController.swift
//  Favorites
//
//  Created by Kris Liu on 2018/8/28.
//  Copyright © 2018 Kris Liu. All rights reserved.
//

import UIKit
import Navigator

public class RootViewController : UITableViewController, DataProtocol {
    
    let letterString: NSString = "abcdefghijklmnopqrstuvwxyz"
    
    public func onDataReceiveBeforeShow(_ data: DataDictionary, fromViewController: UIViewController?) {
        print("Receive data from \(String(describing: fromViewController)) before show: \(data)")
    }
    
    public func onDataReceiveAfterBack(_ data: DataDictionary, fromViewController: UIViewController?) {
        print("Receive data from \(String(describing: fromViewController)) after back: \(data)")
        
        let message = data["message"] as? String ?? "No Message"
        let alertVC = UIAlertController(title: "Callback", message: message, preferredStyle: .alert)
        let cancel = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertVC.addAction(cancel)
        present(alertVC, animated: true, completion: nil)
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        title = "Favorites"
        tabBarItem = UITabBarItem(tabBarSystemItem: UITabBarSystemItem.favorites, tag: 0)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "name")
    }
    
    public override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return letterString.length
    }
    
    public override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "name", for: indexPath)
        var name = ""
        let number = random(min: 5, max: 20)
        for _ in 0...number {
            let idx = random(min: 0, max: 25)
            let range = NSRange(location: idx, length: 1)
            name += letterString.substring(with: range)
        }
        cell.textLabel?.text = name.capitalized
        return cell
    }
    
    public override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        let message = "Hello " + (cell?.textLabel?.text ?? "World")
        let data: DataDictionary = [NavigatorParametersKey.viewControllerName : "MORootViewController", "message" : message]
        navigator?.show(data)
    }
    
    private func random(min: Int, max: Int) -> Int {
        return Int(arc4random_uniform(UInt32(max-min+1))) + min
    }
}

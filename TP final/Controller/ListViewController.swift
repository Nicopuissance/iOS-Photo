//
//  ListViewController.swift
//  TP final
//
//  Created by Nicolas Duwavrent on 17/04/2019.
//  Copyright © 2019 ND. All rights reserved.
//

import UIKit
import Alamofire

class ListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var selectedIndex:Int? = nil
    var users:[User] = []
    
    override func viewDidLoad() {
        print("Before Request")
        AF.request("https://jsonplaceholder.typicode.com/users").responseString { response in
            print ("Recive Request")
            if let userJSON=response.value{
                let data=Data(userJSON.utf8)
                let decoder = JSONDecoder()
                
                do {
                    let decoded = try decoder.decode([User].self, from: data)
                    print(decoded[0].name)
                    self.users=decoded
                    self.tableView.reloadData()
                    
                } catch {
                    print("Failed to decode JSON")
                }
            }
        }
        print ("After request")
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.delegate=self
        tableView.dataSource=self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dest = segue.destination as? AlbumViewController,
            let index=selectedIndex{
            dest.user = users[index]
        }
    }
}

extension ListViewController:UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        selectedIndex=indexPath.row
        performSegue(withIdentifier: "listAlbum", sender: self)
        
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
}

extension ListViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomTableViewCell
        cell.txtLabel.text="\(users[indexPath.row].name) \n\(users[indexPath.row].username) \n\(users[indexPath.row].company.name)"
        
        return cell
    }
    
    
}




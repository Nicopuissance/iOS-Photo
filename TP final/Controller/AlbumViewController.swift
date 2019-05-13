//
//  AlbumViewController.swift
//  TP final
//
//  Created by Nicolas Duwavrent on 17/04/2019.
//  Copyright © 2019 ND. All rights reserved.
//

import UIKit
import Alamofire
import Kingfisher

class AlbumViewController: UIViewController {
    var user=User(id: 0, name: "", username: "", email: "", address: Address(street: "", suite: "", city: "", zipcode: "", geo: Geo(lat: "", lng:"" )), phone: "", website: "", company: Company(name: "", catchPhrase: "", bs: ""))
    @IBOutlet weak var collectionView: UICollectionView!
    
    var selectedIndex:Int? = nil
    var albums:[Album] = []
    
    override func viewDidLoad() {
        print("Before Request")
        print ("https://jsonplaceholder.typicode.com/albums?userId=\(user.id)")
        AF.request("https://jsonplaceholder.typicode.com/albums?userId=\(user.id)").responseString { response in
            print ("Recive Request")
            if let userJSON=response.value{
                let data=Data(userJSON.utf8)
                let decoder = JSONDecoder()
                
                do {
                    let decoded = try decoder.decode([Album].self, from: data)
                    print(decoded[0].title)
                    self.albums=decoded
                    self.collectionView.reloadData()
                    
                } catch {
                    print("Failed to decode JSON")
                }
            }
        }
        print ("After request")
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        collectionView.dataSource=self
        collectionView.delegate=self
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dest = segue.destination as? PhotoViewController,
            let index=selectedIndex{
            dest.album = albums[index]
        }
    }
    
    
    
    
}
extension AlbumViewController:UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewWidth=collectionView.frame.width
        let cellWidth=collectionViewWidth/2.0
        return CGSize(width: cellWidth, height: cellWidth)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedIndex=indexPath.row
        performSegue(withIdentifier: "listPhoto", sender: self)
    }
}

extension AlbumViewController:UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return albums.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell=collectionView.dequeueReusableCell(withReuseIdentifier: "albumCell", for: indexPath) as! CustomAlbumCollectionViewCell
        cell.txtLabel.text=albums[indexPath.row].title
        
        return cell
    }
}








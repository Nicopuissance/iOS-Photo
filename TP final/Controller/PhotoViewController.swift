//
//  PhotoViewController.swift
//  TP final
//
//  Created by Nicolas Duwavrent on 17/04/2019.
//  Copyright © 2019 ND. All rights reserved.
//

import UIKit
import Alamofire
import Kingfisher

class PhotoViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    var album=Album(userId: 0, id: 0, title: "")
    var selectedIndex:Int? = nil
    var photos:[Photo] = []
    let placeholder = UIImage(named: "AppIcon")
    
    override func viewDidLoad() {
        print("Before Request")
        AF.request("https://jsonplaceholder.typicode.com/photos?albumId=\(album.id)").responseString { response in
            print ("Recive Request")
            if let userJSON=response.value{
                let data=Data(userJSON.utf8)
                let decoder = JSONDecoder()
                
                do {
                    let decoded = try decoder.decode([Photo].self, from: data)
                    print(decoded[0].title)
                    self.photos=decoded
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
    
    
    
    
}
extension PhotoViewController:UICollectionViewDelegateFlowLayout{
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
}

extension PhotoViewController:UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell=collectionView.dequeueReusableCell(withReuseIdentifier: "photoCell", for: indexPath) as! CustomPhotoCollectionViewCell
        
        let url = URL(string: photos[indexPath.row].url)
        cell.imgView?.kf.setImage(with: url,placeholder: placeholder)
        return cell
    }
}







//
//  MapViewController.swift
//  TP final
//
//  Created by Nicolas Duwavrent on 17/04/2019.
//  Copyright © 2019 ND. All rights reserved.
//

import UIKit
import MapKit
import Alamofire

class MapViewController: UIViewController {
    var selectedIndex:Int? = nil
    var users:[User] = []
    var placeName:String=""
    var placeInfo:Int=0
    
    @IBOutlet weak var mapView: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
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
                    
                    for user in self.users{
                        let lat=CLLocationDegrees(Double(user.address.geo.lat)!)
                        let lng=CLLocationDegrees(Double(user.address.geo.lng)!)
                        self.mapView.addAnnotation(Place(title: "\(user.name) \(user.username)", coordinate: CLLocationCoordinate2D(latitude:lat, longitude:lng), info: String(user.id)))
                    }
                    
                } catch {
                    print("Failed to decode JSON")
                }
            }
        }
        print ("After request")
        // Do any additional setup after loading the view.
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dest = segue.destination as? AlbumViewController{
            dest.user = users[placeInfo]
        }
    }
    
    func mapView(mapView: MKMapView!, annotationView view: MKAnnotationView!, calloutAccessoryControlTapped control: UIControl!) {
        let capital = view.annotation as! Place
        if let title=capital.title,let info = Int(capital.info) {
            placeName = title
            placeInfo=info
        }
        performSegue(withIdentifier: "mapAlbum", sender: self)
        
    }
    
}


/*
 // MARK: - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
 // Get the new view controller using segue.destination.
 // Pass the selected object to the new view controller.
 }
 */


//
//  Pizzerias.swift
//  PizzaHunt
//
//  Created by Jamar Gibbs on 2/3/16.
//  Copyright © 2016 M1ndful M3d1a. All rights reserved.
//

import UIKit

class Pizzerias: NSObject {
    
   
    
        let latitude: Double
        let longitude: Double
        let name: String
        let routes: String
        let interModal: String
        let address: String
        
        init(dict: NSDictionary) {
            
            let location = dict.objectForKey("location") as! NSDictionary
            self.latitude  = Double(location.objectForKey("latitude") as! String)!
            self.longitude = Double(location.objectForKey("longitude") as! String)!
            self.name      = dict.objectForKey("cta_stop_name") as! String
            self.routes    = dict.objectForKey("routes") as! String
            if let interModalOption = dict.objectForKey("inter_modal") {
                self.interModal = interModalOption as! String
            }else{
                self.interModal = ""
            }
            self.address = dict.objectForKey("_address") as! String
            
        }
    }


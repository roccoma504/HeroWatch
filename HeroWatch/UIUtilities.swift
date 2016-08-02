//
//  UIUtilities.swift
//  HeroWatch
//
//  Created by Matthew Rocco on 7/19/16.
//  Copyright © 2016 Matthew Rocco. All rights reserved.
//

import UIKit

class UIUtilities {
    
    static func displayAlert(targetVC: UIViewController, title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        
        alert.addAction((UIAlertAction(title: "Dismiss",
            style: .Default, handler: {(action) -> Void in
        })))
        
        dispatch_async(dispatch_get_main_queue(),{
            targetVC.presentViewController(alert, animated: true, completion: nil)
        })
    }
    
    static func adjustAlpha (view : UIView, alpha : CGFloat) {
        dispatch_async(dispatch_get_main_queue(),{
            view.alpha = alpha
        })
    }
    
    static func adjustActivity (view : UIActivityIndicatorView, stop : Bool) {
        dispatch_async(dispatch_get_main_queue(),{
            if stop {
                view.stopAnimating()
            }
            else {
                view.startAnimating()
            }
        })
    }
    
    static func hideView (view : UIView, hide : Bool) {
        view.hidden = hide
    }
        
}

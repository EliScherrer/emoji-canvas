//
//  CanvasViewController.swift
//  emoji-canvas
//
//  Created by Eli Scherrer on 2/21/18.
//  Copyright © 2018 Eli Scherrer. All rights reserved.
//

import UIKit

class CanvasViewController: UIViewController {

    //tray itself
    @IBOutlet weak var trayView: UIView!
    
    //tray motion
    var trayOriginalCenter: CGPoint!
    var trayDownOffset: CGFloat!
    var trayUp: CGPoint!
    var trayDown: CGPoint!
    
    //faces added to the canvas
    var newlyCreatedFace: UIImageView!
    
    //face motion
    var newlyCreatedFaceOriginalCenter: CGPoint!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //set initial tray values
        trayDownOffset = 190
        trayUp = trayView.center
        trayDown = CGPoint(x: trayView.center.x ,y: trayView.center.y + trayDownOffset)
        
        
        
    }

    //handle the user dragging the tray
    @IBAction func didPanTray(_ sender: UIPanGestureRecognizer) {
        
        let velocity = sender.velocity(in: view)
        
        if sender.state == .began {
            trayOriginalCenter = trayView.center
        }
        else if sender.state == .changed {
//            trayView.center = CGPoint(x: trayOriginalCenter.x, y: trayOriginalCenter.y + translation.y)
        }
        else if sender.state == .ended {
            
            //tray is moving down
            if ( velocity.y > 0 ) {
                UIView.animate(withDuration:0.4, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options:[] ,
                               animations: { () -> Void in
                                self.trayView.center = self.trayDown
                }, completion: nil)
            }
            //tray is moving up
            else {
                UIView.animate(withDuration:0.4, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options:[] ,
                               animations: { () -> Void in
                                self.trayView.center = self.trayUp
                }, completion: nil)
            }
        
        }
        
        
    }
    
    //for faces in the tray
    @IBAction func didDragFace(_ sender: UIPanGestureRecognizer) {

        let translation = sender.translation(in: view)
        
        if sender.state == .began {
            //imageView now refers to the face that you panned on.
            let imageView = sender.view as! UIImageView
            
            //Create a new image view that has the same image as the one you're currently panning.
            newlyCreatedFace = UIImageView(image: imageView.image)
            
            //Add the new face to the main view.
            view.addSubview(newlyCreatedFace)
            
            //Initialize the position of the new face.
            newlyCreatedFace.center = imageView.center
            
            //Since the original face is in the tray, but the new face is in the main view, you have to offset the coordinates.
            newlyCreatedFace.center.y += trayView.frame.origin.y
            
            newlyCreatedFaceOriginalCenter = newlyCreatedFace.center
            
            UIView.animate(withDuration:0.1, delay: 0.0,
                           options: [],
                           animations: { () -> Void in
                            self.newlyCreatedFace.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
            }, completion: nil)
            
        }
        else if sender.state == .changed {
            newlyCreatedFace.center = CGPoint(x: newlyCreatedFaceOriginalCenter.x + translation.x, y: newlyCreatedFaceOriginalCenter.y + translation.y)
        }
        else if sender.state == .ended {
            UIView.animate(withDuration:0.1, delay: 0.0,
                           options: [],
                           animations: { () -> Void in
                            self.newlyCreatedFace.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            }, completion: nil)

//            newlyCreatedFace.isUserInteractionEnabled = true
//            let dragGesture = UITapGestureRecognizer(target: self, action: #selector(self.didDragFace2))
//            newlyCreatedFace.addGestureRecognizer(dragGesture)
        }
        
        
    }
    
    //for faces already on the canvas
    @objc func didDragFace2(sender: UIPanGestureRecognizer) {
        
        let translation = sender.translation(in: view)
        
        if sender.state == .began {
            //imageView now refers to the face that you panned on.
            let imageView = sender.view as! UIImageView
            
            //Create a new image view that has the same image as the one you're currently panning.
            newlyCreatedFace = UIImageView(image: imageView.image)
            
            //Add the new face to the main view.
            view.addSubview(newlyCreatedFace)
            
            //Initialize the position of the new face.
            newlyCreatedFace.center = imageView.center
            
            //Since the original face is in the tray, but the new face is in the main view, you have to offset the coordinates.
            newlyCreatedFace.center.y += trayView.frame.origin.y
            
            newlyCreatedFaceOriginalCenter = newlyCreatedFace.center
            
            UIView.animate(withDuration:0.1, delay: 0.0,
                           options: [],
                           animations: { () -> Void in
                            self.newlyCreatedFace.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
            }, completion: nil)
            
        }
        else if sender.state == .changed {
            newlyCreatedFace.center = CGPoint(x: newlyCreatedFaceOriginalCenter.x + translation.x, y: newlyCreatedFaceOriginalCenter.y + translation.y)
        }
        else if sender.state == .ended {
            UIView.animate(withDuration:0.1, delay: 0.0,
                           options: [],
                           animations: { () -> Void in
                            self.newlyCreatedFace.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            }, completion: nil)
            
        }
        
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

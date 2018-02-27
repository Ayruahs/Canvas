//
//  CanvasViewController.swift
//  Canvas
//
//  Created by Shaurya Sinha on 21/02/18.
//  Copyright © 2018 Shaurya. All rights reserved.
//

import UIKit

class CanvasViewController: UIViewController {
    var trayOriginalCenter: CGPoint!
    var trayDownOffset: CGFloat!
    var trayUp: CGPoint!
    var trayDown: CGPoint!
    var newlyCreatedFace: UIImageView!
    var newlyCreatedFaceOriginalCenter: CGPoint!

    @IBAction func didPanTray(_ sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: view)
        if(sender.state == .began){
            trayOriginalCenter = trayView.center
        }
        if(sender.state == .changed){
            trayView.center = CGPoint(x: trayOriginalCenter.x, y: trayOriginalCenter.y + translation.y)
        }
        if(sender.state == .ended){
            var velocity = sender.velocity(in: view)
            if(velocity.y > 0){
                UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options: [], animations: {
                    self.trayView.center = self.trayDown
                }, completion: nil)
            }else{
                UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options: [], animations: {
                    self.trayView.center = self.trayUp
                }, completion: nil)
            }
        }
    }
    @IBOutlet weak var trayView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        trayDownOffset = 160
        trayUp = trayView.center
        trayDown = CGPoint(x: trayView.center.x ,y: trayView.center.y + trayDownOffset)
    }

    @IBAction func didPanFace(_ sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: view)
        
        if(sender.state == .began){
            var imageView = sender.view as! UIImageView
            newlyCreatedFace = UIImageView(image: imageView.image)
            view.addSubview(newlyCreatedFace)
            newlyCreatedFace.center = imageView.center
            newlyCreatedFace.center.y += trayView.frame.origin.y
            
            newlyCreatedFaceOriginalCenter = newlyCreatedFace.center
        }
        if sender.state == .changed{
            newlyCreatedFace.center = CGPoint(x: newlyCreatedFaceOriginalCenter.x + translation.x, y: newlyCreatedFaceOriginalCenter.y + translation.y)
        }
        if sender.state == .ended{
            newlyCreatedFace.isUserInteractionEnabled = true
            let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(didPan(sender:)))
            newlyCreatedFace.addGestureRecognizer(panGestureRecognizer)
        }
    }
    
    @objc func didPan(sender: UIPanGestureRecognizer) {
        let location = sender.location(in: view)
        let velocity = sender.velocity(in: view)
        let translation = sender.translation(in: view)
        
        if sender.state == .began {
            newlyCreatedFace = sender.view as! UIImageView
            newlyCreatedFaceOriginalCenter = newlyCreatedFace.center
        } else if sender.state == .changed {
            newlyCreatedFace.center = CGPoint(x: newlyCreatedFaceOriginalCenter.x + translation.x, y: newlyCreatedFaceOriginalCenter.y + translation.y)
        } else if sender.state == .ended {
            print("Gesture ended")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

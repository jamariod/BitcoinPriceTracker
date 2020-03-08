//
//  LockViewController.swift
//  Bitcoin Price Tracker
//
//  Created by Jamario Davis on 2/25/19.
//  Copyright © 2019 KAYCAM. All rights reserved.
//

import UIKit

class LockViewController: UIViewController {

    @IBOutlet var topLock: UIImageView!
    
    @IBOutlet var bottomLock: UIImageView!
    
    @IBOutlet var lockBorder: UIImageView!
    
    @IBOutlet var lockKeyhole: UIImageView!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        openLock()
        DispatchQueue.main.asyncAfter(deadline:.now() + 3.5, execute: {
            self.performSegue(withIdentifier:"bit",sender: self)
        })
    }
    // MARK: - Convenience
    func openLock() {
        UIView.animate(withDuration: 0.4, delay: 2.0, options: [], animations: {
            // Rotate keyhole.
            self.lockKeyhole.transform = CGAffineTransform(rotationAngle: CGFloat(M_PI))
            
        }, completion: { _ in
            UIView.animate(withDuration: 0.5, delay: 0.2, options: [], animations: {
                // Open lock.
                let yDelta = self.lockBorder.frame.maxY
                self.topLock.center.y -= yDelta
                self.lockKeyhole.center.y -= yDelta
                self.lockBorder.center.y -= yDelta
                self.bottomLock.center.y += yDelta
            }, completion: { _ in
                self.topLock.removeFromSuperview()
                self.lockKeyhole.removeFromSuperview()
                self.lockBorder.removeFromSuperview()
                self.bottomLock.removeFromSuperview()
            })
        })
    }
    // MARK: - Status Bar
    override var prefersStatusBarHidden : Bool {
        return true
    }
}


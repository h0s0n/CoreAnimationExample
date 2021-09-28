//
//  ViewController.swift
//  CoreAnimationTutorial
//
//  Created by Yaakoub Hasan on 27/09/2021.
//

import UIKit

class ViewController: UIViewController, CAAnimationDelegate {
    @IBOutlet weak var animationButton: UIButton!
    
    let gradient = CAGradientLayer()
    
    // list of array holding 2 colors
    var gradientSet = [[CGColor]]()
    // current gradient index
    var currentGradient: Int = 0
    
    // colors to be added to the set
    let colorOne = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1).cgColor
    let colorTwo = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1).cgColor
    let colorThree = #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1).cgColor
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        createGradientView()
    }
    
    /// Creates gradient view
    
    func createGradientView() {
        
        // overlap the colors and make it 3 sets of colors
        gradientSet.append([colorOne, colorTwo])
        gradientSet.append([colorTwo, colorThree])
        gradientSet.append([colorThree, colorOne])
        
        // set the gradient size to be the entire screen
        gradient.frame = self.view.bounds
        gradient.colors = gradientSet[currentGradient]
        gradient.startPoint = CGPoint(x:0.5, y:0)
        gradient.endPoint = CGPoint(x:0.5, y:1)
        gradient.drawsAsynchronously = true
        
        self.view.layer.insertSublayer(gradient, at: 0)
        
        animateGradient()
    }
    
    func animateGradient() {
        // cycle through all the colors, feel free to add more to the set
        if currentGradient < gradientSet.count - 1 {
            currentGradient += 1
        } else {
            currentGradient = 0
        }
        
        // animate over 3 seconds
        let gradientChangeAnimation = CABasicAnimation(keyPath: "colors")
        gradientChangeAnimation.duration = 1.5
        gradientChangeAnimation.toValue = gradientSet[currentGradient]
        gradientChangeAnimation.fillMode = CAMediaTimingFillMode.forwards
        gradientChangeAnimation.isRemovedOnCompletion = false
        gradientChangeAnimation.delegate = self
        gradient.add(gradientChangeAnimation, forKey: "gradientChangeAnimation")
    }
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        // if our gradient animation ended animating, restart the animation by changing the color set
        if flag {
            gradient.colors = gradientSet[currentGradient]
            animateGradient()
        }
    }
    @IBAction func animationButtonTapped(_ sender: Any) {
        let point0 = CGPoint(x: animationButton.frame.origin.x, y: 60)
        let point1 = CGPoint(x: 60, y: 350)
        let point2 = CGPoint(x: UIScreen.main.bounds.width - 60, y: 600)
        let point3 = CGPoint(x: animationButton.frame.origin.x, y: UIScreen.main.bounds.height - 60)
        
        let animation = CAKeyframeAnimation()
        animation.keyPath = "position"
        animation.values = [point0,
                            point1,
                            point2,
                            point3]
        animation.keyTimes = [0, 0.35, 0.55, 1]
        animation.duration = 3
//        animation.autoreverses = true
//        animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        animation.repeatCount = Float.infinity
        animationButton.layer.add(animation, forKey: "move")
    }
}


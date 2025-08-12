//
//  ViewController.swift
//  CodePath
//
//  Created by june taylr on 8/12/25.
//

import UIKit

class ViewController: UIViewController {


    @IBOutlet weak var morePetsSwitch: UISwitch!
    @IBOutlet weak var morePetsStepper: UIStepper!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var schoolNameTextField: UITextField!
    
    
    @IBOutlet weak var yearSegmentedControl: UISegmentedControl!
        
    @IBOutlet weak var numberOfPetsLabel: UILabel!
    
    
   

    
    @IBAction func stepperDidChange(_ sender: UIStepper) {

       numberOfPetsLabel.text = "\(Int(sender.value))"
   }
    
    
    
    
    @IBAction func introduceSelfDidTapped(_ sender: UIButton) {

    // showConfetti()

            // Let's us chose the title we have selected from the segmented control
            let year = yearSegmentedControl.titleForSegment(at: yearSegmentedControl.selectedSegmentIndex)

            // Creating a variable of type string, that holds an introduction. The introduction interpolates the values from the text fields provided.
            // Currently we can only present the information in a print statement. However, this lets us verify that our app is printing out what is intended!
            let introduction = "My name is \(firstNameTextField.text!) \(lastNameTextField.text!) and I attend \(schoolNameTextField.text!).\n I am currently in my \(year!) year and I own \(numberOfPetsLabel.text!) dogs.\n It is \(morePetsSwitch.isOn) that I want more pets."

            // Creates the alert where we pass in our message, which our introduction.
            let alertController = UIAlertController(title: "My Introduction", message: introduction, preferredStyle: .alert)

            // A way to dismiss the box once it pops up
            let action = UIAlertAction(title: "Nice to meet you!", style: .default, handler: nil)

            // Passing this action to the alert controller so it can be dismissed
            alertController.addAction(action)

            present(alertController, animated: true, completion: nil)
        }

    
    private func confettiImage(color: UIColor) -> UIImage {
        let size = CGSize(width: 8, height: 14)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        let rect = CGRect(origin: .zero, size: size)
        // simple rounded rectangle “paper”
        UIBezierPath(roundedRect: rect, cornerRadius: 2).addClip()
        color.setFill()
        UIRectFill(rect)
        let img = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return img
    }

    private func showConfetti(duration: TimeInterval = 1.6) {
        let emitter = CAEmitterLayer()
        emitter.emitterPosition = CGPoint(x: view.bounds.midX, y: -10)   // from top
        emitter.emitterShape = .line
        emitter.emitterSize = CGSize(width: view.bounds.width, height: 1)

        let colors: [UIColor] = [.systemPink, .systemBlue, .systemYellow, .systemGreen, .systemOrange, .systemPurple]

        emitter.emitterCells = colors.map { color in
            let cell = CAEmitterCell()
            cell.contents = confettiImage(color: color).cgImage
            cell.birthRate = 7
            cell.lifetime = 5
            cell.velocity = 220
            cell.velocityRange = 80
            cell.yAcceleration = 150
            cell.emissionLongitude = .pi            // downward
            cell.emissionRange = .pi / 6
            cell.spin = 3.5
            cell.spinRange = 1.5
            cell.scale = 0.6
            cell.scaleRange = 0.3
            return cell
        }

        view.layer.addSublayer(emitter)

        // stop creating new confetti after `duration`
        DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
            emitter.birthRate = 0
        }
        // remove after particles finish falling
        DispatchQueue.main.asyncAfter(deadline: .now() + duration + 2.5) {
            emitter.removeFromSuperlayer()
        }
    }


    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}


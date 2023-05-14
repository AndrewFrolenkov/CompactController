//
//  SecondVC.swift
//  CompactController
//
//  Created by Андрей Фроленков on 13.05.23.
//

import Foundation
import UIKit

protocol ConstraintDelegate: AnyObject {
  
  func updateConstraint(int: CGFloat)
}

class SecondVC: UIViewController {
  
  weak var delegate: ConstraintDelegate?
  
  lazy var dissmissButton: UIButton = {
    let button = UIButton()
    button.setImage(UIImage(systemName: "xmark.circle"), for: .normal)
    button.tintColor = .black
    return button
  }()
  
  lazy var segmentedControl: UISegmentedControl = {
    let segmentedControl = UISegmentedControl(items: ["280pt", "150pt"])
    segmentedControl.selectedSegmentIndex = 0
    return segmentedControl
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.backgroundColor = #colorLiteral(red: 0.968627451, green: 0.9725490196, blue: 0.9921568627, alpha: 1)
    view.layer.cornerRadius = 10
    setupConstraints()
    
    drawView()
    
    dissmissButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    segmentedControl.addTarget(self, action: #selector(segmentedControlTapped), for: .valueChanged)
  }
  
  func drawView() {
    
    //Path part
    let path = UIBezierPath()
    path.lineCapStyle = .round
    path.move(to: CGPoint(x: 300 / 2 - 10, y: 0)) //StartPoint
    path.addLine(to: CGPoint(x: 150, y: -10)) //EndPoint of First Line and StartPoint for Second Line
    path.addLine(to: CGPoint(x: 300 / 2 + 10, y: 0)) //EndPoint of Second Line
    path.addLine(to: CGPoint(x: 300 / 2 - 10, y: 0)) //EndPoint of Second Line
    //Shape part
    let shape = CAShapeLayer()
    shape.path = path.cgPath
    shape.lineWidth = 2.0
    shape.fillColor = #colorLiteral(red: 0.968627451, green: 0.9725490196, blue: 0.9921568627, alpha: 1).cgColor
    shape.strokeColor = #colorLiteral(red: 0.968627451, green: 0.9725490196, blue: 0.9921568627, alpha: 1).cgColor
    view.layer.addSublayer(shape)
  }
  
  @objc func segmentedControlTapped(sender: UISegmentedControl) {
    
    self.view.translatesAutoresizingMaskIntoConstraints = false
    switch sender.selectedSegmentIndex {
      
    case 0:
      delegate?.updateConstraint(int: 280)
      
    case 1 :
      
      delegate?.updateConstraint(int: 150)
    default:
      print("error")
    }
  }
  
  @objc private func buttonTapped() {
    
    // First, notify the child that it’s about to be removed
    self.willMove(toParent: nil)
    
    // Then, remove the child from its parent
    self.removeFromParent()
    
    // Finally, remove the child’s view from the parent’s
    self.view.removeFromSuperview()
    
  }
  
  private func setupConstraints() {
    
    dissmissButton.translatesAutoresizingMaskIntoConstraints = false
    segmentedControl.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(dissmissButton)
    view.addSubview(segmentedControl)
    
    NSLayoutConstraint.activate([
      dissmissButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
      dissmissButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
      dissmissButton.widthAnchor.constraint(equalToConstant: 20),
      dissmissButton.heightAnchor.constraint(equalToConstant: 20),
      
      segmentedControl.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 10),
      segmentedControl.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
      
    ])
  }
  
}

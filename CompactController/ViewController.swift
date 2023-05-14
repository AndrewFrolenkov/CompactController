//
//  ViewController.swift
//  CompactController
//
//  Created by Андрей Фроленков on 13.05.23.
//

import UIKit



class ViewController: UIViewController {
  
  lazy var button: UIButton = {
    let button = UIButton()
    button.setTitle("Present", for: .normal)
    button.setTitleColor(UIColor.systemBlue, for: .normal)
    return button
  }()
  
  lazy var secondVC: SecondVC = {
    let secondVC = SecondVC()
    return secondVC
  }()
  
  var heightAnchor: NSLayoutConstraint?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupConstraints()
    
    
    heightAnchor = secondVC.view.heightAnchor.constraint(equalToConstant: 280)
    secondVC.delegate = self
    
    button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
  }
  
  @objc private func buttonPressed() {
    openSecondVC()
  }
  
  private func openSecondVC() {
    secondVC.view.translatesAutoresizingMaskIntoConstraints = false
    self.addChild(secondVC)
    self.view.addSubview(secondVC.view)
    secondVC.didMove(toParent: self)
    
    
    NSLayoutConstraint.activate([
      
      secondVC.view.topAnchor.constraint(equalTo: button.bottomAnchor, constant: 10),
      secondVC.view.widthAnchor.constraint(equalToConstant: 300),
      heightAnchor!,
      secondVC.view.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      
      
    ])
  }
  
  private func setupConstraints() {
    
    button.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(button)
    
    NSLayoutConstraint.activate([
      button.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
      button.centerXAnchor.constraint(equalTo: view.centerXAnchor)
      
    ])
  }
  
}

extension ViewController: ConstraintDelegate {
  
  func updateConstraint(int: CGFloat) {
    if int == 150 {
      
      self.heightAnchor?.constant = 150
      UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: [.curveEaseOut, .allowUserInteraction]) {
        
        self.view.layoutIfNeeded()
        
      }
      
    } else if int == 280 {
      
      self.heightAnchor?.constant = 280
      UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: [.curveEaseOut, .allowUserInteraction]) {
        
        self.view.layoutIfNeeded()
        
      }
    }
  }
  
}

//
//  ViewController.swift
//  SideMenuStudy
//
//  Created by Victor Magalhaes on 15/03/2018.
//  Copyright © 2018 Victor Magalhaes. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private let sideBar : UIVisualEffectView = {
        let mEffect = UIBlurEffect(style: UIBlurEffectStyle.regular)
        let mSideBar = UIVisualEffectView(effect: mEffect)
        mSideBar.backgroundColor = UIColor.red
        return mSideBar
    }()
    
    private let dragger : UIView = {
        let mDragger = UIView()
        mDragger.backgroundColor = UIColor.lightGray
        mDragger.clipsToBounds = true
        return mDragger
    }()
    
    private let menuRightBorder: UIView = {
        let mMenuRightBorder = UIView()
        mMenuRightBorder.backgroundColor = UIColor.lightGray
        mMenuRightBorder.clipsToBounds = true
        return mMenuRightBorder
    }()
    
    var image : UIImageView = {
        var mImage = UIImageView()
        mImage.image = UIImage(named: "perfil.001")
        mImage.clipsToBounds = true
        return mImage
    }()
    
    private let anyLabel : UILabel = {
        let mAnyLabel = UILabel()
        mAnyLabel.text = "Victor Magalhães"
        mAnyLabel.textColor = UIColor.white
        mAnyLabel.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        mAnyLabel.textAlignment = .center
        return mAnyLabel
    }()
    
    private let anyButton : UIButton = {
        let mAnyButton = UIButton(type: UIButtonType.system)
        mAnyButton.setTitle("Any Button", for: .normal)
        mAnyButton.tintColor = UIColor.white
        mAnyButton.clipsToBounds = true
        return mAnyButton
    }()
    
    
    var menuIsVisible = false
    var menuWidth: CGFloat = 0.5
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
        setupSideBarExhibition()
        
    }
    
    // ACTIONS
    
    @objc func buttonAction (){
        print("BUTTON CLICKED!")
    }
    
    @objc func hideSideBar(_ gesture: UISwipeGestureRecognizer) -> Void{
        if menuIsVisible {                                          //choose the best effect for you
            UIView.transition(with: view, duration: 0.15, options: .transitionCrossDissolve, animations: {
                self.sideBar.center.x -= self.view.frame.width * self.menuWidth
                self.dragger.center.x -= self.view.frame.width * self.menuWidth
                self.menuRightBorder.center.x -= self.view.frame.width * self.menuWidth
                
            }, completion: {(finished) in
                self.menuIsVisible = false
            })
            
        }
        
    }
    
    @objc func showSideBar(_ recognizer: UIScreenEdgePanGestureRecognizer) {
        if recognizer.state == .recognized {
            if recognizer.edges == .left{
                if !menuIsVisible{                                          //choose the best effect for you
                    UIView.transition(with: view, duration: 0.15, options: .transitionCrossDissolve, animations: {
                        self.sideBar.center.x += self.view.frame.width * self.menuWidth
                        self.dragger.center.x += self.view.frame.width * self.menuWidth
                        self.menuRightBorder.center.x += self.view.frame.width * self.menuWidth
                    }, completion: {(finished) in
                        self.menuIsVisible = true
                    })
                }
            }
        }
    }
    
    
    // LAYOUT SETUP
    
    //Detect gestures
    private func setupSideBarExhibition(){
        let openSideBar = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(showSideBar))
        openSideBar.edges = .left
        view.addGestureRecognizer(openSideBar)
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(hideSideBar))
        swipeLeft.direction = .left
        self.view.addGestureRecognizer(swipeLeft)
    }
    
    //Add and handle constraints
    private func setupLayout(){
        view.addSubview(dragger)
        dragger.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(sideBar)
        sideBar.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(menuRightBorder)
        menuRightBorder.translatesAutoresizingMaskIntoConstraints = false
        
        sideBar.contentView.addSubview(image)
        image.translatesAutoresizingMaskIntoConstraints = false
        
        sideBar.contentView.addSubview(anyButton)
        anyButton.translatesAutoresizingMaskIntoConstraints = false
        anyButton.addTarget(self, action: #selector(self.buttonAction), for: .touchUpInside)
        
        sideBar.contentView.addSubview(anyLabel)
        anyLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.sideBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: -CGFloat(view.frame.width * menuWidth)),
            self.sideBar.widthAnchor.constraint(equalToConstant: view.frame.width * menuWidth),
            self.sideBar.heightAnchor.constraint(equalToConstant: view.frame.height),
            self.sideBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            self.sideBar.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            self.dragger.leadingAnchor.constraint(equalTo: self.sideBar.trailingAnchor, constant: -CGFloat((view.frame.height * 0.15)/2)),
            self.dragger.widthAnchor.constraint(equalToConstant: self.view.frame.height * 0.1),
            self.dragger.heightAnchor.constraint(equalToConstant: self.view.frame.height * 0.1),
            self.dragger.centerYAnchor.constraint(equalTo: self.sideBar.centerYAnchor),
            
            self.menuRightBorder.trailingAnchor.constraint(equalTo: self.sideBar.trailingAnchor),
            self.menuRightBorder.widthAnchor.constraint(equalToConstant: self.view.frame.height * 0.01),
            self.menuRightBorder.heightAnchor.constraint(equalToConstant: self.view.frame.height),
            self.menuRightBorder.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            self.menuRightBorder.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            self.image.centerXAnchor.constraint(equalTo: self.sideBar.centerXAnchor, constant: -(self.view.frame.height * 0.01)),
            self.image.widthAnchor.constraint(equalToConstant: self.view.frame.height * 0.15),
            self.image.heightAnchor.constraint(equalToConstant: self.view.frame.height * 0.15),
            self.image.topAnchor.constraint(equalTo: self.sideBar.topAnchor, constant: 20),
            
            self.anyButton.trailingAnchor.constraint(equalTo: self.sideBar.trailingAnchor, constant: -(self.view.frame.height * 0.01) - 8 ),
            self.anyButton.leadingAnchor.constraint(equalTo: self.sideBar.leadingAnchor, constant: 8 ),
            self.anyButton.heightAnchor.constraint(equalToConstant: self.view.frame.height * 0.06),
            self.anyButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            
            self.anyLabel.trailingAnchor.constraint(equalTo: self.sideBar.trailingAnchor, constant: -(self.view.frame.height * 0.01) - 8 ),
            self.anyLabel.leadingAnchor.constraint(equalTo: self.sideBar.leadingAnchor, constant: 8 ),
            self.anyLabel.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 20)
            
            ])
        
        self.image.layer.cornerRadius = (view.frame.height * 0.15) / 2
        self.image.layer.borderColor = UIColor.white.cgColor
        self.image.layer.borderWidth = 2
        
        self.anyButton.layer.cornerRadius = 5
        self.anyButton.layer.borderColor = UIColor.white.cgColor
        self.anyButton.layer.borderWidth = 2
        
        self.dragger.layer.cornerRadius = (view.frame.height * 0.1) / 2
    }
    
    
}


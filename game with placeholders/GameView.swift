//
//  GameView.swift
//  game with placeholders
//
//  Created by Jpsmor on 19/09/22.
//

import UIKit

class GameView : UIView {
    
    let stopButton = UIButton()
    let startButton = UIButton()
    let gameBarView = UIView()
    let timeLabel = UILabel()
    let targetView = UIView()
    let cursorView = UIView()
    
    var targetPositionY: NSLayoutConstraint?
    var cursorPositionY: NSLayoutConstraint?
    var auxMovement: CGFloat = 1
    var movement: Timer?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setViewsHierarchy()
        setViewsAttributes()
        setContraints()
        setupAdditionalConfiguration()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setViewsHierarchy() {
        addSubview(stopButton)
        addSubview(startButton)
        addSubview(gameBarView)
        gameBarView.addSubview(targetView)
        addSubview(cursorView)
    }
    
    private func setViewsAttributes() {
        
        stopButton.backgroundColor = .blue
        stopButton.setTitle("Stop", for: .normal)
        stopButton.layer.cornerRadius = 25
        startButton.backgroundColor = .red
        startButton.setTitle("Start", for: .normal)
        startButton.layer.cornerRadius = 25
        
        gameBarView.backgroundColor = .systemPink
        gameBarView.layer.cornerRadius = 10
        targetView.backgroundColor = .systemOrange
        cursorView.backgroundColor = .brown
        
    }
    
    func setContraints() {
        stopButton.translatesAutoresizingMaskIntoConstraints = false
        startButton.translatesAutoresizingMaskIntoConstraints = false
        gameBarView.translatesAutoresizingMaskIntoConstraints = false
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        targetView.translatesAutoresizingMaskIntoConstraints = false
        cursorView.translatesAutoresizingMaskIntoConstraints = false
        
        
        targetPositionY = targetView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 0)
        
        targetPositionY!.isActive = true
        
        cursorPositionY = cursorView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 0)
        
        cursorPositionY!.isActive = true
        
        
        
        //Botões
        NSLayoutConstraint.activate([
            startButton.heightAnchor.constraint(equalToConstant: 50),
            startButton.widthAnchor.constraint(equalToConstant: 50),
            stopButton.heightAnchor.constraint(equalToConstant: 50),
            stopButton.widthAnchor.constraint(equalToConstant: 50),
            startButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20),
            stopButton.bottomAnchor.constraint(equalTo: startButton.topAnchor, constant: -20),
            startButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20),
            stopButton.centerXAnchor.constraint(equalTo: startButton.centerXAnchor)
        ])
        
        //Views
        NSLayoutConstraint.activate([
            gameBarView.centerXAnchor.constraint(equalTo: centerXAnchor),
            gameBarView.centerYAnchor.constraint(equalTo: centerYAnchor),
            gameBarView.heightAnchor.constraint(equalToConstant: 300),
            gameBarView.widthAnchor.constraint(equalToConstant: 30),
            targetView.centerXAnchor.constraint(equalTo: gameBarView.centerXAnchor),
            targetView.widthAnchor.constraint(equalToConstant: 30),
            targetView.heightAnchor.constraint(equalToConstant: 10),
            cursorView.widthAnchor.constraint(equalToConstant: 40),
            cursorView.heightAnchor.constraint(equalToConstant: 5),
            cursorView.centerXAnchor.constraint(equalTo: gameBarView.centerXAnchor)
        ])
        
    }
    
    func setupAdditionalConfiguration () {
        startButton.addTarget(self, action: #selector(tappedStart), for: .touchUpInside)
        stopButton.addTarget(self, action: #selector(tappedStop), for: .touchUpInside)
    }
    
    @objc func tappedStart(sender: UIButton) {
        
        guard movement == nil else { return }
        
        let targetPosition = Int.random(in: -135...135)
        targetPositionY?.constant = CGFloat(targetPosition)
        
        auxMovement = 1
        
        movement = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(cursorMovement), userInfo: nil, repeats: true)

        
    }
    
    @objc func tappedStop (sender: UIButton) {
        
        guard movement != nil else { return }
        
        movement?.invalidate()
          movement = nil
        if cursorPositionY!.constant >= targetPositionY!.constant - 10 && cursorPositionY!.constant <= targetPositionY!.constant + 10 {
            print("Ganhou")
        }
        else {
            print ("perdeu")
        }
        
    }
    
    @objc func cursorMovement () {
        
        if auxMovement == 0 {
            cursorPositionY!.constant += 1
            if cursorPositionY!.constant == 135 {
                auxMovement = 1
            }
        }
        else {
            cursorPositionY!.constant -= 1
            if cursorPositionY!.constant == -135 {
                auxMovement = 0
            }
        }
        
    }
   
    
}

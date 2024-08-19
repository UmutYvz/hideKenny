//
//  ViewController.swift
//  FirstApp
//
//  Created by Umut on 17.08.2024.
//

import UIKit

class ViewController: UIViewController {
    // UI Elements
    @IBOutlet var timerLabel: UILabel!
    @IBOutlet var scoreLabel: UILabel!
    @IBOutlet var highScoreLabel: UILabel!
    @IBOutlet var kenny1: UIImageView!
    @IBOutlet var kenny2: UIImageView!
    @IBOutlet var kenny3: UIImageView!
    @IBOutlet var kenny4: UIImageView!
    @IBOutlet var kenny5: UIImageView!
    @IBOutlet var kenny6: UIImageView!
    @IBOutlet var kenny7: UIImageView!
    @IBOutlet var kenny8: UIImageView!
    @IBOutlet var kenny9: UIImageView!

    // Variables
    var score = 0
    var highScore = 0
    var timeCounter = 0
    var timer = Timer()
    var hideTimer = Timer()
    var kennyArray = [UIImageView]()

    override func viewDidLoad() {
        super.viewDidLoad()
        setKennies()
        showOneKenny()
        checkHighScore()
        startTimer(countdown: 10)
    }

    func setKennies() {
        kenny1.isUserInteractionEnabled = true
        let tapRecognizer1 = UITapGestureRecognizer(target: self, action: #selector(changeScore))
        kenny1.addGestureRecognizer(tapRecognizer1)

        kenny2.isUserInteractionEnabled = true
        let tapRecognizer2 = UITapGestureRecognizer(target: self, action: #selector(changeScore))
        kenny2.addGestureRecognizer(tapRecognizer2)

        kenny3.isUserInteractionEnabled = true
        let tapRecognizer3 = UITapGestureRecognizer(target: self, action: #selector(changeScore))
        kenny3.addGestureRecognizer(tapRecognizer3)

        kenny4.isUserInteractionEnabled = true
        let tapRecognizer4 = UITapGestureRecognizer(target: self, action: #selector(changeScore))
        kenny4.addGestureRecognizer(tapRecognizer4)

        kenny5.isUserInteractionEnabled = true
        let tapRecognizer5 = UITapGestureRecognizer(target: self, action: #selector(changeScore))
        kenny5.addGestureRecognizer(tapRecognizer5)

        kenny6.isUserInteractionEnabled = true
        let tapRecognizer6 = UITapGestureRecognizer(target: self, action: #selector(changeScore))
        kenny6.addGestureRecognizer(tapRecognizer6)

        kenny7.isUserInteractionEnabled = true
        let tapRecognizer7 = UITapGestureRecognizer(target: self, action: #selector(changeScore))
        kenny7.addGestureRecognizer(tapRecognizer7)

        kenny8.isUserInteractionEnabled = true
        let tapRecognizer8 = UITapGestureRecognizer(target: self, action: #selector(changeScore))
        kenny8.addGestureRecognizer(tapRecognizer8)

        kenny9.isUserInteractionEnabled = true
        let tapRecognizer9 = UITapGestureRecognizer(target: self, action: #selector(changeScore))
        kenny9.addGestureRecognizer(tapRecognizer9)

        kennyArray = [kenny1, kenny2, kenny3, kenny4, kenny5, kenny6, kenny7, kenny8, kenny9]
    }

    func startTimer(countdown: Int) {
        timeCounter = countdown
        timerLabel.text = String(countdown)
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countDownTimer), userInfo: nil, repeats: true)
        hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(showOneKenny), userInfo: nil, repeats: true)
    }

    func checkHighScore() {
        let storedHighScore = UserDefaults.standard.object(forKey: "highscore")
        highScore = (storedHighScore ?? 0) as! Int
        highScoreLabel.text = "Highscore: \(highScore)"
    }

    func hideKennies() {
        for kenny in kennyArray {
            kenny.isHidden = true
        }
    }

    @objc func showOneKenny() {
        hideKennies()

        let random = Int(arc4random_uniform(UInt32(kennyArray.count - 1)))
        kennyArray[random].isHidden = false
    }

    @objc func changeScore() {
        score += 1
        scoreLabel.text = "Score: \(score)"
        showOneKenny()
    }

    @objc func countDownTimer() {
        timeCounter -= 1
        timerLabel.text = String(timeCounter)

        if timeCounter < 1 {
            timer.invalidate()
            hideTimer.invalidate()
            hideKennies()

            if score > highScore {
                highScore = score
                highScoreLabel.text = "Highscore: \(highScore)"

                UserDefaults.standard.setValue(highScore, forKey: "highscore")
            }

            let alert = UIAlertController(title: "Time is up!", message: "Do you want to play again?", preferredStyle: UIAlertController.Style.alert)
            let okButton = UIAlertAction(title: "OK!", style: UIAlertAction.Style.cancel, handler: nil)
            let replayButton = UIAlertAction(title: "Replay", style: UIAlertAction.Style.default) { [self] _ in
                score = 0
                scoreLabel.text = "Score: \(score)"
                startTimer(countdown: 10)
            }
            alert.addAction(okButton)
            alert.addAction(replayButton)
            present(alert, animated: true, completion: nil)
        }
    }
}

//
//  ViewController.swift
//  4week_DivisionGame
//
//  Created by sumin on 2021/10/04.
//

import UIKit
import AVFoundation

var soundEffect: AVAudioPlayer?

class ViewController: UIViewController {
    var mode: String? // Easy Mode or Hard Mode

    var imageArray: [UIImage] = [UIImage(named: "blueSheep.png")!, UIImage(named: "redStar.png")!, UIImage(named: "mintChicken.png")!, UIImage(named: "yellowPoodle.png")!]
    var imageEasyArray: [UIImage] = [UIImage(named: "blueSheep.png")!, UIImage(named: "redStar.png")!]
    var imageHardArray: [UIImage] = [UIImage(named: "mintChicken.png")!, UIImage(named: "yellowPoodle.png")!]
    var imageArrayCopy: [UIImage]!
    
    var countTimer: Timer?
    var counter: Int = 60 // 60sec로 설정.
    
    var score: Int = 0 // 0점 시작.
    
    @IBOutlet weak var timerUI: UILabel! // 좌측 상단 시간표시 uiLabel
    @IBOutlet weak var scoreUI: UILabel! // 우측 상단 점수표시 uiLabel
    
    @IBOutlet weak var leftStandard: UIImageView! // 왼쪽 판단 기준
    @IBOutlet weak var leftStandard2: UIImageView! // 왼쪽 판단 기준(하드모드 추가)
    @IBOutlet weak var rightStandard: UIImageView! // 오른쪽 판단 기준
    @IBOutlet weak var rightStandard2: UIImageView! // 오른쪽 판단 기준(하드모드 추가)
    
    @IBOutlet weak var queueElement1: UIImageView!
    @IBOutlet weak var queueElement2: UIImageView!
    @IBOutlet weak var queueElement3: UIImageView!
    @IBOutlet weak var queueElement4: UIImageView!
    @IBOutlet weak var queueElement5: UIImageView!
    
    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var rightButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        playBackgroundSound() // 음악 함수 실행
        
        leftButton.layer.cornerRadius = 10
        leftButton.layer.borderWidth = 1
        leftButton.layer.borderColor = UIColor.gray.cgColor
        
        rightButton.layer.cornerRadius = 10
        rightButton.layer.borderWidth = 1
        rightButton.layer.borderColor = UIColor.gray.cgColor
        
        leftStandard.layer.cornerRadius = 10
        leftStandard2.layer.cornerRadius = 10
        rightStandard.layer.cornerRadius = 10
        rightStandard2.layer.cornerRadius = 10
        
        queueElement1.layer.cornerRadius = 10
        queueElement2.layer.cornerRadius = 10
        queueElement3.layer.cornerRadius = 10
        queueElement4.layer.cornerRadius = 10
        queueElement5.layer.cornerRadius = 10
        
        if mode == "Hard" {
            setEasyStandard() // 좌,우측 이지모드 기준 설정 함수
            setHardStandard() // 좌, 우측 하드모드 기준 설정 함수
        }
        else if mode == "Easy" {
            setEasyStandard() // 좌,우측 이지모드 기준 설정 함수
            leftStandard2.removeFromSuperview() // 하드모드 이미지뷰 삭제
            rightStandard2.removeFromSuperview() // 하드모드 이미지뷰 삭제
        }
        
        self.countTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(changeTimerText), userInfo: nil, repeats: true) // 타이머 반복 실행
        
    }

    // MARK: - 왼쪽 버튼 클릭 : 좌측 하단
    @IBAction func clickLeftButton(_ sender: UIButton) {
        if mode == "Easy" {
            checkSame("left", "Easy") // 기준과 클릭한 버튼이 동일한지 체크.
        }
        else if mode == "Hard" {
            checkSame("left", "Hard") // 기준과 클릭한 버튼이 동일한지 체크.
        }
    }
    
    // MARK: - 오른쪽 버튼 클릭 : 우측 하단
    @IBAction func clickRightButton(_ sender: UIButton) {
        if mode == "Easy" {
            checkSame("right", "Easy") // 기준과 클릭한 버튼이 동일한지 체크.
        }
        else if mode == "Hard" {
            checkSame("right", "Hard") // 기준과 클릭한 버튼이 동일한지 체크.
        }
    }
    
    // MARK: - 기준과 동일한 버튼을 눌렀는지 체크하는 함수.
    func checkSame(_ direction: String, _ mode: String) {
        
        if mode == "Easy" { // 이지 모드
            if direction == "left" { // (이지모드) 왼쪽 버튼 체크.
                if leftStandard.image?.pngData() == self.queueElement1.image?.pngData() { // 좌측 기준과 맨밑이미지가 같다면,
                    score += 100 // 득점.
                    changeEasyQueueImage()
                    changeScoreText()
                    print("점수는 \(score)점")
                }
                else { // 틀렸다면 최종 결과로 이동.(score 전달해야함.)
                    endEffect() // 음악 정지, 타이머 종료(메모리 해제)
                    let finishVC = (self.storyboard?.instantiateViewController(withIdentifier: "FinishVC")) as! FinishViewController
                    finishVC.text = "\(String(score + (60 - counter)))점" // 점수 전달
                    self.navigationController?.pushViewController(finishVC, animated: true)
                }
            }
            else if direction == "right" { // (이지모드) 우측 버튼 체크.
                if rightStandard.image?.pngData() == queueElement1.image?.pngData() { // 우측 기준과 맨밑이미지가 같다면,
                    score += 100 // 득점.
                    changeEasyQueueImage()
                    changeScoreText()
                    print("점수는 \(score)점")
                }
                else { // 틀렸다면 최종 결과로 이동.(점수 전달해야함.)
                    endEffect() // 음악 정지, 타이머 종료(메모리 해제)
                    let finishVC = (self.storyboard?.instantiateViewController(withIdentifier: "FinishVC")) as! FinishViewController
                    finishVC.text = "\(String(score + (60 - counter)))점" // 점수 전달
                    self.navigationController?.pushViewController(finishVC, animated: true)
                }
            }
        }
        else if mode == "Hard" { // 하드 모드
            if direction == "left" { // (하드모드) 왼쪽 버튼 체크.
                if (leftStandard.image?.pngData() == self.queueElement1.image?.pngData()) || (leftStandard2.image?.pngData() == self.queueElement1.image?.pngData()) { // 좌측 기준1,2와 맨밑이미지가 같다면,
                    score += 150 // 득점.
                    changeHardQueueImage()
                    changeScoreText()
                    print("점수는 \(score)점")
                }
                else { // 틀렸다면 최종 결과로 이동.(score 전달해야함.)
                    endEffect() // 음악 정지, 타이머 종료(메모리 해제)
                    let finishVC = (self.storyboard?.instantiateViewController(withIdentifier: "FinishVC")) as! FinishViewController
                    finishVC.text = "\(String(score + (60 - counter)))점" // 점수 전달
                    self.navigationController?.pushViewController(finishVC, animated: true)
                }
            }
            else if direction == "right" { // (하드모드) 우측 버튼 체크.
                if ((rightStandard.image?.pngData() == self.queueElement1.image?.pngData())) || (rightStandard2.image?.pngData() == queueElement1.image?.pngData()) { // 우측 기준1,2와 맨밑이미지가 같다면,
                    score += 150 // 득점.
                    changeHardQueueImage()
                    changeScoreText()
                    print("점수는 \(score)점")
                }
                else { // 틀렸다면 최종 결과로 이동.(점수 전달해야함.)
                    endEffect() // 음악 정지, 타이머 종료(메모리 해제)
                    let finishVC = (self.storyboard?.instantiateViewController(withIdentifier: "FinishVC")) as! FinishViewController
                    finishVC.text = "\(String(score + (60 - counter)))점" // 점수 전달
                    self.navigationController?.pushViewController(finishVC, animated: true)
                }
            }
        }
        
        
        
    }
    
    // MARK: - 이지모드 queue 이미지 변경 함수.
    func changeEasyQueueImage() {
        DispatchQueue.global(qos: .userInitiated).async {
            DispatchQueue.main.async {
                self.queueElement1.image = self.queueElement2.image
                self.queueElement2.image = self.queueElement3.image
                self.queueElement3.image = self.queueElement4.image
                self.queueElement4.image = self.queueElement5.image
                self.queueElement5.image = self.imageEasyArray.randomElement()
            }
        }
    }
    
    // MARK: - 하드모드 queue 이미지 변경 함수.
    func changeHardQueueImage() {
        DispatchQueue.global(qos: .userInitiated).async {
            DispatchQueue.main.async {
                self.queueElement1.image = self.queueElement2.image
                self.queueElement2.image = self.queueElement3.image
                self.queueElement3.image = self.queueElement4.image
                self.queueElement4.image = self.queueElement5.image
                self.queueElement5.image = self.imageArray.randomElement()
            }
        }
    }
    
    // MARK: - score 텍스트 변경 함수.
    func changeScoreText() {
        DispatchQueue.global(qos: .userInitiated).async {
            DispatchQueue.main.async {
                self.scoreUI.text = "\(self.score)점"
            }
        }
    }
    
    
    // MARK: - 타이머 텍스트 변경 함수.
    @objc func changeTimerText() {
        if counter != 0 {
            let strCounter = String(format: "%02d", counter) // 형변환 - https://gonslab.tistory.com/36
            timerUI.text = "00:\(strCounter)"
            counter -= 1
        } else {
            endEffect() // 음악 정지, 타이머 종료(메모리 해제)
            print("Timer End")
            // 최종 결과로 이동.(점수 전달해야함.)
            let finishVC = (self.storyboard?.instantiateViewController(withIdentifier: "FinishVC")) as! FinishViewController
            finishVC.text = "\(String(score + (60 - counter)))점" // 점수 전달
            self.navigationController?.pushViewController(finishVC, animated: true)
        }
    }
    
    // MARK: - 좌,우측 이지모드 기준 이미지 설정 함수.
    func setEasyStandard() {
        imageArrayCopy = imageEasyArray // 카피 어레이에 복사.
        leftStandard.image = imageArrayCopy?.randomElement()
        
        for i in 0..<imageArrayCopy.count { // 기준은 이미지당 하나씩 - 이미 사용된 이미지는 삭제.
            if leftStandard.image == imageArrayCopy[i] {
                imageArrayCopy.remove(at: i)
                break
            }
        }
        rightStandard.image = imageArrayCopy.randomElement() // 다른 기준에 새로운 이미지 할당.
        
    }
    
    // MARK: - 좌,우측 하드모드 기준 이미지 설정 함수.
    func setHardStandard() {
        imageArrayCopy = imageHardArray // 카피 어레이에 복사.
        leftStandard2.image = imageArrayCopy?.randomElement()
        
        for i in 0..<imageArrayCopy.count { // 기준은 이미지당 하나씩 - 이미 사용된 이미지는 삭제.
            if leftStandard2.image == imageArrayCopy[i] {
                imageArrayCopy.remove(at: i)
                break
            }
        }
        rightStandard2.image = imageArrayCopy.randomElement() // 다른 기준에 새로운 이미지 할당.
    }

    // MARK: - 음악 실행 함수.
    func playBackgroundSound() {
        // ▬▬▬▬▬사용하시려면 아래의 출처를 남겨주셔야 합니다▬▬▬▬▬▬
        // 🎵Music provided by 브금대통령
        // 🎵Track : 귀여운 BGM 모음 - https://youtu.be/hgNrf9QqAA0
        // ▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬
        let url = Bundle.main.url(forResource: "뒤뚱뒤뚱", withExtension: "mp3")
            if let url = url{
                do {
                    soundEffect = try AVAudioPlayer(contentsOf: url)
                    soundEffect!.prepareToPlay()
                    soundEffect!.play()

                } catch let error {
                    print(error.localizedDescription)

                }

            }
    }

    // MARK: - 뒤로가기 버튼 클릭 : 좌측 상단
    @IBAction func clickBackButton(_ sender: UIButton) {
        endEffect() // 음악 정지, 타이머 종료(메모리 해제)
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - 게임화면에서 벗어날 때 : 음악 정지, 타이머 종료(메모리 해제)
    func endEffect() {
        soundEffect?.stop() // 음악 정지
        countTimer?.invalidate() // 타이머 종료
        countTimer = nil // 타이머 메모리 해제
    }
    
}


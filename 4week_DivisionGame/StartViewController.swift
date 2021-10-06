//
//  StartViewController.swift
//  4week_DivisionGame
//
//  Created by sumin on 2021/10/04.
//

import UIKit

class StartViewController: UIViewController {

    @IBOutlet weak var easyButton: UIButton!
    @IBOutlet weak var hardButton: UIButton!
    
    @IBOutlet weak var stackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        easyButton.layer.cornerRadius = 10
        easyButton.layer.borderWidth = 1
        easyButton.layer.borderColor = UIColor.gray.cgColor
        
        hardButton.layer.cornerRadius = 10
        hardButton.layer.borderWidth = 1
        hardButton.layer.borderColor = UIColor.gray.cgColor
    }
    
    // 참고 : https://faith-developer.tistory.com/31
    // StartVC에선 네비게이션바가 안보이게 하고,
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        
        // 애니메이션 - https://velog.io/@kerri/iOS-Swift-Bounce-Animation-%EA%B5%AC%ED%98%84%ED%95%98%EA%B8%B0-g1wzu4ur
        stackView.center.x = self.view.frame.width + 30
        UIView.animate(withDuration: 1.5, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 30, options: [], animations: {
            self.stackView.center.x = self.view.frame.width / 2
        }, completion: nil)
    }
    // gameVC에선 네비게이션바가 보이게 설정.
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    @IBAction func clickEasyButton(_ sender: UIButton) {
        let gameVC = (self.storyboard?.instantiateViewController(withIdentifier: "MainVC"))! as! ViewController
        gameVC.mode = "Easy"
        self.navigationController?.pushViewController(gameVC, animated: true)
    }
    
    @IBAction func clickHardMode(_ sender: UIButton) {
        let gameVC = (self.storyboard?.instantiateViewController(withIdentifier: "MainVC"))! as! ViewController
        gameVC.mode = "Hard"
        self.navigationController?.pushViewController(gameVC, animated: true)
    }
    
    // segue 쓸 필요 없을 듯.
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "hardMode" {
//            let modeDetail = segue.destination as? ViewController
//            modeDetail!.mode = "hardMode"
//        }
//    }
    
}

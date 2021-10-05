//
//  StartViewController.swift
//  4week_DivisionGame
//
//  Created by sumin on 2021/10/04.
//

import UIKit

class StartViewController: UIViewController {

    @IBOutlet weak var startButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        startButton.layer.cornerRadius = 10
        startButton.layer.borderWidth = 1
        startButton.layer.borderColor = UIColor.gray.cgColor
    }
    
    // 참고 : https://faith-developer.tistory.com/31
    // StartVC에선 네비게이션바가 안보이게 하고,
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    // gameVC에선 네비게이션바가 보이게 설정.
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    @IBAction func ClickStartButton(_ sender: UIButton) {
        let gameVC = (self.storyboard?.instantiateViewController(withIdentifier: "MainVC"))!
        self.navigationController?.pushViewController(gameVC, animated: true)
    }
    
}

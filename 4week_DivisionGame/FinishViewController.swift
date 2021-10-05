//
//  FinishViewController.swift
//  4week_DivisionGame
//
//  Created by sumin on 2021/10/05.
//

import UIKit

class FinishViewController: UIViewController {

    
    @IBOutlet weak var scoreLabel: UILabel!
    var text: String = ""
    
    @IBOutlet weak var replayButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        scoreLabel.text = text
        replayButton.layer.cornerRadius = 10
        replayButton.layer.borderWidth = 1
        replayButton.layer.borderColor = UIColor.gray.cgColor
    }
    
    
    // MARK: - FinishVC에선 네비게이션바가 안보이게 설정.
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    // MARK: - 도움말 버튼 클릭 시 : 최종 점수 선정 기준 표시.
    @IBAction func questionMarkClick(_ sender: UIButton) {
        let msg = "\n최종점수 = 획득 점수 + 게임 진행 시간"
        let alert = UIAlertController(title: "최종 점수 계산식", message: msg, preferredStyle: UIAlertController.Style.alert)
        let ok = UIAlertAction(title: "OK", style: .default) {(action) in}
        alert.addAction(ok)
        present(alert, animated: false, completion: nil)
    }
    
    // MARK: - 다시하기 버튼 클릭 시 : 첫 화면으로 돌아감.
    @IBAction func clickReplayButton(_ sender: UIButton) {
        self.navigationController?.popToRootViewController(animated: true)
    }
}

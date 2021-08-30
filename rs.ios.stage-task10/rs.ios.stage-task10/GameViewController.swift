//
//  GameViewController.swift
//  rs.ios.stage-task10
//
//  Created by Albert Zhloba on 29.08.21.
//

import UIKit

class GameViewController: UIViewController {
    static var scoreString = "0"
    static var indexPathGlobal: IndexPath = []
    var redoArray: [(String, IndexPath)] = []
    
    var timer: Timer = Timer()
    var count: Int = 0
    var timerCounting: Bool = false
    private let sectionInsets = UIEdgeInsets(top: 0, left: 60, bottom: 0, right: 60)

    fileprivate let titleHeader:UILabel = {
        let tl = UILabel()
        tl.text = "Game"
        tl.translatesAutoresizingMaskIntoConstraints = false
        tl.textAlignment = .left
        tl.textColor = .white
        tl.font = UIFont(name: "Nunito-ExtraBold", size: 36)
        tl.numberOfLines = 0
        tl.lineBreakMode = .byClipping
        
        return tl
    }()
    
    fileprivate let button: UIButton = {
        let bt = UIButton()
        
        bt.setImage(UIImage(named: "icon_Dice.png"), for: .normal)
        bt.translatesAutoresizingMaskIntoConstraints = false
        bt.addTarget(self, action: #selector(rollAction), for: .touchUpInside)

        return bt
    }()
    
    fileprivate let timerLabel:UILabel = {
        let tl = UILabel()
        tl.text = "00:00"
        tl.translatesAutoresizingMaskIntoConstraints = false
        tl.textAlignment = .left
        tl.textColor = UIColor(red: 0.231, green: 0.231, blue: 0.231, alpha: 1)
        tl.font = UIFont(name: "Nunito-ExtraBold", size: 28)
        tl.numberOfLines = 0
        tl.lineBreakMode = .byClipping
        
        return tl
    }()
    
    fileprivate let timerButton: UIButton = {
        let bt = UIButton()
        
        bt.setImage(UIImage(named: "Play.png"), for: .normal)
        bt.translatesAutoresizingMaskIntoConstraints = false
        bt.addTarget(self, action: #selector(timerButtonAction), for: .touchUpInside)

        return bt
    }()
    
    fileprivate let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
       // layout.itemSize = .init(width: 255, height: 300)
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(GameCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        
        return cv
    }()
    
    fileprivate let backCellButton: UIButton = {
        let bt = UIButton()
        
        bt.setImage(UIImage(named: "icon_Next-2.png"), for: .normal)
        bt.translatesAutoresizingMaskIntoConstraints = false
        bt.addTarget(self, action: #selector(backCellAction), for: .touchUpInside)

        return bt
    }()
    
    fileprivate let nextCellButton: UIButton = {
        let bt = UIButton()
        
        bt.setImage(UIImage(named: "icon_Next.png"), for: .normal)
        bt.translatesAutoresizingMaskIntoConstraints = false
        bt.addTarget(self, action: #selector(nextCellAction), for: .touchUpInside)

        return bt
    }()
    
    fileprivate let plus1Button: UIButton = {
        let bt = UIButton()
        
        bt.setTitle("+1", for: .normal)
        bt.setTitleColor(UIColor.white, for: .normal)
        bt.backgroundColor = UIColor(red: 0.518, green: 0.722, blue: 0.678, alpha: 1)
        bt.layer.cornerRadius = 39
        bt.tag = 1
        bt.titleLabel?.font = UIFont(name: "Nunito-ExtraBold", size: 40)
        bt.titleLabel?.textAlignment = .center
        bt.titleLabel?.layer.shadowColor = UIColor(red: 0.329, green: 0.471, blue: 0.435, alpha: 1).cgColor
        bt.titleLabel?.layer.shadowOffset = CGSize(width: 0, height: 2)
        bt.titleLabel?.layer.shadowRadius = 0
        bt.titleLabel?.layer.shadowOpacity = 1
        
        bt.translatesAutoresizingMaskIntoConstraints = false
        bt.addTarget(self, action: #selector(plusMinusAction), for: .touchUpInside)

        return bt
    }()
    
    fileprivate let minus10Button: UIButton = {
        let bt = UIButton()
        
        bt.setTitle("-10", for: .normal)
        bt.setTitleColor(UIColor.white, for: .normal)
        bt.backgroundColor = UIColor(red: 0.518, green: 0.722, blue: 0.678, alpha: 1)
        bt.layer.cornerRadius = 23
        bt.tag = 2
        bt.titleLabel?.font = UIFont(name: "Nunito-ExtraBold", size: 20)
        bt.titleLabel?.textAlignment = .center
        bt.titleLabel?.layer.shadowColor = UIColor(red: 0.329, green: 0.471, blue: 0.435, alpha: 1).cgColor
        bt.titleLabel?.layer.shadowOffset = CGSize(width: 0, height: 2)
        bt.titleLabel?.layer.shadowRadius = 0
        bt.titleLabel?.layer.shadowOpacity = 1
        
        bt.translatesAutoresizingMaskIntoConstraints = false
        bt.addTarget(self, action: #selector(plusMinusAction), for: .touchUpInside)

        return bt
    }()
    
    fileprivate let minus5Button: UIButton = {
        let bt = UIButton()
        
        bt.setTitle("-5", for: .normal)
        bt.setTitleColor(UIColor.white, for: .normal)
        bt.backgroundColor = UIColor(red: 0.518, green: 0.722, blue: 0.678, alpha: 1)
        bt.layer.cornerRadius = 23
        bt.tag = 3
        bt.titleLabel?.font = UIFont(name: "Nunito-ExtraBold", size: 20)
        bt.titleLabel?.textAlignment = .center
        bt.titleLabel?.layer.shadowColor = UIColor(red: 0.329, green: 0.471, blue: 0.435, alpha: 1).cgColor
        bt.titleLabel?.layer.shadowOffset = CGSize(width: 0, height: 2)
        bt.titleLabel?.layer.shadowRadius = 0
        bt.titleLabel?.layer.shadowOpacity = 1
        
        bt.translatesAutoresizingMaskIntoConstraints = false
        bt.addTarget(self, action: #selector(plusMinusAction), for: .touchUpInside)

        return bt
    }()
    
    fileprivate let minus1Button: UIButton = {
        let bt = UIButton()
        
        bt.setTitle("-1", for: .normal)
        bt.setTitleColor(UIColor.white, for: .normal)
        bt.backgroundColor = UIColor(red: 0.518, green: 0.722, blue: 0.678, alpha: 1)
        bt.layer.cornerRadius = 23
        bt.tag = 4
        bt.titleLabel?.font = UIFont(name: "Nunito-ExtraBold", size: 20)
        bt.titleLabel?.textAlignment = .center
        bt.titleLabel?.layer.shadowColor = UIColor(red: 0.329, green: 0.471, blue: 0.435, alpha: 1).cgColor
        bt.titleLabel?.layer.shadowOffset = CGSize(width: 0, height: 2)
        bt.titleLabel?.layer.shadowRadius = 0
        bt.titleLabel?.layer.shadowOpacity = 1
        
        bt.translatesAutoresizingMaskIntoConstraints = false
        bt.addTarget(self, action: #selector(plusMinusAction), for: .touchUpInside)

        return bt
    }()
    
    fileprivate let plus5Button: UIButton = {
        let bt = UIButton()
        
        bt.setTitle("+5", for: .normal)
        bt.setTitleColor(UIColor.white, for: .normal)
        bt.backgroundColor = UIColor(red: 0.518, green: 0.722, blue: 0.678, alpha: 1)
        bt.layer.cornerRadius = 23
        bt.tag = 5
        bt.titleLabel?.font = UIFont(name: "Nunito-ExtraBold", size: 20)
        bt.titleLabel?.textAlignment = .center
        bt.titleLabel?.layer.shadowColor = UIColor(red: 0.329, green: 0.471, blue: 0.435, alpha: 1).cgColor
        bt.titleLabel?.layer.shadowOffset = CGSize(width: 0, height: 2)
        bt.titleLabel?.layer.shadowRadius = 0
        bt.titleLabel?.layer.shadowOpacity = 1
        
        bt.translatesAutoresizingMaskIntoConstraints = false
        bt.addTarget(self, action: #selector(plusMinusAction), for: .touchUpInside)

        return bt
    }()
    
    fileprivate let plus10Button: UIButton = {
        let bt = UIButton()
        
        bt.setTitle("+10", for: .normal)
        bt.setTitleColor(UIColor.white, for: .normal)
        bt.backgroundColor = UIColor(red: 0.518, green: 0.722, blue: 0.678, alpha: 1)
        bt.layer.cornerRadius = 23
        bt.tag = 6
        bt.titleLabel?.font = UIFont(name: "Nunito-ExtraBold", size: 20)
        bt.titleLabel?.textAlignment = .center
        bt.titleLabel?.layer.shadowColor = UIColor(red: 0.329, green: 0.471, blue: 0.435, alpha: 1).cgColor
        bt.titleLabel?.layer.shadowOffset = CGSize(width: 0, height: 2)
        bt.titleLabel?.layer.shadowRadius = 0
        bt.titleLabel?.layer.shadowOpacity = 1
        
        bt.translatesAutoresizingMaskIntoConstraints = false
        bt.addTarget(self, action: #selector(plusMinusAction), for: .touchUpInside)

        return bt
    }()
    
    fileprivate let undoButton: UIButton = {
        let bt = UIButton()
        
        bt.setImage(UIImage(named: "Vector.png"), for: .normal)
        bt.translatesAutoresizingMaskIntoConstraints = false
        bt.addTarget(self, action: #selector(undoAction), for: .touchUpInside)

        return bt
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }
    
    func setupView(){
        
        view.addSubview(titleHeader)
        view.addSubview(button)
        view.addSubview(timerLabel)
        view.addSubview(timerButton)
        view.addSubview(collectionView)
        view.addSubview(plus1Button)
        view.addSubview(backCellButton)
        view.addSubview(nextCellButton)
        view.addSubview(minus10Button)
        view.addSubview(minus5Button)
        view.addSubview(minus1Button)
        view.addSubview(plus5Button)
        view.addSubview(plus10Button)
        view.addSubview(undoButton)
        
        if redoArray.isEmpty{
            undoButton.isEnabled = false
        }
        
        let backButton = UIBarButtonItem(title: "New Game", style: .plain, target: self, action: #selector(newgameTapped))
        backButton.setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "Nunito-ExtraBold", size: 17)!], for: .normal)
        navigationItem.leftBarButtonItem = backButton
        
        let addButton = UIBarButtonItem(title: "Results", style: .plain, target: self, action: #selector(resultsTapped))
        addButton.setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "Nunito-ExtraBold", size: 17)!], for: .normal)
        navigationItem.rightBarButtonItem = addButton
    
        setupconstraint()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor(red: 0.136, green: 0.136, blue: 0.138, alpha: 1)
    }
    
    @objc func rollAction(){
        
    }
    
    @objc func backCellAction(){
        var visibleRect = CGRect()
        visibleRect.origin = collectionView.contentOffset
        visibleRect.size = collectionView.bounds.size
        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
        guard let indexPath = collectionView.indexPathForItem(at: visiblePoint) else { return }
        if (indexPath.row < ViewController.gamersArray.count + 1)
        {let nextItem = NSIndexPath(row: indexPath.row - 1, section: 0)
            collectionView.scrollToItem(at: nextItem as IndexPath, at: .centeredHorizontally, animated: true)}
    }
    
    @objc func nextCellAction(){
        var visibleRect = CGRect()
        visibleRect.origin = collectionView.contentOffset
        visibleRect.size = collectionView.bounds.size
        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
        guard let indexPath = collectionView.indexPathForItem(at: visiblePoint) else { return }
        if (indexPath.row < ViewController.gamersArray.count)
        {let nextItem = NSIndexPath(row: indexPath.row + 1, section: 0)
            collectionView.scrollToItem(at: nextItem as IndexPath, at: .centeredHorizontally, animated: true)}
    }
    
    @objc func plusMinusAction(sender: UIButton){
        if GameViewController.indexPathGlobal.isEmpty {
            GameViewController.indexPathGlobal = [0, 0]
        }
        
        guard let cell = collectionView.cellForItem(at: GameViewController.indexPathGlobal) as? GameCollectionViewCell else {return}
        
        GameViewController.scoreString = cell.score.text!
        var scoreInt = Int(GameViewController.scoreString)
        if(sender.tag == 1){
            scoreInt = scoreInt! + 1
        }
        if(sender.tag == 2){
            scoreInt = scoreInt! - 10
        }
        if(sender.tag == 3){
            scoreInt = scoreInt! - 5
        }
        if(sender.tag == 4){
            scoreInt = scoreInt! - 1
        }
        if(sender.tag == 5){
            scoreInt = scoreInt! + 5
        }
        if(sender.tag == 6){
            scoreInt = scoreInt! + 10
        }
        if let sss = scoreInt {
            GameViewController.scoreString = "\(sss)"
        }
        if let xxx = Int(GameViewController.scoreString) {
            cell.score.text = "\(xxx)"
        }
        if !redoArray.isEmpty && !redoArray.contains(where: { $0.0 == "0" && $0.1 == GameViewController.indexPathGlobal }){
            redoArray.append(("0", GameViewController.indexPathGlobal))
        }
        redoArray.append((GameViewController.scoreString, GameViewController.indexPathGlobal))
        if !redoArray.isEmpty{
            undoButton.isEnabled = true
        }
        print(redoArray)
    }
    
    @objc func undoAction(){
        if redoArray.isEmpty{
            undoButton.isEnabled = false
        }
        else {
            undoButton.isEnabled = true
            guard let cell = collectionView.cellForItem(at: redoArray.last?.1 ?? [0,0]) as? GameCollectionViewCell else {return}
            redoArray.removeLast()
            
            print(redoArray)
            cell.score.text = redoArray.last?.0 ?? "0"
            if redoArray.last?.0 == "0"{
                redoArray.removeLast()
            }
            if redoArray.isEmpty{
                undoButton.isEnabled = false
            }
        }
    }
    
    @objc func newgameTapped(){
        let newGameVC = ViewController()
        newGameVC.modalPresentationStyle = .overCurrentContext
        newGameVC.modalTransitionStyle = .flipHorizontal
        let backButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelTapped))
        backButton.setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "Nunito-ExtraBold", size: 17)!], for: .normal)
        newGameVC.navigationItem.leftBarButtonItem = backButton
        let nav = UINavigationController(rootViewController: newGameVC)
        nav.navigationBar.barTintColor = UIColor(red: 0.137, green: 0.137, blue: 0.137, alpha: 1)
        self.present(nav, animated: true, completion: nil)
        
    }
    
    @objc func resultsTapped(){
        
    }
    
    @objc func cancelTapped(){
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func timerButtonAction(){
        if(timerCounting){
            timerCounting = false
            timer.invalidate()
            timerButton.setImage(UIImage(named: "Play.png"), for: .normal)
            timerLabel.textColor = UIColor(red: 0.231, green: 0.231, blue: 0.231, alpha: 1)
        }
        else {
            timerCounting = true
            timerButton.setImage(UIImage(named: "Pause.png"), for: .normal)
            timerLabel.textColor = UIColor.white
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerCounter), userInfo: nil, repeats: true)
        }
    }
    
    @objc func timerCounter(){
        count = count + 1
        let time = secondsToSecondsMinutes(seconds: count)
        let timeString = makeTimeString(minutes: time.0, seconds: time.1)
        timerLabel.text = timeString
    }
    
    func secondsToSecondsMinutes (seconds: Int) ->(Int, Int){
        return ((seconds / 60), (seconds % 60))
    }
    
    func makeTimeString(minutes: Int, seconds: Int)-> String{
        var timeString = ""
        timeString += String(format: "%02d", minutes)
        timeString += ":"
        timeString += String(format: "%02d", seconds)
        return timeString
    }

    func setupconstraint(){
        
        titleHeader.topAnchor.constraint(equalTo: view.topAnchor, constant: 12).isActive = true
        titleHeader.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        titleHeader.widthAnchor.constraint(equalToConstant: 98).isActive = true
        titleHeader.heightAnchor.constraint(equalToConstant: 41).isActive = true
        
        button.topAnchor.constraint(equalTo: view.topAnchor, constant: 14).isActive = true
        button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        button.widthAnchor.constraint(equalToConstant: 30).isActive = true
        button.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        timerLabel.topAnchor.constraint(equalTo: titleHeader.bottomAnchor, constant: 8).isActive = true
        timerLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        timerLabel.widthAnchor.constraint(equalToConstant: 75).isActive = true
        timerLabel.heightAnchor.constraint(equalToConstant: 41).isActive = true
        
        timerButton.topAnchor.constraint(equalTo: titleHeader.bottomAnchor, constant: 18).isActive = true
        timerButton.leadingAnchor.constraint(equalTo: timerLabel.leadingAnchor, constant: 95).isActive = true
        timerButton.widthAnchor.constraint(equalToConstant: 16).isActive = true
        timerButton.heightAnchor.constraint(equalToConstant: 21).isActive = true
        
        collectionView.topAnchor.constraint(equalTo: timerLabel.bottomAnchor, constant: 18).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        collectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: plus1Button.topAnchor, constant: -17).isActive = true
        
        plus1Button.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -125).isActive = true
        plus1Button.widthAnchor.constraint(equalToConstant: 78).isActive = true
        plus1Button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        plus1Button.heightAnchor.constraint(equalToConstant: 78).isActive = true
        
        backCellButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -149).isActive = true
        backCellButton.widthAnchor.constraint(equalToConstant: 34).isActive = true
        backCellButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 46).isActive = true
        backCellButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        nextCellButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -149).isActive = true
        nextCellButton.widthAnchor.constraint(equalToConstant: 34).isActive = true
        nextCellButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -46).isActive = true
        nextCellButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        minus1Button.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -65).isActive = true
        minus1Button.widthAnchor.constraint(equalToConstant: 46).isActive = true
        minus1Button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        minus1Button.heightAnchor.constraint(equalToConstant: 46).isActive = true
        
        minus5Button.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -65).isActive = true
        minus5Button.widthAnchor.constraint(equalToConstant: 46).isActive = true
        minus5Button.trailingAnchor.constraint(equalTo: minus1Button.leadingAnchor, constant: -26).isActive = true
        minus5Button.heightAnchor.constraint(equalToConstant: 46).isActive = true
        
        plus5Button.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -65).isActive = true
        plus5Button.widthAnchor.constraint(equalToConstant: 46).isActive = true
        plus5Button.leadingAnchor.constraint(equalTo: minus1Button.trailingAnchor, constant: 26).isActive = true
        plus5Button.heightAnchor.constraint(equalToConstant: 46).isActive = true
        
        minus10Button.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -65).isActive = true
        minus10Button.widthAnchor.constraint(equalToConstant: 46).isActive = true
        minus10Button.trailingAnchor.constraint(equalTo: minus5Button.leadingAnchor, constant: -26).isActive = true
        minus10Button.heightAnchor.constraint(equalToConstant: 46).isActive = true
        
        plus10Button.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -65).isActive = true
        plus10Button.widthAnchor.constraint(equalToConstant: 46).isActive = true
        plus10Button.leadingAnchor.constraint(equalTo: plus5Button.trailingAnchor, constant: 26).isActive = true
        plus10Button.heightAnchor.constraint(equalToConstant: 46).isActive = true
        
        undoButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -25).isActive = true
        undoButton.widthAnchor.constraint(equalToConstant: 15).isActive = true
        undoButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40).isActive = true
        undoButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension GameViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ViewController.gamersArray[0].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! GameCollectionViewCell
        cell.data = ViewController.gamersArray[0][indexPath.row].uppercased()
        cell.backgroundColor = UIColor(red: 0.231, green: 0.231, blue: 0.231, alpha: 1)
        cell.layer.cornerRadius = 15
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding = CGFloat(340)
        let availableHeight = view.frame.height - padding
        //let widthPerItem = availableWidth / itemsPerRow
        
        return CGSize(width: 255, height: availableHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        var visibleRect = CGRect()
        visibleRect.origin = collectionView.contentOffset
        visibleRect.size = collectionView.bounds.size
        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
        guard let indexPath = collectionView.indexPathForItem(at: visiblePoint) else { return }
        GameViewController.indexPathGlobal = indexPath
        //print(GameViewController.indexPathGlobal)
        
        //print(GameViewController.scoreString)
    }
}

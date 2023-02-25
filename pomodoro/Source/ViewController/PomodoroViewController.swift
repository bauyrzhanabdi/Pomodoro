import UIKit
import SnapKit

final class PomodoroViewController: UIViewController {
    // MARK: - Properties
    private lazy var isWorkTime: Bool = true
    private lazy var isStarted: Bool = false
    private lazy var isActive: Bool = false
    private lazy var workingColor: UIColor = .red
    private lazy var relaxingColor: UIColor = .orange
    private lazy var timer: Timer? = nil
    private lazy var milliseconds: TimeInterval = 0
    private lazy var timeRemaining: TimeInterval = 25
    private let totalTime: TimeInterval = 25
    
    
    // MARK: - Outlets
    private lazy var countdownLabel: UILabel = UILabel(
        text: get(time: timeRemaining),
        allignment: .center,
        color: isWorkTime ? workingColor : relaxingColor,
        fontSize: 50,
        fontWeight: 0
    )
    
    private lazy var timerControlButton: UIButton = UIButton(
        image: isStarted ? "pause" : "play",
        imageColor: isWorkTime ? workingColor : relaxingColor,
        backgroundColor: .clear,
        action: #selector(timerControlButtonPressed),
        target: self
    )
    
    private lazy var circularProgressBar: CircularProgressBar = {
        let circularProgressBar = CircularProgressBar()
        circularProgressBar.center = view.center
        return circularProgressBar
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupHierarchy()
        setupLayout()
    }
    
    // MARK: - Setup
    private func setupHierarchy() {
        view.addSubview(circularProgressBar)
        view.addSubview(countdownLabel)
        view.addSubview(timerControlButton)
    }
    
    private func setupLayout() {
        countdownLabel.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.centerY.equalTo(view)
        }
        
        timerControlButton.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.top.equalTo(countdownLabel.snp.bottom).offset(20)
            make.width.equalTo(50)
            make.height.equalTo(50)
        }
    }
    
    // MARK: - Methods
    private func startTimer() {
        timer = Timer.scheduledTimer(
            timeInterval: 0.001,
            target: self,
            selector: #selector(updateTime),
            userInfo: nil,
            repeats: true
        )
    }
    
    private func pauseTimer() {
        if let timer = timer {
            if timer.isValid {
                timer.invalidate()
                return
            }
            startTimer()
        }
    }
    
    private func endTimer() {
        if timeRemaining == 0 {
            timer?.invalidate()
            timer = nil
            changeState()
        }
    }
    
    private func changeState() {
        isWorkTime.toggle()
        isStarted.toggle()
        isActive.toggle()
        let image = isStarted ? "pause" : "play"
        timerControlButton.setImage(UIImage(systemName: image), for: .normal)
        timeRemaining = !isWorkTime ? 5 : 25
        !isWorkTime ? changeVisual(color: relaxingColor) : changeVisual(color: workingColor)
    }
    
    private func changeVisual(color: UIColor) {
        countdownLabel.text = get(time: timeRemaining)
        countdownLabel.textColor = color
        timerControlButton.tintColor = color
        circularProgressBar.changeProgressBarColor(
            state: isWorkTime,
            relaxingColor: relaxingColor,
            workingColor: workingColor
        )
    }
    
    private func get(time: TimeInterval) -> String {
        let minutes = Int(time.rounded()) / 60
        let seconds = Int(time.rounded()) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }

    // MARK: - Actions
    @objc private func timerControlButtonPressed(_ sender: UIButton) {
        isStarted.toggle()
        isStarted ? startTimer() : pauseTimer()
        let image = isStarted ? "pause" : "play"
        sender.setImage(UIImage(systemName: image), for: .normal)
        if !isActive {
            circularProgressBar.animateProgress(duration: timeRemaining)
            isActive.toggle()
        }
        !isStarted ? circularProgressBar.pauseProgress() : circularProgressBar.resumeProgress()
    }
    
    @objc private func updateTime() {
        if milliseconds < 1000 {
            milliseconds += 1
            return
        }
        
        timeRemaining -= 1
        milliseconds = 0
        countdownLabel.text = get(time: timeRemaining)
        endTimer()
    }
    
}


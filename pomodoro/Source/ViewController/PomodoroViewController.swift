import UIKit
import SnapKit

class PomodoroViewController: UIViewController {
    // MARK: - Parameters
    private lazy var isWorkTime: Bool = true
    private lazy var isStarted: Bool = false
    private lazy var timer: Timer? = nil
    private var timeInSeconds: Int = 25
    
    // MARK: - Outlets
    private lazy var countdownLabel: UILabel = UILabel(
        text: get(time: timeInSeconds),
        allignment: .center,
        color: isWorkTime ? .red : .green,
        fontSize: 50,
        fontWeight: 0
    )
    
    private lazy var timerControlButton: UIButton = UIButton(
        image: isStarted ? "pause" : "play",
        imageColor: isWorkTime ? .red : .green,
        backgroundColor: .clear,
        action: #selector(timerControlButtonPressed),
        target: self
    )
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupHierarchy()
        setupLayout()
    }
    
    // MARK: - Setup
    private func setupHierarchy() {
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
            timeInterval: 1.0,
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
        if timeInSeconds == 0 {
            timer?.invalidate()
            timer = nil
            changeState()
        }
    }
    
    private func changeState() {
        isWorkTime.toggle()
        isStarted.toggle()
        let image = isStarted ? "pause" : "play"
        timerControlButton.setImage(UIImage(systemName: image), for: .normal)
        timeInSeconds = !isWorkTime ? 5 : 25
        !isWorkTime ? changeVisual(color: .green) : changeVisual(color: .red)
    }
    
    private func changeVisual(color: UIColor) {
        countdownLabel.text = get(time: timeInSeconds)
        countdownLabel.textColor = color
        timerControlButton.tintColor = color
    }
    
    private func get(time: Int) -> String {
        let minutes = time / 60
        let seconds = time % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }

    // MARK: - Actions
    @objc private func timerControlButtonPressed(_ sender: UIButton) {
        isStarted.toggle()
        isStarted ? startTimer() : pauseTimer()
        let image = isStarted ? "pause" : "play"
        sender.setImage(UIImage(systemName: image), for: .normal)
    }
    
    @objc private func updateTime() {
        timeInSeconds -= 1
        countdownLabel.text = get(time: timeInSeconds)
        endTimer()
    }
    
}


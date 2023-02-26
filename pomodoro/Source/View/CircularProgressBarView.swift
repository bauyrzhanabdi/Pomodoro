import UIKit

final class CircularProgressBar: UIView {
    // MARK: - Properties
    private lazy var progressLayer: CAShapeLayer = CAShapeLayer()
    private lazy var backgroundLayer: CAShapeLayer = CAShapeLayer()
    private lazy var startPoint: CGFloat = CGFloat(-Double.pi / 2)
    private lazy var endPoint: CGFloat = CGFloat(3 * Double.pi / 2)
    private lazy var progress: CGFloat = 0 {
        didSet {
            progressLayer.strokeEnd = progress
        }
    }
    private let radius: CGFloat
    
    // MARK: Initialization
    init(radius: Double) {
        self.radius = CGFloat(radius)
        super.init(frame: .zero)
        createCircularPath()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    // MARK: - Methods
    func createCircularPath() {
        let circularPath = UIBezierPath(
            arcCenter: CGPoint(x: frame.size.width / 2, y: frame.size.height / 2),
            radius: radius,
            startAngle: startPoint,
            endAngle: endPoint,
            clockwise: true
        )
        
        backgroundLayer.path = circularPath.cgPath
        backgroundLayer.fillColor = UIColor.clear.cgColor
        backgroundLayer.lineCap = .round
        backgroundLayer.lineWidth = 20.0
        backgroundLayer.strokeEnd = 1.0
        backgroundLayer.strokeColor = UIColor.systemGray4.cgColor
        
        progressLayer.path = circularPath.cgPath
        progressLayer.fillColor = UIColor.clear.cgColor
        progressLayer.lineCap = .round
        progressLayer.lineWidth = 10.0
        progressLayer.strokeEnd = 0
        progressLayer.strokeColor = UIColor.red.cgColor
        
        layer.addSublayer(backgroundLayer)
        layer.addSublayer(progressLayer)
    }
    
    func changeProgressBarColor(state: Bool, relaxingColor: UIColor, workingColor: UIColor) {
        progressLayer.strokeColor = !state ? relaxingColor.cgColor : workingColor.cgColor
    }
    
    func animateProgress(duration: TimeInterval) {
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        
        animation.duration = duration
        animation.fromValue = 0
        animation.toValue = 1.0
        animation.fillMode = .forwards
        animation.isRemovedOnCompletion = false
        
        progressLayer.add(animation, forKey: "progressAnimation")
    }
    
    func pauseProgress() {
        let pausedTime = progressLayer.convertTime(CACurrentMediaTime(), from: nil)
        progressLayer.speed = 0.0
        progressLayer.timeOffset = pausedTime
    }

    func resumeProgress() {
        let pausedTime = progressLayer.timeOffset
        progressLayer.speed = 1.0
        progressLayer.timeOffset = 0.0
        progressLayer.beginTime = 0.0
        
        let timeSincePause = progressLayer.convertTime(CACurrentMediaTime(), from: nil) - pausedTime
        progressLayer.beginTime = timeSincePause
    }
}

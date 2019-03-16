import UIKit

class AppSettings {
    
    static let shared = AppSettings()
    
    private init() {
    }
    
    static let CounterValue = "CounterValue"
    
    let defaults = UserDefaults.standard
    
    var counterValue: Int {
        get {
            return defaults.integer(forKey: AppSettings.CounterValue)
        }
        set {
            defaults.set(newValue, forKey: AppSettings.CounterValue)
        }
    }
    
}

class UserDefaultsViewController: UIViewController {

    @IBOutlet weak var incrementButton: UIButton!
    @IBOutlet weak var valueLabel: UILabel!
    
    let settings = AppSettings.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        settings.defaults.addObserver(self, forKeyPath: AppSettings.CounterValue, options: [.initial, .old, .new], context: nil)

    }
    
    func updateView() {
        valueLabel.text = "Counter: \(settings.counterValue)"
    }

    @IBAction func increment(_ sender: Any) {
        settings.counterValue += 1
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if let keyPath = keyPath, let change = change, let newValue = change[.newKey], keyPath == AppSettings.CounterValue {
            print("\(keyPath) changed to \(newValue)")
            updateView()
        } else {
            super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
        }
    }
    
    deinit {
        settings.defaults.removeObserver(self, forKeyPath: AppSettings.CounterValue)
    }
    
}

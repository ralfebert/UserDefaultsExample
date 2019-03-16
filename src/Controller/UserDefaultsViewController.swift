import UIKit

class AppSettings {

    static let shared = AppSettings()

    private init() {}

    static let CounterValue = "CounterValue"
    static let SliderPreferenceValue = "slider_preference"

    let defaults = UserDefaults.standard

    var counterValue: Int {
        get {
            return self.defaults.integer(forKey: AppSettings.CounterValue)
        }
        set {
            self.defaults.set(newValue, forKey: AppSettings.CounterValue)
        }
    }

    var sliderValue: Float {
        get {
            return self.defaults.float(forKey: AppSettings.SliderPreferenceValue)
        }
        set {
            self.defaults.set(newValue, forKey: AppSettings.SliderPreferenceValue)
        }
    }

}

class UserDefaultsViewController: UIViewController {

    @IBOutlet var incrementButton: UIButton!
    @IBOutlet var valueLabel: UILabel!
    @IBOutlet var sliderValueLabel: UILabel!

    let settings = AppSettings.shared

    override func viewDidLoad() {
        super.viewDidLoad()

        self.settings.defaults.addObserver(self, forKeyPath: AppSettings.CounterValue, options: [.initial, .old, .new], context: nil)
        self.settings.defaults.addObserver(self, forKeyPath: AppSettings.SliderPreferenceValue, options: [.initial, .old, .new], context: nil)

        print(self.settings.sliderValue)

    }

    func updateView() {
        self.valueLabel.text = "Counter: \(self.settings.counterValue)"
        self.sliderValueLabel.text = "\(self.settings.sliderValue)"
    }

    @IBAction func increment(_: Any) {
        self.settings.counterValue += 1
    }

    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey: Any]?, context: UnsafeMutableRawPointer?) {
        if let keyPath = keyPath, let change = change, let newValue = change[.newKey] {
            print("\(keyPath) changed to \(newValue)")
            self.updateView()
        } else {
            super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
        }
    }

    deinit {
        settings.defaults.removeObserver(self, forKeyPath: AppSettings.CounterValue)
        settings.defaults.removeObserver(self, forKeyPath: AppSettings.SliderPreferenceValue)
    }

}

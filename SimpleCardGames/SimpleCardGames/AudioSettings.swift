import Foundation

final class AudioSettings: NSObject, NSSecureCoding {
    static var supportsSecureCoding: Bool { true }

    var musicEnabled: Bool
    var soundEnabled: Bool
    var volume: Double

    init(musicEnabled: Bool = true, soundEnabled: Bool = true, volume: Double = 0.7) {
        self.musicEnabled = musicEnabled
        self.soundEnabled = soundEnabled
        self.volume = volume
    }

    required init?(coder: NSCoder) {
        self.musicEnabled = coder.decodeBool(forKey: "musicEnabled")
        self.soundEnabled = coder.decodeBool(forKey: "soundEnabled")
        self.volume = coder.decodeDouble(forKey: "volume")
    }

    func encode(with coder: NSCoder) {
        coder.encode(musicEnabled, forKey: "musicEnabled")
        coder.encode(soundEnabled, forKey: "soundEnabled")
        coder.encode(volume, forKey: "volume")
    }
}

final class AudioSettingsStore {
    private let fileName: String

    init(fileName: String = "audio-settings") {
        self.fileName = fileName
    }

    private var fileURL: URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            .appendingPathComponent("\(fileName).dat")
    }

    func save(_ settings: AudioSettings) throws {
        let data = try NSKeyedArchiver.archivedData(withRootObject: settings, requiringSecureCoding: false)
        try data.write(to: fileURL)
    }

    func load() throws -> AudioSettings {
        guard FileManager.default.fileExists(atPath: fileURL.path) else {
            return AudioSettings()
        }

        let data = try Data(contentsOf: fileURL)
        guard let settings = try NSKeyedUnarchiver.unarchivedObject(ofClass: AudioSettings.self, from: data) else {
            return AudioSettings()
        }

        return settings
    }
}

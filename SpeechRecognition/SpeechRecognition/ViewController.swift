//
//  ViewController.swift
//  SpeechRecognition
//
//  Created by Quang Tran on 5/12/17.
//  Copyright © 2017 Quang Tran. All rights reserved.
//
//  https://www.invasivecode.com/weblog/natural-language-processing-speech-recognition-ios/?doing_wp_cron=1494551302.8191900253295898437500
//

import UIKit
import Speech

class ViewController: UIViewController, SFSpeechRecognizerDelegate {
  
  lazy var speechRecognizer: SFSpeechRecognizer? = {
    if let recognizer = SFSpeechRecognizer(locale: Locale(identifier: "en-US")) {
      recognizer.delegate = self
      return recognizer
    }
    else { return nil }
  }()
  
  @IBOutlet var startRecordingButton: UIButton! {
    willSet {
      newValue.isEnabled = false
      newValue.setTitle("Start voice recording", for: .normal)
    }
  }
  
  lazy var audioEngine: AVAudioEngine = {
    let audioEngine = AVAudioEngine()
    return audioEngine
  }()
  
  var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
  var recognitionTask: SFSpeechRecognitionTask?

  let taggerOptions: NSLinguisticTagger.Options = [.joinNames, .omitWhitespace]
  
  lazy var linguisticTagger: NSLinguisticTagger = {
    let tagSchemes = NSLinguisticTagger.availableTagSchemes(forLanguage: "en")
    return NSLinguisticTagger(tagSchemes: tagSchemes, options: Int(self.taggerOptions.rawValue))
  }()
  
  @IBOutlet var textView : UITextView!

  override func viewDidLoad() {
    super.viewDidLoad()
    
    let locales = SFSpeechRecognizer.supportedLocales()
    print(locales)
    
    SFSpeechRecognizer.requestAuthorization { (authStatus: SFSpeechRecognizerAuthorizationStatus) in
      
      DispatchQueue.main.async {
        switch authStatus {
        case .authorized:
          self.startRecordingButton.isEnabled = true
        case .denied:
          self.startRecordingButton.isEnabled = false
          self.startRecordingButton.setTitle("User denied access to speech recognition", for: .disabled)
        case .restricted:
          self.startRecordingButton.isEnabled = false
          self.startRecordingButton.setTitle("Speech recognition restricted on this device", for: .disabled)
        case .notDetermined:
          self.startRecordingButton.isEnabled = false
          self.startRecordingButton.setTitle("Speech recognition not yet authorized", for: .disabled)
        }
      }
    }
    
//    let tagSchemes = NSLinguisticTagger.availableTagSchemes(forLanguage: "en")
//    let options: NSLinguisticTagger.Options = [.joinNames, .omitWhitespace]
//    let linguisticTagger = NSLinguisticTagger(tagSchemes: tagSchemes, options: Int(options.rawValue))
//    
//    let sentence = "Do you know about the legendary iOS training in San Francisco by InvasiveCode?"
//    
//    linguisticTagger.string = sentence
//    
//    linguisticTagger.enumerateTags(in: NSMakeRange(0, (sentence as NSString).length),
//                                   scheme: NSLinguisticTagSchemeNameTypeOrLexicalClass,
//                                   options: options) { (tag, tokenRange, _, _) in
//      
//      let token = (sentence as NSString).substring(with: tokenRange)
//      print("\(token) -> \(tag)")
//    }
  }

  @IBAction func startRecordingButtonTapped() {
    if audioEngine.isRunning {
      audioEngine.stop()
      recognitionRequest?.endAudio()
      startRecordingButton.isEnabled = false
      startRecordingButton.setTitle("Stopping", for: .disabled)
    } else {
      try! startRecording()
      startRecordingButton.setTitle("Stop recording", for: [])
    }
  }
  
  private func startRecording() throws {
    
    // Cancel the previous task if it's running.
    if let recognitionTask = self.recognitionTask {
      recognitionTask.cancel()
      self.recognitionTask = nil
    }
    
    // Create a new audio session
    let audioSession = AVAudioSession.sharedInstance()
    try audioSession.setCategory(AVAudioSessionCategoryRecord)
    try audioSession.setMode(AVAudioSessionModeMeasurement)
    try audioSession.setActive(true, with: .notifyOthersOnDeactivation)
    
    // Create a new live recognition request
    recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
    
    // Get the audio engine input node
    guard let inputNode = audioEngine.inputNode else { fatalError("Audio engine has no input node") }
    
    guard let recognitionRequest = self.recognitionRequest else { fatalError("Unable to create a SFSpeechAudioBufferRecognitionRequest object") }
    
    // Configure request so that results are returned before audio recording is finished
    recognitionRequest.shouldReportPartialResults = true
    
    // A recognition task represents a speech recognition session.
    // We keep a reference to the task so that it can be cancelled.
    recognitionTask = speechRecognizer?.recognitionTask(with: recognitionRequest) { result, error in
      
      var isFinal = false
      
      // When the recognizer returns a result, we pass it to
      // the linguistic tagger to analyze its content.
      if let result = result {
        let sentence = result.bestTranscription.formattedString
        self.linguisticTagger.string = sentence
        self.textView.text = sentence
        self.linguisticTagger.enumerateTags(in: NSMakeRange(0, (sentence as NSString).length), scheme: NSLinguisticTagSchemeNameTypeOrLexicalClass, options: self.taggerOptions) { (tag, tokenRange, _, _) in
          let token = (sentence as NSString).substring(with: tokenRange)
          print("\(token) -> \(tag)")
        }
        isFinal = result.isFinal
      }
      
      if error != nil || isFinal {
        self.audioEngine.stop()
        inputNode.removeTap(onBus: 0)
        
        self.recognitionRequest = nil
        self.recognitionTask = nil
        
        self.startRecordingButton.isEnabled = true
        self.startRecordingButton.setTitle("Start Recording", for: [])
      }
    }
    
    let recordingFormat = inputNode.outputFormat(forBus: 0)
    inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer: AVAudioPCMBuffer, when: AVAudioTime) in
      self.recognitionRequest?.append(buffer)
    }
    
    // Prepare the audio engine to allocate resources
    audioEngine.prepare()
    
    // Start the audio engine
    try audioEngine.start()
    
    textView.text = "(Go ahead, I'm listening)"
    
  }
}


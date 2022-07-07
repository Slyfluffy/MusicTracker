//
//  metronome.swift
//  MusicTracker
//
//  Created by Journey Curtis on 5/6/22.
//

import Foundation
import AVFoundation
/**
 * SOUNDMANAGER :: MUSICTRACKER
 * Handles the playing of the beat sound.
 */
struct SoundManager {
    static var instance = SoundManager()
    var audioPlayer = AVAudioPlayer()
    
    /**
    * PLAYBEAT :: SOUNDMANAGER
    * INPUTS  :: NONE
    * OUTPUTS :: NONE
    * Plays the beat for our metronome
    **/
    mutating func playBeat() {
       guard let url = Bundle.main.url(forResource: "beat",
                                       withExtension: ".mp3")
       else { return }
        
       do {
           audioPlayer = try AVAudioPlayer(contentsOf: url)
           audioPlayer.play()
       } catch {
           print("Error")
       }
   }
}

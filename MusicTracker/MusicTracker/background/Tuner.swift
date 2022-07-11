//
//  Tuner.swift
//  MusicTracker
//
//  Created by Journey Curtis on 6/2/22.
//  Inspired by Yu Chao's Tuner implementation
//  https://shinerightstudio.com/posts/ios-tuner-app-using-audiokit/

import Foundation

struct Note: Equatable {
    enum Accidental: Int { case natural = 0, sharp, flat }
    enum Name: Int { case a = 0, b, c, d, e, f, g }
    
    static let octave: [Note] = [
        Note(.c, .natural), Note(.c, .sharp),
        Note(.d, .natural),
        Note(.e, .flat), Note(.e, .natural),
        Note(.f, .natural),Note(.f, .sharp),
        Note(.g, .natural),
        Note(.a, .flat), Note(.a, .natural),
        Note(.b, .flat), Note(.b, .natural)
    ]
    
    var note: Name
    var accidental: Accidental
    
    var frequency: Double {
        guard let note = Note.octave.firstIndex(of: self) else {
            return 440.0
        }
        guard let a = Note.octave.firstIndex(of: Note(.a, .natural)) else {
            return 440.0
        }
        
        let index = note - a
        return 440.0 * pow(2.0, Double(index) / 12.0)
    }
    
    init(_ note: Name, _ accidental: Accidental) {
        self.note = note
        self.accidental = accidental
    }
    
    static func ==(lhs: Note, rhs: Note) -> Bool {
        return lhs.note == rhs.note && lhs.accidental == rhs.accidental
    }
    
    static func !=(lhs: Note, rhs: Note) -> Bool {
        return !(lhs == rhs)
    }
}

//
//  MetroTunerView.swift
//  MusicTracker
//
//  Created by Journey Curtis on 6/27/22.
//

import SwiftUI

struct MetroTunerView: View {
    var body: some View {
        VStack {
            TunerView()
            MetronomeView()
        }
    }
}

struct MetroTunerView_Previews: PreviewProvider {
    static var previews: some View {
        MetroTunerView()
            .previewDevice("iPad Air (5th generation)")
    }
}

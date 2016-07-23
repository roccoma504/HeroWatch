//
//  Constants.swift
//  HeroWatch
//
//  Created by Matthew Rocco on 7/19/16.
//  Copyright © 2016 Matthew Rocco. All rights reserved.
//
//  This package contains constants used by the application.
//

import ChameleonFramework
import UIKit


// 
// Color constants
//

let PRIMARY_COLOR = FlatOrangeDark()
let SECONDARY_COLOR = FlatBlue()

//
// Platform Constants
//

let CONSOLE_ARRAY = ["psn","xbl","pc"]
let REGION_ARRAY = ["eu", "us", "kr", "cn", "global"]

let BASE_URL = "https://api.lootbox.eu"


//
// Hero related constants
//

enum heroes {
    case Soldier76
    case Hanzo
    case Pharah
    case Genji
    case Tracer
    case Widowmaker
    case Bastion
    case Dva
    case Torbjorn
    case Zenyatta
    case McCree
    case Mercy
    case Roadhog
    case Reaper
    case Symmetra
}

let heroImageMap = ["Soldier: 76":"soldier_76.png",
                    "Hanzo":"hanzo.png",
                    "Pharah":"pharah.png",
                    "Genji":"genji.png",
                    "Tracer":"tracer.png",
                    "Widowmaker":"widowmaker.png",
                    "Bastion":"bastion.png",
                    "D.Va":"dva.png",
                    "Torbj&#xF6;rn":"torbjorn.png",
                    "Zenyatta":"zenyatta.png",
                    "McCree":"mcree.png",
                    "Mercy":"mercy.png",
                    "Roadhog":"roadhog.png",
                    "Reaper":"reaper.png",
                    "Symmetra":"symmetra.png",
                    "Lucio":"lucio.png",
                    "Reinhardt":"reinhardt.png"]




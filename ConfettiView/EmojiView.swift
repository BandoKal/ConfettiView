//
//  EmojiView.swift
//  ConfettiView
//
//  Created by Bandy Jason on 9/19/17.
//  Copyright © 2017 ConfettiView. All rights reserved.
//

import Foundation

class EmojiView: StringView {
    let possibleEmjois = ["🙆","😪","🙍","😢","😊","🙀","😘","😹","😇","😒","😍","🙌","🙏","😎","😛","😜","😽","😾","😚",
                          "😳","😁","😖","😉","😡","😫","😶","🙈","😰","🙊","😏","😩","😤","😕","😥","🙉","😭","😈","😣",
                          "😔","😵","🙅","😬","😆","😮","😸","🙋","😺","😲","😟","😦","😑","🙇","😝","😯","😴","😋","😷",
                          "😗","😻","😅","😙","😂","😱","😞","😿","😌","🙎","😐","😠","😃","😓","😧","😄","😨","❌","✋",
                          "✅","❎","✨","✊","🚂","🚠","🚨","🚰","🛀","🚹","🚤","🚌","🚔","🚴","🚎","🚟","🚅","🚓","🚶",
                          "🚁","🚃","🚕","🚐","🚿","🚳","🚺","🚙","🚡","🚗","🚋","🚀","🚩","🚥","🚜","🚸","🚉","🚵","🚽",
                          "🚊","🚧","🚣","🚑","🚒","🚝","🚦","🚷","🚯","🚭","🚮","🚞","🚱","🚆","🚍","🚈","🚢","🚖","🚬",
                          "🚲","🚼","🚘","🚪","🚄","🚛","🚚","🚾","🚻","🚏","🚫","🚇","😀","🛃","🛁","🛅","🛄","🛂","🍠",
                          "🏦","🔲","🎍","👰","💕","📫","🕃","📎","🍺","🏿","📱","💛","🐌","🌾","📢","💗","🌛","👬","🍙",
                          "🏰","👡","🐽","🎴","🍉","📘","💵","🐅","🎌","👘","🔎","💢","🍲","🎦","📈","💃","📺","🔋","👌",
                          "🕘","🕚","👯","🐂","📓","👷","👲","🔞","📑","📝","🍝","🎯","🔍","🍛","👉","🔘","📲","🏣","🐷",
                          "👭","🍧","💮","🍀","🍨","📼","🐓","🔴","🐙","🏥","🔫","🔌","🍡","🕦","💯","🍁","🎵","💸","🌓",
                          "🐇","🐁","🐊","🐋","🐾","💚","🍯","👸","🔅","📄","💍","🎑","🌗","🐃","📙","🕗","🐡","💶","👟",
                          "🔆","🔒","🕐","🕢","🔡","📕","📯","🔠","🏠","🍼","🌒","🕒","🐹","📒","🎇","👍","🔟","🔶","💉",
                          "🐏","🔏","🌟","🎫","🐫","💑","🏉","🎐","🎃","🔕","🍣","🎩","🕓","💬","🎺","💁","🎥","📋","🏮",
                          "📥","💤","📏","🌏","💈","👔","💂","📮","💿","🏀","🍦","🐛","💱","👖","🐤","🍋","🕕","👐","🏢",
                          "💼","🔤","🔱","🐉","🎹","🎊","🐖","🍕","💾","🔊","🍌","🔸","🏽","🍗","🎋","💐","🕙","🐝","🎸",
                          "💖","🎰","🎮","🍈","🏬","🕠","💪","🌵","💻","🍂","🎉","💺","📃","📩","🔄","🔰","🌲","🎳","🎽",
                          "📠","🔔","🍵","🕞","📵","🌑","💎","💫","💝","👕","🐼","🐬","📻","🍥","🕔","💨","🔑","💰","🍐",
                          "🌜","📍","💩","🐎","🍞","🐒","🔹","👀","🔯","👢","👨","🎻","🏡","🔪","🏈","📤","🐄","👼","🎪",
                          "📟","🍓","👏","🐠","🌕","🐞","🍫","📣","🐔","🐜","🌞","🏄","🌰","📇","🎎","🌽","👩","👽","🍖",
                          "🐕","📀","👦","🍘","🏊","👂","👮","📶","🌍","🐑","👾","🍔","📦","🐐","🔗","🎬","🐶","💆","🕛",
                          "🍱","🏁","👻","👣","🎷","💒","🎂","🍃","🎄","🐭","🍻","📞","💴","🏃","💟","🕖","👝","👹","👋",
                          "🔐","💞","🎁","🐲","🔀","👳","🍊","🐰","📴","🔂","🏾","🌹","🎨","🐍","👛","📆","🍜","🏼","💏",
                          "👵","🍰","🕡","🔧","💧","👱","🐥","🐴","🔬","🍏","🍑","💲","📅","🔥","🐀","🍇","📌","👿","💜",
                          "🔻","🏧","🐱","📜","🕤","🐮","🍴","🐸","💭","🏻","🌝","🐢","🐦","🔵","👃","🌴","👺","🕜","😼",
                          "🐧","💥","💽","👫","💳","👥","📳","🔮","🔼","🌱","👤","🎢","🌐","🐘","🐆","🔳","🕑","🎶","🍆",
                          "👑","🕣","💠","🎒","🎓","💡","📚","🏯","📐","👗","🐚","🍮","👚","👇","📉","🎿","📔","📬","👎",
                          "🔭","🏤","🎈","🏪","🎡","🎱","🔁","🐪","📡","🔃","💣","🎏","🏂","🐵","🍒","🐗","👜","👴","🌔",
                          "💋","🌿","🍭","🐳","💓","🕧","👠","💙","📹","🕝","🍷","👒","👞","🐨","🏫","💄","💊","🌖","💇",
                          "🐟","💦","🔺","🔨","🌻","🎤","👓","🌳","👈","👆","💅","🍤","🏨","👊","📧","🔣","🎲","🎣","🍟",
                          "🐣","💷","🌘","🌚","🔖","📁","🍪","🎼","🔦","🍳","💘","📪","📷","🎀","📖","💔","🔷","🐩","📰",
                          "📊","🍎","🏇","🌙","🍬","🌺","💹","🎠","📗","🌎","🍍","🎆","🕟","🏭","🏆","📛","🍢","🏩","🌷",
                          "🐈","🐯","🐺","💌","👪","🎾","🍩","🍄","🍸","📂","📨","🔈","🔉","🔓","🍶","💀","🔢","🎧","👶",
                          "🌠","👙","🔽","🍚","🍹","🔇","🐻","🔩","🌸","🌼","🎭","👄","👅","👧","📭","🍅","🎅","🕥"]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.clear
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    init?(center point:CGPoint, depth:Double = 1) {
        let index: Int = Int(arc4random_uniform(UInt32(self.possibleEmjois.count)))
        let emoji =  self.possibleEmjois[index]
        super.init(center: point, depth: depth, text: emoji)
    }
}




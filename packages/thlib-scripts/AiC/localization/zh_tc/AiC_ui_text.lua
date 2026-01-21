---=====================================
---THLoOP Localization Dialog
---東方夢搖籃本土化 對話
---=====================================

--[=[
For translaters:
This is the UI text file of THLoOP.
It includes all text in UI and menus (not images).
Only the contents in `""` and `[[]]` need to be translated. Change other code can lead to error.
The code in `<>` is text effect. To change text effect, see `AiC_text_effect.lua`.
給翻譯者：
這是東方夢搖籃的UI文字檔案。
它包括所有UI和選單中的文字（非圖片）。
只有`""`和`[[]]`中的內容需要被翻譯。更改其他程式碼可能引發錯誤。
`<>`中的程式碼是文字效果。要更改文字效果，參見`AiC_text_effect.lua`。
--]=]

local lib = aic.l10n.zh_tc.ui

---音樂室文字
---Music room text
lib.music_room_text = {
    title = {
        [0] = "遙遠彼方的記憶",
        "夢境彼方 搖籃仙境",
        "Wonderland of 0 & 1",
        "Star Chaser",
        "Star Rider",
        "/*死魚眼_日照不足_往返跑部*/",
        "正午時分的妖精宴會",
        "G.H.O.S.T",
        "縹緲之風　～ Assassinatroid",
        "魔法使的祭典　～ Starry Forest",
        "森林中的未知際遇",
        "純白之花",
        "守護之光",
        "超越空想的Stella",
        "即使已然無力迴天",
        "於樂園中仰望繁星　～ Alice In Gensokyo",
        "失色的星之夢　～ Reality or Fantasy?",
        "森之意志",
        "寧靜的夏夜",
        "Above Star",
        "夢醒之時",
        --以下是DLC曲目
        "DOORS_OF_MYSTERIES",
        "BACK_DANCERS",
        "INDESCRIBABLE",
        "DEEP_INTO_THE_WONDERLAND",
        "ALTERNATIVE",
        "THE_YAKUMO",
        "EYE_OF_LAPLACE",
        "LAST_DANCE",
        "VIOLET_NIGHT",
        "樂園與群星與永遠之夢"
        
    },
    comment = {
        [0] = [[
            出處：LuaSTG標題畫面主題曲

            　LuaSTG預設的標題畫面的主題曲。

            　雖然不知從何而來，但這段旋律早已深入每一位LuaSTGer的心中。
            　繼續以彈幕為筆，描繪這美妙的幻想世界吧。
        ]],
        [[
            原曲：An-fillnote - Title
            出處：Hinayua/橋野水葉 - 《AliceInCradle》

            　標題畫面的主題曲。

            　十分令人安心的旋律，即使沒有聽過也是一樣。
        ]],
        [[
            原曲：ginkiha - Extra stage
            出處：Cloba·U - 《Star Shooter!》

            「數據刪除」
        ]],
        [[
            原曲：ginkiha - Star Chaser! 
            出處：Cloba·U - 《Star Chaser!》
            
            「數據刪除」
        ]],
        [[
            原曲：ginkiha - The Star Hill

            「數據刪除」
        ]],
        [[
            原曲：ginkiha - 通常Boss
            出處：Cloba·U - 《Star Shooter!》
            
            「數據刪除」
        ]],
        [[
            原曲：上海愛麗絲幻樂團 - 午夜的妖精舞會
            出處：上海愛麗絲幻樂團 - 《妖精大戰爭 　～ 東方三月精》
            
            「數據刪除」
        ]],
        [[
            原曲：AliceSoft - 濡羽色GUSTYWIND
            出處：AliceSoft - 《多娜多娜 一起來幹壞事吧》
            
            「數據刪除」
        ]],
        [[
            原曲：AliceSoft - Breakthru>>>
            出處：AliceSoft - 《多娜多娜 一起來幹壞事吧》
            
            「數據刪除」
        ]],
        [[
            原曲：上海愛麗絲幻樂團 - 魔法使的憂鬱
            出處：上海愛麗絲幻樂團 - 《The Grimoire of Marisa》附帶CD
            
            　EX面道中的主題曲。
            
            　因為還在魔法森林，所以還在幻想鄉境內。
            　理所當然地用了幻想鄉的曲子。
        ]],
        [[
            原曲：ginkiha - 編織者之森(Battle)
            出處：Hinayua/橋野水葉 - 《AliceInCradle》
            
            　諾艾爾·柯涅爾的一階段主題曲。
            
            　節奏十分輕快，因為諾艾爾這時還並未意識到對手有多強大。
            　聽著這首曲子，就彷彿能看見笨拙地揮動著法杖的諾艾爾呢。
            　聞起來像散落的魔力。
        ]],
        [[
            原曲：ginkiha - 伊庫夏·波利斯塔奇亞
            出處：Hinayua/橋野水葉 - 《AliceInCradle》
            
            　伊庫夏·波利斯塔奇亞的主題曲。
            
            　慌慌張張的感覺。
            　伊庫夏還未從與森主的戰鬥中恢復，
            　即便如此，她也想為諾艾爾爭取一點時間。
        ]],
        [[
            原曲：Feryquitous - Ha-chan
            出處：Cloba·U - 《Star Shooter!》
            
            　普莉姆拉的主題曲。
            
            　氣氛突然變得緊張。
            　普莉姆拉身為獸人難以使用魔法戰鬥……
            　即便如此，她也想為諾艾爾爭取一點時間。
        ]],
        [[
            原曲：Feryquitous - Unknown wisdom
            出處：Cloba·U - 《Star Liner!》
            
            　諾艾爾·柯涅爾的二階段主題曲。
            
            　諾艾爾開始全力以赴，因為背後有她要守護的人。
            　從這裡開始，或許能看到諾艾爾曾見過的攻擊。
            　是時候將它們如數奉還了。
        ]],
        [[
            原曲：An-fillnote - 森林之主
            出處：Hinayua/橋野水葉 - 《AliceInCradle》
            
            　聖光爆發的主題曲。
            
            　連續使用聖光爆發會對施法者的精神造成極大的損傷。
            　但諾艾爾已經沒有餘暇去思考後果了。
            　強烈的暈眩感撕裂著她的理智。
            　暈厥概率：412%
        ]],
        [[
            原曲：森林之主 - 東方風Remix
            出處：https://www.bilibili.com/video/BV1f8411P7fG/
            
            　諾艾爾·柯涅爾的最終階段主題曲。
            
            　極其具有幻想鄉風味的曲子。
            　借助幻想的境界之力與秘匿的背後之力，最後與眼前的敵人一戰吧。
            　彈幕的奧義，正是這夢幻泡影般的美麗。
            　幻想鄉，又何嘗不是幻想的搖籃呢。
        ]],
        [[
            原曲：Feryquitous - The Amplifier

            　諾艾爾·柯涅爾的Last Spellcard主題曲。
            
            　對諾艾爾來說，她所生活的世界無疑就是現實；
            　而對於我們來說，她的世界不過是搖籃中的幻想。
            　但是，我們真的有資格定義什麼是現實嗎？
            　這個問題的答案，想必各位都已了然於心。
            　*遊戲中播放版本為刪減版，按住低速鍵播放完整版
        ]],
        [[
            原曲：watson - 森之記憶
            出處：Hinayua/橋野水葉 - 《AliceInCradle》
            
            　結局A的主題曲。
            
            　讓人十分有安心感的曲子。
            　接下來就交給她吧。
            　「所以，請自豪地挺起胸膛吧，少女」
        ]],
        [[
            原曲：An-fillnote - 魔女的雜貨店
            出處：Hinayua/橋野水葉 - 《AliceInCradle》
            
            　結局B的主題曲。
            
            　大家都回到了日常的生活。
            　但是，也許對於兩個人來說，有什麼發生了改變……
            　聞起來像大吉嶺。
            
        ]],
        [[
            原曲：ginkiha - Staff
            出處：Cloba·U - 《Star Chaser!》
            
            　Staff畫面的主題曲。
            
            　在那星空之上，才是故事真正開始的地方。
            　未來的路還很長，請陪諾艾爾，愛麗絲和菲奧蕾特一起走下去吧。
            　願能再相見。
        ]],
        [[
            原曲：上海愛麗絲幻樂團 - Player Score
            出處：上海愛麗絲幻樂團 - 《東方風神錄　～ Mountain of Faith》
            
            　滿身瘡痍的主題曲。
            
            　這次又是在哪裡醒來呢？
            　小心不要太沉溺於夢境。
        ]],
        --以下是DLC曲目
        [[
            原曲：上海愛麗絲幻樂團 - 禁斷之門對面，是此世還是彼世
            出處：上海愛麗絲幻樂團 - 《東方天空璋 　～ Hidden Star in Four Seasons》
            
            「數據刪除」
        ]],
        [[
            原曲：上海愛麗絲幻樂團 - Crazy Back Dancers
            出處：上海愛麗絲幻樂團 - 《東方天空璋 　～ Hidden Star in Four Seasons》
            
            「數據刪除」
        ]],
        [[
            原曲：上海愛麗絲幻樂團 - 秘神摩多羅　～ Hidden Star in All Seasons. & 被隱匿的四季
            出處：上海愛麗絲幻樂團 - 《東方天空璋 　～ Hidden Star in Four Seasons》
            
            「數據刪除」
        ]],
        [[
            原曲：上海愛麗絲幻樂團 - 妖妖跋扈 　～ Who done it!
            出處：上海愛麗絲幻樂團 - 《東方妖妖夢 　～ Perfect Cherry Blossom》
            
            「數據刪除」
        ]],
        [[
            原曲：上海愛麗絲幻樂團 - 兩方世界
            出處：上海愛麗絲幻樂團 - 《東方三月精 　～ Strange and Bright Nature Deity.》附屬CD

            「數據刪除」
        ]],
        [[
            原曲：上海愛麗絲幻樂團 - Necro-Fantasia
            出處：上海愛麗絲幻樂團 - 《東方妖妖夢 　～ Perfect Cherry Blossom》
            
            「數據刪除」
        ]],
        [[
            原曲：上海愛麗絲幻樂團 - 夜幕降臨 　～ Evening Star
            出處：上海愛麗絲幻樂團 - 《東方萃夢想　～ Immaterial and Missing Power》
            
            「數據刪除」
        ]],
        [[
            原曲：上海愛麗絲幻樂團 - 憑坐處於夢與現實之間　～ Necro-Fantasia
            出處：上海愛麗絲幻樂團 - 《東方憑依華　～ Antinomy of Common Flowers》
            
            「數據刪除」
        ]],
        [[
            原曲：上海愛麗絲幻樂團 - 畢竟就算不是夜晚也有鬼怪
            出處：上海愛麗絲幻樂團 - 《七夕坂夢幻能　～ Taboo Japan Disentanglement》
            
            「數據刪除」
        ]],
        [[
            原曲：An-fillnote - City of Grace
            出處：Hinayua/桥野 水叶 - 《AliceInCradle》

            　標題畫面的主題曲（新）。

            　如同幻想鄉般，群星籠罩的搖籃。
            　永遠之夢，與現實也並無二致。
        ]]
        
    },
    warn1 =
    [[
        ＊＊　選擇的音樂尚未在遊戲進行的過程中播放過　＊＊

        　　　　　　音樂的評論可能會造成劇透，
        　　　　　　　即使那樣也要播放嗎？
    
        　　　　想現在播放的話，請再次按下確定鍵。
        不想現在播放的話，請選擇其它已開啟的音樂進行欣賞。
    ]],
    warn2 =
    [[
        ＊＊　選擇的音樂已經在遊戲進行的過程中播放過　＊＊

        　　　　　音樂的評論可能會造成流向的改變，
        　　　　　　　即使那樣也要播放嗎？
        
        　　　　想現在播放的話，請再次按下確定鍵。
        不想現在播放的話，請選擇其它已開啟的音樂進行欣賞。
    ]],
    --[=[
        This is chararacter source of comment of 22.EYE OF LAPLACE.
        THLoOP will randomly choose characters in it to generate music comment.
        You can add or delete characters in it as you like.
        這是EYE OF LAPLACE的評論的字元來源。
        夢搖籃會隨機抽取其中的字元生成音樂評論。
        你可以隨意增刪其中的字元。
    --]=]
    warn3 = {
        "a", "b", "c", "d", "e", "f", "g", "h", "i",
        "j", "k", "l", "m", "n", "o", "p", "q", "r",
        "s", "t", "u", "v", "w", "x", "y", "z",
    }
}

---完整版符卡名稱
lib.sc_list = {
    {
        { "「ステラの弾幕」", "Default Attack「Starry Shooting」" },
        {},
        { "爆咒「球型炸彈」", "箭咒「純白之箭」",
            "引咒「能量球」", "防咒「魔法障壁」", "喚咒「使魔召喚」", "仿魔咒「空中回廊」",
            "仿赤咒「炎舞神樂」", "「不顧一切的聖光爆發！」", "境符「光與影的限間」", "結界「八重護盾結界」",
            "「繁星若夢」", "Reality Reverse" }
    },
    {
        { "「ステラの弾幕」", "Default Attack「Starry Shooting」" },
        {},
        { "爆咒「球型炸彈」", "箭咒「純白之箭」",
            "引咒「能量球」", "防咒「魔法障壁」", "喚咒「使魔召喚」", "仿魔咒「空中回廊」",
            "仿赤咒「炎舞神樂」", "「不顧一切的聖光爆發！」", "境符「光與影的限間」", "結界「八重護盾結界」",
            "「繁星若夢」", "Reality Reverse" }
    },
    {
        { "「ステラの弾幕」", "Default Attack「Starry Shooting」" },
        {},
        { "爆咒「球型炸彈　速」", "散咒「純白之箭　散」",
            "引咒「能量球　改」", "護咒「魔法加護」", "喚咒「使魔召喚　御」", "仿星咒「銀河鐵道」",
            "仿焱咒「紅蓮祭儀」", "「拼上性命的聖光爆發！」", "境界「明與滅的囚籠」", "結界「十六重護盾大結界」",
            "「月華流轉」", "Reality Reverse" }
    },
    {
        { "「ステラの弾幕」", "Default Attack「Starry Shooting」" },
        {},
        { "爆咒「球型炸彈　速」", "散咒「純白之箭　散」",
            "引咒「能量球　改」", "護咒「魔法加護」", "喚咒「使魔召喚　御」", "仿月咒「空明流光」",
            "仿彗咒「流星祈願」", "「拼上性命的聖光爆發！」", "境界「明與滅的囚籠」", "結界「十六重護盾大結界」",
            "「幻夢的搖籃」", "Reality Reverse" }
    }
}

lib.Ixia_scname = { "追咒「純白之箭　誘」", "追咒「純白之箭　誘」", "追咒「純白之箭　改」", "追咒「純白之箭　改」" }

lib.sphit_name = "「珠輝的素描本」"

lib.player_scname = {
    Reimu = { '靈符「夢想封印」', '結界「擴散結界」' },
    Marisa = { '魔符「星塵幻想」', '戀符「極限火花」' },
    Sakuya = { '幻葬「夜霧幻影殺人鬼」', '幻世「咲夜的世界」' },
    Muki = { '生靈「幻夢蝶華舞」', '散靈「剎那藤結術」', '「幻想華奏」' },
    Nenyuki = { '魔夢「夢魂幻想」', '戀星「星魘火花」' },
    Noel = { '箭咒「純白之箭」', '爆咒「球型炸彈」', '引咒「能量球」' }
}

lib.new_skill_text = {
    "使魔召喚", [[
    將能量匯聚在杖端，召喚輔助戰鬥的使魔。
    因為術式複雜導致詠唱時間較長且魔力消耗較大，
    但與此相對使魔帶來的火力優勢也相當強大。
    對術式稍加修改就可大幅改變使魔的行為，
    甚至可以複製曾經見過的攻擊方式，
    是效果相當多樣的泛用型魔法。]],
    "秘儀結界", [[
    來自神秘樂子人賢者的力量。
    符卡被替換為秘儀結界。
    使用秘儀結界後立即進行一次全屏消彈，
    並獲得一個持續一段時間的護盾。
    護盾可以抵消一次miss並在生效時提供短暫無敵時間。
    ]]
}

lib.tips = {
    select = '選擇',
    back = '返回上一級選單',
    select_diff = '選擇難度',
    select_player = '選擇自機',
    equip_enhancer = '攜帶插件',
    unequip_enhancer = '卸下插件',
    start_game = '開始遊戲',
    play_music = '播放音樂',
    pause_continue_music = '暫停/繼續音樂',
    select_music = '選擇音樂',
    input_char = '輸入字元',
    delete_char = '刪除字元',
    select_option = '選擇設定項',
    change_option = '更改設定項',
    change_key_binding = '更改鍵位',
    select_key_binding = '選擇鍵位',
    play_replay = '播放回放',
    select_stage = '選擇關卡',
    select_save_pos = '選擇儲存位置',
    cancel_save_rep = '取消儲存回放',
    move = '移動',
    page_up_down = '翻頁',
}

lib.enhancer_select_tips = {
    cost = '消耗',
    enhancer_overload = '插件過載',
    equipped_enhancer = '已裝備',
    enhancer_slot = '插件槽',
}

lib.library = { "檢視得分排行", "檢視符卡歷史", "檢視結局" }

lib.player_data = {
    total_play_times = '總遊戲次數',
    play_time = '遊玩時長',
    finish_times = '通關次數',
}

lib.enhancer_select = {
    cost = '消耗'
}

lib.music_room = {
    curr_play_pos = '當前播放位置：'
}

lib.achievement = {
    achivement_complished = "完成成就"
}

---！注意！
---以下文字通過換行符\n控制每行長度在合理範圍內，在翻譯時請通過除錯確定合適的換行位置。
lib.difficulty_select = {
    --easy
    --kawaisou is kibishii（厳しい）
    { '傷害倍率：0.8x\n魔力槽碎裂概率：50%', '即使未接觸過彈幕遊戲的人\n也能安心享受的難度。\n放心大膽地miss吧。' },
    --normal
    --kawaisou is kowai（怖い）
    { '傷害倍率：1.0x\n魔力槽碎裂概率：75%', '為曾接觸過其他低密度\n彈幕遊戲的玩家準備的難度。\n在符卡的使用上請不要吝嗇。' },
    --hard
    --kawaisou is kawaii（可愛い）
    { '傷害倍率：1.2x\n魔力槽碎裂概率：90%', '為有經驗的東方玩家準備的難度，\n彈幕更具挑戰性。\n從這裡開始，不再有任何仁慈。' },
    --lunatic
    --kawaisou is kakkoii（かっこいい）
    { '傷害倍率：1.5x\n魔力槽碎裂概率：100%', '獻給各位機師的難度。\n向LNNNN*進發吧。\n在此難度下如果處於插件過載狀態，\n一次Miss就會滿身瘡痍。\n*Lunatic No Miss No Bomb No Dodge No Enhancer。' },
    tip = "\n彈幕難度區分尚未實裝，\n目前難度僅影響系統。"
}

lib.journey_select = {
    --In Cradle
    --kawaisou is kimochii（気持ちいい）……？
    { '閃避無敵時間：1.0x', '作為廚聖直面諾艾爾的審判。\n你所做的一切，都需在此償還。' },
    --Alice
    --kawaisou is kakenai（描けない）
    { '閃避無敵時間：0.5x', '與諾艾爾一同面對愛麗絲。\n她究竟是敵人，還是朋友？' }
}

lib.enhancer_select = {
    { '盜壘滑步', '使攜帶者免疫體術攻擊，\n閃避後的無敵時間增加30f。' },
    { '藏巧守拙', '攜帶者Miss時不丟失魔力，\n但禁用收點線。\n\n適用於經常Miss的人。\n\n※不能與濡濕預兆同時攜帶' },
    { '雙重閃避', '允許攜帶者連續閃避兩次，\n閃避消耗降低25%。\n\n適用於喜歡閃避的人。' },
    { '超載詠唱', '允許攜帶者釋放符卡時\n使用魔力補足缺少的過充魔力；\n符卡消耗增加10%。\n\n適用於經常使用符卡的人。' },
    { '抓地鞋', '允許攜帶者使用閃避時\n不按下方向鍵，\n此時將不進行移動。\n\n適用於只需要無敵時間的人。' },
    { '長法杖', '使攜帶者的射擊\n判定大小增加50%，\n但傷害不變。\n對雷射無效。' },
    { '祈雨御守', '當攜帶者擊破敵人時，\n增加道具的掉落數量。' },
    { '濡濕預兆', '無論攜帶者Miss前魔力為多少，\n總會產生500魔力。\n\n適用於恐懼火力不足的人。\n\n※不能與藏巧守拙同時攜帶' },
    { '恐高症', '使攜帶者使用符卡後\n無敵時間增加60f。' },
    { '血之虹瞳', '攜帶者拾取過充魔力道具時\n不再增加5點過充魔力，\n而是增加1點生命值。' },
    { '貓之緩降', '當攜帶者處於收點線以上時\n獲得60f無敵時間，\n冷卻時間300f。\n\n適用於經常在收點時Miss的人。' },
    { '珠輝的素描本', '將符卡變為「珠輝的素描本」，\n傷害較低、無敵時間較短。\n符卡消耗降低60%。' },
    { '椎奈的程式設計指導書', '跳過所有對話。' },
    { '菖蒲的小型終端', '最大閃避距離增加100%。' },
    { '歌夜的耳機', '禁用符卡和閃避，\n受到傷害降低50%。' },
    { '諾艾爾的法杖', '射擊傷害增加50%，\n單次Miss時魔力槽碎裂程度\n增加100%。\n若難度為噩夢則\n額外增加50%射擊速度。\n\n本插件消耗插槽數始終為\n最大插槽數+1。' },
}

if _debug.pmode then
    lib.enhancer_select[12][2] = '開啟完美無缺模式。\n遊戲會自動存檔，\n當Miss時可以回到上一個存檔點。'
end

lib.option = {
    username = '使用者名稱',
    locale = '語言　Language',
    resolution = '解析度',
    display_mode = '顯示模式',
    fullscreen_mode = '全螢幕模式', 
    windowed_mode = '視窗模式',
    vsync = '垂直同步',
    SFX = '音效音量',
    BGM = '背景音樂音量',
    autofire = '自動射擊',
    autoslow = '自動低速',
    autododge = '雙擊閃避（未實裝）',
    opening_se = '進入關卡時音效',
    old_version = '舊版',
    new_version = '新版',
    title_bgm = '標題畫面背景音樂',
    normal_version = '普通版',
    full_version = '完全版',
    sfwmode = '健全模式', 
    supersafe = '開（超健全）',
    key_binding = '鍵位設定',
    reset = '重置為預設設定',
    save_and_quit = '儲存並退出',
    return_to_option = '返回設定',
    choose_key_binding = '選擇需要更改的鍵位。',
    input_new_key_binding = '按下新的鍵位。',
    return_to_option_and_save = '返回設定。\n鍵位設定將在設定儲存的同時變更。',
    sfwmode_warning = '\n未滿18歲或正在錄影的玩家\n請務必選擇健全模式為開。',
    recommend = '（推薦）',
    text2 = {
        '更改使用者名稱。\n按Backspace鍵刪除已輸入字元，\n按Esc鍵儲存更改。\n使用者名稱與遊戲存檔綁定，\n更改使用者名稱可以更換存檔\n（需重啟遊戲）。',
        '更改语言设定。\n更改語言設定。\nChoose your display language.\n言語設定を変更します。\n對語言的改變將會即刻生效。',
        '設定視窗顯示模式下\n遊戲視窗的大小。',
        '設定遊戲的顯示模式。',
        '啟用垂直同步（VSync）\n可避免畫面撕裂。',
        '設定音效的音量。',
        '設定背景音樂的音量。',
        '設定是否啟用自動射擊。\n若啟用，需按住射擊鍵以停火。\n不建議與自動低速一起使用。',
        '設定是否啟用自動低速。\n若啟用，在開火時\n將自動進入低速模式。\n不建議與自動射擊一起使用。',
        '設定是否啟用雙擊閃避（實驗性）。\n若啟用，雙擊方向鍵即可閃避。\n目前本功能尚處於測試階段，\n若發生報錯請報告作者。',
        '設定進入關卡時播放的音效。\n舊版為0.24a之前的音效，\n新版為0.24a之後的音效。',
        '設定標題畫面的背景音樂。\n普通版為原作遊戲的版本，\n完全版在普通版的基礎上\n增加了一段額外旋律。',
        '設定是否顯示性方面的描寫。\n\n\n當然在這裡你是沒法關掉它的……',
        '更改鍵盤或手把的按鍵。',
        '將所有設定還原至預設值。',
        '儲存設定並退出。\n若不想儲存設定，\n請直接按取消鍵退出。',
    },
    ---注意：大寫英文字母部分不用翻譯
    text3 = { { 'UP', '上移' }, { 'DOWN', '下移' }, { 'LEFT', '左移' }, { 'RIGHT', '右移' }, { 'SLOW', '低速移動' },
        { 'SHOOT', '射擊/確認' }, { 'SPELL', '符卡/取消' }, { 'SPECIAL', '系統特殊功能' }, { 'REPFAST', '錄影播放加速' },
        { 'REPSLOW', '錄影播放減速' }, { 'MENU', '暫停/返回' }, { 'SNAPSHOT', '截圖' }, { 'RETRY', '快速重新開始' } }
}

lib.replay = {
    warning = '該Replay遊戲版本與當前版本相差較大，播放可能導致錯誤。是否繼續播放？\n若要播放，請再次按下確認鍵。',
}

lib.save_replay = {
    warn1 = 'Replay尚未儲存。是否退出？\n若要退出，請按下確認鍵。',
    warn2 = '該位置已有Replay。是否覆蓋？\n若要覆蓋，請再次按下確認鍵。',
}
---=====================================
---THLoOP Localization Dialog
---东方梦摇篮本土化 对话
---=====================================

--[=[
For translaters:
This is the UI text file of THLoOP.
It includes all text in UI and menus (not images).
Only the contents in `""` and `[[]]` need to be translated. Change other code can lead to error.
The code in `<>` is text effect. To change text effect, see `AiC_text_effect.lua`.
给翻译者：
这是东方梦摇篮的UI文本文件。
它包括所有UI和菜单中的文字（非图片）。
只有`""`和`[[]]`中的内容需要被翻译。更改其他代码可能引发错误。
`<>`中的代码是文字效果。要更改文字效果，参见`AiC_text_effect.lua`。
--]=]

local lib = aic.l10n.ja_jp.ui

---音乐室文本
---Music room text
lib.music_room_text = {
    title = {
        [0] = "遥远彼方的记忆",
        "梦境彼方 摇篮仙境",
        "Wonderland of 0 & 1",
        "Star Chaser",
        "Star Rider",
        "/*死鱼眼_日照不足_往返跑部*/",
        "正午时分的妖精宴会",
        "G.H.O.S.T",
        "缥缈之风　～ Assassinatroid",
        "魔法使的祭典　～ Starry Forest",
        "森林中的未知际遇",
        "纯白之花",
        "守护之光",
        "超越空想的Stella",
        "即使已然无力回天",
        "于乐园中仰望繁星　～ Alice In Gensokyo",
        "失色的星之梦　～ Reality or Fantasy?",
        "森之意志",
        "宁静的夏夜",
        "Above Star",
        "梦醒之时",
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
        "乐园与群星与永远之梦"
        
    },
    comment = {
        [0] = [[
            出处：LuaSTG标题画面主题曲

            　LuaSTG默认的标题画面的主题曲。

            　虽然不知从何而来，但这段旋律早已深入每一位LuaSTGer的心中。
            　继续以弹幕为笔，描绘这美妙的幻想世界吧。
        ]],
        [[
            原曲：An-fillnote - Title
            出处：Hinayua/桥野みずは - 《AliceInCradle》

            　标题画面的主题曲。

            　十分令人安心的旋律，即使没有听过也是一样。
        ]],
        [[
            原曲：ginkiha - Extra stage
            出处：Cloba·U - 《Star Shooter!》

            「数据删除」
        ]],
        [[
            原曲：ginkiha - Star Chaser! 
            出处：Cloba·U - 《Star Chaser!》
            
            「数据删除」
        ]],
        [[
            原曲：ginkiha - The Star Hill

            「数据删除」
        ]],
        [[
            原曲：ginkiha - 通常Boss
            出处：Cloba·U - 《Star Shooter!》
            
            「数据删除」
        ]],
        [[
            原曲：上海爱丽丝幻乐团 - 午夜的妖精舞会
            出处：上海爱丽丝幻乐团 - 《妖精大战争 　～ 东方三月精》
            
            「数据删除」
        ]],
        [[
            原曲：AliceSoft - 濡羽色GUSTYWIND
            出处：AliceSoft - 《多娜多娜 一起来干坏事吧》
            
            「数据删除」
        ]],
        [[
            原曲：AliceSoft - Breakthru>>>
            出处：AliceSoft - 《多娜多娜 一起来干坏事吧》
            
            「数据删除」
        ]],
        [[
            原曲：上海爱丽丝幻乐团 - 魔法使的忧郁
            出处：上海爱丽丝幻乐团 - 《The Grimoire of Marisa》附带CD
            
            　EX面道中的主题曲。
            
            　因为还在魔法森林，所以还在幻想乡境内。
            　理所当然地用了幻想乡的曲子。
        ]],
        [[
            原曲：ginkiha - 编织者之森(Battle)
            出处：Hinayua/桥野みずは - 《AliceInCradle》
            
            　诺艾儿·柯涅尔的一阶段主题曲。
            
            　节奏十分轻快，因为诺艾儿这时还并未意识到对手有多强大。
            　听着这首曲子，就仿佛能看见笨拙地挥动着法杖的诺艾儿呢。
            　闻起来像散落的魔力。
        ]],
        [[
            原曲：ginkiha - 伊夏·波利斯塔切尔
            出处：Hinayua/桥野みずは - 《AliceInCradle》
            
            　伊夏·波利斯塔切尔的主题曲。
            
            　慌慌张张的感觉。
            　伊夏还未从与森主的战斗中恢复，
            　即便如此，她也想为诺艾儿争取一点时间。
        ]],
        [[
            原曲：Feryquitous - Ha-chan
            出处：Cloba·U - 《Star Shooter!》
            
            　普莉姆拉的主题曲。
            
            　气氛突然变得紧张。
            　普莉姆拉身为兽人难以使用魔法战斗……
            　即便如此，她也想为诺艾儿争取一点时间。
        ]],
        [[
            原曲：Feryquitous - Unknown wisdom
            出处：Cloba·U - 《Star Liner!》
            
            　诺艾儿·柯涅尔的二阶段主题曲。
            
            　诺艾儿开始全力以赴，因为背后有她要守护的人。
            　从这里开始，或许能看到诺艾儿曾见过的攻击。
            　是时候将它们如数奉还了。
        ]],
        [[
            原曲：An-fillnote - 森之领主
            出处：Hinayua/桥野みずは - 《AliceInCradle》
            
            　圣光爆发的主题曲。
            
            　连续使用圣光爆发会对施法者的精神造成极大的损伤。
            　但诺艾儿已经没有余暇去思考后果了。
            　强烈的晕眩感撕裂着她的理智。
            　晕厥概率：412%
        ]],
        [[
            原曲：森之领主 - 东方风Remix
            出处：https://www.bilibili.com/video/BV1f8411P7fG/
            
            　诺艾儿·柯涅尔的最终阶段主题曲。
            
            　极其具有幻想乡风味的曲子。
            　借助幻想的境界之力与秘匿的背后之力，最后与眼前的敌人一战吧。
            　弹幕的奥义，正是这梦幻泡影般的美丽。
            　幻想乡，又何尝不是幻想的摇篮呢。
        ]],
        [[
            原曲：Feryquitous - The Amplifier

            　诺艾儿·柯涅尔的Last Spellcard主题曲。
            
            　对诺艾儿来说，她所生活的世界无疑就是现实；
            　而对于我们来说，她的世界不过是摇篮中的幻想。
            　但是，我们真的有资格定义什么是现实吗？
            　这个问题的答案，想必各位都已了然于心。
            　*游戏中播放版本为删减版，按住低速键播放完整版
        ]],
        [[
            原曲：watson - 森之记忆
            出处：Hinayua/桥野みずは - 《AliceInCradle》
            
            　结局A的主题曲。
            
            　让人十分有安心感的曲子。
            　接下来就交给她吧。
            　「所以，请自豪地挺起胸膛吧，少女」
        ]],
        [[
            原曲：An-fillnote - 魔女的杂货店
            出处：Hinayua/桥野みずは - 《AliceInCradle》
            
            　结局B的主题曲。
            
            　大家都回到了日常的生活。
            　但是，也许对于两个人来说，有什么发生了改变……
            　闻起来像大吉岭。
            
        ]],
        [[
            原曲：ginkiha - Staff
            出处：Cloba·U - 《Star Chaser!》
            
            　Staff画面的主题曲。
            
            　在那星空之上，才是故事真正开始的地方。
            　未来的路还很长，请陪诺艾儿和爱丽丝一起走下去吧。
            　愿能再相见。
        ]],
        [[
            原曲：上海爱丽丝幻乐团 - Player Score
            出处：上海爱丽丝幻乐团 - 《东方风神录　～ Mountain of Faith》
            
            　满身疮痍的主题曲。
            
            　这次又是在哪里醒来呢？
            　小心不要太沉溺于梦境。
        ]],
        --以下是DLC曲目
        [[
            原曲：上海爱丽丝幻乐团 - 禁断之门对面，是此世还是彼世
            出处：上海爱丽丝幻乐团 - 《东方天空璋 　～ Hidden Star in Four Seasons》
            
            「数据删除」
        ]],
        [[
            原曲：上海爱丽丝幻乐团 - Crazy Back Dancers
            出处：上海爱丽丝幻乐团 - 《东方天空璋 　～ Hidden Star in Four Seasons》
            
            「数据删除」
        ]],
        [[
            原曲：上海爱丽丝幻乐团 - 秘神摩多罗　～ Hidden Star in All Seasons. & 被隐匿的四季
            出处：上海爱丽丝幻乐团 - 《东方天空璋 　～ Hidden Star in Four Seasons》
            
            「数据删除」
        ]],
        [[
            原曲：上海爱丽丝幻乐团 - 妖妖跋扈 　～ Who done it!
            出处：上海爱丽丝幻乐团 - 《东方妖妖梦 　～ Perfect Cherry Blossom》
            
            「数据删除」
        ]],
        [[
            原曲：上海爱丽丝幻乐团 - 两方世界
            出处：上海爱丽丝幻乐团 - 《东方三月精 　～ Strange and Bright Nature Deity.》附属CD

            「数据删除」
        ]],
        [[
            原曲：上海爱丽丝幻乐团 - Necro-Fantasia
            出处：上海爱丽丝幻乐团 - 《东方妖妖梦 　～ Perfect Cherry Blossom》
            
            「数据删除」
        ]],
        [[
            原曲：上海爱丽丝幻乐团 - 夜幕降临 　～ Evening Star
            出处：上海爱丽丝幻乐团 - 《东方萃梦想　～ Immaterial and Missing Power》
            
            「数据删除」
        ]],
        [[
            原曲：上海爱丽丝幻乐团 - 凭坐处于梦与现实之间　～ Necro-Fantasia
            出处：上海爱丽丝幻乐团 - 《东方凭依华　～ Antinomy of Common Flowers》
            
            「数据删除」
        ]],
        [[
            原曲：上海爱丽丝幻乐团 - 毕竟就算不是夜晚也有鬼怪
            出处：上海爱丽丝幻乐团 - 《七夕坂梦幻能　～ Taboo Japan Disentanglement》
            
            「数据删除」
        ]],
        [[
            原曲：An-fillnote - City of Grace
            出处：Hinayua/桥野 水叶 - 《AliceInCradle》

            　标题画面的主题曲（新）。

            　如同幻想乡般，群星笼罩的摇篮。
            　永远之梦，与现实也并无二致。
        ]]
        
    },
    warn1 =
    [[
        ＊＊　选择的音乐尚未在游戏进行的过程中播放过　＊＊

        　　　　　　音乐的评论可能会造成剧透，
        　　　　　　　即使那样也要播放吗？
    
        　　　　想现在播放的话，请再次按下确定键。
        不想现在播放的话，请选择其它已开启的音乐进行欣赏。
    ]],
    warn2 =
    [[
        ＊＊　选择的音乐已经在游戏进行的过程中播放过　＊＊

        　　　　　音乐的评论可能会造成流向的改变，
        　　　　　　　即使那样也要播放吗？
        
        　　　　想现在播放的话，请再次按下确定键。
        不想现在播放的话，请选择其它已开启的音乐进行欣赏。
    ]],
    --[=[
        This is chararacter source of comment of 22.EYE OF LAPLACE.
        THLoOP will randomly choose characters in it to generate music comment.
        You can add or delete characters in it as you like.
        这是EYE OF LAPLACE的评论的字符来源。
        梦摇篮会随机抽取其中的字符生成音乐评论。
        你可以随意增删其中的字符。
    --]=]
    warn3 = {
        "a", "b", "c", "d", "e", "f", "g", "h", "i",
        "j", "k", "l", "m", "n", "o", "p", "q", "r",
        "s", "t", "u", "v", "w", "x", "y", "z",
    }
}

---完整版符卡名称
lib.sc_list = {
    {
        { "「ステラの弾幕」", "Default Attack「Starry Shooting」" },
        {},
        { "爆咒「地面炸弹」", "箭咒「纯白之箭」",
            "引咒「聚能火球」", "防咒「魔法障壁」", "唤咒「使魔召唤」", "仿魔咒「空中回廊」",
            "仿赤咒「炎舞神乐」", "「不顾一切的圣光爆发！」", "境符「光与影的限间」", "结界「八重护盾结界」",
            "「繁星若梦」", "Reality Reverse" }
    },
    {
        { "「ステラの弾幕」", "Default Attack「Starry Shooting」" },
        {},
        { "爆咒「地面炸弹」", "箭咒「纯白之箭」",
            "引咒「聚能火球」", "防咒「魔法障壁」", "唤咒「使魔召唤」", "仿魔咒「空中回廊」",
            "仿赤咒「炎舞神乐」", "「不顾一切的圣光爆发！」", "境符「光与影的限间」", "结界「八重护盾结界」",
            "「繁星若梦」", "Reality Reverse" }
    },
    {
        { "「ステラの弾幕」", "Default Attack「Starry Shooting」" },
        {},
        { "爆咒「地面炸弹　速」", "散咒「纯白之箭　散」",
            "引咒「聚能火球　改」", "护咒「魔法加护」", "唤咒「使魔召唤　御」", "仿星咒「银河铁道」",
            "仿焱咒「红莲祭仪」", "「拼上性命的圣光爆发！」", "境界「明与灭的囚笼」", "结界「十六重护盾大结界」",
            "「月华流转」", "Reality Reverse" }
    },
    {
        { "「ステラの弾幕」", "Default Attack「Starry Shooting」" },
        {},
        { "爆咒「地面炸弹　速」", "散咒「纯白之箭　散」",
            "引咒「聚能火球　改」", "护咒「魔法加护」", "唤咒「使魔召唤　御」", "仿月咒「空明流光」",
            "仿彗咒「流星祈愿」", "「拼上性命的圣光爆发！」", "境界「明与灭的囚笼」", "结界「十六重护盾大结界」",
            "「幻梦的摇篮」", "Reality Reverse" }
    }
}

lib.Ixia_scname = { "追咒「纯白之箭　诱」", "追咒「纯白之箭　诱」", "追咒「纯白之箭　改」", "追咒「纯白之箭　改」" }

lib.sphit_name = "「珠辉的素描本」"

lib.player_scname = {
    Reimu = { '灵符「梦想封印」', '结界「扩散结界」' },
    Marisa = { '魔符「星尘幻想」', '恋符「极限火花」' },
    Sakuya = { '幻葬「夜雾幻影杀人鬼」', '幻世「咲夜的世界」' },
    Muki = { '生灵「幻梦蝶华舞」', '散灵「刹那藤结术」', '「幻想华奏」' },
    Nenyuki = { '魔梦「梦魂幻想」', '恋星「星魇火花」' },
    Noel = { '箭咒「纯白之箭」', '爆咒「地面炸弹」', '引咒「聚能火球」' }
}

lib.new_skill_text = {
    "使魔召唤", [[
    将能量汇聚在杖端，召唤辅助战斗的使魔。
    因为术式复杂导致咏唱时间较长且魔力消耗较大，
    但与此相对使魔带来的火力优势也相当强大。
    对术式稍加修改就可大幅改变使魔的行为，
    甚至可以复制曾经见过的攻击方式，
    是效果相当多样的泛用型魔法。]],
    "秘仪结界", [[
    来自神秘乐子人贤者的力量。
    符卡被替换为秘仪结界。
    使用秘仪结界后立即进行一次全屏消弹，
    并获得一个持续一段时间的护盾。
    护盾可以抵消一次miss并在生效时提供短暂无敌时间。
    ]]
}

lib.subtitle = {
    '选择关卡',
    '选择符卡',
    '选择游戏回放',
    '数据与文档',
    '森林音乐室',
    '设定变更',
    '游戏方法',
    '选择游戏难度',
    '选择自机',
    '选择插件',
    '请输入名字',
    '保存游戏回放', 
    '展示战斗经历',
    '选择结局'
}

lib.tips = {
    select = '选择',
    back = '返回上一级菜单',
    select_diff = '选择难度',
    select_player = '选择自机',
    equip_enhancer = '携带插件',
    unequip_enhancer = '卸下插件',
    start_game = '开始游戏',
    play_music = '播放音乐',
    pause_continue_music = '暂停/继续音乐',
    select_music = '选择音乐',
    input_char = '输入字符',
    delete_char = '删除字符',
    select_option = '选择设置项',
    change_option = '更改设置项',
    change_key_binding = '更改键位',
    select_key_binding = '选择键位',
    play_replay = '播放回放',
    select_stage = '选择关卡',
    select_save_pos = '选择保存位置',
    cancel_save_rep = '取消保存回放',
    move = '移动',
    page_up_down = '翻页',
}

lib.enhancer_select_tips = {
    cost = '消耗',
    enhancer_overload = '插件过载',
    equipped_enhancer = '已装备',
    enhancer_slot = '插件槽',
}

lib.library = { "查看得分排行", "查看符卡历史", "查看结局" }

lib.player_data = {
    total_play_times = '总游戏次数',
    play_time = '游玩时长',
    finish_times = '通关次数',
}

lib.enhancer_select = {
    cost = '消耗'
}

lib.music_room = {
    curr_play_pos = '当前播放位置：'
}

lib.achievement = {
    achivement_complished = "完成成就"
}

---！注意！
---以下文本通过换行符\n控制每行长度在合理范围内，在翻译时请通过调试确定合适的换行位置。
lib.difficulty_select = {
    --easy
    --kawaisou is kibishii（厳しい）
    { '伤害倍率：0.8x\n魔力槽碎裂概率：50%', '即使未接触过弹幕游戏的人\n也能安心享受的难度。\n放心大胆地miss吧。' },
    --normal
    --kawaisou is kowai（怖い）
    { '伤害倍率：1.0x\n魔力槽碎裂概率：75%', '为曾接触过其他低密度\n弹幕游戏的玩家准备的难度。\n在符卡的使用上请不要吝啬。' },
    --hard
    --kawaisou is kawaii（可愛い）
    { '伤害倍率：1.2x\n魔力槽碎裂概率：90%', '为有经验的东方玩家准备的难度，\n弹幕更具挑战性。\n从这里开始，不再有任何仁慈。' },
    --lunatic
    --kawaisou is kakkoii（かっこいい）
    { '伤害倍率：1.5x\n魔力槽碎裂概率：100%', '献给各位机师的难度。\n向LNNNN*进发吧。\n在此难度下如果处于插件过载状态，\n一次Miss就会满身疮痍。\n*Lunatic No Miss No Bomb No Dodge No Enhancer。' },
    tip = "\n弹幕难度区分尚未实装，\n目前难度仅影响系统。"
}

lib.journey_select = {
    --In Cradle
    --kawaisou is kimochii（気持ちいい）……？
    { '闪避无敌时间：1.0x', '作为厨圣直面诺艾儿的审判。\n你所做的一切，都需在此偿还。' },
    --Alice
    --kawaisou is kakenai（描けない）
    { '闪避无敌时间：0.5x', '与诺艾儿一同面对爱丽丝。\n她究竟是敌人，还是朋友？' }
}

lib.enhancer_select = {
    { '盗垒滑步', '使携带者免疫体术攻击，\n闪避后的无敌时间增加30f。' },
    { '藏巧守拙', '携带者Miss时不丢失魔力，\n但禁用收点线。\n\n适用于经常Miss的人。\n\n※不能与濡湿预兆同时携带' },
    { '双重闪避', '允许携带者连续闪避两次，\n闪避消耗降低25%。\n\n适用于喜欢闪避的人。' },
    { '超载咏唱', '允许携带者释放符卡时\n使用魔力补足缺少的过充魔力；\n符卡消耗增加10%。\n\n适用于经常使用符卡的人。' },
    { '抓地鞋', '允许携带者使用闪避时\n不按下方向键，\n此时将不进行移动。\n\n适用于只需要无敌时间的人。' },
    { '长法杖', '使携带者的射击\n判定大小增加50%，\n但伤害不变。\n对激光无效。' },
    { '祈雨御守', '当携带者击破敌人时，\n增加道具的掉落数量。' },
    { '濡湿预兆', '无论携带者Miss前魔力为多少，\n总会产生500魔力。\n\n适用于恐惧火力不足的人。\n\n※不能与藏巧守拙同时携带' },
    { '恐高症', '使携带者使用符卡后\n无敌时间增加60f。' },
    { '血之虹瞳', '携带者拾取过充魔力道具时\n不再增加5点过充魔力，\n而是增加1点生命值。' },
    { '猫之缓降', '当携带者处于收点线以上时\n获得60f无敌时间，\n冷却时间300f。\n\n适用于经常在收点时Miss的人。' },
    { '珠辉的素描本', '将符卡变为「珠辉的素描本」，\n伤害较低、无敌时间较短。\n符卡消耗降低60%。' },
    { '椎奈的编程指导书', '跳过所有对话。' },
    { '菖蒲的小型终端', '最大闪避距离增加100%。' },
    { '歌夜的耳机', '禁用符卡和闪避，\n受到伤害降低50%。' },
    { '诺艾儿的法杖', '射击伤害增加50%，\n单次Miss时魔力槽碎裂程度\n增加100%。\n若难度为噩梦则\n额外增加50%射击速度。\n\n本插件消耗插槽数始终为\n最大插槽数+1。' },
}

if _debug.pmode then
    lib.enhancer_select[12][2] = '开启完美无缺模式。\n游戏会自动存档，\n当Miss时可以回到上一个存档点。'
end

lib.option = {
    username = '用户名',
    locale = '语言　Language',
    resolution = '分辨率',
    display_mode = '显示模式',
    fullscreen_mode = '全屏模式', 
    windowed_mode = '窗口模式',
    vsync = '垂直同步',
    SFX = '音效音量',
    BGM = '背景音乐音量',
    autofire = '自动射击',
    autoslow = '自动低速',
    autododge = '双击闪避（未实装）',
    opening_se = '进入关卡时音效',
    old_version = '旧版',
    new_version = '新版',
    title_bgm = '标题画面背景音乐',
    normal_version = '普通版',
    full_version = '完全版',
    sfwmode = '健全模式', 
    supersafe = '开（超健全）',
    key_binding = '键位设置',
    reset = '重置为默认设置',
    save_and_quit = '保存并退出',
    return_to_option = '返回设置',
    choose_key_binding = '选择需要更改的键位。',
    input_new_key_binding = '按下新的键位。',
    return_to_option_and_save = '返回设置。\n键位设置将在设置保存的同时变更。',
    sfwmode_warning = '\n未满18岁或正在录像的玩家\n请务必选择健全模式为开。',
    recommend = '（推荐）',
    text2 = {
        '更改用户名。\n按Backspace键删除已输入字符，\n按Esc键保存更改。\n用户名与游戏存档绑定，\n更改用户名可以更换存档\n（需重启游戏）。',
        '更改语言设定。\n更改語言設定。\nChoose your display language.\n言語設定を変更します。\n对语言的改变将会立即生效。',
        '设置窗口显示模式下\n游戏窗口的大小。',
        '设置游戏的显示模式。',
        '启用垂直同步（VSync）\n可避免画面撕裂。',
        '设置音效的音量。',
        '设置背景音乐的音量。',
        '设置是否启用自动射击。\n若启用，需按住射击键以停火。\n不建议与自动低速一起使用。',
        '设置是否启用自动低速。\n若启用，在开火时\n将自动进入低速模式。\n不建议与自动射击一起使用。',
        '设置是否启用双击闪避（实验性）。\n若启用，双击方向键即可闪避。\n目前本功能尚处于测试阶段，\n若发生报错请报告作者。',
        '设置进入关卡时播放的音效。\n旧版为0.24a之前的音效，\n新版为0.24a之后的音效。',
        '设置标题画面的背景音乐。\n普通版为原作游戏的版本，\n完全版在普通版的基础上\n增加了一段额外旋律。',
        '设置是否显示性方面的描写。\n\n\n当然在这里你是没法关掉它的……',
        '更改键盘或手柄的按键。',
        '将所有设定还原至默认值。',
        '保存设定并退出。\n若不想保存设定，\n请直接按取消键退出。',
    },
    ---注意：大写英文字母部分不用翻译
    text3 = { { 'UP', '上移' }, { 'DOWN', '下移' }, { 'LEFT', '左移' }, { 'RIGHT', '右移' }, { 'SLOW', '低速移动' },
        { 'SHOOT', '射击/确认' }, { 'SPELL', '符卡/取消' }, { 'SPECIAL', '系统特殊功能' }, { 'REPFAST', '录像播放加速' },
        { 'REPSLOW', '录像播放减速' }, { 'MENU', '暂停/返回' }, { 'SNAPSHOT', '截图' }, { 'RETRY', '快速重新开始' } }
}

lib.replay = {
    warning = '该Replay游戏版本与当前版本相差较大，播放可能导致错误。是否继续播放？\n若要播放，请再次按下确认键。',
}

lib.save_replay = {
    warn1 = 'Replay尚未保存。是否退出？\n若要退出，请按下确认键。',
    warn2 = '该位置已有Replay。是否覆盖？\n若要覆盖，请再次按下确认键。',
}

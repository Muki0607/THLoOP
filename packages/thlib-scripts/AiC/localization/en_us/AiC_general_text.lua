---=====================================
---THAIC Localization General
---东方梦摇篮本土化 通用
---=====================================

--[=[
For translaters:
This is the general terms text file of THAIC.
It includes character names, game terms, etc.
Only the contents in `""` and `[[]]` need to be translated. Change other code can lead to error.
The code in `<>` is text effect. To change text effect, see `AiC_text_effect.lua`.
给翻译者：
这是东方梦摇篮的通用术语文本文件。
它包括人名、游戏术语等。
只有`""`和`[[]]`中的内容需要被翻译。更改其他代码可能引发错误。
`<>`中的代码是文字效果。要更改文字效果，参见`AiC_text_effect.lua`。
--]=]

local lib = aic.l10n.en_us.general

lib.title = "东方梦摇篮 ~ Alice In Cradle"

lib.terms = {
    yes = "是",
    no = "否",
    move = "移动",
    key = "键",
    ending = "结局",
    unknown = "？？？？",
    on = "开",
    off = "关",
    nonspell = "通常攻击",
}

lib.punctions = {
    question_mark = "？",
    exclamation_mark = "！",
}

lib.character_names = {
    reimu = "博丽 灵梦",
    marisa = "雾雨 魔理沙",
    sakuya = "十六夜 咲夜",
    muki = "小林 无记",
    nenyuki = "千幻 念雪",
}

lib.difficulty = {
    easy = "简单",
    normal = "普通",
    hard = "噩梦",
    lunatic = "地狱",
    extra = "额外",
}

lib.rep_info = {
    username = "用户名",
    is_finished = "是否通关",
    time = "时间",
    score = "总分",
    version = "游戏版本",
    player = "自机",
    difficulty = "难度",
    enhancer_select = "携带插件",
    unknown_player = "未知自机",
    unknown_version = "未知版本",
    unknown_difficulty = "未知难度"
}

lib.exception_title = "程序异常警告"

lib.exception = {
    title = "游戏出现异常",
    restype = { lua = "脚本", model = "模型", pack = "压缩包" },
    load_failed = { "加载游戏资源 ", " 时发现文件 ",
        " 丢失。\n请检查该文件是否被移动或删除。\n若无法找到文件，请重新下载游戏。\n若文件存在且重启游戏后仍然出现此提示框，请报告作者。",
        "时出现未知错误。\n若重启游戏后仍然出现此提示框，请报告作者。"
    },
    permission_denied = {
        "检测到游戏存档文件被其他进程占用。\n请结束该进程后点击确定。\n若本提示框持续出现，请重启游戏。",
        "读取游戏存档文件时出现未知错误。\n请尝试重启游戏。\n若重启游戏后仍然出现本提示框，请报告作者。"
    },
    framefunc_error = "游戏运行时出现帧逻辑错误。\n请将游戏日志发送给作者。",
    rendering_error = "游戏运行时出现渲染逻辑错误。\n请将游戏日志发送给作者。",
    lang_load_failed = { "加载语言 ", " 时发现文件 ",
        " 丢失或出错。\n请检查该文件是否被移动、删除或修改。\n若无法找到文件，请重新下载游戏。\n若文件存在且重启游戏后仍然出现此提示框，请报告作者。",
    },

}
---=====================================
---THLoOP Localization General
---东方梦摇篮本土化 通用
---=====================================

--[=[
For translaters:
This is the general terms text file of THLoOP.
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

lib.title = "Touhou Lodestar of Paradise"

lib.terms = {
    yes = "Yes",
    no = "No",
    move = "Move",
    key = "Key",
    ending = "Ending",
    unknown = "????",
    on = "On",
    off = "Off",
    nonspell = "Normal Attack",
}

lib.punctions = {
    question_mark = "?",
    exclamation_mark = "!",
}

lib.character_names = {
    reimu = "Hakurei Reimu",
    marisa = "Kirisame Marisa",
    sakuya = "Izayoi Sakuya",
    muki = "Kobayashi Muki",
    nenyuki = "Sengen nenyuki",
    noel = "Noel Cornehl",
    laevigata = "Laevigata Cornehl",
    ixia = "Ixia Polystachya",
    primula = "Primula",
    Alma = "Alma Opfebaum",
    mepha = "Mepha Gridyard",
}

lib.other_iterm = {
    ---贝尔米特国立大学
    ---魔物
    ---第四槐安通道
    ---梦貘
}

lib.difficulty = {
    easy = "Easy",
    normal = "Normal",
    hard = "Hard",
    lunatic = "Lunatic",
    extra = "Extra",
}

lib.rep_info = {
    username = "Username",
    is_finished = "Completed",
    time = "Time",
    score = "Total Score",
    version = "Game Version",
    player = "Player Character",
    difficulty = "Difficulty",
    enhancer_select = "Equipped Enhancers",
    unknown_player = "Unknown Player Character",
    unknown_version = "Unknown Version",
    unknown_difficulty = "Unknown Difficulty"
}

lib.exception_title = "Program Exception Warning"

lib.exception = {
    title = "Game Exception",
    restype = { lua = "script", model = "model", pack = "package" },
    load_failed = { "Loading game resources ", " failed to find file ",
        ".\nPlease check if the file has been moved or deleted.\nIf the file cannot be found, please re-download the game.\nIf the file exists and this message still appears after restarting the game, please report to the author.",
        " encountered an unknown error.\nIf this message still appears after restarting the game, please report to the author."
    },
    permission_denied = {
        "Detected that the game save file is occupied by another process.\nPlease terminate the process and click OK.\nIf this prompt persists, please restart the game.",
        "An unknown error occurred while reading the game save file.\nPlease try restarting the game.\nIf this prompt still appears after restarting the game, please report this issue to the developer."
    },
    framefunc_error = "A frame logic error occurred during game runtime.\nPlease send the game log to the developer.",
    rendering_error = "A rendering logic error occurred during game runtime.\nPlease send the game log to the developer.",
    lang_load_failed = { "An error occurred while loading language ", ".\nFile ",
        " is missing or corrupted.\nPlease check if the file has been moved, deleted or modified.\nIf the file cannot be found, please redownload the game.\nIf the file exists and this prompt still appears after restarting the game, please report this issue to the developer.",
    },

}
---=====================================
---THLoOP Localization v1.00a
---东方梦摇篮本土化 v1.00a
---=====================================

---版本更新记录
---v1.00a
---初始版本

---@class aic.l10n @东方梦摇篮本土化
aic.l10n = {}
local lib = aic.l10n
l10n = {}

---localization，简写为l10n（l和n之间有10个字母）。
---直译为"本土化"（不建议译为"本地化"，因为本地这个词往往对应的是远程/在线），
---是包括但不限于文本翻译（往往还涉及到数字/日期/时间的格式调整、民间计量单位的换算等）的一项重要工作。
---————《厨圣的高级修养——Alice in Cradle的localization语法》

---可用的语言
lib.lang = {}
---可用语言名称列表，用于有序地显示语言
lib.lang_list = {}

---初始化语言
---@param formal_name string @正式名称，需要和文件夹名相同
---@param simplified_name string @简化名称（两个大写字母）
---@param full_name string @全名（将会在游戏中显示）
function lib.InitLang(formal_name, simplified_name, full_name)
    lib.lang[formal_name] = { simplified_name, full_name }
    table.insert(lib.lang_list, formal_name)
end

---加载所有语言文件
function lib.LoadAllLang()
    for lang, _ in pairs(lib.lang) do
        lib[lang] = { ui = {}, dialog = {}, general = {} } --游戏UI与系统所用文字、对话所用文字、通用术语
        for _, file in ipairs({ "AiC_dialog_text.lua", "AiC_ui_text.lua", "AiC_general_text.lua" }) do
            if _debug.l10n_tryexcept_disabled then
                DoFile("AiC/localization/" .. lang .. "/" .. file)
            else
                aic.exception.TryExcept(function()
                        DoFile("AiC/localization/" .. lang .. "/" .. file)
                    end,
                    {
                        [""] = function()
                            lstg.MsgBoxWarn(lib[setting.locale].general.lang_load_failed[1] .. lib.lang[lang][2]
                                .. lib[setting.locale].general.lang_load_failed[2] .. file
                                .. lib[setting.locale].general.lang_load_failed[3])
                        end
                    })
            end
        end
        Print("[l10n] Successfully loaded language: " .. lang)
    end
end

---重载l10n
function lib.Reload()
    ---当前语言的l10n
    l10n = lib[setting.locale]
end

---!注意！这里的初始化顺序将影响设置中语言选项的显示顺序
---!Caution! The initialization order here affects the display order of language options in settings
lib.InitLang("zh_cn", "CN", "简体中文(CN)")
lib.InitLang("zh_tc", "TC", "繁體中文(TC)")
lib.InitLang("en_us", "EN", "English(US)")
lib.InitLang("ja_jp", "JP", "日本語(JP)")

-------------------------------------------
--please add your language at next line!
--lib.InitLang("xx_XX", "XX", "Your Language(XX)")
-------------------------------------------

lib.LoadAllLang()
lib.Reload()


---部分lstg原生函数重载

--- 简单的警告弹窗
---@param msg string
function lstg.MsgBoxWarn(msg)
    local ret = lstg.MessageBox(l10n.general.exception_title, tostring(msg), 1 + 48)
    if ret == 2 then
        stage.QuitGame()
    end
end

local old_RenderTTF = lstg.RenderTTF
function lstg.RenderTTF(ttfname, text, left, right, bottom, top, align, color, scale)
    if setting.locale ~= "zh_cn" then
        ttfname = string.gsub(ttfname, "zh_cn", setting.locale)
    end
    old_RenderTTF(ttfname, text, left, right, bottom, top, align, color, scale)
end

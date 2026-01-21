---=====================================
---THLoOP Extra Function Library v1.11b
---东方梦摇篮 额外函数库 v1.11b
---=====================================

---注:原data中改动处将会标记上'THLoOP Arranged''THLoOP Changed'或'THLoOP Added'来标记AIC改动或新增代码
---当然有些地方标Arranged是因为已经不记得改过哪里了
---@alias aic_change_sign 'Arranged = 整体改动'| 'Changed = 局部改动'| 'Added = 新增'

---版本更新记录
---v1.00a
---初始版本
---v1.01a
---将aic.menu移至AiC_menu.lua
---v1.01b
---将aic移至aic.sys，现在aic本身不含函数
---v1.02a
---添加table扩展库aic.table
---v1.02b
---添加版本号常量aic.version，它代表当前整个梦摇篮的版本
---v1.03a
---添加ext扩展库aic.ext
---v1.10a
---添加function扩展库aic.function、Python扩展库aic.py、完美无缺模式aic.pmode
---v1.11a
---添加输入aic.input、string扩展库aic.string
---v1.11b
---添加DirectInput扩展aic.input.dinput、本地化aic.l10n、rpg支持库aic.rpg

--THLoOP待完成事项
--完成剩余弹幕
--实装Practice、Spellcard Practice
--尝试使用RenderTarget制作图层系统

---@class aic @东方梦摇篮额外函数库
aic = {}

---东方梦摇篮版本号
---@type string
aic.version = '1.00a'

---东方梦摇篮DLC标志
---@type boolean
aic.DLC = false

---有问题的话需要来这里调整各个库的加载顺序
---虽说理论上以下依赖关系都不会被加载顺序影响，只要游戏启动时依赖的库存在即可

---类型扩展
DoFile("AiC/AiC_string.lua")--AiC string扩展库
DoFile("AiC/AiC_function.lua")--AiC function扩展库，依赖aic.table,aic.string
DoFile("AiC/AiC_table.lua")--AiC table扩展库

---杂项
DoFile("AiC/AiC_debug.lua")--AiC Debug，依赖aic.input,aic.func,aic.table,aic.ui,aic.py
DoFile("AiC/AiC_py.lua")--AiC Python扩展库，依赖aic.table,aic.func
DoFile("AiC/AiC_3d.lua")--AiC 3d，依赖aic.math
DoFile("AiC/AiC_misc.lua")--AiC杂项，依赖aic.input,aic.ui
DoFile("AiC/AiC_pmode.lua")--AiC 完美无缺模式，依赖aic.ext,aic.menu,aic.sys
DoFile("AiC/AiC_math.lua")--AiC数学库
DoFile("AiC/AiC_sdl.lua")--AiC SDL支持（未完成）

---输入
DoFile("AiC/AiC_input.lua")--AiC输入，依赖aic.table,aic.math
DoFile("AiC/AiC_dinput.lua")--AiC DirectInput扩展

---游戏内
DoFile("AiC/AiC_l10n.lua")--AiC本土化
DoFile("AiC/AiC_custom_dialog.lua")--AiC自定义对话库，依赖aic.string,aic.l10n,aic.table
DoFile("AiC/AiC_menu.lua")--AiC菜单，依赖aic.sys,aic.input,aic.l10n,aic.table,aic.string,aic.ui
DoFile("AiC/AiC_ui.lua")--AiC UI，依赖aic.custom_dialog，依赖aic.l10n,aic.table,aic.string
DoFile("AiC/AiC_rpg.lua")--AiC RPG支持库

---系统相关
DoFile("AiC/AiC_ext.lua")--AiC ext扩展库，依赖aic.view3d
DoFile("AiC/AiC_sys.lua")--AiC 系统，依赖aic.py

---API全局化
DoFile("AiC/AiC_api.lua")--AiC API

return aic

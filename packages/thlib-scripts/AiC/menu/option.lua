local lib = aic.menu



---option（大致与ext的option相同）
lib.option = Class(object)

function lib.option:init()
    self.num = 6
    self.x = screen.width * 0.5
    self.y = screen.height * 0.5
    self.default_x = screen.width * 0.5
    self.default_y = screen.height * 0.5
    self.pos1 = 1
    self.pos2 = 1
    self.t = 16
    self.l1 = 16
    self.l2_key = 9
    self.l2_keysys = 5
    self.l2 = self.l2_key + self.l2_keysys
    self.alpha = 255
    self.scale = 0.5
    self.level = 1
    self.wait = 30
    self.timer = 0
    self.key_changing = false
    self.username_changing = false
    self.username = setting.username
    self.bound = false
    self.setting = loadConfigureTable() --因为需要存读文件，为了安全起见这边和插件菜单一样单独先存一份，保存时再存整个表到setting
    self.res = { { 640, 480 }, { 800, 600 }, { 960, 720 }, { 1024, 768 }, { 1280, 960 }, { 1600, 1200 },
        { 1920, 1440 }, { 2560, 1920 }, { 3200, 2400 }, { 3840, 2880 }, { 4320, 3240 }, { 5120, 3840 } }
    

    self.applySetting = function(newsetting)
        setting.username = setting.username or self.username
        setting.locale = newsetting.locale
        aic.l10n.Reload()
        setting.resx, setting.resy, setting.windowed, setting.vsync = newsetting.resx, newsetting.resy, newsetting.windowed, newsetting.vsync
        if not lstg.ChangeVideoMode(setting.resx, setting.resy, setting.windowed, setting.vsync) then
            setting.windowed = true
            saveConfigure()
            if not lstg.ChangeVideoMode(newsetting.resx, newsetting.resy, newsetting.windowed, newsetting.vsync) then
                stage.QuitGame()
                return
            end
        end
        lstg.SetSEVolume(newsetting.sevolume / 100)
        lstg.SetBGMVolume(newsetting.bgmvolume / 100)
        saveConfigureTable(newsetting)
        loadConfigure()
        ResetScreen(true)
        ResetUI()
    end

    self.reload = function()
        local o = l10n.ui.option
        self.text1 = {
            { o.username, setting.username, setting.username },
            { o.locale --[[ aic.l10n.lang[zh_cn][2], aic.l10n.lang[zh_tc][2], aic.l10n.lang[en_us][2], aic.l10n.lang[ja_jp][2], ... ]] }, --实际为在下面读取l10n中已加载语言
            { o.resolution, 7, { 1, 3, 4, 5, 7 } },
            { o.display_mode, o.fullscreen_mode, o.windowed_mode },
            { o.vsync, l10n.general.terms.off, l10n.general.terms.on },
            { o.SFX, 21, { 1, 5, 9, 13, 17, 21 } },
            { o.BGM, 21, { 1, 5, 9, 13, 17, 21 } },
            { o.autofire, l10n.general.terms.off, l10n.general.terms.on },
            { o.autoslow, l10n.general.terms.off, l10n.general.terms.on },
            { o.autododge, l10n.general.terms.off, l10n.general.terms.on },
            { o.opening_se, o.old_version, o.new_version },
            { o.title_bgm, o.normal_version, o.full_version },
            { o.sfwmode, l10n.general.terms.on, o.supersafe },
            o.key_binding,
            o.reset,
            o.save_and_quit }
        self.text2 = o.text2
        self.text3 = o.text3
        self.setname = { 'username', 'locale', 'resx', 'windowed', 'vsync', 'sevolume', 'bgmvolume', 'autofire', 'autoslow', 'autododge', 'newopening', 'newbgm', 'sfwmode' }

        --实际为在下面读取l10n中已加载语言
        local lang = {
            --[[
            zh_cn = "简体中文(CN)",
            zh_tc = "繁體中文(TC)",
            en_us = "English(US)",
            ja_jp = "日本語(JP)",
            --]]
        }
        for k, _ in pairs(aic.l10n.lang) do
            lang[k] = aic.l10n.lang[k][2]
        end
        self.lang_kt = setvaluetable(sp.copy(aic.l10n.lang_list), lang)
        ---对键表调用ipairs会按顺序返回键值对，并额外返回一个计数变量
        for k, v, i in ipairs(self.lang_kt) do
            if k == self.setting.locale then
                self.pos_locale = i
            end
            table.insert(self.text1[2], v)
        end

        for k, v in ipairs(self.res) do
            if v[1] == self.setting.resx then
                self.pos_res = k
            end
        end
        for _, v in ipairs({ 'autofire', 'autoslow', 'autododge', 'newopening', 'newbgm' }) do 
            self.setting[v] = self.setting[v] or false
        end
        self.setting.sfwmode = self.setting.sfwmode or true
    end

    self.flyin = function()
        self.locked = true
        --self.wait = self.t
        self.x = self.default_x + screen.width * 0.25
        self.y = self.default_y
        task.New(self, function()
            task.Wait(self.t / 4)
            for i = 1, self.t * 3 / 4 do
                self.alpha = i * 255 / (self.t * 3 / 4)
                task.Wait()
            end
            self.locked = false
        end)
        task.New(self, function()
            task.MoveTo(self.default_x, self.y, self.t, 2)
        end)
    end

    self.flyout = function(dir)
        self.locked = true
        --self.wait = self.t
        task.New(self, function()
            for i = 1, self.t do
                self.alpha = 255 - i * 255 / self.t
                task.Wait()
            end
        end)
        if dir == 1 then
            task.New(self, function()
                --task.MoveTo(self.x, screen.height * 1.5, self.t, 2)
                task.MoveTo(self.x, self.y + 20, self.t, 2)
            end)
        elseif dir == -1 then
            task.New(self, function()
                --task.MoveTo(self.x, screen.height * -0.5, self.t, 2)
                task.MoveTo(self.x, self.y - 20, self.t, 2)
            end)
        elseif dir == 'quit' then
            lib.PopMenuStack()
        end
    end

    self.reload()
    lib.Fly(self, 1, 'right')
end

function lib.option:frame()
    task.Do(self)
    self.timer = self.timer + 1
    self.wait = max(self.wait - 1, 0)
    if self.wait < 1 and not self.locked then
        --local lastkey = GetLastKey()
        local set = self.setting
        if self.level == 1 then
            --一层（主设置）逻辑
            if self.username_changing then
                if aic.input.CheckLastKey('menu') then
                    self.wait = self.t
                    self.username_changing = false
                end
                local lastchar = aic.input.GetLastChar()
                if #self.username < 8 and lastchar then
                    self.wait = 8
                    self.username = self.username .. lastchar
                end
                if GetKeyState(KEY.ESCAPE) then
                    self.wait = self.t
                    set.username = self.username
                    self.username_changing = false
                end
                if GetKeyState(KEY.BACKSPACE) then
                    self.wait = 8
                    self.username = string.sub(self.username, 1, -2)
                end
                return
            end
            if KeyIsPressed('spell') or aic.input.CheckLastKey('menu') then
                --不保存直接退出
                PlaySound('cancel00', 0.5)
                self.flyout('quit') 
            end
            if KeyIsPressed('shoot') then
                self.wait = self.t
                --这里写死位置说实话不太好，但没什么更好的解决办法了
                if self.pos1 == 1 then
                    PlaySound('ok00', 0.5)
                    self.username_changing = true
                elseif self.pos1 == 14 then
                    --进入键位设置
                    PlaySound('ok00', 0.5)
                    self.key_changing = false
                    self.flyout(-1)
                    task.New(self, function()
                        task.Wait(self.t)
                        self.level = 2
                        self.x = self.default_x
                        self.y = self.default_y
                        for i = 1, self.t do
                            self.alpha = i * 255 / self.t
                            task.Wait()
                        end
                        self.locked = false
                    end)
                elseif self.pos1 == 15 then
                    --还原默认设置
                    PlaySound('ok00', 0.5)
                    self.setting = sp.copy(default_setting) --抄一份默认设置
                    --我忘记这几个为什么要单独写出来了，可能是因为原版setting没有吧
                    for _, v in ipairs({ 'autofire', 'autoslow', 'autododge', 'newopening', 'newbgm' }) do 
                        self.setting[v] = false
                    end
                    self.setting.sfwmode = true
                elseif self.pos1 == 16 then
                    --保存并退出
                    set.resx = self.res[self.pos_res][1]
                    set.resy = self.res[self.pos_res][2]
                    self.applySetting(set)
                    PlaySound('ok00', 0.5)
                    self.flyout('quit')
                end
            end
            --上下移动与调节逻辑
            if KeyIsDown('up') then
                self.wait = 8
                PlaySound('aic_setting_move', 0.5)
                if self.pos1 > 1 then
                    self.pos1 = self.pos1 - 1
                else
                    self.pos1 = self.l1
                end
            elseif KeyIsDown('down') then
                self.wait = 8
                PlaySound('aic_setting_move', 0.5)
                if self.pos1 < self.l1 then
                    self.pos1 = self.pos1 + 1
                else
                    self.pos1 = 1
                end
            elseif KeyIsDown('left') then
                self.wait = 8
                --又是写死……哎
                if self.pos1 == 1 or (self.pos1 == 2 and self.pos_locale == 1) or (self.pos1 == 6 and set.sevolume == 0) or (self.pos1 == 7 and set.bgmvolume == 0) or (self.pos1 == 13 and not set.sfwmode) then
                    PlaySound('aic_setting_limited', 0.3)
                else
                    PlaySound('aic_setting_scroll', 0.5)
                end
                if self.pos1 == 1 then
                elseif self.pos1 == 2 then
                    self.pos_locale = max(self.pos_locale - 1, 1)
                    set.locale = self.lang_kt('get', self.pos_locale)
                    setting.locale = set.locale
                    aic.l10n.Reload()
                    self.reload()
                elseif self.pos1 == 3 then
                    if self.pos_res > 1 then
                        self.pos_res = self.pos_res - 1
                    else
                        self.pos_res = #self.res
                    end
                elseif self.pos1 == 6 then
                    set.sevolume = max(0, set.sevolume - 5)
                elseif self.pos1 == 7 then
                    set.bgmvolume = max(0, set.bgmvolume - 5)
                elseif self.pos1 == 13 and set.sfwmode then
                    set.sfwmode = not set.sfwmode
                else
                    for k, v in pairs(self.setname) do
                        if self.pos1 == k and v ~= 'sfwmode' then
                            set[v] = not set[v]
                        end
                    end
                end
            elseif KeyIsDown('right') then
                self.wait = 8
                if self.pos1 == 1 or (self.pos1 == 2 and self.pos_locale == self.lang_kt('len')) or (self.pos1 == 6 and set.sevolume == 100) or (self.pos1 == 7 and set.bgmvolume == 100) or (self.pos1 == 13 and set.sfwmode) then
                    PlaySound('aic_setting_limited', 0.3)
                else
                    PlaySound('aic_setting_scroll', 0.5)
                end
                if self.pos1 == 1 then
                elseif self.pos1 == 2 then
                    self.pos_locale = min(self.pos_locale + 1, self.lang_kt('len'))
                    set.locale = self.lang_kt('get', self.pos_locale)
                    setting.locale = set.locale
                    aic.l10n.Reload()
                    self.reload()
                elseif self.pos1 == 3 then
                    if self.pos_res < #self.res then
                        self.pos_res = self.pos_res + 1
                    else
                        self.pos_res = 1
                    end
                elseif self.pos1 == 6 then
                    set.sevolume = min(100, set.sevolume + 5)
                elseif self.pos1 == 7 then
                    set.bgmvolume = min(100, set.bgmvolume + 5)
                elseif self.pos1 == 13 and not set.sfwmode then
                    set.sfwmode = not set.sfwmode
                else
                    for k, v in pairs(self.setname) do
                        if self.pos1 == k and v ~= 'sfwmode' then
                            set[v] = not set[v]
                        end
                    end
                end
            end
        else
            if self.key_changing then
                if aic.input.InputState ~= 'keyboard' then
                    local KEY
                    if aic.input.dinput.isConnected(1) then
                        KEY = DJOY
                    else
                        KEY = XJOY
                    end
                    local key = aic.input.GetLastJoy()
                    for _, v in pairs(KEY) do
                        if key == v and v ~= 0 then
                            if self.pos2 <= self.l2_key then
                                local keys, k = set.joysticks, string.lower(self.text3[self.pos2][1])
                                keys[k] = v
                            else
                                local keysys, k = set.joysticksys, string.lower(self.text3[self.pos2][1])
                                keysys[k] = v
                            end
                            self.key_changing = false
                            PlaySound('aic_ok', 0.5)
                        end
                    end
                else
                    for _, v in pairs(KEY) do
                        if GetKeyState(v) then
                            if self.pos2 <= self.l2_key then
                                local keys, k = set.keys, string.lower(self.text3[self.pos2][1])
                                keys[k] = v
                            else
                                local keysys, k = set.keysys, string.lower(self.text3[self.pos2][1])
                                keysys[k] = v
                            end
                            self.key_changing = false
                            PlaySound('aic_ok', 0.5)
                        end
                    end
                end
            else
                if KeyIsPressed('spell') or aic.input.CheckLastKey('menu') then
                    PlaySound('cancel00', 0.5)
                    self.level = 1
                    self.flyout(-1)
                    self.flyin()
                elseif KeyIsPressed('shoot') then
                    PlaySound('select00', 0.5)
                    if self.pos2 == self.l2 then
                        self.level = 1
                        self.flyout(-1)
                        self.flyin()
                    else
                        self.wait = 30
                        self.key_changing = true
                    end
                end
                if KeyIsDown('up') then
                    self.wait = 8
                    PlaySound('aic_setting_move', 0.5)
                    if self.pos2 > 1 then
                        self.pos2 = self.pos2 - 1
                    else
                        self.pos2 = self.l2
                    end
                elseif KeyIsDown('down') then
                    self.wait = 8
                    PlaySound('aic_setting_move', 0.5)
                    if self.pos2 < self.l2 then
                        self.pos2 = self.pos2 + 1
                    else
                        self.pos2 = 1
                    end
                end
            end
        end
    end
end

function lib.option:render()
    SetViewMode('ui')
    --SetImageState('white', '', Color(150, 85, 76, 74))
    --RenderRect('white', 0, screen.width, 0, screen.height)
    --副标题
    lib.DrawSubTitle(self, screen.width * 0.8)
    SetImageState('Muki_AiC_square_empty', '', color(COLOR_WHITE, self.alpha))
    SetImageState('Muki_AiC_square_middle', '', color(COLOR_WHITE, self.alpha))
    local d, x, y = 30, self.x - 30, self.y + screen.height * 0.45
    local x1, x2 = x - screen.width * 0.4, x + screen.width * 0.1
    local lang = self.lang_kt
    local lang_square_offset = 5

    if self.level == 1 then
        lib.DrawTips(self, { l10n.ui.tips.select, l10n.ui.tips.back }, { l10n.ui.tips.select_option, l10n.ui.tips.change_option })
        --设置名称与值
        for i = 1, self.l1 do
            local text = self.text1[i]
            if type(text) == 'string' then
                --用户名、键位设定、使用默认设定、保存并退出
                DrawText('main_font_zh_cn', text, x1, y + (self.pos1 / 3 - i) * d, 1,
                    color(COLOR_WHITE, self.alpha), nil, 'left')
            else
                DrawText('main_font_zh_cn', text[1], x1, y + (self.pos1 / 3 - i) * d, 1,
                    color(COLOR_WHITE, self.alpha), nil, 'left')
                if type(text[2]) == 'string' then
                    --选择项类型
                    local x, dx, dy = (x1 + x2) / 2, 5, -10
                    --注意：这里是写死的位置
                    if i ~= 1 and i ~= 2 then
                        Render('Muki_AiC_square_empty', x - dx, y + (self.pos1 / 3 - i) * d + dy, 0, 0.25)
                        Render('Muki_AiC_square_empty', x + dx, y + (self.pos1 / 3 - i) * d + dy, 0, 0.25)
                        --多于两个选项的特殊处理
                        if i == 13 then
                            Render('Muki_AiC_square_empty', x + 3 * dx, y + (self.pos1 / 3 - i) * d + dy, 0, 0.25)
                        end
                    end
                    if i == 2 then
                        for j = 1, lang('len') do
                            Render('Muki_AiC_square_empty', x + (2 * j - lang_square_offset) * dx, y + (self.pos1 / 3 - i) * d + dy, 0, 0.25)
                        end
                    end
                    --这里原来只考虑了只有真假两种状态的选择项，对用户名和语言要特殊处理
                    if self.setting[self.setname[i]] then
                        --注意：这里是写死的位置
                        if i == 1 then
                            --不知道为什么这里直接用表里的不行
                            DrawText('main_font_zh_cn', self.username, x2, y + (self.pos1 / 3 - i) * d,
                                1, color(COLOR_WHITE, self.alpha), nil, 'right')
                        else
                            if i == 2 then
                                DrawText('main_font_zh_cn', text[self.pos_locale + 1], x2, y + (self.pos1 / 3 - i) * d,
                                    1, color(COLOR_WHITE, self.alpha), nil, 'right')
                                for j = 1, lang('len') do
                                    if lang('get', j) == self.setting.locale then
                                        Render('Muki_AiC_square_middle', x + (2 * j - lang_square_offset) * dx, y + (self.pos1 / 3 - i) * d + dy, 0, 0.25)
                                    end
                                end
                            else
                                DrawText('main_font_zh_cn', text[3], x2, y + (self.pos1 / 3 - i) * d,
                                    1, color(COLOR_WHITE, self.alpha), nil, 'right')
                                if i == 13 then
                                    Render('Muki_AiC_square_middle', x + 3 * dx, y + (self.pos1 / 3 - i) * d + dy, 0, 0.25)
                                else
                                    Render('Muki_AiC_square_middle', x + dx, y + (self.pos1 / 3 - i) * d + dy, 0, 0.25)
                                end
                            end
                        end
                    else
                        --注意：这里是写死的位置
                        if i == 2 then
                            DrawText('main_font_zh_cn', text[self.pos_locale + 1], x2, y + (self.pos1 / 3 - i) * d,
                                1, color(COLOR_WHITE, self.alpha), nil, 'right')
                        else
                            DrawText('main_font_zh_cn', text[2], x2, y + (self.pos1 / 3 - i) * d,
                                1, color(COLOR_WHITE, self.alpha), nil, 'right')
                        end
                        if i ~= 1 and i ~= 2 then
                            if i == 13 then
                                Render('Muki_AiC_square_middle', x + dx, y + (self.pos1 / 3 - i) * d + dy, 0, 0.25)
                            else
                                Render('Muki_AiC_square_middle', x - dx, y + (self.pos1 / 3 - i) * d + dy, 0, 0.25)
                            end
                        end
                    end
                else
                    --拖动条类型（虽然并不能拖）
                    local x, d1, d2, dy = (x1 + x2) / 2 - 20, 2, 5, -15
                    for j = 1, text[2] do
                        local len = 5
                        if aic.table.Search(text[3], j) then len = 10 end
                        --[[aic.ui.RenderStroke(RenderRect, color(COLOR_BLACK, self.alpha), 'white',
                            x + j * d2, x + j * d2 + d1,
                            y + (self.pos1 / 3 - i) * d + dy, y + (self.pos1 / 3 - i) * d + len + dy)]]
                        SetImageState('white', '', color(COLOR_WHITE, self.alpha))
                        RenderRect('white', x + j * d2, x + j * d2 + d1,
                            y + (self.pos1 / 3 - i) * d + dy, y + (self.pos1 / 3 - i) * d + len + dy)
                        local y0 = y + (self.pos1 / 3 - i) * d + dy + 15
                        local p
                        --注意：这里是写死的位置
                        if i == 3 then
                            p = self.pos_res
                        elseif i == 6 then
                            p = self.setting.sevolume / 5 + 1
                        elseif i == 7 then
                            p = self.setting.bgmvolume / 5 + 1
                        end
                        if j == p then
                            local x0 = x + j * d2 + d1 / 2
                            Render('Muki_AiC_square_empty', x0, y0, 0, 0.1)
                            Render('Muki_AiC_square_middle', x0, y0, 0, 0.1)
                        end
                    end
                    --[[
                    aic.ui.RenderStroke(RenderRect, color(COLOR_BLACK, self.alpha), 'white',
                        x + d2, x + text[2] * d2 + d1,
                        y + (self.pos1 / 3 - i) * d - d1 + dy, y + (self.pos1 / 3 - i) * d + dy)
                    SetImageState('white', '', color(COLOR_WHITE, self.alpha))]]
                    RenderRect('white', x + d2, x + text[2] * d2 + d1,
                        y + (self.pos1 / 3 - i) * d - d1 + dy, y + (self.pos1 / 3 - i) * d + dy)
                end
            end
        end

        --注意：这里是写死的位置（渲染位置和警告的显示）
        --分辨率
        local res = self.res[self.pos_res][1] .. 'x' .. self.res[self.pos_res][2]
        DrawText('main_font_zh_cn', res,
            x2, y + (self.pos1 / 3 - 3) * d, 1, color(COLOR_WHITE, self.alpha), nil, 'right')

        --音量
        DrawText('main_font_zh_cn', self.setting.sevolume .. '%',
            x2, y + (self.pos1 / 3 - 6) * d, 1, color(COLOR_WHITE, self.alpha), nil, 'right')
        DrawText('main_font_zh_cn', self.setting.bgmvolume .. '%',
            x2, y + (self.pos1 / 3 - 7) * d, 1, color(COLOR_WHITE, self.alpha), nil, 'right')

        --设置说明
        DrawText('main_font_zh_cn', self.text2[self.pos1],
            x2 + 150, y - 5 * d, 1, color(COLOR_WHITE, self.alpha), nil, 'centerpoint')
        if self.pos1 == 13 then
            DrawText('main_font_zh_cn', l10n.ui.option.sfwmode_warning,
                x2 + 150, y - 5 * d + 8, 1, color(COLOR_RED, self.alpha), nil, 'centerpoint')
        end

        --指示光标
        local l, r, o = '<', '>', 3
        if self.username_changing then l, r, o = '>', '<', 5 end
        if not self.locked then
            for i = 1, self.l1 do
                if i == self.pos1 then
                    DrawText('main_font_zh_cn', l, x1 - 25 - 5 * sin(o * self.timer),
                        y + (self.pos1 / 3 - i) * d, 1, color(COLOR_WHITE, self.alpha), nil, 'left')
                    DrawText('main_font_zh_cn', r, x2 + 25 + 5 * sin(o * self.timer),
                        y + (self.pos1 / 3 - i) * d, 1, color(COLOR_WHITE, self.alpha), nil, 'right')
                end
            end
        end
    else
        lib.DrawTips(self, { l10n.ui.tips.change_key_binding, l10n.ui.tips.back }, { l10n.ui.tips.select_key_binding })
        --键位名称与当前键位
        --在这里学到的教训：如果你打算写一个三层以上的嵌套，不要嫌麻烦，每一层的索引都应该单独写出来，否则出现nil时都不知道是哪一层的问题
        local keyname, key = aic.input.KeyNameList()
        local keys, keysys = self.setting.keys, self.setting.keysys
        if aic.input.InputState == 'xjoy' then
            keyname = XJOY
            keys, keysys = self.setting.joysticks, self.setting.joysticksys
        elseif aic.input.InputState == 'djoy' then
            keyname = DJOY
            keys, keysys = self.setting.joysticks, self.setting.joysticksys
        end
        for i = 1, self.l2 - 1 do
            if aic.input.InputState == 'keyboard' then
                if i <= self.l2_key then
                    local k = string.lower(self.text3[i][1])
                    key = keyname[keys[k]]
                else
                    local k = string.lower(self.text3[i][1])
                    key = keyname[keysys[k]]
                end
            else
                if i <= self.l2_key then
                    local k = string.lower(self.text3[i][1])
                    key = aic.table.Search(keyname, keys[k])
                else
                    local k = string.lower(self.text3[i][1])
                    key = aic.table.Search(keyname, keysys[k])
                end
            end

            --键位设定
            if setting.locale ~= 'en_us' then
                DrawText('main_font_zh_cn', self.text3[i][1], x1, y + (self.pos2 / 3 - i) * d + 8, 0.5,
                    color(COLOR_WHITE, self.alpha), nil, 'left')
            end
            DrawText('main_font_zh_cn', self.text3[i][2], x1, y + (self.pos2 / 3 - i) * d, 1,
                color(COLOR_WHITE, self.alpha), nil, 'left')
            if key then
                DrawText('main_font_zh_cn', key, x2, y + (self.pos2 / 3 - i) * d,
                    1, color(COLOR_WHITE, self.alpha), nil, 'right')
            end
        end

        --返回选项
        DrawText('main_font_zh_cn', l10n.ui.option.return_to_option, x1, y + (self.pos2 / 3 - self.l2) * d, 1,
            color(COLOR_WHITE, self.alpha), nil, 'left')
        
        --设置说明
        local text = l10n.ui.option.choose_key_binding
        if self.key_changing then text = l10n.ui.option.input_new_key_binding end
        if self.pos2 == self.l2 then text = l10n.ui.option.return_to_option_and_save end
        DrawText('main_font_zh_cn', text,
            x2 + 150, y - 3 * d, 1, color(COLOR_WHITE, self.alpha), nil, 'centerpoint')

        --指示光标
        local l, r, o = '<', '>', 3
        if self.key_changing then l, r, o = '>', '<', 5 end
        if not self.locked then
            for i = 1, self.l2 do
                if i == self.pos2 then
                    DrawText('main_font_zh_cn', l, x1 - 25 - 5 * sin(o * self.timer),
                        y + (self.pos2 / 3 - i) * d, 1, color(COLOR_WHITE, self.alpha), nil, 'left')
                    DrawText('main_font_zh_cn', r, x2 + 25 + 5 * sin(o * self.timer),
                        y + (self.pos2 / 3 - i) * d, 1, color(COLOR_WHITE, self.alpha), nil, 'right')
                end
            end
        end

    end

    SetViewMode('world')
end

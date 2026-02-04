---=====================================
---THLoOP Debug v1.00a
---东方梦摇篮Debug v1.01a
---=====================================

---版本更新记录
---v1.00a
---初始版本

---@class aic.debug @东方梦摇篮Debug
aic.debug = {}
local lib = aic.debug

--有一种暴力的美（
---解析环境或表或特定变量的所有信息
---@param env any @要解析的环境或表或特定变量
---@param unpack boolean @是否递归调用获取表中所有表的信息，默认为true
---@param maxlevel number @最大递归层数，也是最深能查找的表的层数，默认为10
---@param Cfilter boolean @是否过滤掉C函数，默认为true
---@param classfilter boolean @是否过滤掉class，默认为true
---@param string boolean @是否打印string类型的名称与值，默认为true
---@param number boolean @是否打印number类型的名称与值，默认为true
---@param boolean boolean @是否打印boolean类型的名称与值，默认为true
---@param other boolean @是否打印其他类型的名称与类型，默认为true
---@param tablename string @递归调用时传入，当前获取的表的名称
---@param level number @递归调用时传入，当前递归调用层级，用于确定缩进
---@return string @所有信息！
function lib.GetAllInfo(env, unpack, maxlevel, Cfilter, classfilter, string, number, boolean, other, tablename, level)
    --递归调用层级
    level = level or 0
    --最大递归层数（其实基本上递归到5层就是极限了）
    maxlevel = maxlevel or 10
    --防止栈溢出
    if level >= maxlevel then return '' end
    --改变默认值
    if unpack == nil then unpack = true end
    if Cfilter == nil then Cfilter = true end
    if classfilter == nil then classfilter = true end
    if string == nil then string = true end
    if number == nil then number = true end
    if boolean == nil then boolean = true end
    if other == nil then other = true end
    --要获取的表或环境
    env = env or getfenv()
    --解析单个变量时将其临时包装为表
    if type(env) ~= 'table' then
        env = { env }
    end
    --存储函数信息的表
    local func = {}
    --函数信息类型
    local infoname = {
        ['定义起始行'] = 'linedefined',
        ['定义结束行'] = 'lastlinedefined',
        ['是否接受变长参数'] = 'isvararg',
        ['源代码路径'] = 'source',
        ['函数类型（C或Lua）'] = 'what',
        ['形参数量'] = 'nparams',
        ['上值数量'] = 'nups',
    }
    --函数信息类型的键表，用于保证函数信息按顺序输出
    --当然写个有序字典也可以解决这个问题
    local setvaluetable = setvaluetable or aic.table.SetValueTable
    local infoname_kt = setvaluetable({
        '定义起始行', '定义结束行', '是否接受变长参数', '源代码路径',
        '函数类型（C或Lua）', '形参数量', '上值数量' }, infoname)
    ---@type string
    ---因为string已经作为形参名，这里使用面向对象的方式调用string的函数
    local tab = '\t'
    local indent = tab:rep(level)
    --所有信息
    local allinfo = ''
    if not tablename then allinfo = '以下是给定变量的所有信息：\n' end
    for k, v in pairs(env) do
        if type(v) == 'string' then
            if string then
                allinfo = allinfo .. '\n' .. indent .. '字符串' .. k .. '的值是：' .. tostring(v) .. '\n'
            end
        elseif type(v) == 'number' then
            if number then
                allinfo = allinfo .. '\n' .. indent .. '数字' .. k .. '的值是：' .. tostring(v) .. '\n'
            end
        elseif type(v) == 'boolean' then
            if boolean then
                allinfo = allinfo .. '\n' .. indent .. '布尔值' .. k .. '的值是：' .. tostring(v) .. '\n'
            end
        elseif type(v) == 'table' and unpack and v ~= env and not (v.is_class and classfilter) then
            allinfo = allinfo .. '\n' .. indent .. '以下是表' .. k .. '的所有信息：\n\n'
                .. lib.GetAllInfo(v, unpack, maxlevel - 1, Cfilter, classfilter,
                    string, number, boolean, other, k, level + 1)
        elseif type(v) == 'function' and not (Cfilter and debug.getinfo(v).what == 'C') then
            func[k] = debug.getinfo(v)
            local info = func[k]
            info.params = {}
            for i = 1, info.nparams do
                local name = debug.getlocal(v, i)
                table.insert(info.params, name)
            end
            info.ups = {}
            for i = 1, info.nups do
                local name, value = debug.getupvalue(v, i)
                info.ups[name] = value
            end
        else
            if other then
                if type(v) == 'table' and v.is_class then
                    allinfo = allinfo .. indent .. k .. '的类型是：' .. 'class' .. '\n'
                elseif type(v) == 'function' then
                    allinfo = allinfo .. indent .. k .. '的类型是：' .. 'Cfunction' .. '\n'
                else
                    allinfo = allinfo .. indent .. k .. '的类型是：' .. type(v) .. '\n'
                    allinfo = allinfo .. indent .. k .. '的值是：' .. tostring(v) .. '\n'
                end
            end
        end
    end
    for k1, v1 in pairs(func) do
        local info = '\n' .. indent .. '以下是函数' .. k1 .. '的信息：' .. indent .. '\t'
        --[=[
        for i = 1, infoname_kt('len') do
            info = info .. '\n\t' .. indent .. infoname_kt('get', i) .. ':' .. tostring(v1[infoname_kt[i]])
        end
        --]=]
        for k, v in ipairs(infoname_kt) do
            info = info .. '\n\t' .. indent .. k .. ':' .. tostring(v1[v])
        end
        if v1.nparams > 0 then
            info = info .. '\n\t' .. indent .. '形参名称：' .. table.concat(v1.params, ', ')
        end
        if v1.nups > 0 then
            info = info .. '\n\t' .. indent .. '上值名称与值：'
            for k3, v3 in pairs(v1.ups) do
                info = info .. k3 .. ' = ' .. tostring(v3) .. ' '
            end
        end
        allinfo = allinfo .. info .. '\n'
    end
    if tablename then
        allinfo = allinfo .. '\n' .. tab:rep(level - 1) .. '表' .. tablename .. '的所有信息已经打印完毕。\n'
    else
        allinfo = allinfo .. '\n' .. '给定表' .. '的所有信息已经打印完毕。\n'
    end
    return allinfo
end

---命令行窗口（未完成，多行逻辑存在问题）

lib.Terminal = Class(object)

function lib.Terminal:init(x, y, print_to_log)
    self.group = GROUP_GHOST
    self.layer = LAYER_TOP + _infinite
    self.bound = false
    self.state = 'normal'
    self.hist1 = {}
    self.hist2 = {}
    self.input = {}
    self.cursor = 0
    self.x = x or screen.width / 8
    self.y = y or screen.height * 7 / 8
    self.a = 200
    self.b = 800
    self.wait = 20
    self.t = 30
    self.lastchar = ''
    -- 修改: 使用一个栈来管理嵌套的代码块
    self.block_stack = {}
    self.tmpinput_code = ''
    self.tmpinput_for_history = {}
    self.print_to_log = print_to_log
    self.is_terminal = true

    -- 获取新块类型
    function self.getNewBlockType(line)
        line = line:gsub("^%s+", "") -- Remove leading whitespace
        if line:match("^if%s+") then return "if" end
        if line:match("^while%s+") then return "while" end
        if line:match("^for%s+") then return "for" end
        if line:match("^repeat $ ") then return "repeat" end
        if line:match("^function%s+") then return "function" end
        if line:match("^do $ ") then return "do" end
        return nil
    end

    -- 弹出匹配的块
    function self.popMatchingBlock(end_line)
        if #self.block_stack == 0 then
            -- 如果堆栈为空却遇到结束符，这是一个语法错误
            return "unexpected_end"
        end
        local top_block = self.block_stack[#self.block_stack]

        -- 检查是否是标准的 'end' 结束符
        if end_line:match("^%s*end%s*") then -- 放宽对行尾的要求，允许注释
            if top_block == "if" or top_block == "while" or top_block == "for"
                or top_block == "function" or top_block == "do" then
                table.remove(self.block_stack) -- 弹出匹配的块
                return top_block
            elseif top_block == "repeat" then
                -- 'repeat' 的结束符是 'until', 不是 'end'
                return "mismatched_end"
            end
            -- 检查 'until' 结束符
        elseif end_line:match("^%s*until%s+") then
            if top_block == "repeat" then
                table.remove(self.block_stack)  -- 弹出 repeat 块
                return top_block
            else
                -- 'until' 只能结束 'repeat'
                return "mismatched_until"
            end
            -- 检查 'else' 或 'elseif' - 它们不是结束符，而是 if 块的一部分
        elseif end_line:match("^%s*else%s* $ ") or end_line:match("^%s*elseif%s+") then
            if top_block == "if" then
                -- 'else'/'elseif' 属于当前 'if' 块，不弹出，返回特殊标记
                return "part_of_if"
            else
                -- 'else'/'elseif' 不能出现在非 'if' 块内
                return "unexpected_else_or_elseif"
            end
        end
        -- 如果到这里还没匹配，说明遇到了不匹配的 'end' (例如 while 内遇到 for 的 end)
        return "mismatched_end"
    end

    -- 获取缩进字符串
    function self.getIndentString(level)
        return string.rep('    ', level)
    end

    -- 清空当前输入行
    function self.clearCurrentInput()
        self.cursor = 0
        self.input = {}
    end

    -- 记录输入历史
    function self.recordHistory(input_str)
        local indent_prefix = self.getIndentString(#self.block_stack)
        if #self.block_stack == 0 then
            indent_prefix = ">>> " .. indent_prefix
        end
        table.insert(self.hist1, indent_prefix .. input_str)
    end
end

function lib.Terminal:frame()
    self.wait = max(self.wait - 1, -self.t)
    if self.wait < 1 then
        if self.state == 'normal' then
            if IsValid(player) then
                player.lock = true
            end
            if aic.input.KeyIsPressed(KEY.ESCAPE) then
                self.wait = self.t
                Del(self)
            end
            if aic.input.KeyIsPressed(KEY.ENTER) then
                self.wait = self.t
                self.state = 'input'
            end
            if aic.input.KeyIsPressed(KEY.ALT) then
                self.wait = self.t
                self.state = 'hide'
            end
        elseif self.state == 'hide' then
            if IsValid(player) then
                player.lock = false
            end
            if aic.input.KeyIsPressed(KEY.ENTER) then
                self.wait = self.t
                self.state = 'normal'
            end
        elseif self.state == 'input' then
            if IsValid(player) then
                player.lock = true
            end
            if aic.input.KeyIsDown(KEY.ALT) then
                self.wait = self.t
                self.state = 'normal'
            end
            ---@type string
            local lastchar = aic.input.GetLastChar()
            if lastchar ~= '' and lastchar ~= self.lastchar then --防止重复输入
                self.wait = self.t / 2
                table.insert(self.input, self.cursor + 1, lastchar)
                self.cursor = self.cursor + lastchar:len()
                self.lastchar = lastchar
            end
            if self.wait <= -self.t then
                self.lastchar = ''
            end
            if aic.input.KeyIsDown(KEY.BACKSPACE) then
                self.wait = self.t
                if self.cursor >= 1 then
                    table.remove(self.input, self.cursor)
                    self.cursor = self.cursor - 1
                end
            end
            if aic.input.KeyIsDown(KEY.DELETE) then
                self.wait = self.t
                if self.cursor < #self.input then
                    table.remove(self.input, self.cursor + 1)
                end
            end
            if aic.input.KeyIsDown(KEY.HOME) then
                self.wait = self.t
                self.cursor = 0
            end
            if aic.input.KeyIsDown(KEY.END) then
                self.wait = self.t
                self.cursor = #self.input
            end
            if aic.input.KeyIsDown(KEY.ENTER) then
                self.wait = self.t
                ---@type string
                local current_line_str = table.concat(self.input)

                aic.exception.TryExcept(
                    function()
                        -- 核心执行逻辑放在这里
                        if current_line_str ~= '' then
                            local new_block_type = self.getNewBlockType(current_line_str)
                            if new_block_type then
                                table.insert(self.block_stack, new_block_type)
                                -- 记录多行块的开始行到临时历史
                                table.insert(self.tmpinput_for_history,
                                    self.getIndentString(#self.block_stack - 1) .. current_line_str)
                                self.tmpinput_code = self.tmpinput_code ..
                                    self.getIndentString(#self.block_stack - 1) .. current_line_str .. "\n"
                                self.clearCurrentInput()
                                return nil -- No direct result for starting a block
                            else
                                if current_line_str:match("^%s*end%s* $") or
                                    current_line_str:match("^%s*else%s* $") or
                                    current_line_str:match("^%s*elseif%s+") or
                                    current_line_str:match("^%s*until%s+") then
                                    if #self.block_stack > 0 then
                                        local popped_type = self.popMatchingBlock(current_line_str)
                                        if popped_type then
                                            -- 记录结束行到临时历史
                                            table.insert(self.tmpinput_for_history,
                                                self.getIndentString(#self.block_stack) .. current_line_str)
                                            self.tmpinput_code = self.tmpinput_code ..
                                                self.getIndentString(#self.block_stack) .. current_line_str .. "\n"
                                            if #self.block_stack == 0 then
                                                -- 整个多行块结束，准备执行
                                                local full_code_to_execute = self.tmpinput_code
                                                -- 将临时历史记录移动到正式历史
                                                for _, hist_line in ipairs(self.tmpinput_for_history) do
                                                    table.insert(self.hist1, ">>> " .. hist_line)
                                                end
                                                -- 清空临时存储
                                                self.tmpinput_for_history = {}
                                                self.tmpinput_code = ""

                                                self.clearCurrentInput()
                                                -- 返回执行结果
                                                return aic.func.execute(full_code_to_execute)
                                            end
                                            self.clearCurrentInput()
                                            return nil
                                        else
                                            -- 抛出语法错误，由 Except 捕获
                                            raise(SyntaxError("SyntaxError: unexpected '" ..
                                                current_line_str:match("%w+") .. "'"))
                                        end
                                    else
                                        raise(SyntaxError("SyntaxError: unexpected '" ..
                                            current_line_str:match("%w+") .. "'"))
                                    end
                                else
                                    if #self.block_stack > 0 then
                                        -- 记录中间行到临时历史和代码
                                        table.insert(self.tmpinput_for_history,
                                            self.getIndentString(#self.block_stack) .. current_line_str)
                                        self.tmpinput_code = self.tmpinput_code ..
                                            self.getIndentString(#self.block_stack) .. current_line_str .. "\n"
                                        self.clearCurrentInput()
                                        return nil
                                    else
                                        if current_line_str:find('%b()') or current_line_str:find('^%s*local%s+') or
                                            (current_line_str:find('%s=%s') and not current_line_str:find('[%w_]=')
                                                and not current_line_str:find('==')) then
                                            self.recordHistory(current_line_str)
                                            local execution_result = aic.func.execute(current_line_str)
                                            -- 如果 execute 返回 nil (常见于 print 等无返回值函数)，则不显示结果
                                            -- 否则，显示其返回值
                                            if execution_result ~= nil then
                                                if type(execution_result) == "table" and getmetatable(execution_result) == nil then
                                                    table.insert(self.hist2, aic.table.ToString(execution_result))
                                                    if self.print_to_log then
                                                        Print("[Terminal] " .. aic.table.ToString(execution_result))
                                                    end
                                                else
                                                    table.insert(self.hist2, tostring(execution_result))
                                                    if self.print_to_log then
                                                        Print("[Terminal] " .. tostring(execution_result))
                                                    end
                                                end
                                            end
                                            self.clearCurrentInput()
                                            return nil
                                        else
                                            self.recordHistory(current_line_str)
                                            -- 对于求值表达式，使用 eval 并返回其结果以供后续处理
                                            local evaluation_result = aic.func.eval(current_line_str)
                                            table.insert(self.hist2, tostring(evaluation_result))
                                            if self.print_to_log then
                                                Print("[Terminal] " .. tostring(evaluation_result))
                                            end
                                            self.clearCurrentInput()
                                            return evaluation_result
                                        end
                                    end
                                end
                            end
                        else
                            if #self.block_stack > 0 then
                                -- 记录空行到临时历史和代码
                                table.insert(self.tmpinput_for_history, "")
                                self.tmpinput_code = self.tmpinput_code .. "\n"
                            end
                            self.clearCurrentInput()
                        end
                    end,
                    -- Except: 定义错误处理方式
                    {
                        [""] = function(error_message)
                            -- 将运行时错误或其他错误信息添加到历史记录
                            table.insert(self.hist2, "\n---------- Terminal ----------\n" .. error_message)
                            Log(3, "\n---------- Terminal ----------\n" .. error_message)
                            -- 清空当前输入行
                            self.clearCurrentInput()
                            -- 清空临时多行块历史（因为输入无效）
                            self.tmpinput_for_history = {}
                            self.tmpinput_code = ""
                            -- Block stack might be in an inconsistent state after a syntax error, reset it.
                            self.block_stack = {}
                            -- 返回 nil，表示处理完成
                            return nil
                        end
                    }
                )
            end
            if KeyIsDown('left') then
                self.wait = self.t
                self.cursor = max(self.cursor - 1, 0)
            elseif KeyIsDown('right') then
                self.wait = self.t
                self.cursor = min(self.cursor + 1, #self.input)
            end
        end
    end
end

function lib.Terminal:render()
    SetViewMode('ui')
    local x, y = self.x + 2, self.y - 2
    if self.state ~= "hide" then
        SetImageState('white', '', color(COLOR_BLACK, 175))
        RenderRect('white', self.x, self.x + self.a * 2, self.y, self.y - self.b)
    end
    DrawText('consola', "AiC_Debug_Terminal " .. "state:" .. self.state, x, y + 30, 0.8, nil, nil, 'left')
    if self.state ~= "hide" then
        DrawText('consola', "Input History", x, y + 15, 0.8, nil, nil, 'left')
        DrawText('consola', "Result History", x + self.a, y + 15, 0.8, nil, nil, 'left')
        -- 输入历史
        local cur = self.cursor
        local input_str = table.concat(self.input)
        local indent_level = #self.block_stack
        local prompt_prefix = ""
        if indent_level == 0 then
            prompt_prefix = ">>> "
        end
        local input_left = prompt_prefix .. self.getIndentString(indent_level) .. string.sub(input_str, 1, cur)
        local input_right = string.sub(input_str, cur + 1, -1)

        local cursor_char
        if self.timer % 60 < 30 then
            cursor_char = '|'
        else
            cursor_char = ' '
        end
        local final_input_display = input_left .. cursor_char .. input_right
        local history_display = table.concat(self.hist1, "\n")

        DrawText('consola', history_display .. "\n" .. final_input_display, x, y, 0.5, nil, nil, 'left')

        -- 结果历史
        DrawText('consola', table.concat(self.hist2, '\n'), x + self.a, y, 0.5, nil, nil, 'left')
    end
    SetViewMode('world')
end

function lib.Terminal:del()
    if IsValid(player) then
        player.lock = false
    end
end

function lib.NewTerminal(x, y, print_to_log)
    if print_to_log == nil then print_to_log = true end
    for _, o in ObjList(GROUP_GHOST) do
        if o.is_terminal then safeDel(o) end
    end
    New(lib.Terminal, x, y, print_to_log)
end
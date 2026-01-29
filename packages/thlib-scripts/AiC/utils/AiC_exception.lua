---=====================================
---THLoOP Exception v1.00a
---东方梦摇篮 异常处理 v1.01a
---=====================================

---版本更新记录
---v1.00a
---初始版本

---@class aic.exception @东方梦摇篮异常处理
aic.exception = {}
local lib = aic.exception

---基础异常类
---@class Exception
lib.Exception = plus.Class()

function lib.Exception:init(message)
    self.class = Exception
    self.classname = "Exception"
    self.message = message or self.classname
    self.pattern = '.+'
    self.stack = debug.traceback()
    self.timestamp = os.time()
end

function lib.Exception:__tostring()
    return string.format("[%s] %s\nStack trace:\n%s",
        self.classname or "Exception",
        self.message,
        self.stack
    )
end

---@最后触发的异常的错误信息
---@type string|Exception
lib.last_exception = nil

---新建异常类
---@param name string @异常名称
---@param parent plus.Class @异常父类
---@param pattern string @匹配模式
---@@return
function lib.NewException(name, parent, pattern)
    parent = parent or Exception
    local cls = plus.Class(parent)
    cls.classname = name
    cls.pattern = pattern or name

    ---重写 __tostring 以包含类名
    function cls:__tostring()
        return string.format("[%s] %s\nStack trace:\n%s",
            name,
            self.message,
            self.stack
        )
    end

    return cls
end

---常见错误

---编译错误
CompileError = lib.NewException("CompileError", Exception, "falied to compile")

---语法错误
SyntaxError = lib.NewException("SyntaxError", Exception)
UnexpectedSymbol = lib.NewException("UnexpectedSymbol", SyntaxError, ".+expected.+")
MalformedNumber = lib.NewException("MalformedNumber", SyntaxError, "malformed number")
UnfinishedString = lib.NewException("UnfinishedString", SyntaxError, "unfinished string")
InvalidEscapeSequence = lib.NewException("InvalidEscapeSequence", SyntaxError, "invalid escape sequence")
InvalidLongTag = lib.NewException("InvalidLongTag", SyntaxError, "invalid long tag")

---运行时错误
RuntimeError = lib.NewException("RuntimeError", Exception)
CallError = lib.NewException("CallError", RuntimeError, "attempt to call")
IndexError = lib.NewException("IndexError", RuntimeError, "attempt to index")
ArithmeticError = lib.NewException("ArithmeticError", RuntimeError, "attempt to perform arithmetic on")
IterateError = lib.NewException("IterateError", RuntimeError, "attempt to iterate over")
StackOverflow = lib.NewException("StackOverflow", RuntimeError, "stack overflow")

---LuaSTG错误
LstgError = lib.NewException("LstgError", Exception)
ArgumentError = lib.NewException("ArgumentError", LstgError, "invalid argument")
InvalidObj = lib.NewException("InvalidObject", LstgError, "invalid.+object")
LoadFailed = lib.NewException("LoadFailed", LstgError, "load .+ failed")
NotSupported = lib.NewException("NotSuuported", LstgError, "not supported")

---文件错误
FileError = lib.NewException("FileError", Exception)
PermissionDenied = lib.NewException("PermissionDenied", FileError, "Permission denied")
FileNotFound = lib.NewException("PermissionDenied", FileError, "(No such file or directory)|(File not found)")

---其他错误
ModuleNotFound = lib.NewException("ModuleNotFound", Exception, "module .+ not found")
MemoryExhausted = lib.NewException("MemoryExhausted", Exception, "not enough memory")

---模拟`Python`中的`try..except..else..finally`块
---
---当`Try`正常运行时，以`Try`的返回值调用`Else`并返回`Try`的返回值；
---否则根据错误信息类型决定行为：
---若错误信息类型为字符串，在错误信息中查找是否有`Except`中指定*异常*（模式字符串），若有则执行对应函数；
---若错误信息类型为`Exception`，查找是否是`Except`中指定*异常*（异常类）的实例，若有则执行对应函数；
---若错误信息没有与任何*异常*匹配，执行`Except`中索引为''（空字符串）的函数；
---若`Except`中函数发生错误将重新抛出。
---无论何种情况，`Finally`总会在最后执行，且一定会执行。请注意，`Finally`中的错误不会被捕获。
---当`Try`或`Except`正常运行时，以其返回值作为参数调用`Finally`；
---否则以错误信息为参数调用`Finally`。
---`Else`与`Finally`的返回值将被忽略。
---若在`Except`中以表作为索引，则将其视为*异常*的列表，其中任意一个*异常*匹配成功即会执行对应函数；
---
---使用例：
---```
--->TryExcept(function()
--->    Del(object)
--->end,
--->{
--->    [InvalidObj] = function()
--->        Print("invalid object.")
--->    end,
--->    [{ BadArgument, InvalidArgument }] = function()
--->        Print("invalid argument.")
--->    end,
--->    [''] = function()
--->        Print("unhandled error.")
--->},
--->function(ret)
--->    Print("TryExcept successed.")
--->end,
--->function(ret)
--->    Print("TryExcept finished.")
--->end)
---```
---@param Try function @Try代码块
---@param Except table<string|Exception|table<string>|table<Exception>> @Except代码块
---@param Else function @Else代码块
---@param Finally function @Finally代码块
---@param plain boolean @是否使用简单查找（不使用正则表达式与转义字符）
---@overload fun(Try:function, Except:table<string|Exception|table<string>|table<Exception>>)
---@overload fun(Try:function, Except:table<string|Exception|table<string>|table<Exception>>, Else:function)
---@overload fun(Try:function, Except:table<string|Exception|table<string>|table<Exception>>, Else:function, Finally:function)
---@return any
function lib.TryExcept(Try, Except, Else, Finally, plain)
    assert(type(Try) == 'function', "invalid argument.")

    local success, result = xpcall(Try,
        ---@param err? string|Exception
        function(err)
            -- 记录原始错误，无论是字符串还是对象
            lib.last_exception = err
            if type(err) == "string" then
                -- 如果是字符串错误，则附加traceback
                lib.last_exception = err
                    .. "\n========== inner traceback ==========\n"
                    .. debug.traceback()
                    .. "\n=============================="
            elseif type(err) == "table" and getmetatable(err) then
                -- 如果是对象错误，则更新其stack信息
                lib.last_exception = err
                lib.last_exception.stack = debug.traceback()
            else
                -- 其他类型（如 number, boolean 等），转为字符串并附加traceback
                lib.last_exception = tostring(err)
                    .. "\n========== inner traceback ==========\n"
                    .. debug.traceback()
                    .. "\n=============================="
            end
            return lib.last_exception
        end)

    -- 最终要传递给 Finally 的参数
    local finally_args = { result }
    local finally_arg_count = 1

    if success then
        -- Try 成功：返回 Try 的结果，执行 Else（如果有），然后 Finally(result)
        if Else and type(Else) == 'function' then
            xpcall(Else, function(err)
                print("error in Else block: " .. tostring(err))
            end, result)
        end
    else
        -- Try 失败：尝试从 Except 中找匹配的 handler
        local handler_func = nil
        local matched_key = nil
        local original_error = result -- 保存原始错误对象用于传递给handler

        if Except and type(Except) == 'table' then
            -- 遍历 Except 表，寻找匹配项
            for exc_type, handler in pairs(Except) do
                if type(handler) == 'function' then
                    local is_match = false

                    if type(exc_type) == 'table' then
                        -- 情况1：键是异常类
                        if exc_type.init then
                            if aic.class.IsInstance(original_error, exc_type) then
                                is_match = true
                            end
                            -- 情况2：键是字符串列表
                        elseif type(exc_type[1]) == 'string' then
                            local error_str = tostring(original_error) -- 将错误转为字符串进行匹配
                            -- 列表中的多个字符串模式
                            for _, pattern in ipairs(exc_type) do
                                if type(pattern) == 'string' and
                                    string.find(string.lower(error_str), string.lower(pattern), 1, plain) then
                                    is_match = true
                                    break
                                end
                            end
                            -- 情况3：键是异常类列表
                        elseif type(exc_type[1]) == 'table' then
                            for _, t in ipairs(exc_type) do
                                if aic.class.IsInstance(original_error, exc_type) then
                                    is_match = true
                                end
                            end
                            -- 情况4: 键是字符串
                        elseif type(exc_type) == 'string' then
                            local error_str = tostring(original_error) -- 将错误转为字符串进行匹配
                            if exc_type == "" then
                                -- 空字符串作为默认 fallback
                                if not handler_func then
                                    handler_func = handler
                                    matched_key = exc_type
                                end
                            elseif string.find(string.lower(error_str), string.lower(exc_type), 1, plain) then
                                is_match = true
                            end
                        end

                        if is_match then
                            handler_func = handler
                            matched_key = exc_type
                            break
                        end
                    end
                end

                -- 如果没找到具体匹配，使用空字符串对应的 handler（如果存在）
                if not handler_func then
                    handler_func = Except[""]
                    if handler_func then
                        matched_key = ""
                    end
                end
            end

            if handler_func then
                -- 执行匹配到的 Except 分支，传递原始错误对象或字符串
                local esuccess, eresult = xpcall(handler_func, function(err)
                    local handler_err_msg = "\nerror in exception handler for '" ..
                        tostring(matched_key) .. "':\n " .. tostring(err)
                        .. "\n========== inner traceback ==========\n"
                        .. debug.traceback()
                        .. "\n=============================="
                    lib.last_exception = handler_err_msg
                    return lib.last_exception
                end, original_error) -- 关键：传递原始错误，而非格式化后的result

                if esuccess then
                    -- Except 成功处理：更新返回值，继续 Finally
                    result = eresult
                    finally_args = { eresult }
                    finally_arg_count = 1
                else
                    -- Except 自身出错：记录错误，跳过 Else，Finally 接收这个新错误
                    lib.last_exception = eresult
                    finally_args = { eresult }
                    finally_arg_count = 1
                    if Finally and type(Finally) == 'function' then
                        Finally(eresult)
                    end
                    error(eresult)
                end
            else
                -- 没有任何 handler 匹配
                lib.last_exception = original_error -- 使用原始错误
                if Finally and type(Finally) == 'function' then
                    Finally(original_error)
                end
                error("unhandled error: " .. tostring(original_error))
            end
        end
    end
    -- 执行 Finally（无论成败都执行）
    if Finally and type(Finally) == 'function' then
        Finally(unpack(finally_args, 1, finally_arg_count))
    end

    -- 返回最终结果
    return unpack(finally_args, 1, finally_arg_count)
    
end

---模拟`Python`中的`raise`语句抛出异常，当不传入`exception`时将把最后捕获的异常抛出
--- @param exception? string|plus.Class|Exception 抛出的异常
function lib.Raise(exception)
    -- 情况 1: 没有提供参数 -> 重新抛出上次存储的异常
    if exception == nil then
        if lib.last_exception then
            error(lib.last_exception)
        else
            -- 如果 last_exception 也为空，则抛出RuntimeError
            lib.Raise(RuntimeError())
        end
    end

    -- 情况 2: 字符串，直接抛出
    if type(exception) == "string" then
        error(exception, 2) -- level 2 表示错误发生在调用 Raise 的地方，而不是在 Raise 函数内部
    end

    if type(exception) == "table" then
        local mt = getmetatable(exception)

        -- 情况 3: 异常类 (具有 init 方法的表)
        if exception.init then
            error(exception(), 2)
            -- 情况 4: 异常实例 (具有 init 方法的表的实例)
        elseif mt and mt.init then
            error(exception, 2)
            -- 情况 5：普通表 (既不是类也不是实例)，转换为字符串抛出
        else
            error(tostring(exception), 2)
        end
    end

    -- 情况 6: 其他类型 (number, boolean, etc.)，转换为字符串抛出
    error(tostring(exception), 2)
end

---模拟`Python`中的`pass`语句，不做任何事
function lib.Pass()
end

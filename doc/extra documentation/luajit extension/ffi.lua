--- FFI 库允许从纯 Lua 代码中调用外部 C 函数和使用 C 数据结构。
--- 术语表
--- cdecl    — 一个抽象的 C 类型声明（Lua 字符串）。
--- ctype    — 一个 C 类型对象。这是由 ffi.typeof() 返回的一种特殊 cdata。当被调用时，它充当 cdata 的构造函数。
--- cdata    — 一个 C 数据对象。它保存着对应 ctype 的值。
--- ct       — 一个 C 类型说明符，可用于大多数 API 函数。可以是 cdecl、ctype 或作为模板类型的 cdata。
--- cb       — 一个回调对象。这是一个持有特殊函数指针的 C 数据对象。从 C 代码调用此函数会运行一个关联的 Lua 函数。
--- VLA      — 可变长度数组，用 ? 代替元素个数来声明，例如 "int[?]"。创建时必须给出元素个数 (nelem)。
--- VLS      — 可变长度结构体，是一种最后一个元素是 VLA 的结构体 C 类型。声明和创建的规则相同。
---
--- 声明和访问外部符号
--- 必须先声明外部符号，然后才能通过索引 C 库命名空间来访问，这会自动将符号绑定到特定的库。
---@class ffi
ffi = {}

--- 为类型或外部符号（命名变量或函数）添加多个 C 声明。def 必须是 Lua 字符串。
--- 建议对字符串参数使用如下语法糖：
---```
--- ffi.cdef [[
--- typedef struct foo { int a, b; } foo_t;  // 声明一个结构体和 typedef。
--- int dofoo(foo_t *f, int n);  /* 声明一个外部 C 函数。 */
--- ]]
---```
--- 字符串的内容（上面绿色的部分）必须是一系列由分号分隔的 C 声明，单个声明的末尾分号可以省略。
--- 请注意，外部符号只是被声明，但尚未绑定到任何特定地址。绑定是通过 C 库命名空间实现的（见下文）。
--- C 声明不会经过 C 预处理器。不允许使用预处理器标记，除了 #pragma pack。请将现有 C 头文件中的 #define 替换为 enum、static const 或 typedef 和/或通过外部 C 预处理器处理文件（一次）。注意不要包含来自不相关头文件的不必要或冗余声明。
---@param def string @包含 C 声明序列的 Lua 字符串
function ffi.cdef(def)
end

--- 这是默认的 C 库命名空间 —— 注意大写的 'C'。它绑定到目标系统上的默认符号集或库。这些或多或少与 C 编译器默认提供的相同，无需指定额外的链接库。
--- 在 POSIX 系统上，这绑定到符号在默认或全局命名空间中。这包括所有从可执行文件以及任何加载到全局命名空间中的库导出的符号。这至少包括 libc、libm、libdl（在 Linux 上）、libgcc（如果用 GCC 编译），以及 LuaJIT 本身提供的 Lua/C API 的任何导出符号。
--- 在 Windows 系统上，这绑定到从 *.exe、lua51.dll（即 LuaJIT 本身提供的 Lua/C API）、LuaJIT 链接的 C 运行时库 (msvcrt*.dll)、kernel32.dll、user32.dll 和 gdi32.dll 导出的符号。
---@class ffi.C
ffi.C = {}

--- 加载指定名称的动态库，并返回一个绑定其符号的新 C 库命名空间。在 POSIX 系统上，如果 global 为 true，库符号也会被加载到全局命名空间。
--- 如果 name 是路径，则从该路径加载库。否则，name 会以系统相关的方式规范化，并在动态库的默认搜索路径中查找：
--- 在 POSIX 系统上，如果名称不包含点，则会附加扩展名 .so。此外，必要时会添加 lib 前缀。因此 ffi.load("z") 会在默认的共享库搜索路径中查找 "libz.so"。
--- 在 Windows 系统上，如果名称不包含点，则会附加扩展名 .dll。因此 ffi.load("ws2_32") 会在默认的 DLL 搜索路径中查找 "ws2_32.dll"。
---@param name string @动态库的名称或路径
---@param global? boolean @是否将符号加载到全局命名空间（POSIX 系统）
---@return table @绑定到库符号的 C 库命名空间
function ffi.load(name, global)
end

-- 创建 cdata 对象
-- 以下 API 函数创建 cdata 对象（type() 返回 "cdata"）。所有创建的 cdata 对象都会被垃圾回收。

--- 为给定的 ct 创建 cdata 对象。VLA/VLS 类型需要 nelem 参数。第二种语法使用 ctype 作为构造函数，其他方面完全等效。
--- cdata = ctype(nelem, init)
--- 根据初始化器的规则，使用可选的 init 参数初始化 cdata 对象。多余的初始化器会导致错误。
--- 性能提示：如果你想创建许多同类对象，请仅解析 cdecl 一次，并使用 ffi.typeof() 获取其 ctype。然后重复使用 ctype 作为构造函数。
--- 请注意，匿名结构体声明每次用于 ffi.new() 时都会隐式创建一个新的、不同的 ctype。这可能不是你想要的，尤其是在创建多个 cdata 对象时。根据 C 标准，不同的匿名结构体不被认为是赋值兼容的，即使它们可能具有相同的字段！此外，它们被 JIT 编译器视为不同的类型，这可能导致过多的 trace。强烈建议使用 ffi.cdef() 声明命名结构体或 typedef，或者使用 ffi.typeof() 为匿名结构体创建单个 ctype 对象。
---@param ct string|ffi.ctype @C 类型说明符（cdecl 或 ctype）
---@param nelem? integer @对于 VLA/VLS 类型，指定元素个数
---@param init? any @初始化值
---@return ffi.cdata @新创建的 cdata 对象
function ffi.new(ct, nelem, init)
end

--- 为给定的 ct 创建 ctype 对象。
--- 此函数特别适用于仅解析 cdecl 一次，然后将得到的 ctype 对象用作构造函数。
---@param ct string|ffi.ctype @C 类型说明符（cdecl 或 ctype）
---@return ffi.ctype @ctype 对象
function ffi.typeof(ct)
end

--- 为给定的 ct 创建标量 cdata 对象。cdata 对象使用 init 通过 C 类型转换规则的"强制转换"变体进行初始化。
--- 此函数主要用于覆盖指针兼容性检查或将指针转换为地址，反之亦然。
---@param ct string|ffi.ctype @C 类型说明符（cdecl 或 ctype）
---@param init any @要转换的值
---@return ffi.cdata @转换后的 cdata 对象
function ffi.cast(ct, init)
end

--- 为给定的 ct 创建 ctype 对象并将其与元表关联。只允许结构体/联合体类型、复数和向量。其他类型可以包装在结构体中。
--- 与元表的关联是永久性的，之后无法更改。之后既不能修改元表的内容，也不能修改 __index 表（如果有）的内容。关联的元表自动应用于此类型的所有用途，无论对象是如何创建的或来自何处。注意：预定义的类型操作具有优先级（例如，声明的字段名不能被覆盖）。
--- 所有标准的 Lua 元方法都已实现。这些元方法被直接调用，没有快捷方式，并且适用于任何类型的组合。对于二元操作，首先检查左操作数是否有有效的 ctype 元方法。__gc 元方法仅适用于结构体/联合体类型，并在创建实例时执行隐式的 ffi.gc() 调用。
---@param ct string|ffi.ctype @C 类型说明符（cdecl 或 ctype）
---@param metatable table @要关联的元表
---@return ffi.ctype @带有元表关联的 ctype 对象
function ffi.metatype(ct, metatable)
end

--- 将终结器与指针或聚合 cdata 对象关联。cdata 对象原样返回。
--- 此函数允许将非托管资源安全地集成到 LuaJIT 垃圾收集器的自动内存管理中。
--- 典型用法：
---```
--- local p = ffi.gc(ffi.C.malloc(n), ffi.C.free)
--- ...
--- p = nil -- p 的最后一个引用消失。
---```
--- GC 最终会运行终结器：ffi.C.free(p)
--- cdata 终结器的工作方式类似于 userdata 对象的 __gc 元方法：当 cdata 对象的最后一个引用消失时，关联的终结器会以该 cdata 对象为参数被调用。终结器可以是 Lua 函数、cdata 函数或 cdata 函数指针。可以通过设置 nil 终结器来移除现有的终结器，例如在显式删除资源之前：
---```
--- ffi.C.free(ffi.gc(p, nil)) -- 手动释放内存。
---```
---@param cdata ffi.cdata @要关联终结器的 cdata 对象
---@param finalizer function|nil @终结器函数，nil 表示移除现有终结器
---@return ffi.cdata @传入的 cdata 对象（未改变）
function ffi.gc(cdata, finalizer)
end

-- C 类型信息
-- 以下 API 函数返回关于 C 类型的信息。它们对于检查 cdata 对象非常有用。

--- 返回 ct 的大小（字节）。如果大小未知（例如 "void" 或函数类型），则返回 nil。对于 VLA/VLS 类型需要 nelem，cdata 对象除外。
---@param ct string|ffi.ctype|ffi.cdata @C 类型说明符
---@param nelem? integer @对于 VLA/VLS 类型，指定元素个数
---@return number|nil @大小（字节）或 nil（如果未知）
function ffi.sizeof(ct, nelem)
end

--- 返回 ct 所需的最小对齐量（字节）。
---@param ct string|ffi.ctype|ffi.cdata @C 类型说明符
---@return number @对齐量（字节）
function ffi.alignof(ct)
end

--- ofs,bpos,bsize = ffi.offsetof(ct, field)
--- 返回 field 相对于 ct 起始处的偏移量（字节），ct 必须是结构体。对于位域，还返回其位置和字段大小（位）。
---@param ct string|ffi.ctype @C 类型说明符（必须是结构体类型）
---@param field string @字段名称
---@return number @偏移量（字节）
---@return number? @位位置（仅位域）
---@return number? @位大小（仅位域）
function ffi.offsetof(ct, field)
end

--- 如果 obj 具有由 ct 给出的 C 类型，则返回 true。否则返回 false。
--- C 类型限定符（const 等）被忽略。指针使用标准指针兼容性规则检查，但对 void * 没有特殊处理。如果 ct 指定了结构体/联合体，那么指向此类型的指针也被接受。否则类型必须完全匹配。
--- 注意：此函数接受 obj 参数的所有类型的 Lua 对象，但对于非 cdata 对象总是返回 false。
---@param ct string|ffi.ctype @C 类型说明符
---@param obj any @要检查的对象
---@return boolean @如果 obj 具有指定类型则为 true
function ffi.istype(ct, obj)
end

-- 工具函数

--- 返回上次指示错误条件的 C 函数调用设置的错误号。如果提供了可选的 newerr 参数，则将错误号设置为新值并返回先前的值。
--- 此函数提供了一种跨平台且与操作系统无关的获取和设置错误号的方法。注意：只有一些 C 函数会设置错误号。并且只有当函数实际指示了错误条件（例如返回值为 -1 或 NULL）时，它才有意义。否则，它可能包含也可能不包含任何先前设置的值。
--- 建议仅在需要时调用此函数，并尽可能在相关 C 函数返回后立即调用。errno 值在钩子、内存分配、JIT 编译器调用和其他内部 VM 活动期间都会保留。对于 Windows 上的 GetLastError() 返回值也是如此，但你需要自己声明和调用它。
---@param newerr? integer @要设置的新错误号
---@return integer @错误号（设置前）
function ffi.errno(newerr)
end

--- 从 ptr 指向的数据创建一个内部化的 Lua 字符串。
--- 如果省略可选的 len 参数，ptr 被转换为 "char *"，并假定数据以零结尾。字符串长度用 strlen() 计算。
--- 否则 ptr 被转换为 "void *"，len 给出数据的长度。数据可能包含嵌入的零，并且不必是面向字节的（尽管这可能导致字节序问题）。
--- 此函数主要用于将由 C 函数返回的（临时）"const char *" 指针转换为 Lua 字符串，并存储它们或将它们传递给期望 Lua 字符串的其他函数。Lua 字符串是数据的（内部化）副本，与原始数据区域不再有任何关系。Lua 字符串是 8 位干净的，可用于保存任意的非字符数据。
--- 性能提示：如果知道字符串长度，传递长度会更快。例如，当长度由 sprintf() 之类的 C 调用返回时。
---@param ptr ffi.cdata* @指向数据的指针
---@param len? integer @数据长度（字节）
---@return string @创建的 Lua 字符串
function ffi.string(ptr, len)
end

--- 将 src 指向的数据复制到 dst。dst 被转换为 "void *"，src 被转换为 "const void *"。
--- 第一种语法中，len 给出要复制的字节数。注意：如果 src 是 Lua 字符串，则 len 不得超过 #src+1。
--- 第二种语法中，复制的源必须是 Lua 字符串。字符串的所有字节加上一个零终止符被复制到 dst（即 #src+1 字节）。
--- 性能提示：ffi.copy() 可用作 C 库函数 memcpy()、strcpy() 和 strncpy() 的更快（可内联）替代品。
---@param dst ffi.cdata* @目标地址
---@param src ffi.cdata*|string @源地址或 Lua 字符串
---@param len? integer @要复制的字节数（如果 src 是 cdata）
function ffi.copy(dst, src, len)
end

--- 用由 c 给出的 len 个常量字节填充 dst 指向的数据。如果省略 c，则数据用零填充。
--- 性能提示：`ffi.fill()` 可用作 C 库函数 memset(dst, c, len) 的更快（可内联）替代品。请注意参数顺序不同！
---@param dst ffi.cdata* @目标地址
---@param len integer @要填充的字节数
---@param c? integer @填充字节值（0-255），默认为 0
function ffi.fill(dst, len, c)
end

-- 目标特定信息

--- 如果 param（Lua 字符串）适用于目标 ABI（应用程序二进制接口），则返回 true。否则返回 false。目前定义了以下参数：
---> 参数        描述
---> [32bit]    32 位架构
---> [64bit]    64 位架构
---> [le]       小端架构
---> [be]       大端架构
---> [fpu]      目标有硬件 FPU
---> [softfp]   softfp 调用约定
---> [hardfp]   hardfp 调用约定
---> [eabi]     标准 ABI 的 EABI 变体
---> [win]      标准 ABI 的 Windows 变体
---@param param string @ABI 参数名称
---@return boolean @如果参数适用于目标 ABI 则为 true
function ffi.abi(param)
end

--- 包含目标操作系统名称。内容与 jit.os 相同。
ffi.os = ""

--- 包含目标架构名称。内容与 jit.arch 相同。
ffi.arch = ""

-- 回调的方法

--- 回调的 C 类型有一些额外的方法
---@class ffi.callback
local cb = {}

--- 释放与回调关联的资源。关联的 Lua 函数被解除锚定，可能会被垃圾回收。回调函数指针不再有效，不得再被调用（它可能会被后续创建的回调重用）。
function cb:free()
end

--- 将新的 Lua 函数与回调关联。回调的 C 类型和回调函数指针不变。
--- 此方法对于动态切换回调的接收者非常有用，无需每次都创建新回调并重新注册（例如使用 GUI 库）。
---@param func function @新的 Lua 函数
function cb:set(func)
end

-- 扩展的标准库函数

--- 以下标准库函数已扩展为可与 cdata 对象一起使用：
--- `local n = tonumber(cdata)`
--- 将数字 cdata 对象转换为 double 并作为 Lua 数字返回。这对于装箱的 64 位整数值特别有用。注意：此转换可能导致精度损失。
--- `local s = tostring(cdata)`
--- 返回 64 位整数（"nnnLL" 或 "nnnULL"）或复数（"re±imi"）值的字符串表示。否则返回 ctype 对象（"ctype<type>"）或 cdata 对象（"cdata<type>: address"）的 C 类型的字符串表示，除非你用 __tostring 元方法覆盖它（见 ffi.metatype()）。
--- `local iter, obj, start = pairs(cdata)`
--- `iter, obj, start = ipairs(cdata)`
--- 调用相应 ctype 的 __pairs 或 __ipairs 元方法。
---@class ffi.cdata
local cdata = {}

-- 对 Lua 解析器的扩展
-- Lua 源代码的解析器将带有后缀 LL 或 ULL 的数字字面量视为有符号或无符号 64 位整数。大小写无关，但建议使用大写以增强可读性。它处理十进制（42LL）和十六进制（0x2aLL）字面量。

-- 复数的虚部可以通过在数字字面量后添加后缀 i 或 I 来指定，例如 12.5i。注意：你需要使用 1i 来获得值为 1 的虚部，因为 i 本身仍然指代名为 i 的变量。

return ffi
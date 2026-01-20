---=====================================
---THAIC Global API v1.00a
---东方梦摇篮 全局API v1.00a
---=====================================

---将AiC的部分常用（也可能不常用）函数导出到全局
---不知不觉中已经写了这么多函数啊（感叹）

---版本更新记录
---v1.00a
---初始版本
---v1.01a
---添加函数注释

--东方梦摇篮3D
--还没做完所以暂时不导出到全局
--[[
object3D = aic.view3d.object
hypot3D = aic.view3d.hypot
Dist3D = aic.view3d.Dist
Angle3D = aic.view3d.Angle
GetV3D = aic.view3d.GetV
SetV3D = aic.view3d.SetV
BoxCheck3D = aic.view3d.BoxCheck
ColliCheck3D = aic.view3d.ColliCheck
CollisionCheck3D = aic.view3d.CollisionCheck
Render2D = aic.view3d.Render2D
Render3D = aic.view3d.Render3D
RenderAuto3D = aic.view3d.RenderAuto3D
--]]

--东方梦摇篮杂项

getpos = aic.misc.GetPos

--东方梦摇篮系统

CheckEnhancer = aic.sys.CheckEnhancer
CheckDiff = aic.sys.CheckDiff
GetDiff = aic.sys.GetDiff
safeDel = aic.sys.SafeDel
safeKill = aic.sys.SafeKill
safeWait = aic.sys.SafeWait
safeSave = aic.sys.SafeSave
WaitUntil = aic.sys.WaitUntil

--东方梦摇篮table扩展库

removemetatable = aic.table.RemoveMetatable
_setmetatable = aic.table.SetMetatable
_getmetatable = aic.table.GetMetatable
setkeytable = aic.table.SetKeyTable
setvaluetable = aic.table.SetValueTable
makekeytable = aic.table.MakeKeyTable

--东方梦摇篮UI

color = aic.ui.color
DrawText = aic.ui.DrawText
AddSPPoint = aic.ui.AddSPPoint
AddSPPoint2 = aic.ui.AddSPPoint2
CheckSPPoint = aic.ui.CheckSPPoint

--东方梦摇篮数学库

nand = aic.math.nand
nor = aic.math.nor
xor = aic.math.xor
xnor = aic.math.xnor
rotate = aic.math.rotate
round = aic.math.round
appr_equal = aic.math.appr_equal
PosTrans = aic.math.PosTrans
IsIn = aic.math.IsIn

--东方梦摇篮Python扩展库

BadArgument = "bad argument"
InvalidArgument = "invalid argument"
ArgumentError = ".+ argument"
InvalidObj = "invalid.+object"
CompileError = "falied to compile"
StackOverflow = "stack overflow"
NilValueError = "nil value"
LoadFailed = "load .+ failed"
PermissionDenied = "Permission denied"
AnyException = ".*"
TryExcept = aic.py.TryExcept
raise = aic.py.Raise
pass = aic.py.Pass
range = aic.py.Range


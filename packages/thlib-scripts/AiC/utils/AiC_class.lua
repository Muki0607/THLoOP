---=====================================
---THLoOP Class v1.00a
---东方梦摇篮 类相关 v1.01a
---=====================================

---版本更新记录
---v1.00a
---初始版本

---@class aic.class @东方梦摇篮异常处理
aic.class = {}
local lib = aic.class

---@param obj table @对象
---@param classinfo plus.Class|table<plus.Class> @类或类的表
function lib.IsInstance(obj, classinfo)
    if type(obj) ~= "table" then
        return false
    end

    if classinfo.init then --使用是否带有init函数来判断是类还是装有类的表
        if obj.class == classinfo then
            return true
        end
        -- 检查继承链
        local meta = getmetatable(obj)
        while meta do
            if meta.class == classinfo then
                return true
            end
            meta = meta.super
        end
    else
        for _, c in ipairs(classinfo) do
            if obj.class == c then
                return true
            end
        end
        -- 检查继承链
        local meta = getmetatable(obj)
        while meta do
            for _, c in ipairs(classinfo) do
                if meta.class == c then
                    return true
                end
            end
            meta = meta.super
        end
    end

    return false
end
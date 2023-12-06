require ".luam"

--- Runs fn on every item of the table, returning a new table.
--- Will pass the current item, current index, and a reference to self as parameters to fn
--- ```fn(item, index, self)```
---
--- @param fn function The function to be called to determine the new value for each item, index pair
--- @return table
---
--- Example:
--- ```
--- local table = T {1, 2, 3}
--- local new = table:imap(function(x) return x * 2 end)
--- ```
--- New will be equal to {2, 4, 6}
---
function table:imap(fn)
    local newTable = T {}
    for i = 1, #self do
        table.insert(newTable, fn(self[i], i, self) or nil)
    end
    return newTable
end

--- Runs fn on every item of the table, returning a new table.
--- Will pass in the current item, the current *key*, and a reference to self as parameters to fn
--- Ex: ```fn(item, key, self)```
--- **This method uses pairs to iterate the table, which does not preserve table order!**
---
--- @param fn function The function to be called on each value, key pair
--- @return table
---
--- Example:
--- ```
--- local table = T {1, 2, 3}
--- local new = table:imap(function(x) return x * 2 end)
--- ```
--- New will be equal to {2, 4, 6}
---
function table:map(fn)
    local newTable = T {}
    for key, value in pairs(self) do
        newTable[key] = fn(value, key, self) or nil
    end
    return newTable
end

--- Runs fn on every item in the table, returning nothing.
--- Will pass in the current item, current *index*, and self as parameters to fn.
--- Ex: ```fn(item, index, self)```
---
--- @param fn function The function to be called on each item, index pair
---
--- Example:
--- ```
--- local table = T {"a", "b", "c"}
--- table:iforeach(function (x, i) print(i, x) end)
--- ```
--- will output
--- ```
--- 1 a
--- 2 b
--- 3 c
--- ```
function table:iforeach(fn)
    for i = 1, #self do
        fn(self[i], i, self)
    end
end

--- Runs fn on every item in the table, returning nothing.
--- Will pass in the current item, current key, and self as parameters to fn.
--- Ex: ```fn(item, key, self)```
--- **This method uses pairs to iterate the table, which does not preserve table order!**
---
--- @param fn function - The function to call on each item
---
--- Example:
--- ```
--- local table = T {a = 1, b = 2, c = 3}
--- table:iforeach(function (x, key) print(key, x) end)
--- ```
--- will output
--- ```
--- a 1
--- b 2
--- c 3
--- ```
function table:foreach(fn)
    for key, item in pairs(self) do
        fn(item, key, self)
    end
end

--- For each item in the table, sets the accumulator to be the result of fn(a, item), returning the final accumulator value.
--- Will pass in the accumulator, the current item, current key, and self as parameters to fn
--- Ex: ```fn(a, c, ck, self)```.
--- **This method uses pairs to iterate the table, which does not preserve table order!**
---
--- @param fn function The accumulator function
--- @param a any The initial value
--- @return any result The final value of the accumulator
---
--- Example:
--- ```
--- local table = T {a = 1, b = 2, c = 3}
--- local result = table:reduce(function(a, c, ck) return a .. c .. ck end, 0)
--- print(result)
--- ```
--- will output ```1a2bc3```
function table:reduce(fn, a)
    for key, item in pairs(self) do
        a = fn(a, item, key, self)
    end
    return a
end

--- For each item in the table, sets the accumulator to be the result of fn(a, item), returning the final accumulator value.
--- Will pass in the accumulator, the current item, current key, and self as parameters to fn
--- Ex: ```fn(a, c, ck, self)```
---
--- @param fn function The accumulator function
--- @param a any The initial value
--- @return any result The final value of the accumulator
---
--- Example:
--- ```
--- local table = T {1, 2, 3}
--- local result = table:reduce(function(a, c) return a + c end, 0)
--- print(result)
--- ```
--- will output ```6```
function table:ireduce(fn, a)
    for i = 1, #self do
        a = fn(a, self[i], i, self)
    end
    return a
end

--- Tests if every item returns true from fn
--- Will pass in the current item, current key, and self as parameters to fn
--- Ex: ```fn(c, ck, self)```.
--- **This method uses pairs to iterate the table, which does not preserve table order!**
---
--- @param fn function The function to be called on every item, key pair of the table
--- @return boolean
---
--- Example:
--- ```
--- local table = {a = 2, b = 4, c = 6}
--- local allItemsAreEven = table:every(function (item) item % 2 == 0 end)
--- print(allItemsAreEven)
---```
--- Will print ```true``` only if every item is an even number
function table:every(fn)
    for key, item in pairs(self) do
        if not fn(item, key, self) then
            return false
        end
    end
    return true
end

--- Tests if every item returns true from fn
--- Will pass in the current item, current index, and self as parameters to fn
--- Ex: ```fn(c, i, self)```.
---
--- @param fn function The function to be called on every item, index pair of the table
--- @return boolean
---
--- Example:
--- ```
--- local table = {2, 4, 6}
--- local allItemsAreEven = table:every(function (item) item % 2 == 0 end)
--- print(allItemsAreEven)
---```
--- Will print ```true``` only if every item is an even number
function table:ievery(fn)
    for i = 1, #self do
        if not fn(self[i], i, self) then
            return false
        end
    end
    return true
end

--- Tests if any item returns true from fn
--- Will pass in the current item, current key, and self as parameters to fn
--- Ex: ```fn(c, ck, self)```.
--- **This method uses pairs to iterate the table, which does not preserve table order!**
---
--- @param fn function The function to be called on every item, key pair of the table
--- @return boolean
---
--- Example:
--- ```
--- local table = {a = 1, b = 4, c = 3}
--- local anyItemIsEven = table:any(function (item) item % 2 == 0 end)
--- print(anyItemIsEven)
---```
--- Will print ```true``` because there is an even item
function table:any(fn)
    for key, value in pairs(self) do
        if fn(value, key, self) then
            return true
        end
    end
    return false
end

--- Tests if any item returns true from fn
--- Will pass in the current item, current index, and self as parameters to fn
--- Ex: ```fn(c, i, self)```.
---
--- @param fn function The function to be called on every item, index pair of the table
--- @return boolean
---
--- Example:
--- ```
--- local table = {1, 4, 3}
--- local anyItemIsEven = table:any(function (item) item % 2 == 0 end)
--- print(anyItemIsEven)
---```
--- Will print ```true``` because there is an even item
function table:iany(fn)
    for i = 1, #self do
        if fn(self[i], i, self) then
            return true
        end
    end
    return false
end

--- Filters a table by fn as the condition, maintaining key value pairs.
--- Will pass in the current item, current key, and self as parameters to the fn
--- Ex: ```fn(c, ck, self)```
--- **This method uses pairs to iterate the table, which does not preserve table order!**
---
--- @param fn function
--- @return table
---
function table:filter(fn)
    local result = T {}
    for key, value in pairs(self) do
        if fn(value, key, self) then
            result[key] = value
        end
    end
    return result
end

--- Filters a table by fn as the condition, inserting all items via table.insert
--- Will pass in the current item, current index, and self as parameters to the fn
--- Ex: ```fn(c, i, self)```
---
--- @param fn function
--- @return table
---
function table:ifilter(fn)
    local result = T {}
    for i = 1, #self do
        if fn(self[i], i, self) then
            table.insert(result, self[i])
        end
    end
    return result
end

local colorKey = {
    string = 0x400,
    number = 0x4000,
    table = 0x8,
    ["function"] = 0x10
}

local function writeColoredByType(value)
    term.setTextColor(colorKey[type(value)])
    local text = tostring(value)

    if type(value) == "string" then
        text = '"' .. text .. '"'
    end

    if type(value) == "function" then
        local info = debug.getinfo(value)
        text = info.short_src .. " ln." .. info.linedefined
    end

    term.write(text)
    term.setTextColor(0x1)
end

local function printKey(key, tab)
    if type(key) == "string" and key:find("%W") then
        term.write(tab .. '[')
        writeColoredByType(key)
        term.write(']: ')
    else
        term.write(tab)
        writeColoredByType(key)
        term.write(": ")
    end
end

--- Recursively prints the contents of a table
function table:print(nest, tab)
    term.write("{")
    print()

    nest = nest or {}
    tab = tab or "  "

    nest[self] = true
    for key, value in pairs(self) do
        if type(value) == "table" and not nest[value] then
            printKey(key, tab)
            table.print(value, nest, tab .. "  ")
        else
            printKey(key, tab)
            writeColoredByType(value)
            print()
        end
    end
    nest[self] = false

    local subtab = tab:sub(3, #tab)
    term.write(subtab .. "}")

    print()
end

--- Finds the first index of the passed in item
function table:indexOf(item)
    for i = 1, #self do
        if self[i] == item then
            return i
        end
    end
end

--- Finds the first key that corresponds to the passed in item
function table:findFirstKey(item)
    for key, value in pairs(self) do
        if value == item then
            return key
        end
    end
end

--- Returns a new table that contains all of the values from *start* to *_end*.<br>
--- Negative numbers can be used to count down from the end of the table<br>
--- Only works on indexed tables.
---
---@param start number
---@param _end? number
function table:slice(start, _end)
    -- TODO: Reduce the size of these unecessarily large if statements
    if start and not _end then
        if start < 0 then
            start = #self + start + 1
            _end = #self
        else
            _end = start
            start = 0
        end
    end

    if start and _end then
        start = start < 0 and #self - start or start
        _end = _end < 0 and #self - _end or _end
    end

    if not start then
        start = 0
        _end = #self
    end

    local result = T {}
    for i = start, _end do
        table.insert(result, self[i])
    end
    return result
end

--- Combines every item in an indexed table into one string, delimited by ```delim```
--- @param delim string
--- @return string
function table:join(delim)
    if #self == 0 then return "" end
    delim = delim or ", "
    local result = self[1]
    for i = 2, #self do
        result = result .. delim .. tostring(self[i])
    end
    return result
end

--- Constructs a new extended table
---
--- @param o table
--- @return table
---
function T(o)
    setmetatable(o, { __index = table })
    return o
end

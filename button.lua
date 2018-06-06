--[[
MIT License

Copyright (c) 2018 - Vinicius Costa Castro

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
--]]

button = {
    isSelectable = true
}

local function pointIsInsideRectangle(px, py, x, y, w, h)
    return px >= x and px <= (x + w) and py >= y and py <= (y + h)
end

function button:new(title, width, height, ...)
    vararg = {...}

    local __posX = vararg[1] or 0
    local __posY = vararg[2] or 0
    local __backgroundcolor = vararg[3] or { 255, 255, 255 }
    local __backgroundcolorhover = __backgroundcolor
    local __action = vararg[4] or function()
            print("Não há evento registrado")
        end
    local __textfont = vararg[5] or false
    
    local current = {}
    current.draw = function()
        collectgarbage("step")
        local textfont = (__textfont and love.graphics.newFont(__textfont, 25)) or love.graphics.newFont()
        love.graphics.setFont(textfont)
        love.graphics.setColor(__backgroundcolor)

        local textwidth = textfont:getWidth(title)
        local textheight = textfont:getHeight(title)

        if (type(__posX) ~= "number" and type(__posX) == "string") then
            if (__posX == "left") then
                __posX = 25
            elseif (__posX == "center") then
                __posX = (love.graphics.getWidth() / 2) - (width / 2)
            elseif (__posX == "right") then
                __posX = love.graphics.getWidth() - (width - 25)
            else
                error("Orientation invalid. Expected \"left\", \"right\" or \"center\", received [" .. button[i].posX .. "]")
            end
        end

        if (type(__posY) ~= "number" and type(__posY) == "string") then
            if (__posY == "left") then
                __posY = 25
            elseif (__posY == "center") then
                __posY = (love.graphics.getHeight() / 2) - (height / 2)
            elseif (__posY == "bottom") then
                __posY = love.graphics.getHeight() - (height - 25)
            else
                error("Orientation invalid. Expected \"top\", \"bottom\" or \"center\", received " .. button[i].posX .. "")
            end
        end

        local buttonRectangle = love.graphics.rectangle(
            "fill",
            __posX,
            __posY,
            width,
            height
        )

        local cRed, cGreen, cBlue = love.graphics.getColor()
        if (cRed == 0 and cGreen == 0 and cBlue == 0) then
            love.graphics.setColor(255, 255, 255)
        elseif (cRed == 1 and cGreen == 1 and cBlue == 1) then
            love.graphics.setColor(0, 0, 0)
        else
            love.graphics.setColor(255, 255, 255)
        end

        local middlePointX = (__posX + (width / 2)) - (textwidth / 2)
        local middlePointY = (__posY + (height / 2)) - (textheight / 2)

        love.graphics.print(string.upper(title), middlePointX, middlePointY)
        love.graphics.setColor(0, 0, 0)
    end
    current.mousemoved = function(x,y)
        if (button.isSelectable and type(__posX) == "number" and type(__posY) == "number" and pointIsInsideRectangle(x, y, __posX, __posY, width, height)) then
            __backgroundcolor = { 0, 0, 0 }
        else
            __backgroundcolor = __backgroundcolorhover
        end
    end
    current.mousepressed = function(x,y,b)
        if (button.isSelectable and b == 1 and pointIsInsideRectangle(x,y,__posX,__posY, width, height)) then
            __action()
        end
    end

    return current
end

return button

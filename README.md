# buttonLove2d
Button Library for a [LÖVE](http://www.love2d.com)

Example
=======
```
function love.load()
  helloWorldButton = buttonLib:new("Hello, World!", 250, 50, 100, 100, {255,25,255}, function() print("Hello, World!") end)
end

function love.draw()
  helloWorldButton.draw()
end

function love.mousemoved(x,y)
  helloWorldButton.mousemoved(x,y)
end

function love.mousepressed(x,y,b,it)
  helloWorldButton.mousepressed(x,y,b)
end
```
Installation
============

``
buttonLib = require "libraries/button"
``

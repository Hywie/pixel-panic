-- print(saveFile.states)
cx = 63
cy = 63
started = false
score = 1
music(0)

LoadingBox = {
    _topLeftX = 0,
    _topLeftY = 0,
    _bottomRightX = 0,
    _bottomRightY = 0,
    _width = 80,
    _height = 10,
    indicatorpercentage = 80,
    indicatorwidth = 2,
    fillpercentage = 100,
    visible = true,
    x = 0,
    y = 0,
    bordercolour = 7,
    fillcolour = 14,
    indicatorcolour = 10
}

function LoadingBox:new(o)
    o = o or LoadingBox
    self.__index = self
    return setmetatable(o, self)
end

function LoadingBox:draw()
    if not self.visible then return end

    local halfwidth = self._width / 2
    local halfheight = self._height / 2

    -- calculate the position of the corners
    self._topLeftX = self.x - halfwidth
    self._topLeftY = self.y - halfheight
    self._bottomRightX = self.x + halfwidth
    self._bottomRightY = self.y + halfheight

    -- draw border outline
    rect(self._topLeftX, self._topLeftY, self._bottomRightX, self._bottomRightY, self.bordercolour)

    -- draw the fill area
    local fillx = self._topLeftX + ((self._width - 1) * self.fillpercentage) / 100
    if (self.fillpercentage > 1) then
        rectfill(self._topLeftX + 1, self._topLeftY + 1, fillx, self._bottomRightY - 1, self.fillcolour)
    end

    local indicatorX = self._topLeftX + (self._width * self.indicatorpercentage) / 100
    local indicatorY = self.y

    -- draw the indicator line ( pixel area range is indicatorX to indicatorX + indicator width)
    for i = 0, self.indicatorwidth do
        local x = indicatorX + i
        line(x, self.y + halfheight - 1, x, self.y - halfheight + 1, self.indicatorcolour)
    end
end

testloader = LoadingBox:new()
testloader.x = 63
testloader.y = 63
testloader.fillpercentage = 10
testloader.indicatorpercentage = 12

printh('\n\n ======')
printh("test loader x " .. testloader.x)

function draw_title()
    print("pixel panic", cx - 20, cy - 20, 12)
    print("press ❎ to start", cx - 30, cy, 7)
    if savefile.highScore > 1 then
        print("high score: " .. savefile.highScore - 1, cx - 23, cy + 15, 7)
    end
end

function start()
    barx = cx + 39
    linewidth = 2
    linex = cx - 38 + rnd(77)
    started = true
end

function _init()
    cartdata("void_pixelpanic_1_0_0")
    if (savefile.highScore == nil) then savefile.highScore = 0 end
    printh(savefile.highScore)
    barx = cx + 39
    draw_title()
end

function game_over()
    if score > savefile.highScore then savefile.highScore = score end
    started = false
    music(-1, 300)
    music(0, 500)
end
function draw_line()
    linewidthhalf = linewidth / 2
    xstart = linex - linewidthhalf
    xend = linex + linewidthhalf

    rectfill(xstart, cy - 4, xend, cy + 4, 10)

    -- helper
    if (score < 3 and savefile.highScore < 3) then
        print("❎", linex - 3, cy + 7, 11)
    end
end

function has_Won_round()
    xstart = linex - linewidthhalf
    xend = linex + linewidthhalf

    return barx > xstart and barx < xend
end

function _update()
    if (not started and btnp(5, 0)) then
        score = 1
        music(-1, 300)
        music(1, 300)
        start()
        return
    end

    if btnp(5, 0) then
        if has_Won_round() then
            sfx(0)
            score += 100
            start()
        else
            sfx(1)
            game_over()
        end
    end

    if (barx > cx - 38) then
        -- bar speeds as the score increases
        local speedMulti = (score / 1000) + 1
        barx -= (0.2 * speedMulti)
    end
end

function _draw()
    cls(13)
    testloader:draw()
end

function _draw2()
    cls(13)

    if not started then
        draw_title()
        return
    end

    print("score: " .. score - 1, cx - 15, cy + 15, 7)

    -- outline
    rect(cx - 40, cy - 5, cx + 40, cy + 5, 7)

    -- bar
    if (barx > cx - 38) then
        rectfill(cx - 39, cy - 4, barx, cy + 4, 14)
    end

    -- line
    draw_line()
end
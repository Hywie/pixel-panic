LoadingBox = {}

function LoadingBox:new(o)
    self._topLeftX = 0
    self._topLeftY = 0
    self._bottomRightX = 0
    self._bottomRightY = 0
    self._width = 80
    self._height = 10
    self.indicatorpercentage = 80
    self.indicatorwidth = 2
    self.fillpercentage = 100
    self.visible = true
    self.x = 0
    self.y = 0
    self.bordercolour = 7
    self.fillcolour = 14
    self.indicatorcolour = 10
    self.is_collision = false
    return setmetatable(self, self)
end

function LoadingBox:draw()
    if not self.visible then return end
    self.is_collision = false

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
        if flr(fillx) == flr(x) then self.is_collision = true end
        line(x, self.y + halfheight - 1, x, self.y - halfheight + 1, self.indicatorcolour)
    end
end
scene_1 = {
    scene_id = 'scene_1',
    score = 0,
    loading_box = {},
    center_x = 64,
    center_y = 64
}

function scene_1:init()
    -- scene_1 is a single loading box in the center of the screen.
    self.loading_box = LoadingBox:new()
    self.loading_box.x = 64
    self.loading_box.y = 64

    -- reset vars
    self:restart()
end

function scene_1:reset()
    self.loading_box.fillpercentage = 100
    self.loading_box.indicatorpercentage = rnd(90) + 5
end

function scene_1:restart()
    self.score = 0
    self.speed = 1
    self:reset()
end

function scene_1:draw()
    cls()
    self.loading_box:draw()

    print('score: ' .. self.score)
end

function scene_1:update()
    if btnp(5, 0) then
        if self.loading_box.is_collision then
            self.score += 100
            self.speed += 0.1
            sfx(0)
            self:reset()
        else
            sfx(5)
            self:game_over()
            return
        end
        -- if the loading box's progress is below 1, then game over
    else
        if self.loading_box.fillpercentage < self.speed then
            self:game_over()
            return
        end
    end

    -- update the loading box's progress
    self.loading_box.fillpercentage = self.loading_box.fillpercentage - 0.2
end

function scene_1:game_over()
    -- set high score if score is above it
    if self.score > save_file.highscore then
        save_file.highscore = self.score
    end

    -- restart and go to title screen
    self:restart()
    current_scene = 'title'
end
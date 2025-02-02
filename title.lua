title = {}

title.scene_id = 'title'

function title:init()
    -- scene_1 is a single loading box in the center of the screen.
    self.loading_box = LoadingBox:new()
    self.loading_box.x = 64
    self.loading_box.y = 64
end

function title:draw()
    cls(13)
    print("\^w\^tpixel panic", center_screen_x - 43, center_screen_y - 20, 139)
    line(center_screen_x - 43, center_screen_y - 5, center_screen_x + 43, center_screen_y - 5, 1)
    print("press ❎ to start", center_screen_x - 33, center_screen_y, 7)
    if save_file.highscore > 0 then
        print("high score: " .. save_file.highscore, center_screen_x - 32, center_screen_y + 15, 137)
    end
end

function title:update()
    if btnp(5, 0) then
        current_scene = 'scene_1'
    end
end
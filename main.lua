printh('\n\n ======')

file_save_map = {
    highscore = 0
}

function _init()
    -- load save data
    save_file = CData:new(file_save_map)
    save_file:load("void_pixelpanic_1_0_0")

    if (save_file.highscore == nil) then save_file.highscore = 0 end

    printh('Loaded high score: ' .. save_file.highscore)

    scenes = {}
    scenes[title.scene_id] = title
    scenes[title.scene_id]:init()
    scenes[scene_1.scene_id] = scene_1
    scenes[scene_1.scene_id]:init()
    current_scene = title.scene_id

    -- music(0)
end

function _draw()
    scenes[current_scene]:draw()
end

function _update60()
    scenes[current_scene]:update()
end
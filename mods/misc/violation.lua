local players = {}
local SHOW_FORMSPEC = 3 -- Number of violations that the player has to do before showing the formspec
local RESET_TIMER = 10 -- Time before resetting the counter to 0 (in seconds)

minetest.register_on_protection_violation(function(pos, name)
	local player = minetest.get_player_by_name(name)
	if not player then
		return
	end
	minetest.chat_send_player(name, "Setting your look yaw you because you violated a protection. / Votre angle de vision a été modifié car vous avez violé une protection.")
	player:set_look_horizontal(player:get_look_horizontal() + math.pi)
	if (players[name] or 1) >= SHOW_FORMSPEC then
		minetest.show_formspec(name, "misc:violation", "size[8,2,true]"..
			"label[0,0;Setting your look yaw because you violated a protection.\nVotre angle de vision a été modifié car vous avez violé une protection.]"..
			"button_exit[3,1;2,1;exit;OK]")
	end

	if not players[name] then
		minetest.after(RESET_TIMER, function(name)
			players[name] = nil
		end, name)
	end
	players[name] = (players[name] or 1) + 1
end)

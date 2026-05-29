global.current_stage = 1

global.paused = false;

//default_day_state = {
//	total_time: 120,
//	order_expiration_mult: 0.8,
// goal: 5.00
//}

STAGE_STATES = [
	{
		total_time: 60,
		order_expiration_mult: 1,
		goal: 150,
		spawn_interval: 5
	},{
		total_time: 60,
		order_expiration_mult: 1,
		goal: 200,
		spawn_interval: 4.5
	},{
		total_time: 60,
		order_expiration_mult: 0.8,
		goal: 200,
		spawn_interval: 3,
	},{
		total_time: 60,
		order_expiration_mult: 0.6,
		goal: 200,
		spawn_interval: 2,
	},{
		total_time: 60,
		order_expiration_mult: 0.6,
		goal: 250,
		spawn_interval: 2
	},{
		total_time: 60,
		order_expiration_mult: 0.6,
		goal: 250,
		spawn_interval: 2
	},{
		total_time: 60,
		order_expiration_mult: 0.6,
		goal: 250,
		spawn_interval: 2
	}
]

layer_set_visible("in_game_layer", false);
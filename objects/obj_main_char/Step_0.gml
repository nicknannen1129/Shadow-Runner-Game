/// @description Insert description here
// You can write your code in this editor
if( char_health < 0 )
{
	room_goto(rm_death);	
}
else if( char_health < 250 )
{
	char_health+=3;	
}
else if( char_health < 500 )
{
	char_health+=2;	
}
else if( char_health < 1000 )
{
	char_health+=1;	
}

if( m_is_state(main_char_state_mchn, "running")  )
{
	if( !audio_is_playing(snd_running) )
	{
		audio_play_sound(snd_running, 1, true);
	}
}
else
{
	audio_stop_sound(snd_running);
}

if( m_is_state(main_char_state_mchn, "shooting") || m_is_state(main_char_state_mchn, "crouch_shooting") 
	|| m_is_state(main_char_state_mchn, "jump_shooting") || m_is_state(main_char_state_mchn, "slide_shooting") )
{	
	if( create_flag == 0 )
	{
		
		var inst;
	
		if( inst_main_char.char_direction == 0 )
		{	
			if( m_is_state(main_char_state_mchn, "crouch_shooting") )
			{
				inst = instance_create_layer(x+170, y-310, "Instances", obj_lazer_bolt);
			}
			else if( m_is_state(main_char_state_mchn, "jump_shooting") )
			{
				inst = instance_create_layer(x+170, y-300, "Instances", obj_lazer_bolt);
			}
			else if( m_is_state(main_char_state_mchn, "slide_shooting") )
			{
				inst = instance_create_layer(x+125, y-170, "Instances", obj_lazer_bolt);
			}
			else
			{
				inst = instance_create_layer(x+165, y-375, "Instances", obj_lazer_bolt);
			}
		}
		else
		{
			if( m_is_state(main_char_state_mchn, "crouch_shooting") )
			{
				inst = instance_create_layer(x-190, y-310, "Instances", obj_lazer_bolt);
			}
			else if( m_is_state(main_char_state_mchn, "jump_shooting") )
			{
				inst = instance_create_layer(x-190, y-300, "Instances", obj_lazer_bolt);
			}
			else if( m_is_state(main_char_state_mchn, "slide_shooting") )
			{
				inst = instance_create_layer(x-125, y-170, "Instances", obj_lazer_bolt);
			}
			else
			{
				inst = instance_create_layer(x-185, y-375, "Instances", obj_lazer_bolt);
			}
		}
	
		with( inst )
		{
			if( inst_main_char.char_direction == 0)
			{
				if( m_is_state(inst_main_char.main_char_state_mchn, "jump_shooting") )
				{
					inst.phy_speed_x = 30;
					inst.phy_speed_y = 10
					inst.phy_rotation = 15;
				}
				else
				{	
					inst.phy_speed_x = 30;
				}
			}
			else
			{
				if( m_is_state(inst_main_char.main_char_state_mchn, "jump_shooting") )
				{
					inst.phy_speed_x = -30;
					inst.phy_speed_y = 10
					inst.phy_rotation = 165;
				}
				inst.phy_speed_x = 	-30;
			}
			
			audio_play_sound(snd_lazer, 1, false);
		}
		
		create_flag = 1;
	}
	else
	{
		create_flag += 1;
		
		if( create_flag == 10 )
		{
			create_flag = 0;	
		}
	}
}

if( !position_meeting(x+75, y+15, obj_block) && !position_meeting(x-75, y+15, obj_block) )
{
	if( !m_is_state(main_char_state_mchn, "crouching") )
	{
		with (inst_main_char) {
			m_send(main_char_state_mchn, "jump");
		}
	}
}
else
{
	double_jump_flag = 0;
	
	with (inst_main_char) {
		m_send(main_char_state_mchn, "idle");
	}
}

if( global.enemies_defeated >= 4*global.difficulty_counter )
{
	global.max_enemies+=1;
	global.enemies_defeated = 0;
	global.difficulty_counter+=1;
}

if( global.enemy_counter < global.max_enemies )
{
	var x_spawn = random_range(0, room_width);
	var y_spawn = random_range(0, room_height);
	
	while( !place_free(x_spawn, y_spawn) )
	{
		x_spawn = random_range(0, room_width);
		y_spawn = random_range(0, room_height);
	}

	instance_create_layer(x_spawn, y_spawn, "Instances", obj_enemy);
		
	global.enemy_counter+=1;
}
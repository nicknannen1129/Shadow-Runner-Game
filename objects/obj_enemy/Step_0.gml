/// @description Insert description here
// You can write your code in this editor
phy_linear_damping = 5;

if( inst_main_char.x < x  )
{
	if( x > inst_main_char.x+500 )
	{
		if( x < inst_main_char.x+1000 )
		{
			phy_position_x-=10;
			char_direction = 0;
		}
		else
		{
			phy_position_x-=5;
			char_direction = 0;	
		}
	}
	
	if( x < inst_main_char.x+490 )
	{
		phy_position_x+=10;
		char_direction = 0;
	}
	
	if( x < inst_main_char.x+1000 )
	{
		
		if( create_flag == 0 )
		{
			var inst = instance_create_layer(x-85, y+5, "Instances", obj_enemy_lazer);
			
			with( inst )
			{
				inst.phy_rotation = 180;
				inst.phy_speed_x = -30;	
				audio_play_sound(snd_enemy_lazer, 1, false);
			}
			
			create_flag = 1;
		}
		
		else
		{
			create_flag += 1;
		
			if( create_flag == 50 )
			{
				create_flag = 0;	
			}
		}
	}
}
else if( inst_main_char.x > x )
{
	if( x < inst_main_char.x-500 )
	{
		if( x > inst_main_char.x-700 )
		{
			phy_position_x+=10;	
			char_direction = 1;
		}
		else
		{
			phy_position_x+=5;	
			char_direction = 1;
		}
	}
	else if( x > inst_main_char.x-490 )
	{
		phy_position_x-=10;
		char_direction = 1;
	}
	
	if( x < inst_main_char.x+700 )
	{
		
		if( create_flag == 0 )
		{
			

			var inst = instance_create_layer(x+85, y+5, "Instances", obj_enemy_lazer);
			
			with( inst )
			{
				inst.phy_speed_x = 30;
				audio_play_sound(snd_enemy_lazer, 1, false);
			}
			
			create_flag = 1;
		}
		
		else
		{
			create_flag += 1;
		
			if( create_flag == 50 )
			{
				create_flag = 0;	
			}
		}
	}
}

if( inst_main_char.y-335 < y )
{
	if( y < inst_main_char.y-330 || y > inst_main_char.y-340 )
	{
		phy_position_y-=10;	
	}
}
else if( inst_main_char.y-335 > y )
{
	if( y < inst_main_char.y-330 || y > inst_main_char.y-340 )
	{
		phy_position_y+=3;	
	}
}

if(char_direction = 1)
{
	image_xscale = -1;	
}
else
{
	image_xscale = 1;	
}
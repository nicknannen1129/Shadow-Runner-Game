/// @description Insert description here
// You can write your code in this editor
if( place_meeting(x+12, y+48, obj_block) )
{
	instance_destroy();	
}
else if( place_meeting(x+12, y+48, obj_enemy) )
{
	var inst = instance_nearest(x+12, y+48, obj_enemy);
	
	with(inst)
	{
		if(inst.enemy_health <= 250 )
		{
			instance_destroy(inst);	
			global.enemy_counter-=1;
			global.enemies_defeated+=1;
			global.total_enemies_defeated+=1;
		}
		else
		{
			inst.enemy_health-=350;
		}
	}
	
	instance_destroy();
}
	
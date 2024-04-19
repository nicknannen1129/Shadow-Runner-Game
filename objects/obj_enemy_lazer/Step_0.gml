/// @description Insert description here
// You can write your code in this editor
if( place_meeting(x+15, y+48, obj_block) )
{
	instance_destroy();	
}
else if( place_meeting(x+15, y+48, obj_main_char) )
{
	var inst = instance_nearest(x+12, y+48, obj_main_char);
	
	with(inst)
	{
		inst.char_health-=100;
	}
	
	instance_destroy();
}
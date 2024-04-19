/// @description Insert description here
// You can write your code in this editor
if point_in_rectangle(mouse_x, mouse_y, x-10, y-4, x+10, y+4)
{
	sprite_index = spr_menu_highlighted;
}
else
{
	sprite_index = spr_menu;
}
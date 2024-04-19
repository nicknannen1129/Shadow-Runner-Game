/// @description Insert description here
// You can write your code in this editor
x = camera_get_view_x(view_camera[0]) + 1400;
y = camera_get_view_y(view_camera[0]) + 20;

draw_set_colour( c_aqua );
draw_text_transformed(x, y, "Enemies Defeated: " + string(global.total_enemies_defeated), 4, 4, 0);
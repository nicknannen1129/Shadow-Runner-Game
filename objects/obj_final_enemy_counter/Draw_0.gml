/// @description Insert description here
// You can write your code in this editor
x = camera_get_view_x(view_camera[0]) + 32;
y = camera_get_view_y(view_camera[0]) + 55;

draw_set_colour( c_red );
draw_text_transformed(x, y, "Enemies Defeated: " + string(global.total_enemies_defeated), 0.25, 0.25, 0);
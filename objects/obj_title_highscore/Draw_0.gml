/// @description Insert description here
// You can write your code in this editor
x = camera_get_view_x(view_camera[0]) + 30;
y = camera_get_view_y(view_camera[0]) + 41;

draw_set_colour( c_aqua );
draw_text_transformed(x, y, "Personal Best: " + string(global.highscore) + " Enemies Defeated", 0.15, 0.15, 0);
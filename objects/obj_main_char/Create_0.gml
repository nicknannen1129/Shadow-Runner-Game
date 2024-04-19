/// @description Insert description here
// You can write your code in this editor
phy_fixed_rotation=true;
char_direction = 0;
double_jump_flag = 0;
create_flag = 0;
char_health = 1000;

main_char_state_mchn = m_create("idle");

m_rule(main_char_state_mchn, "run", "idle", "running");
m_rule(main_char_state_mchn, "run", "shooting", "running");
m_rule(main_char_state_mchn, "run", "slide_shooting", "running");
m_rule(main_char_state_mchn, "stop_running", "running", "idle");
m_rule(main_char_state_mchn, "run", "idle", "running");
m_rule(main_char_state_mchn, "run", "shooting", "running");
m_rule(main_char_state_mchn, "stop_shooting", "shooting", "idle");
m_rule(main_char_state_mchn, "jump", "idle", "jumping");
m_rule(main_char_state_mchn, "jump", "crouching", "jumping");
m_rule(main_char_state_mchn, "jump", "running", "jumping");
m_rule(main_char_state_mchn, "jump", "shooting", "jumping");
m_rule(main_char_state_mchn, "land", "jumping", "idle");
m_rule(main_char_state_mchn, "shoot", "idle", "shooting");
m_rule(main_char_state_mchn, "shoot", "running", "shooting");
m_rule(main_char_state_mchn, "crouch", "idle", "crouching");
m_rule(main_char_state_mchn, "crouch", "shooting", "crouching");
m_rule(main_char_state_mchn, "crouch", "running", "crouching");
m_rule(main_char_state_mchn, "uncrouch", "crouching", "idle");
m_rule(main_char_state_mchn, "uncrouch", "sliding", "running");
m_rule(main_char_state_mchn, "uncrouch", "slide_shooting", "shooting");
m_rule(main_char_state_mchn, "crouch_shoot", "crouching", "crouch_shooting");
m_rule(main_char_state_mchn, "crouch_shoot", "shooting", "crouch_shooting");
m_rule(main_char_state_mchn, "crouch_shoot", "slide_shooting", "crouch_shooting");
m_rule(main_char_state_mchn, "stop_shooting", "crouch_shooting", "crouching");
m_rule(main_char_state_mchn, "uncrouch", "crouch_shooting", "shooting");
m_rule(main_char_state_mchn, "jump_shoot", "jumping", "jump_shooting");
m_rule(main_char_state_mchn, "stop_shooting", "jump_shooting", "jumping");
m_rule(main_char_state_mchn, "slide_shoot", "sliding", "slide_shooting");
m_rule(main_char_state_mchn, "land", "jump_shooting", "idle");
m_rule(main_char_state_mchn, "slide", "running", "sliding");
m_rule(main_char_state_mchn, "crouch", "sliding", "crouching");

m_rule(main_char_state_mchn, "run", "sliding", "running");
m_rule(main_char_state_mchn, "stop_shooting", "slide_shooting", "sliding");


m_action(main_char_state_mchn, ">idle", function() {
	sprite_index = spr_main_char_idle;
});

m_action(main_char_state_mchn, ">running", function() {
	sprite_index = spr_main_char_run;
});

m_action(main_char_state_mchn, ">shooting", function() {
	sprite_index = spr_main_char_shoot;
});

m_action(main_char_state_mchn, ">jumping", function() {
	sprite_index = spr_main_char_jump;
});

m_action(main_char_state_mchn, ">crouching", function() {
	sprite_index = spr_main_char_crouch;
});

m_action(main_char_state_mchn, ">crouch_shooting", function() {
	sprite_index = spr_main_char_crouch_shoot;
});

m_action(main_char_state_mchn, ">jump_shooting", function() {
	sprite_index = spr_main_char_jump_shoot;
});

m_action(main_char_state_mchn, ">sliding", function() {
	sprite_index = spr_main_char_slide;
	friction = 0.2;
});

m_action(main_char_state_mchn, ">slide_shooting", function() {
	sprite_index = spr_main_char_shoot_slide;
});
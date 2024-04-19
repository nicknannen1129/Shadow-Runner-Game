/// @description Insert description here
// You can write your code in this editor
if( !keyboard_check_pressed(ord("D")) )
{
	image_xscale = -1;
	char_direction = 1;

	if( !m_is_state(main_char_state_mchn, "shooting") 
		&& !m_is_state(main_char_state_mchn, "crouch_shooting")
		&& !m_is_state(main_char_state_mchn, "crouching")
		&& !m_is_state(main_char_state_mchn, "sliding")
		&& !m_is_state(main_char_state_mchn, "slide_shooting") )
	{
		with (inst_main_char) {
			m_send(main_char_state_mchn, "run");
		}
	
		inst_main_char.phy_speed_x-=1;
	}
}
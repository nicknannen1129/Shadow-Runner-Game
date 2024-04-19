/// @description Insert description here
// You can write your code in this editor

if( m_is_state(main_char_state_mchn, "jumping") )
{
	with (inst_main_char) {
		m_send(main_char_state_mchn, "jump_shoot");
	}
}
else if( m_is_state(main_char_state_mchn, "sliding")
	|| m_is_state(main_char_state_mchn, "slide_shooting") )
{
	with (inst_main_char) {
		m_send(main_char_state_mchn, "slide_shoot");
	}
	
	if( phy_speed_x == 0 )
	{
		with (inst_main_char) {
			m_send(main_char_state_mchn, "crouch_shoot");
		}
	}
}
else if( m_is_state(main_char_state_mchn, "crouching") )
{
	if( keyboard_check_pressed(ord("S")) )
	{
		with (inst_main_char) {
			m_send(main_char_state_mchn, "crouch_shoot");
		}
	}
	else
	{
		with (inst_main_char) {
			m_send(main_char_state_mchn, "shoot");
		}
		
		inst_main_char.phy_speed_x = 0;
	}
}
else if( !m_is_state(main_char_state_mchn, "running") 
	&& !m_is_state(main_char_state_mchn, "jump_shooting") )
{
	with (inst_main_char) {
		m_send(main_char_state_mchn, "shoot");
	}
	
	inst_main_char.phy_speed_x = 0;
}
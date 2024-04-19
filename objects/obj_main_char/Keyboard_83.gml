/// @description Insert description here
// You can write your code in this editor
if( m_is_state(main_char_state_mchn, "jumping") || m_is_state(main_char_state_mchn, "jump_shooting") )
{
	with (inst_main_char) {
		m_send(main_char_state_mchn, "crouch");
	}
	
	inst_main_char.phy_speed_y = 500;
}
else if(keyboard_check(vk_space) && !m_is_state(main_char_state_mchn, "sliding")
	&& !m_is_state(main_char_state_mchn, "slide_shooting")
	&& !m_is_state(main_char_state_mchn, "running") )
{
	with (inst_main_char) {
		m_send(main_char_state_mchn, "crouch_shoot");
	}
	
	inst_main_char.phy_speed_x = 0;

}
else if( m_is_state(main_char_state_mchn, "running") 
	|| m_is_state(main_char_state_mchn, "sliding") )
{

		with (inst_main_char) {
			m_send(main_char_state_mchn, "slide");
		}
		
		if( phy_speed_x == 0 )
		{
			with (inst_main_char) {
				m_send(main_char_state_mchn, "crouch");
			}
		}
}
else if( !m_is_state(main_char_state_mchn, "slide_shooting") )
{
	with (inst_main_char) {
		m_send(main_char_state_mchn, "crouch");
	}

	inst_main_char.phy_speed_x=0;
}

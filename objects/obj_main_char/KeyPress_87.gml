/// @description Insert description here
// You can write your code in this editor
friction = 0;
if( double_jump_flag < 1 )
{
	if( double_jump_flag == 0 )
	{
		with (inst_main_char) {
			m_send(main_char_state_mchn, "crouch");
		}
	}
	
	with (inst_main_char) {
		m_send(main_char_state_mchn, "jump");
	}
	
	inst_main_char.phy_speed_y = -500;
	double_jump_flag += 1;
}
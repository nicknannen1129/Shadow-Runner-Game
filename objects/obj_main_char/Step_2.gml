/// @description Insert description here
// You can write your code in this editor
if( position_meeting(x-50, y+25, obj_block) || position_meeting(x+50, y+25, obj_block) )
{
	if( m_is_state(main_char_state_mchn, "jumping" ) || m_is_state(main_char_state_mchn, "jump_shooting" ))
	{
		with (inst_main_char) {
			m_send(main_char_state_mchn, "land");
		}
	}
}
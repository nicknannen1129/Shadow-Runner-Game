/// @description Insert description here
// You can write your code in this editor
if( m_is_state(inst_main_char.main_char_state_mchn, "jumping") 
	|| m_is_state(inst_main_char.main_char_state_mchn, "jump_shooting") )
{
	friction = 0;	
}
else
{
	friction = 1;	
}
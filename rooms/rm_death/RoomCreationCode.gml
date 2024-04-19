audio_stop_all();

if( global.total_enemies_defeated > global.highscore )
{
	global.highscore = global.total_enemies_defeated;
	highscore_save();
}
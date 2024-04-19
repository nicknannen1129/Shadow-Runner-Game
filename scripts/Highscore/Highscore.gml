// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function highscore_load()
{
	var highscore_file = working_directory + "highscore";
	
	try
	{
		var handle = file_text_open_read(highscore_file);
		
		global.highscore = file_text_read_real(handle);
	}
	catch(_exception)
	{
		global.highscore = 0;
	}
}

function highscore_save()
{
	var highscore_file = working_directory + "highscore";
	var handle = file_text_open_write(highscore_file);
	
	file_text_write_real(handle, global.highscore);
	file_text_close(handle);
}
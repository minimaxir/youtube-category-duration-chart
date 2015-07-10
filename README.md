# youtube-category-duration
Code and data needed to reproduce The Relationship Between YouTube Video Category and Length of the Video

![](http://i.imgur.com/PvWYB2n.png)

Due to size (3.7MB), data must be downloaded from [this Dropbox URL](https://www.dropbox.com/s/juskxxe8zvgcj0i/youtube_duration_category.csv?dl=0).

Data obtained from my scraped database of YouTube submission metadata with this SQL query:
	
	SELECT category,
		duration - 1 as video_duration,
		COUNT(category) as num_videos
	FROM yt_videos
	WHERE duration > 0
	GROUP BY category, video_duration

Requires packages declared at beginning of *Rstart.R*. Fonts will only render if code is run on OS X.
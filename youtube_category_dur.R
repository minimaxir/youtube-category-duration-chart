source("Rstart.R")

secondsToString <- function(seconds) {
	sprintf("%01d:%02d", seconds %/% 60, seconds %% 60)
}

df <- read_csv("youtube_duration_category.csv") %>% group_by(category) %>% mutate(norm = num_videos/sum(num_videos)) %>% filter(!category %in% c("Action/Adventure","Documentary","Drama","Family","Horror","Thriller","Movies","Sci-Fi/Fantasy","Trailers"))

df_medians <- df %>% group_by(category) %>% summarize(count = sum(num_videos), mean = mean(rep(video_duration,num_videos)), med = median(rep(video_duration,num_videos))) %>% arrange(desc(med))

total_videos = sum(df$num_videos) # 11,159,063

# Sort facets by largest median to smallest
df$category = factor(df$category, level=df_medians$category)

plot <- ggplot(df, aes(color=category, fill=category, x=video_duration, y=norm)) +
	geom_density(stat="identity", alpha=0.75, size=0.25) +
	fte_theme() +
	facet_wrap(~ category, ncol=4, scales = "free_y") +
	scale_x_continuous(limits = c(0,600), breaks = seq(0,600, by=60), labels = paste(0:10,"m",sep='')) +
	geom_vline(aes(xintercept=med), size=0.20, data=df_medians, color="#1a1a1a", alpha=1, linetype="dashed") +
	geom_text(aes(label = paste("Median —", secondsToString(med)), x=med-130), y=Inf, vjust=2, size=2, hjust=-1, family="Avenir Next Condensed Regular", data=df_medians, color="#1a1a1a", alpha=1) +
	
	theme(axis.text.y = element_blank(), axis.title.y = element_blank(), panel.grid.major.y=element_blank()) +
	labs(title = expression(atop("The Relationship Between YouTube Video Category and Length of the Video",scriptstyle(italic("Density Distribution of Video Durations for 11,159,063 YouTube Videos, by YouTube Category")))), x = expression("Video Duration  " ~ scriptstyle(italic("(# of Minutes)"))))
	
max_save(plot,"youtube_category_duration", "YouTube API",h=6,w=8,tall=T,pdf=F)
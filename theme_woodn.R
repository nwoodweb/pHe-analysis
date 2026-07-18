# Custom Theming for R Graphics
# Nathan Wood 2025 contact@nwoodweb.xyz
# MIT LICENSE

require(ggplot2)

# GOOD COLORS

theme_woodn <- function(){
    font <- "Heros"
    theme_minimal() %+replace%
    theme(
        panel.grid.major = element_line(colour='#ffffff'),
        panel.grid.minor = element_blank(),
        axis.line = element_line(color = '#000000', linewidth = 1.0),
        axis.ticks = element_blank(),
	plot.title = element_text(
            family = font,
            size = 36,
            face = 'bold' 
        ),
        axis.title = element_text(
            family = font,
            size = 24,
            face = 'bold'
        ),
        axis.text = element_text(
            family = font,
            size = 20
        ),
	legend.title = element_text(
		family = font,
		size = 24,
		face = 'bold'
		), 
	legend.text = element_text(
		family = font,
		size = 18
		),
	
    )
}


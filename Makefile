FIGURES = $(shell ls -1 --color=no docs/*-dark.png docs/*-light.png | xargs -I{} basename "{}" .png | sed -e 's:-\(light\|dark\)$$::' | uniq)

image-tags:
	@MAX_WIDTH=0; \
	for d in $(FIGURES); do \
		FILE=docs/$${d}-dark.png; \
		WIDTH=$$(file $$FILE | cut -d' ' -f 5); \
		if [ $$WIDTH -lt 4000 ]; then \
			if [ $$MAX_WIDTH -lt $$WIDTH ]; then \
				MAX_WIDTH=$$WIDTH; \
			fi; \
		fi; \
	done; \
	for d in $(FIGURES); do \
		FILE=docs/$${d}-dark.png; \
		WIDTH=$$(file $$FILE | cut -d' ' -f 5); \
		if [ $$WIDTH -lt 4000 ]; then \
			BASE=$$(basename $$d .png); \
			PCT=$$(echo $$WIDTH/$$MAX_WIDTH*90 | bc -l); \
			printf "![$$BASE]($$BASE-dark.png#only-dark){ width=\"%4.2f%%\" }\n" \
				$$PCT; \
			printf "![$$BASE]($$BASE-light.png#only-light){ width=\"%4.2f%%\" }\n" \
				$$PCT; \
			echo "<br><a name="Figure-X">__Figure X__</a> - _<CAPTION>_"; \
			echo "{ .figure }"; \
			echo; \
		fi; \
	done;


.PHONY: all 

CURR_DIR = .

OUT_DIR = $(CURR_DIR)

SOURCES = $(CURR_DIR)/*.tex

TARGETS = $(CURR_DIR)/combinatoria.pdf

all: $(TARGETS) 

# object files
$(TARGETS): $(SOURCES)
	if [ -e $(CURR_DIR)/$(@F:.pdf=.toc) ] ; then
		cp $(CURR_DIR)/$(@F:.pdf=.toc) $(CURR_DIR)/$(@F:.pdf=.toc_old)
	fi
	pdflatex $(CURR_DIR)/$(@F:.pdf=.tex) -o $@ 
	if [ -e $(CURR_DIR)/$(@F:.pdf=.toc_old) ] ; then
		if diff $(CURR_DIR)/$(@F:.pdf=.toc) $(CURR_DIR)/$(@F:.pdf=.toc_old) ; then
			rm $(CURR_DIR)/$(@F)
			pdflatex $(CURR_DIR)/$(@F:.pdf=.tex) -o $@ 
			rm $(CURR_DIR)/$(@F:.pdf=.toc_old)
		fi
	fi

clean:
	rm -rf *.pdf

neat:
	find $(CURR_DIR) ! -name "*.tex" -a ! -name "*.pdf" -a ! -name "Makefile" -type f -delete


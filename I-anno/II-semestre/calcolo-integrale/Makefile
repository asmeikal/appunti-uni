
.PHONY: all 

CURR_DIR = .

OUT_DIR = $(CURR_DIR)

SOURCES = $(CURR_DIR)/*.tex

TARGETS = $(CURR_DIR)/calcolo_integrale.pdf \
	$(CURR_DIR)/cheat_sheet.pdf

all: $(TARGETS)

# object files
$(TARGETS): $(SOURCES)
	pdflatex $(CURR_DIR)/$(@F:.pdf=.tex) -o $@ 

clean:
	rm -rf *.pdf

neat:
	find $(CURR_DIR) ! -name "*.tex" -a ! -name "*.pdf" -a ! -name "Makefile" -type f -delete


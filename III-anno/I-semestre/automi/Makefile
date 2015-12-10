
.PHONY: all clean

CURR_DIR = .

OUT_DIR = $(CURR_DIR)

SOURCES = $(CURR_DIR)/*.tex
TARGETS = $(CURR_DIR)/appunti-automi.pdf

all: $(TARGETS)

$(TARGETS): $(TARGETS:.pdf=.tex) $(SOURCES)
	latexmk -pdf -pdflatex="pdflatex -interaction=nonstopmode" -use-make $(CURR_DIR)/$(@F:.pdf=.tex)

clean:
	latexmk -C

neat:
	latexmk -c


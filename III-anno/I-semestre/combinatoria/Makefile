
.PHONY: all clean

CURR_DIR = .

OUT_DIR = $(CURR_DIR)

TARGETS = $(CURR_DIR)/combinatoria.pdf

all: $(TARGETS)

$(TARGETS): $(TARGETS:.pdf=.tex)
	latexmk -pdf -pdflatex="pdflatex -interaction=nonstopmode" -use-make $(CURR_DIR)/$(@F:.pdf=.tex)

clean:
	latexmk -CA


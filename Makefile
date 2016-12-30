BUILD = build
BOOKNAME = my-book
TITLE = title.txt
METADATA = metadata.xml
CHAPTERS = NTHU.md
TOC = --toc
FORMAT = markdown+tex_math_dollars+latex_macros+backtick_code_blocks+fenced_code_attributes
COVER_IMAGE = images/cover.jpg
LATEX_CLASS = report

all: book

book: epub html pdf

clean:
	rm -r $(BUILD)

epub: $(BUILD)/epub/$(BOOKNAME).epub

html: $(BUILD)/html/$(BOOKNAME).html

pdf: $(BUILD)/pdf/$(BOOKNAME).pdf

$(BUILD)/epub/$(BOOKNAME).epub: $(CHAPTERS)
	mkdir -p $(BUILD)/epub
	pandoc $(TOC) -f $(FORMAT) -S --epub-metadata=$(METADATA) --epub-cover-image=$(COVER_IMAGE) -o $@ $^

$(BUILD)/html/$(BOOKNAME).html: $(CHAPTERS)
	mkdir -p $(BUILD)/html
	pandoc $(TOC) -f $(FORMAT) -S -m -s --css github-pandoc.css --standalone --self-contained -o $@ $^

$(BUILD)/pdf/$(BOOKNAME).pdf: $(CHAPTERS)
	mkdir -p $(BUILD)/pdf
	pandoc $(TOC) -f $(FORMAT) --smart -S --latex-engine=xelatex --template pandoc.template.zh.tex --variable cjkmainfont --variable cjkmonofont --variable monofont="BiauKai" --variable mainfont="BiauKai" -V documentclass=$(LATEX_CLASS) -o $@ $^

.PHONY: all book clean epub html pdf

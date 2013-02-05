.PHONY   = clean pdf odt html
.DEFAULT = pdf

src = $(shell find -name "*.rst")
out = $(shell echo $(src) | sed -e "s/\.rst//g")
pwd = $(shell pwd)

pdf:
	for o in $(out); do \
	  rst2pdf --font-path=$(pwd)/fonts \
	          --stylesheets=$(pwd)/styles.pdf.d/ja.json \
	          --stylesheets=$(pwd)/styles.pdf.d/model.json \
	          --output=$(pwd)/build/$${o}.pdf \
	          --language=ja \
	          $${o}.rst; \
	done

odt:
	for o in $(out); do \
	  rst2odt --stylesheet=$(pwd)/styles.odt.d/styles.odt \
	          --config=$(pwd)/styles.odt.d/mapping.conf \
	          --generate-oowriter-toc \
	          $${o}.rst build/$${o}.odt;\
	done

html:
	for o in $(out); do \
	  rst2html --no-generator \
	  		   --no-datestamp \
			   --no-source-link \
			   --no-toc-backlinks \
			   --section-numbering \
			   --output-encoding=UTF-8:strict \
			   --language=ja \
			   --template=styles.html.d/template.txt \
			   --stylesheet-path=styles.html.d/style.css \
			   --embed-stylesheet \
	           $${o}.rst build/$${o}.html;\
	done

clean:
	rm -rf build/*

test:
	@echo $(out)
	@echo $(out)

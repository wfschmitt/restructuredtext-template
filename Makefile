.PHONY   = clean clean-html pdf odt html html2pdf
.DEFAULT = pdf

src = $(shell find -maxdepth 1 -name "*.rst")
out = $(shell echo $(src) | sed -e "s/\.rst//g")
pwd = $(shell pwd)
wkhtmltopdf = $(shell which wkhtmltopdf || which wkhtmltopdf-amd64 || wkhtmltopdf-i386 || echo "")

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

html: clean-html
	[ -d images ] && ln -sf "../images" build-html/images || :
	[ -d includes ] && ln -sf "../includes" build-html/includes || :
	# we emebed styles
	#[ -d styles.html.d ] && ln -sf "../styles.html.d" build-html/css || :
	for o in $(out); do \
		ln -sf "../$${o}.rst" build-html/$${o}.rst; \
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
			build-html/$${o}.rst build-html/$${o}.html;\
	done

html2pdf: html
	for o in $(out); do \
		$(wkhtmltopdf) \
			--footer-right [page] \
			--footer-left [section] \
			--footer-font-size 9 \
			--footer-line \
			--footer-spacing 5 \
			--margin-top 20mm \
			--margin-bottom 20mm \
			--margin-left 20mm \
			--margin-right 20mm \
			build-html/$${o}.html build/$${o}.html.pdf; \
	done


clean:
	rm -rf build/*
	rm -f build-html/*

clean-html:
	rm -f build-html/*

test:
	@echo $(out)
	@echo $(out)
	@echo $(wkhtmltopdf)

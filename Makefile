BOOK_FILE_NAME = seattle-tour
TEMP_DIR = out

PDF_BUILDER = pandoc
PDF_BUILDER_FLAGS = \
	--latex-engine xelatex \
	--template ../_layouts/pdf-template.tex \
	--listings

combine:
	mkdir -p $(TEMP_DIR)
	cat _areas/*.md | tools/remove_header.rb > $(TEMP_DIR)/$(BOOK_FILE_NAME).md
	cp -r img/ ${TEMP_DIR}/img
	#cp _layouts/metadata.xml $(TEMP_DIR)/

pdf: combine
	cd $(TEMP_DIR) && $(PDF_BUILDER) $(PDF_BUILDER_FLAGS) $(BOOK_FILE_NAME).md -o $(BOOK_FILE_NAME).pdf

nup:
	cd $(TEMP_DIR) && pdfnup --frame false  --nup 2x1 $(BOOK_FILE_NAME).pdf

book: pdf
	cd $(TEMP_DIR) && pdf2ps $(BOOK_FILE_NAME).pdf - | psbook | psnup -2 -W5.5in -H8.5in -s0.9 -b1.4cm | ps2pdf - $(BOOK_FILE_NAME)-booklet.pdf

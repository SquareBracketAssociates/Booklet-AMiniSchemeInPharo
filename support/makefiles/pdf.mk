PILLAR_HOME ?= $(shell pwd)
PILLAR_EXEC ?= $(PILLAR_HOME)/pillar

$(call check_defined, LATEXTEMPLATE, Template for main document in PDF)
$(call check_defined, LATEXCHAPTERTEMPLATE, Template for individual chapters in PDF)

# List of alternate PDF formats generated from the default TeX and activated via
# the support/latex/*.preamble.tex files.
#
# Define the actual list in the main makefile; this just provides a default list
export ALTERNATEPRINTFORMATS ?= spiral

.phony: pdf pdfbook pdfchapters pdf-clean

pdf: pdfbook pdfchapters ## Everything PDF
pdfbook: $(OUTPUTDIRECTORY)/$(MAIN).pdf
pdfchapters: $(CHAPTERS:%=$(OUTPUTDIRECTORY)/%.pdf)

clean: pdf-clean
pdf-clean:
	for f in $(addprefix $(OUTPUTDIRECTORY)/,$(MAIN) $(CHAPTERS)); do \
		latexmk -cd -f -c "$$f" ; \
		rm -f "$$f.tex" "$$f.d" $$(dirname $$f)/Makefile; \
	done

# LaTeX sources generation from Pillar & templates
$(OUTPUTDIRECTORY)/$(MAIN).tex: $(CHAPTERS:%=%.pillar)
$(OUTPUTDIRECTORY)/%.tex: %.pillar | prepare
	$(PILLAR_EXEC) export --to="LaTeX" --outputDirectory=$(OUTPUTDIRECTORY) --outputFile=$@ $<

# Generated rules for each alternate PDF format
define FORMAT_rule
.phony: $(1) $(1)book $(1)chapters $(1)-clean

$(1): $(1)book $(1)chapters
$(1)book: $$(OUTPUTDIRECTORY)/$$(MAIN).$(1).pdf
$(1)chapters: $$(CHAPTERS:%=$$(OUTPUTDIRECTORY)/%.$(1).pdf)

clean: $(1)-clean
$(1)-clean:
	for f in $$(patsubst %,$$(OUTPUTDIRECTORY)/%.$(1),$$(MAIN) $$(CHAPTERS)); do \
		latexmk -cd -f -c "$$$$f" ; \
		rm -f "$$$$f.tex" "$$$$f.d"; \
	done

# LaTeX wrapper files for alternate formats
%.$(1).tex: %.tex support/latex/$(1).preamble.tex
	@echo '\input{root/support/latex/$(1).preamble}\input{$$(*F)}' > $$@
endef
$(foreach fmt,$(ALTERNATEPRINTFORMATS),\
	$(eval $(call FORMAT_rule,$(fmt))))

# LaTeX compilation via sub-make
# (required because of the paths in the *.d dependency files)
$(OUTPUTDIRECTORY)/%.pdf: $(OUTPUTDIRECTORY)/%.tex
	cp support/makefiles/pdf.sub.mk $(@D)/Makefile
	make --directory=$(@D) $(@F)

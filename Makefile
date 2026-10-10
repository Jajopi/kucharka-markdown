# Build the guidebook from Markdown with pandoc.
#   make            – everything (PDF, single-page HTML, multi-page HTML, zip)
#   make pdf        – PDFs only
#   make html       – single-page HTML only
#   make chunked    – multi-page HTML only (one page per chapter)
#   make cs-pdf     – one language / one format (also en-pdf, cs-html, …)
#   make clean

PANDOC ?= pandoc
LANGS  ?= cs en
BUILD  ?= build
T      := templates

# numbered chapters in numeric order, then (if any) the appendices A.md, B.md, …
chapters   = $(shell ls $(1)/[0-9]*.md 2>/dev/null | sort -V)
appendices = $(sort $(wildcard $(1)/[A-Z].md))
sources    = $(call chapters,$(1)) $(if $(call appendices,$(1)),$(T)/appendices.md $(call appendices,$(1)))
deps       = $(call sources,$(1)) $(1)/metadata.yaml $(wildcard $(1)/images/*) $(wildcard $(T)/*)

PDFS    := $(foreach l,$(LANGS),$(BUILD)/kucharka-$(l).pdf)
HTMLS   := $(foreach l,$(LANGS),$(BUILD)/kucharka-$(l).html)
CHUNKED := $(foreach l,$(LANGS),$(BUILD)/html-$(l)/index.html)
ZIP     := $(BUILD)/kucharka-html.zip

.PHONY: all pdf html chunked zip clean $(foreach l,$(LANGS),$(l)-pdf $(l)-html $(l)-chunked)
.SECONDEXPANSION:

all: pdf html chunked zip
pdf: $(PDFS)
html: $(HTMLS)
chunked: $(CHUNKED)
zip: $(ZIP)

$(foreach l,$(LANGS),$(eval $(l)-pdf: $(BUILD)/kucharka-$(l).pdf))
$(foreach l,$(LANGS),$(eval $(l)-html: $(BUILD)/kucharka-$(l).html))
$(foreach l,$(LANGS),$(eval $(l)-chunked: $(BUILD)/html-$(l)/index.html))

$(BUILD)/kucharka-%.pdf: $$(call deps,%)
	@mkdir -p $(@D)
	$(PANDOC) --defaults=$(T)/pdf.yaml --resource-path=$*:. \
	  --metadata-file=$*/metadata.yaml -o $@ $(call sources,$*)

$(BUILD)/kucharka-%.html: $$(call deps,%)
	@mkdir -p $(@D)
	$(PANDOC) --defaults=$(T)/html.yaml --resource-path=$*:. \
	  --metadata-file=$*/metadata.yaml -o $@ $(call sources,$*)

$(BUILD)/html-%/index.html: $$(call deps,%)
	@mkdir -p $(BUILD)
	rm -rf $(BUILD)/html-$*
	$(PANDOC) --defaults=$(T)/chunked.yaml --resource-path=$*:. \
	  --metadata-file=$*/metadata.yaml -o $(BUILD)/html-$* $(call sources,$*)
	cp $(T)/style.css $(BUILD)/html-$*/style.css

# zip with the multi-page HTML of every language + the single-page HTML files
$(ZIP): $(CHUNKED) $(HTMLS)
	rm -f $@
	cd $(BUILD) && zip -qr $(notdir $@) $(foreach l,$(LANGS),html-$(l) kucharka-$(l).html)

clean:
	rm -rf $(BUILD)

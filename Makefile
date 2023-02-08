VENV=venv/bin/activate
OUTPUT_DIR=output
RESOURCES=$(OUTPUT_DIR)/hxl-proxy-resources.csv
RECIPES=$(OUTPUT_DIR)/hxl-proxy-recipes.csv

run: recipes

resources: $(RESOURCES)

recipes: $(RECIPES)

$(RESOURCES): $(VENV) $(OUTPUT_DIR)
	. $(VENV) && python3 find-resources.py > $(RESOURCES)

$(RECIPES): $(RESOURCES)
	. $(VENV) && cat $(RESOURCES) \
	| hxlcut -i meta+url \
	| hxlselect -q 'meta+url ~ hxlstandard.org/data/[^/.]{6}[/.]' \
	| hxlreplace -t meta+url -r -p '^(https://proxy.hxlstandard.org/data/.{6}).*' -s '\1' \
	| hxlcount -t meta+url \
	| hxlsort -r -t meta+count \
	| hxlrename -r '#meta+url:Recipe#x_recipe+url' \
	> $(RECIPES)

$(OUTPUT_DIR):
	mkdir -p $(OUTPUT_DIR)

$(VENV): requirements.txt
	rm -rf venv \
	&& python3 -m venv venv \
	&& . $(VENV) \
	&& pip3 install -r requirements.txt

clean:
	rm -rf $(RESOURCES) $(RECIPES)

real-clean: clean
	rm -rf $(VENV)

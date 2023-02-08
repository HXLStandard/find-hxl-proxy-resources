VENV=venv/bin/activate
OUTPUT_DIR=output
OUTPUT=$(OUTPUT_DIR)/hxl-proxy-resources.csv

run: $(OUTPUT)

$(OUTPUT): $(VENV)
	. $(VENV) && mkdir -p $(OUTPUT_DIR) && python3 find-resources.py > $(OUTPUT)

$(VENV):
	rm -rf venv && python3 -m venv venv && . $(VENV) && pip3 install -r requirements.txt

clean:
	rm -rf $(OUTPUT)

real-clean: clean
	rm -rf $(VENV)

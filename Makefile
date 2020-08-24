.PHONY: clean test_environment requirements 
#################################################################################
# GLOBALS                                                                       #
#################################################################################

PROJECT_DIR := $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))
PROJECT_NAME = geo_mapping
PYTHON_INTERPRETER = python3

ifeq (,$(shell which conda))
HAS_CONDA=False
else
HAS_CONDA=True
endif


## Delete all compiled Python files (no dependicies)
clean:
	find . -type f -name "*.py[co]" -delete
	find . -type d -name "__pycache__" -delete

## Test python environment is setup correctly
test_environment:
	$(PYTHON_INTERPRETER) test_environment.py

requirements: test_environment
	## I SHOULD ADD SOME SORT OF THING HERE WHICH CAN CHECK IF THE ENVIRONMENT IS ACTIVE?
	$(PYTHON_INTERPRETER) -m pip install -U pip setuptools wheel
	$(PYTHON_INTERPRETER) -m pip install -r requirements.txt

		@echo "please download r tree with: "
		@echo "pip install "rtree>=0.8,<0.9""   
		@echo "please activate jupyter notebook" 

## Set up python interpreter environment
create_environment:
ifeq (True,$(HAS_CONDA))
		@echo ">>> Detected conda, creating conda environment."
ifeq (3,$(findstring 3,$(PYTHON_INTERPRETER)))
	conda create --name $(PROJECT_NAME) python=3.7
else
		@echo "No version of python3 has been detected"
endif
		@echo ">>> New conda env created. Activate with:\nconda activate $(PROJECT_NAME)"
else
		@echo " There is no detected conda environment"
endif

#Delete the environment
delete_env: 
	conda env remove --name $(PROJECT_NAME)

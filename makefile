CC                    = gcc
CFLAGS                = -IResource/inc -IUnity -ITest/Specific/inc -ITest/Generic/inc

# Directories
CUR_DIR               = .
OBJ_DIR               = $(CUR_DIR)/Obj
BIN_DIR               = $(CUR_DIR)/Bin
TEST_DIR              = $(CUR_DIR)/Test
TEST_GENERIC_DIR      = $(TEST_DIR)/Generic
TEST_SPECIFIC_DIR     = $(TEST_DIR)/Specific
TEST_GENERIC_SRC_DIR  = $(TEST_GENERIC_DIR)/src
TEST_GENERIC_INC_DIR  = $(TEST_GENERIC_DIR)/inc
TEST_SPECIFIC_SRC_DIR = $(TEST_SPECIFIC_DIR)/src
TEST_SPECIFIC_INC_DIR = $(TEST_SPECIFIC_DIR)/inc
REPORT_DIR            = $(TEST_DIR)/Report
UNITY_DIR             = $(CUR_DIR)/Unity

# Source files
TEST_SRC_FILES     = $(wildcard $(TEST_GENERIC_SRC_DIR)/*.c)
UNITY_SRC_FILES    = $(wildcard $(UNITY_DIR)/*.c)

# Convert .c files to .o files
TEST_OBJ_FILES     = $(patsubst $(TEST_GENERIC_SRC_DIR)/%.c,$(OBJ_DIR)/%.o,$(TEST_SRC_FILES))
UNITY_OBJ_FILES    = $(patsubst $(UNITY_DIR)/%.c,$(OBJ_DIR)/%.o,$(UNITY_SRC_FILES))
MAIN_OBJ_FILE      = $(OBJ_DIR)/main.o
MAINSUITE_OBJ_FILE = $(OBJ_DIR)/TestSuite01.o

# MAIN_OBJ_FILES: Object files required for building the main application.
# TEST_ALL_OBJ_FILES: Object files required for building the test application (including Unity, test suite, etc.).
MAIN_OBJ_FILES     = $(MAIN_OBJ_FILE)
TEST_ALL_OBJ_FILES = $(UNITY_OBJ_FILES) $(TEST_OBJ_FILES) $(MAINSUITE_OBJ_FILE)

# TEST_TARGET: The final executable for the test application, stored in the BIN_DIR.
TEST_TARGET        = $(BIN_DIR)/test_app.exe

# Report file
REPORT_FILE = $(REPORT_DIR)/Result.txt

all: clean build test

# The build target depends on both the test executable and the main application.
build: $(TEST_TARGET) $(TARGET)

# Compile source files from Resource/src
$(OBJ_DIR)/%.o: $(RESOURCE_SRC_DIR)/%.c
	$(CC) $(CFLAGS) -c $< -o $@

# Compile source files from Unity
$(OBJ_DIR)/%.o: $(UNITY_DIR)/%.c
	$(CC) $(CFLAGS) -c $< -o $@

# Compile test source files from Test/src
$(OBJ_DIR)/%.o: $(TEST_GENERIC_SRC_DIR)/%.c
	$(CC) $(CFLAGS) -c $< -o $@

# Compile TestSuite01 source file
$(OBJ_DIR)/TestSuite01.o: $(TEST_SPECIFIC_SRC_DIR)/TestSuite01.c
	$(CC) $(CFLAGS) -c $< -o $@

# Link objects to create the test executable
$(TEST_TARGET): $(TEST_ALL_OBJ_FILES)
	$(CC) $(TEST_ALL_OBJ_FILES) -o $@

# Run tests
test: build
	@$(TEST_TARGET) > $(REPORT_FILE) 2>&1
	@echo "----------------------------------------------------------------"
	@python $(TEST_DIR)/convert_report_to_html.py $(REPORT_FILE)
	@python $(TEST_DIR)/convert_report_to_xlsx.py $(REPORT_FILE)
	@echo "----------------------------------------------------------------"

# Clean object files and binaries
clean:
	rm -f $(OBJ_DIR)/*.o $(BIN_DIR)/* $(REPORT_DIR)/*

.PHONY: all clean test

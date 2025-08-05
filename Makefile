# ==============================================================================
# Build Configuration
# ==============================================================================

# Directories
SRCDIR := src
INCDIR := inc
OBJDIR := .o
BINDIR := build

# RGBDS toolchain
RGBDS ?=
ASM   := $(RGBDS)rgbasm
LINK  := $(RGBDS)rgblink
FIX   := $(RGBDS)rgbfix

# Flags for rgbasm
ASFLAGS := -I$(INCDIR)/

# Flags for rgbfix
FIXFLAGS := -v -p 0xFF

# ==============================================================================
# File Definitions
# ==============================================================================

# Find all .asm source files in the current directory
ASMSOURCES := $(wildcard $(SRCDIR)/*.asm)

# Convert .asm filenames to .o object files
OBJS := $(patsubst $(SRCDIR)/%.asm,$(OBJDIR)/%.o,$(ASMSOURCES))

# Convert .asm filenames to .gb ROM paths in BINDIR
ROMS := $(patsubst $(SRCDIR)/%.asm,$(BINDIR)/%.gb,$(ASMSOURCES))

# ==============================================================================
# Build Targets
# ==============================================================================

# Default target - builds all ROMs
all: $(ROMS)
	@echo "All ROMs built successfully in $(BINDIR)/"

# Rule to create the output directories
$(BINDIR) $(OBJDIR):
	mkdir -p $@

# Rule to build a ROM (.gb) from its object file (.o)
$(BINDIR)/%.gb: $(OBJDIR)/%.o | $(BINDIR) $(OBJDIR)
	$(LINK) -o $@ $^
	$(FIX) $(FIXFLAGS) $@
	@echo "Successfully created $@"

# Rule to assemble a source file (.asm) into an object file (.o)
$(OBJDIR)/%.o: $(SRCDIR)/%.asm | $(OBJDIR)
	$(ASM) $(ASFLAGS) -o $@ $<

# Clean up all generated files
clean:
	rm -rf $(OBJDIR)
	rm -rf $(BINDIR)
	@echo "Cleaned all build artifacts"

# Tells 'make' that 'all' and 'clean' are not actual files to be built
.PHONY: all clean
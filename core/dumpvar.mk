# ---------------------------------------------------------------
# the setpath shell function in envsetup.sh uses this to figure out
# what to add to the path given the config we have chosen.
ifeq ($(CALLED_FROM_SETUP),true)

ifneq ($(filter /%,$(SOONG_HOST_OUT_EXECUTABLES)),)
ABP := $(SOONG_HOST_OUT_EXECUTABLES)
else
ABP := $(PWD)/$(SOONG_HOST_OUT_EXECUTABLES)
endif
ifneq ($(filter /%,$(HOST_OUT_EXECUTABLES)),)
ABP := $(ABP):$(HOST_OUT_EXECUTABLES)
else
ABP := $(ABP):$(PWD)/$(HOST_OUT_EXECUTABLES)
endif

ANDROID_BUILD_PATHS := $(ABP)
ANDROID_PREBUILTS := prebuilt/$(HOST_PREBUILT_TAG)
ANDROID_GCC_PREBUILTS := prebuilts/gcc/$(HOST_PREBUILT_TAG)

# Dump mulitple variables to "<var>=<value>" pairs, one per line.
# The output may be executed as bash script.
# Input variables:
#   DUMP_MANY_VARS: the list of variable names.
#   DUMP_VAR_PREFIX: an optional prefix of the variable name added to the output.
.PHONY: dump-many-vars
dump-many-vars :
	HOST_OS_EXTRA:=$(shell python -c "import platform; print(platform.platform())")
	ifneq ($(BUILD_WITH_COLORS),0)
		include $(TOP_DIR)build/core/colors.mk
	endif
	$(info $(CLR_RED)=============================================================$(CLR_RST))
	$(info $(CLR_RED)                                                             $(CLR_RST))
	$(info $(CLR_RED)██╗███╗   ██╗██╗   ██╗██╗ ██████╗████████╗██████╗ ██╗██╗  ██╗$(CLR_RST))
	$(info $(CLR_RED)██║████╗  ██║██║   ██║██║██╔════╝╚══██╔══╝██╔══██╗██║╚██╗██╔╝$(CLR_RST))
	$(info $(CLR_RED)██║██╔██╗ ██║██║   ██║██║██║        ██║   ██████╔╝██║ ╚███╔╝ $(CLR_RST))
	$(info $(CLR_RED)██║██║╚██╗██║╚██╗ ██╔╝██║██║        ██║   ██╔══██╗██║ ██╔██╗ $(CLR_RST))
	$(info $(CLR_RED)██║██║ ╚████║ ╚████╔╝ ██║╚██████╗   ██║   ██║  ██║██║██╔╝ ██╗$(CLR_RST))
	$(info $(CLR_RED)╚═╝╚═╝  ╚═══╝  ╚═══╝  ╚═╝ ╚═════╝   ╚═╝   ╚═╝  ╚═╝╚═╝╚═╝  ╚═╝$(CLR_RST))
	$(info $(CLR_RED)                                                             $(CLR_RST))
	$(info $(CLR_RED)=============================================================$(CLR_RST))
	@$(foreach v, $(DUMP_MANY_VARS),\
	  echo "$(DUMP_VAR_PREFIX)$(CLR_RED)$(v)='$($(v))'$(CLR_RST)";)
	$(info $(CLR_RED)=============================================================$(CLR_RST))

endif # CALLED_FROM_SETUP

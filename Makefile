OS = LINUX
PKGS = 	--pkg gee-1.0 --pkg gtk+-3.0 --pkg gmodule-2.0 --pkg granite
		\
		\
# Pakete
PACKAGES       =  gee-1.0  gtk+-3.0  gio-2.0  gmodule-2.0 granite
PKG_FLAGS             = $(PACKAGES:%=--pkg %)
# Version des Pakets
VERSION        = 0.01
# Name des Pakets
PKG_NAME       = XMI_GEN
GIR_NAME = $(PKG_NAME)-$(VERSION).gir

# Allgemeine Quelldateien mit Pfad
ASRC_FILES                 = $(wildcard *.vala) $(wildcard src/Clutter/*.vala) $(wildcard src/OpenGL/*.vala) $(wildcard src/Gdk/*.vala)
# Quelldateien mit Pfad
SRC_FILES                  = $(ASRC_FILES)

LIBS = \
	
FLAGS = -g
FILES = \
	 src/main.vala \
	 src/Window.vala \
	 src/build_dir.vala \
	 src/MasterState.vala \
	 src/CLASS.vala \
     src/Namespace.vala \
	 src/load_file.vala \
	 src/Attribute.vala \
	 src/Datatype.vala \
	 src/Method.vala \
	 src/Parameter.vala \
	 src/FileName.vala \
	 src/load_file_private.vala \
	 src/Finish.vala \

all: $(FILES)
	valac $(FLAGS) $(PKGS) $(LIBS) -o main $(FILES)
	./main 

clean:
	find . -type f -name "*.so" -exec rm -f {} \;
	find . -type f -name "*.a" -exec rm -f {} \;
	find . -type f -name "*.o" -exec rm -f {} \;
	find . -type f -name "*.h" -exec rm -f {} \;
	find . -type f -name "*.c" -exec rm -f {} \;
	rm main

gir: $(FILES)
	valac -C  $(PKGS) $(LIBS)  $(FILES) --library $(PKG_NAME) --gir $(GIR_NAME) --basedir ./
	find . -type f -name "*.so" -exec rm -f {} \;
	find . -type f -name "*.a" -exec rm -f {} \;
	find . -type f -name "*.o" -exec rm -f {} \;
	find . -type f -name "*.h" -exec rm -f {} \;
	find . -type f -name "*.c" -exec rm -f {} \;


doc: $(SRC_FILES)
	@echo "Generating Documentation..."
	@valadoc -o doc/ --vapidir=/usr/share/vala-0.18/vapi/  $(PKG_FLAGS) $(CC_FLAGS) $(SRC_FILES) --package-name $(PKG_NAME) --package-version=$(VERSION)
	@gnome-open ./doc/index.html

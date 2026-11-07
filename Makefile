.DEFAULT_GOAL := build

CC := gcc
CFLAGS := -std=c99 -Wall -Wextra -Wpedantic -g
LDLIBS := -lm

TASK ?= zad01

TASKS := zad01 zad02 zad03 zad04 zad05 zad06
APPS := $(addprefix build/,$(TASKS))

ifeq ($(filter $(TASK),$(TASKS)),)
$(error Nieznane zadanie: $(TASK))
endif

.PHONY: build run test all clean

build: build/$(TASK)

build/%: src/%.c
	mkdir -p build
	$(CC) $(CFLAGS) $< -o $@ $(LDLIBS)

run: build/$(TASK)
	./build/$(TASK)

test: build/$(TASK)
	bash ./run_tests.sh $(TASK)

all: $(APPS)

clean:
	rm -rf build
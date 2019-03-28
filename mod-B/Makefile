
TARGET = modinfo
SOURCE = $(TARGET).c

all: $(TARGET)

$(TARGET):
	$(CC) $(CFLAGS) -o $(TARGET) $(SOURCE) $(LDFLAGS)

clean:
	@-rm -f *.o $(TARGET)


.PHONY: all clean $(TARGET)

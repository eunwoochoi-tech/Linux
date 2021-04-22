CC = gcc
CXX = g++

TARGET			= app
C_SRCS			= app.c
C_OBJS			:= $(C_SRCS:.c=.o)
CXX_SRCS		= test.cpp
CXX_OBJS		:= $(CXX_SRCS:.cpp=.o)

OPENCV = `pkg-config opencv4 --libs --cflags`
LIBS = $(OPENCV)

$(TARGET): $(CXX_OBJS) $(C_OBJS) 
	gcc -o $@ $^ -lstdc++ $(LIBS)
$(CXX_OBJS): $(CXX_SRCS)
	$(CXX) -c -o $@ $^ $(LIBS)
$(C_OBJS): $(C_SRCS)
	$(CC) -c -o $@ $^ $(LIBS)
clean:
	rm -rf *.o $(TARGET)

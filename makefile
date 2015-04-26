# Builds 2 test progs for testing boost thread vs pthreads
# The test progs should be named the same as the resulting binaries with a cpp
# extension. There is only one file required for each. This makefile is designed
# to build them as a large project would be built. Creating object files then
# linking them togather. To make sure the benchmark is as realistic as possible.

CPP_FLAGS   := -O2 -s
BOOST_EXE   := bthread
PTHREAD_EXE := pthread

all: $(BOOST_EXE) $(PTHREAD_EXE)

$(BOOST_EXE): $(BOOST_EXE).o
	g++ $^ -o $@ -lboost_thread

$(PTHREAD_EXE): $(PTHREAD_EXE).o
	g++ $^ -o $@ -lpthread

clean:
	rm -rf *.o
	if [ -e pthread ] ; then rm pthread ; fi
	if [ -e bthread ] ; then rm bthread ; fi

%.o: %.cpp
	g++ $(CPP_FLAGS) -c $^ -o $@

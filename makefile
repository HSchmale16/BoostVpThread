all: bthread pthread

bthread:
	g++ bthread.cpp -o $@ -lboost_thread

pthread: 
	g++ pthread.cpp -o $@ -lpthread

.PHONY: clean
clean:
	rm pthread bthread

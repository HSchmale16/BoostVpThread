all: bthread pthread

bthread:
	g++ bthread.cpp -O2 -o $@ -lboost_thread

pthread: 
	g++ pthread.cpp -O2 -o $@ -lpthread

clean:
	rm pthread bthread

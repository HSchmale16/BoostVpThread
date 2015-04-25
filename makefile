all: bthread pthread

bthread:
	g++ bthread.cpp -o $@ -lboost_thread

pthread: 
	g++ pthread.cpp -o $@ -lpthread



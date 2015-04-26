/** Creates a 100 threads to do something
 */

#include "constants.h"
#include <boost/thread/thread.hpp>
#include <cstdlib>
#include <cstdio>
#include <cmath>

double intergrals[100];

struct tData{
    int id;
    double c2;
    double c1;
    double c0;
};

void foo(tData* d){
    // Calculate the intergral of a random quadratic using
    // reiman sums
    double tot = 0;
    d->c2  = d->id / 50.0 - 1.0;
    d->c1  = d->id / 100.0;
    d->c0  = rand() / (RAND_MAX / 4.0);
    for(double j = -10; j < 10; j+=DX){
        tot += (d->c2 * pow(j, 2) + d->c1 * j + d->c0) * DX;
    }
    intergrals[d->id] = tot;
}

int main(){
    boost::thread* threads[100];
    tData          data[100];

    srand(RAND_SEED);
    for(int j = 0; j < 100; j++){
        data[j].id  = j;
        threads[j]  = new boost::thread(&foo, &data[j]);
    }
    for(int j = 0; j < 100; j++){
        threads[j]->join();
        printf("%d  ->   %fX^2 + %fX + %f = %f\n", data[j].id, data[j].c2,
            data[j].c1, data[j].c0, intergrals[j]);
        delete threads[j];
    }
    return 0;
}

/** Creates a 100 threads to do something
 */

#include <pthread.h>
#include <cstdlib>
#include <cstdio>
#include <cmath>

const double DX = .001;
double intergrals[100];

struct tData{
    int id;
    double c2;
    double c1;
    double c0;
};

void* foo(void* threaddata){
    // Calculate the intergral of a random quadratic using
    // reiman sums
    tData* d;
    double tot = 0;
    d = (tData*)threaddata;
    
    for(double j = -10; j < 10; j+=DX){
        tot += (d->c2 * pow(j, 2) + d->c1 * j + d->c0) * DX;
    }
    intergrals[d->id] = tot;
    pthread_exit(NULL);
}

int main(){
    pthread_t threads[100];
    tData     data[100];
    int       rc;

    srand(time(0));
    for(int j = 0; j < 100; j++){
        data[j].id  = j;
        data[j].c2  = j / 50.0 - 1.0;
        data[j].c1  = j / 100.0;
        data[j].c0  = rand() / (RAND_MAX / 4.0);
        rc = pthread_create(&threads[j], NULL, foo, &data[j]);
        if(rc){
            // print error
            printf("Threading Err: %d\n", rc);
            exit(0);
        }
    }
    for(int j = 0; j < 100; j++){
        pthread_join(threads[j], NULL);
        printf("%d  ->   %fX^2 + %fX + %f = %f\n",data[j].id, data[j].c2,
            data[j].c1, data[j].c0, intergrals[j]);
    }
    return 0;
}

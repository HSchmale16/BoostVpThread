# BoostVpThread

A benchmark of `pthreads` vs `boost::thread` using riemann sums of randomlly generated quadratics running in 100 threads.

# Run instructions
1. You must be running a unix(or unix-like) box with the following utilities and libriaries available.
    * `gnu make`
    * `perl`
    * `g++`
    * `boost_thread`
    * `pthread`
2. Run `test.pl`
3. The winner of the benchmark is output at the end.

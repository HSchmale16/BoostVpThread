#!/usr/bin/perl
$ITER = 50.0; # Iterations for the benchmark

# build prog
system("sh -c make > /dev/null");

Bench("pthread", $ITER);
Bench("bthread", $ITER);

# Perform Clean-up
# system("rm junk");
system("sh -c make clean > /dev/null");

# ---- Subroutines ----

# bench mark
# Accepts a binary name to execute returns points for the win
sub Bench{
    local $ITER   = $_[1];
    local $sz     = `wc --bytes $_[0]`;
    local $dt_sys = 0;
    local $dt_usr = 0;
    local $dt_rea = 0;
    for($a = 0; $a < $ITER; $a++) {
        system("{ time ./$_[0] > /dev/null ; } 2> junk");
        # Real
        my $out = `head -2 junk | tail -1`;
        $out=~s/[^.0-9]//g;
        $dt_rea += $out;
        # User
        my $out = `tail -2 junk | head -1`;
        $out=~s/[^.0-9]//g;
        $dt_usr += $out;
        # Sys
        my $out = `tail -1 junk`;
        $out=~s/[^.0-9]//g;
        $dt_sys += $out;
    }
    print  "\n  --- $_[0] ---\n";
    printf("Bin Size = %d\n\n", $sz);
    printf("tot Real = %f\n", $dt_rea);    
    printf("tot User = %f\n", $dt_usr);
    printf("tot Sys  = %f\n", $dt_sys);
    $dt_rea /= $ITER;
    $dt_usr /= $ITER;
    $dt_sts /= $ITER;
    printf("avg Real = %f\n", $dt_rea);
    printf("avg User = %f\n", $dt_usr);
    printf("avg Sys  = %f\n", $dt_sys);
}

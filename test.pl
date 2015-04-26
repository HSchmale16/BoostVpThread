#!/usr/bin/perl
$ITER = 5000.0; # Iterations for the benchmark

# build prog
system("sh -c make > /dev/null");

# benchmark pthread
$pdt = 0; # pthread delta t
$psz = `wc --bytes pthread`;
for($a = 0; $a < $ITER; $a++) {
    system("{ time ./pthread > /dev/null ; } 2> junk");
    my $out = `tail -1 junk`;
    $out=~s/[^.0-9]//g;
    $pdt += $out;
}

print  "\n  --- PThreads ---\n";
printf("Binary Size   = %d\n", $psz);
printf("total runtime = %f\n", $pdt);
$pdt = $pdt / $ITER;
printf("avg runtime   = %f\n", $pdt);

# bench bthread
$bdt = 0; # bthread delta t
$bsz = `wc --bytes bthread`;
for($a = 0; $a < $ITER; $a++) {
    system("{ time ./bthread > /dev/null ; } 2> junk");
    my $out = `tail -1 junk`;
    $out=~s/[^.0-9]//g;
    $bdt += $out;
}

print  "\n  --- Boost Threads ---\n";
printf("Binary Size   = %d\n", $bsz);
printf("total runtime = %f\n", $bdt);
$bdt = $bdt / $ITER;
printf("avg runtime   = %f\n", $bdt);

# determine the winner
$pwin = 0;
$bwin = 0;
# Average Execuation Time
if($pdt > $bdt){
    print("Boost Threads are faster\n");
    bwin += 1;
}else{
    print("pthreads are faster\n");
    pwin += 1;
}

# Binary Size
if($psz < $bsz){
    print("pthread binary size is smaller");
    pwin += 1;
}else{
    print("boost thread binary is smaller");
    bwin += 1;
}

# Perform Clean-up
system("rm junk");
system("sh -c make clean > /dev/null");

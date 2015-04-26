#!/usr/bin/perl
$ITER = 5000; # Iterations for the benchmark

# build prog
system("sh -c make > /dev/null");

# benchmark pthread
$pdt = 0; # pthread delta t
for($a = 0; $a < $ITER; $a++) {
    system("{ time ./pthread > /dev/null ; } 2> junk");
    my $out = `tail -1 junk`;
    $out=~s/[^.0-9]//g;
    $pdt += $out;
}

print  "  --- PThreads ---\n";
printf("total runtime = %f\n", $pdt);
$pdt = $pdt / $ITER;
printf("avg runtime   = %f\n", $pdt);

# bench bthread
$bdt = 0; # bthread delta t
for($a = 0; $a < $ITER; $a++) {
    system("{ time ./bthread > /dev/null ; } 2> junk");
    my $out = `tail -1 junk`;
    $out=~s/[^.0-9]//g;
    $bdt += $out;
}

print  "  --- Boost Threads ---\n";
printf("total runtime = %f\n", $bdt);
$bdt = $bdt / $ITER;
printf("avg runtime   = %f\n", $bdt);

# determine the winner
if($pdt > $bdt){
    print("Boost Threads are faster\n");
}else{
    print("pthreads are faster\n");
}

# Perform Clean-up
system("rm junk");
system("sh -c make clean > /dev/null");

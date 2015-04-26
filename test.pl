#!/usr/bin/perl
$ITER = 50; # Iterations for the benchmark

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
$pdt = $pdt / $ITER;

# bench bthread
$bdt = 0; # bthread delta t
for($a = 0; $a < $ITER; $a++) {
    system("{ time ./bthread > /dev/null ; } 2> junk");
    my $out = `tail -1 junk`;
    $out=~s/[^.0-9]//g;
    $bdt += $out;
}
$bdt = $bdt / $ITER;

# output the results whatever they may be
printf("pthread avg runtime = %f\n", $pdt);
printf("boost thread avg    = %f\n", $bdt);


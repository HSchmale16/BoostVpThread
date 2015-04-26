#!/usr/bin/perl
$ITER = 1000.0; # Iterations for the benchmark

# build prog
system("sh -c make > /dev/null");

@p = Bench("pthread", $ITER);
@b = Bench("bthread", $ITER);

# determine winner
print "\n ---- Results ----\n";
$pwin = 0; $bwin = 0;
for($a = 0; $a < scalar(@p); $a++){
    # low score wins
    if($p[$a] < $b[$a]){
        $pwin += 1;
        $w = "pthreads";
    }else{
        $bwin += 1;
        $w = "boost";
    }
    printf("Test %d Winner: %s\n", $a, $w);
}

# the final winner is who had the most points at the end
if($pwin > $bwin){
    $w = "pthreads";
}else{
    $w = "boost";
}
printf("\nFinal Winner: %s\n", $w);


# Perform Clean-up
system("rm junk");
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
    printf("Bin Size = %d bytes\n\n", $sz);
    printf("tot Real = %f sec\n", $dt_rea);    
    printf("tot User = %f sec\n", $dt_usr);
    printf("tot Sys  = %f sec\n\n", $dt_sys);
    local $at_rea = $dt_rea / $ITER;
    local $at_usr = $dt_usr / $ITER;
    local $at_sys = $dt_sys / $ITER;
    printf("avg Real = %f sec\n", $at_rea);
    printf("avg User = %f sec\n", $at_usr);
    printf("avg Sys  = %f sec\n", $at_sys);
    @res = ($sz, $dt_sys, $dt_usr, $dt_rea, $at_sys, $at_usr, $at_rea);
    return @res;
}

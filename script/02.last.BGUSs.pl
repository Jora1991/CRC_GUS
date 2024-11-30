use strict;
use warnings;

die"usage:perl $0 
    <in1:prot fa after blast and hmm> 
    <in2:nucl fa after blast and hmm> 
    <in3:tax annotation>
    <in4:sample.readsNum.list>\n" unless @ARGV == 4;
my($geneList,$nucl,$taxAnno,$readsNum)=@ARGV;

$/="\n>";
my %geneList;
open IN,$geneList;
while(my $seq=<IN>){
    chomp$seq;
    $seq=~s/^>//;
    my $id=$1 if $seq=~/^(.*)/;
    $seq=~s/^.*//;
    $seq=~s/\n//g;
    $seq=~s/\s+//g;
    $geneList{$id}=$seq;
}
close IN;

my %nucl;
open IN,$nucl;
while(my $seq=<IN>){
    chomp$seq;
    $seq=~s/^>//;
    my $id=$1 if $seq=~/^(.*)/;
    $seq=~s/^.*//;
    $seq=~s/\n//g;
    $seq=~s/\s+//g;
    $nucl{$id}=$seq;
}
close IN;

$/="\n";
my %checkTime;
my %checkIDsLast;
open IN,$taxAnno;
while(<IN>){
    chomp;
    my@or=split/\t/;
    next unless $geneList{$or[0]} && $or[5]=~/sk__Bacteria/ && $or[4] eq "s";
    my @tax=split/;/,$or[5];
    $tax[-1]=~s/^s__//;
    next if $tax[-1] eq 'uncultured bacterium';
    $checkIDsLast{$or[0]}=1;
    $checkTime{$tax[-1]}++;
}
close IN;

my %abun;
my @sampleIDs;
open FILE,$readsNum;
while(my $file=<FILE>){
    open IN,$file;
    my $sampleID=$1 if $file=~/.*\/(.*)\//;
    while(<IN>){
        chomp;
        my($id,$num,$rpk,$tpm)=(split/\s+/)[0,1,2,3];
        next unless $checkIDsLast{$id};
        $abun{$id}{$sampleID}{'num'}=$num;
        $abun{$id}{$sampleID}{'rpk'}=$rpk;
        $abun{$id}{$sampleID}{'tpm'}=$tpm;
    }
    close IN;
    push @sampleIDs,$sampleID;
}
close FILE;

my %idNum;
open IN,$taxAnno;
open O1,">04.2.BGUSs.last.tax.txt";
open O2,">04.2.BGUSs.last.seq.fa";
open O3,">04.2.BGUSs.last.nucl.fa";
open O4,">05.BGUS.abun.rel.txt";
open O5,">05.BGUS.abun.abs.txt";
open O6,">05.BGUS.abun.TPM.txt";
print O4 "GusID\t".join("\t",@sampleIDs)."\n";
print O5 "GusID\t".join("\t",@sampleIDs)."\n";
print O6 "GusID\t".join("\t",@sampleIDs)."\n";
while(<IN>){
    chomp;
    my@or=split/\t/;
    next unless $geneList{$or[0]} && $or[5]=~/sk__Bacteria/ && $or[4] eq "s";
    my @tax=split/;/,$or[5];
    $tax[-1]=~s/^s__//;
    next if $tax[-1] eq 'uncultured bacterium';
    my @kk=split/\s+/,$tax[-1];
    $kk[0]=~s/^\[//;
    $kk[0]=substr($kk[0],0,3);
    my$kk=join("_",@kk);
    $idNum{$tax[-1]}++;
    my $len=length($geneList{$or[0]});
    if($checkTime{$tax[-1]} == 1){
        print O1 "$kk.GUS\t$len\t$_\n";
        print O2 ">$kk.GUS\n$geneList{$or[0]}\n";
        print O3 ">$kk.GUS\n$nucl{$or[0]}\n";
        print O4 "$kk.GUS";
        print O5 "$kk.GUS";
        print O6 "$kk.GUS";
    }else{
        print O1 "$kk.GUS$idNum{$tax[-1]}\t$len\t$_\n";
        print O2 ">$kk.GUS$idNum{$tax[-1]}\n$geneList{$or[0]}\n";
        print O3 ">$kk.GUS$idNum{$tax[-1]}\n$nucl{$or[0]}\n";
        print O4 "$kk.GUS$idNum{$tax[-1]}";
        print O5 "$kk.GUS$idNum{$tax[-1]}";
        print O6 "$kk.GUS$idNum{$tax[-1]}";
    }
    foreach my $s (@sampleIDs){
        if($abun{$or[0]}{$s}{'num'}){
            print O4 "\t".$abun{$or[0]}{$s}{'tpm'}/1000000;
            print O5 "\t$abun{$or[0]}{$s}{'num'}";
            print O6 "\t$abun{$or[0]}{$s}{'tpm'}";
        }else{
            print O4 "\t0";
            print O5 "\t0";
            print O6 "\t0";
        }
    }
    print O4 "\n";
    print O5 "\n";
    print O6 "\n";
}
close IN;
close O1;
close O2;
close O3;
close O4;
close O5;
close O6;
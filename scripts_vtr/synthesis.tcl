#set main project location
set Orig_Proj /home/flo/FLORENT/GIT/ALGOSUP_POC
#set your file input
set source_verilog $Orig_Proj/Examples/2ffs_no_rst_VTR/flipflop.v
#set architexture file 
set arch_file  $Orig_Proj/src/simple-7series.xml

yosys -import
plugin -i parmys

yosys -import

read_verilog -nomem2reg +/parmys/vtr_primitives.v
setattr -mod -set keep_hierarchy 1 single_port_ram
setattr -mod -set keep_hierarchy 1 dual_port_ram

puts "Using parmys as partial mapper"
parmys_arch -a $arch_file

puts "Using Yosys read_verilog command"
read_verilog -sv -nolatches $source_verilog

# Check that there are no combinational loops
scc -select
select -assert-none %
select -clear

hierarchy -check -auto-top -purge_lib
procs
opt_expr
opt_clean
check
opt -nodffe -nosdff
procs -norom
fsm
opt
wreduce
peepopt
opt_clean
share
opt -full
memory -nomap
flatten
opt -full
techmap -map +/parmys/adff2dff.v
techmap -map +/parmys/adffe2dff.v
techmap -map +/parmys/aldff2dff.v
techmap -map +/parmys/aldffe2dff.v
opt -full


parmys -a $arch_file -nopass 
# original option -c /home/flo/FLORENT/GIT/vtr-verilog-to-routing/temp/odin_config.xml YYY
opt -full
techmap 
opt -fast
dffunmap
opt -fast -noff

#autoname
stat
hierarchy -check -auto-top -purge_lib
write_blif -true + vcc -false + gnd -undef + unconn -blackbox flipflop.parmys.blif


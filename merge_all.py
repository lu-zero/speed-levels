from pyexcel.cookbook import merge_all_to_a_book
import glob
import sys
import os

source = sys.argv[1]
cpu = sys.argv[2]
limit = sys.argv[3]
filename = os.path.splitext(os.path.basename(source))[0]

merge_all_to_a_book(glob.glob(f"{cpu}-*-speed-levels-{filename}.csv"), f"{cpu}-{filename}-l{limit}.ods")

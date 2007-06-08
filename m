From: Nicholas Mc Guire <der.herr@hofr.at>
Subject: lguest/host benchmarks.
Date: Fri, 8 Jun 2007 09:27:56 +0200 (CEST)
Message-ID: <Pine.LNX.4.60.0706080908100.811@rtl14.hofr.at>
References: <Pine.LNX.4.60.0706011704240.786@rtl14.hofr.at>
	<1180780059.9228.72.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1180780059.9228.72.camel@localhost.localdomain>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org


HI !

  here are some preliminary benchmarks of lguest vs host (2.6.21)

  Most results seem resonable - the file create/delete is a bit
  strange - does anybody have an idea why 0k file create/delete could
  be so much faster under lguest and 10k file so much slower ?
  The only really serious problem with lguest performance seems to be
  mmap latency, page-faults and protection faults.

  the only problem that lmbench had was to calculate the cpu speed under
  lguest (had to pass that on the commandline).

  the sometimes better results of lguest compared to the host can also be
  due to the better locality as lguest was only using 32MB total (host
  idle).

hofrat

Host:
HW: AMD Duron 1.6GHz 256MB RAM HZ=250
distribution; Slackware 11.0 (ext3 80GB)

Lguest:
lguest-2.6.21-254.patch HZ=250
cmdline: Documentation/lguest/lguest 32m vmlinux --block=../slackfs root=/dev/lgba ro
distribution: Slackeare 11.0 minimum instalation (ext3 1GB)

(lguest was not using the network)

                  L M B E N C H  3 . 0   S U M M A R Y
                  ------------------------------------
 		 (Alpha software, do not distribute)

Basic system parameters
------------------------------------------------------------------------------
Host                 OS Description              Mhz  tlb  cache  mem   scal
                                                      pages line   par   load
                                                            bytes 
--------- ------------- ----------------------- ---- ----- ----- ------ ----
darkstar  Lguest 2.6.21       i686-pc-linux-gnu 1602    32    64 2.9500    1
darkstar  Lguest 2.6.21       i686-pc-linux-gnu 1602    32    64 2.7500    1
darkstar   Linux 2.6.21       i686-pc-linux-gnu 1602    32    64 2.4900    1
darkstar   Linux 2.6.21       i686-pc-linux-gnu 1602    32    64 2.5600    1

Processor, Processes - times in microseconds - smaller is better
------------------------------------------------------------------------------
Host                 OS  Mhz null null      open slct sig  sig  fork exec sh
                              call  I/O stat clos TCP  inst hndl proc proc proc
--------- ------------- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ----
darkstar  Lguest 2.6.21 1602 0.21 0.36 2.57 3.84      0.68 1.64 1137 2653 7960
darkstar  Lguest 2.6.21 1602 0.21 0.37 2.38 4.02      0.65 1.75 1137 2653 7960
darkstar   Linux 2.6.21 1602 0.18 0.37 3.54 5.20 28.9 0.62 1.59 213. 1042 8725
darkstar   Linux 2.6.21 1602 0.18 0.37 4.01 5.88 17.7 0.62 1.50 204. 1077 8840

Basic integer operations - times in nanoseconds - smaller is better
-------------------------------------------------------------------
Host                 OS  intgr intgr  intgr  intgr  intgr
                           bit   add    mul    div    mod 
--------- ------------- ------ ------ ------ ------ ------ 
darkstar  Lguest 2.6.21 1.0900 0.8700 4.3300   42.8   41.0
darkstar  Lguest 2.6.21 0.9800 1.0300 4.5600   42.8   51.1
darkstar   Linux 2.6.21 0.6200 0.6200 2.4800   25.5   26.7
darkstar   Linux 2.6.21 0.6200 0.6200 2.4800   25.4   26.7

Basic float operations - times in nanoseconds - smaller is better
-----------------------------------------------------------------
Host                 OS  float  float  float  float
                          add    mul    div    bogo
--------- ------------- ------ ------ ------ ------ 
darkstar  Lguest 2.6.21 3.8500 4.1100   23.5 7.4000
darkstar  Lguest 2.6.21 5.2900 4.4800   18.9 7.3400
darkstar   Linux 2.6.21 2.4800 2.4800   10.9 6.2200
darkstar   Linux 2.6.21 2.4800 2.4800   10.8 6.2200

Basic double operations - times in nanoseconds - smaller is better
------------------------------------------------------------------
Host                 OS  double double double double
                          add    mul    div    bogo
--------- ------------- ------  ------ ------ ------ 
darkstar  Lguest 2.6.21 3.7300 4.1100   20.4 6.5700
darkstar  Lguest 2.6.21 3.7300 4.1000   23.5 6.5700
darkstar   Linux 2.6.21 2.4800 2.4800   10.9 5.5600
darkstar   Linux 2.6.21 2.4800 2.4800   10.8 5.6100

Context switching - times in microseconds - smaller is better
-------------------------------------------------------------------------
Host                 OS  2p/0K 2p/16K 2p/64K 8p/16K 8p/64K 16p/16K 16p/64K
                          ctxsw  ctxsw  ctxsw ctxsw  ctxsw   ctxsw   ctxsw
--------- ------------- ------ ------ ------ ------ ------ ------- -------
darkstar  Lguest 2.6.21 6.0900 6.9500  136.3  137.1  282.3   160.7   232.0
darkstar  Lguest 2.6.21 6.6200 6.9200  130.6  137.1  282.2   160.7   231.9
darkstar   Linux 2.6.21 1.1400 1.9600   77.4   26.1   90.3    36.9   123.8
darkstar   Linux 2.6.21 1.3700 2.1100   78.9   26.8   90.8    37.2   124.9

*Local* Communication latencies in microseconds - smaller is better
---------------------------------------------------------------------
Host                 OS 2p/0K  Pipe AF     UDP  RPC/   TCP  RPC/ TCP
                         ctxsw       UNIX         UDP         TCP conn
--------- ------------- ----- ----- ---- ----- ----- ----- ----- ----
darkstar  Lguest 2.6.21 6.090  18.3 19.4 
darkstar  Lguest 2.6.21 6.620  18.5 27.6 
darkstar   Linux 2.6.21 1.140 8.805 10.7              18.9        64.
darkstar   Linux 2.6.21 1.370 9.547 10.8              18.1        62.

File & VM system latencies in microseconds - smaller is better
-------------------------------------------------------------------------------
Host                 OS   0K File      10K File     Mmap    Prot   Page   100fd
                         Create Delete Create Delete Latency Fault  Fault  selct
--------- ------------- ------ ------ ------ ------ ------- ----- ------- -----
darkstar  Lguest 2.6.21   24.0 4.0000  220.0 1499.3   629.0 4.207 7.75490 4.205
darkstar  Lguest 2.6.21   20.0 8.0000  348.1 2415.5   612.0 3.254 7.75490 4.224
darkstar   Linux 2.6.21   47.2   14.8  121.3   28.4    97.0 0.426 1.30680 3.857
darkstar   Linux 2.6.21   45.8   14.0  115.4   27.3    97.0 0.617 1.37670 3.822

*Local* Communication bandwidths in MB/s - bigger is better
-----------------------------------------------------------------------------
Host                OS  Pipe AF    TCP  File   Mmap  Bcopy  Bcopy  Mem   Mem
                              UNIX      reread reread (libc) (hand) read write
--------- ------------- ---- ---- ---- ------ ------ ------ ------ ---- -----
darkstar  Lguest 2.6.21 139. 146.       420.2  701.4  262.8  262.8 701. 525.6
darkstar  Lguest 2.6.21 135. 140.       420.3  701.4  262.8  262.8 525. 525.6
darkstar   Linux 2.6.21 156. 979. 134.  406.3  636.6  275.3  276.3 609. 457.3
darkstar   Linux 2.6.21 156. 829. 136.  409.3  638.0  293.1  292.2 610. 496.7

Memory latencies in nanoseconds - smaller is better
     (WARNING - may not be correct, check graphs)
------------------------------------------------------------------
Host                 OS   Mhz   L1 $   L2 $    Main mem    Guesses
--------- -------------   ---   ----   ----    --------    -------
darkstar  Lguest 2.6.21  1602 2.1380   14.7       182.3
darkstar  Lguest 2.6.21  1602 2.1380   14.7       182.3
darkstar   Linux 2.6.21  1602 1.8650   12.6       155.2
darkstar   Linux 2.6.21  1602 1.8620   12.5       154.8

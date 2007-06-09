From: Nicholas Mc Guire <der.herr@hofr.at>
Subject: Re: lguest/host benchmarks.
Date: Sat, 9 Jun 2007 06:44:34 +0200 (CEST)
Message-ID: <Pine.LNX.4.60.0706090628570.395@rtl14.hofr.at>
References: <Pine.LNX.4.60.0706011704240.786@rtl14.hofr.at>
	<1180780059.9228.72.camel@localhost.localdomain>
	<Pine.LNX.4.60.0706080908100.811@rtl14.hofr.at>
	<1181362602.6025.72.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1181362602.6025.72.camel@localhost.localdomain>
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
Cc: Jens Axboe <jens.axboe@oracle.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

>
> Hi Nicholas,
>
> 	Thanks for this!
>
>>   here are some preliminary benchmarks of lguest vs host (2.6.21)
>>
>>   Most results seem resonable - the file create/delete is a bit
>>   strange - does anybody have an idea why 0k file create/delete could
>>   be so much faster under lguest and 10k file so much slower ?
>
> Is this ext3?   The lguest blockio drvier is very naive and is actually
> synchronous (SLOW!), but also ignores barriers.
>

found a part of the problem - the guest goes streight into the ground if 
it runs low on memory. This series is the same filesystem just with 
m32/m64/m128 on the commandline of lguest.

<snip>
File & VM system latencies in microseconds - smaller is better
-------------------------------------------------------------------------------
Host                 OS   0K File      10K File     Mmap    Prot   Page   100fd
                         Create Delete Create Delete Latency Fault  Fault  selct
--------- ------------- ------ ------ ------ ------ ------- ----- ------- -----
darkstar  Lguest32 2.6.   24.0 4.0000  220.0 1499.3   629.0 4.207 7.75490 4.205
darkstar  Lguest32 2.6.   20.0 8.0000  348.1 2415.5   612.0 3.254 7.75490 4.224
darkstar  Lguest64 2.6.   24.0 4.0000  552.2   20.0   629.0 3.882 7.75290 4.430
darkstar  Lguest64 2.6.   24.0 4.0000  108.0  952.4   629.0 4.049 7.75440 4.400
darkstar  Lguest128 2.6   24.0 4.0000   84.0   12.0   629.0 3.481 7.75440 4.225
darkstar  Lguest128 2.6   24.0 4.0000   84.0   12.0   629.0 4.309 7.75490 4.203
darkstar   Linux 2.6.21   47.2   14.8  121.3   28.4    97.0 0.426 1.30680 3.857
darkstar   Linux 2.6.21   45.8   14.0  115.4   27.3    97.0 0.617 1.37670 3.822
<snip>

so the file issue is most likely a memory exhaustion effect on the guest 
(memory variation has close to no effect on fork/sh times though). A 
indication of locality realted peformance influence can be seen in the
low level int/fp opperations:

<snip>
Basic integer operations - times in nanoseconds - smaller is better
-------------------------------------------------------------------
Host                 OS  intgr intgr  intgr  intgr  intgr
                           bit   add    mul    div    mod
--------- ------------- ------ ------ ------ ------ ------
darkstar  Lguest32 2.6. 1.0900 0.8700 4.3300   42.8   41.0
darkstar  Lguest32 2.6. 0.9800 1.0300 4.5600   42.8   51.1
darkstar  Lguest64 2.6. 1.0300 0.9500 4.1600   42.7   39.3
darkstar  Lguest64 2.6. 1.0900 0.8700 4.4000   53.9   62.9
darkstar  Lguest128 2.6 1.0900 0.8700 3.4700   57.0   62.9
darkstar  Lguest128 2.6 1.0900 1.9600 4.4000   53.8   63.0
darkstar   Linux 2.6.21 0.6200 0.6200 2.4800   25.5   26.7
darkstar   Linux 2.6.21 0.6200 0.6200 2.4800   25.4   26.7

we still are checking things related to the absolute values reported - not 
yet convinced that timing is that correct on the guest.

> BTW, I suspect your sh is different inside the guest than host:
>
>> darkstar  Lguest 2.6.21 1602 0.21 0.37 2.38 4.02      0.65 1.75 1137 2653 7960
>> darkstar   Linux 2.6.21 1602 0.18 0.37 3.54 5.20 28.9 0.62 1.59 213. 1042 8725
>

nop - same shell - Slacware 11.0 (bash-3.0 something) in both cases, my 
guess is that locality is helping here a bit.

>>   The only really serious problem with lguest performance seems to be
>>   mmap latency, page-faults and protection faults.
>
> Yes.  A real page fault hurts quite a bit, because all page faults go
> via the host (which can swap out guest pages or have them COW).
> Sequence goes:
>
> - Guest userspace hits page
> - Trap to switcher
> - Switch to host kernel
> - Walk guest pagetables to see if it's mapped, it's not, so deliver.
> - Switch to guest kernel
> - Process fault, insert page table entry
> - Trap to switcher
> - Switch to host kernel
> - Insert page table entry in shadow pagetables
> - Switch to guest kernel
> - Handle fault
>
> This can be optimized by enhancing the switcher itself to walk the guest
> page tables and reflect is straight back into the guest if it's not
> mapped there.  This shouldn't actually be too hard, but I wonder if it's
> worth the complexity...
>
Even if it were it should not go into lguest - the really nice thing about 
it is that one can actually understand it !
Most of this will not really hurt performance of applicaitons that much, 
so I doubt it is worth the trouble.

thx!
hofrat

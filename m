From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [PATCH RFC V4 0/5] kvm : Paravirt-spinlock support for KVM guests
Date: Mon, 16 Jan 2012 17:40:58 +1100
Message-ID: <03D10A71-19F8-4278-B7A4-3F618ED6ECF0@goop.org>
References: <20120114182501.8604.68416.sendpatchset@oc5400248562.ibm.com>
	<3EC1B881-0724-49E3-B892-F40BEB07D15D@suse.de>
Mime-Version: 1.0 (Apple Message framework v1251.1)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <3EC1B881-0724-49E3-B892-F40BEB07D15D@suse.de>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Alexander Graf <agraf@suse.de>
Cc: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, linux-doc@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Jan Kiszka <jan.kiszka@siemens.com>, Virtualization <virtualization@lists.linux-foundation.org>, Paul Mackerras <paulus@samba.org>, "H. Peter Anvin" <hpa@zytor.com>, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, Xen <xen-devel@lists.xensource.com>, Dave Jiang <dave.jiang@intel.com>, KVM <kvm@vger.kernel.org>, Glauber Costa <glommer@redhat.com>, X86 <x86@kernel.org>, Ingo Molnar <mingo@redhat.com>, Avi Kivity <avi@redhat.com>, Rik van Riel <riel@redhat.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Greg Kroah-Hartman <gregkh@suse.de>, Sasha Levin <levinsasha928@gmail.com>, Sedat Dilek <sedat.dilek@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>, Dave Hansen <dave@linux.vnet.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

On Jan 16, 2012, at 2:57 PM, Alexander Graf wrote:

> 
> On 14.01.2012, at 19:25, Raghavendra K T wrote:
> 
>> The 5-patch series to follow this email extends KVM-hypervisor and Linux guest 
>> running on KVM-hypervisor to support pv-ticket spinlocks, based on Xen's implementation.
>> 
>> One hypercall is introduced in KVM hypervisor,that allows a vcpu to kick
>> another vcpu out of halt state.
>> The blocking of vcpu is done using halt() in (lock_spinning) slowpath.
> 
> Is the code for this even upstream? Prerequisite series seem to have been posted by Jeremy, but they didn't appear to have made it in yet.

No, not yet.  The patches are unchanged since I last posted them, and as far as I know there are no objections to them, but I'd like to get some performance numbers just to make sure they don't cause any surprising regressions, especially in the non-virtual case.

> 
> Either way, thinking about this I stumbled over the following passage of his patch:
> 
>> +               unsigned count = SPIN_THRESHOLD;
>> +
>> +               do {
>> +                       if (inc.head == inc.tail)
>> +                               goto out;
>> +                       cpu_relax();
>> +                       inc.head = ACCESS_ONCE(lock->tickets.head);
>> +               } while (--count);
>> +               __ticket_lock_spinning(lock, inc.tail);
> 
> 
> That means we're spinning for n cycles, then notify the spinlock holder that we'd like to get kicked and go sleeping. While I'm pretty sure that it improves the situation, it doesn't solve all of the issues we have.
> 
> Imagine we have an idle host. All vcpus can freely run and everyone can fetch the lock as fast as on real machines. We don't need to / want to go to sleep here. Locks that take too long are bugs that need to be solved on real hw just as well, so all we do is possibly incur overhead.

I'm not quite sure what your concern is.  The lock is under contention, so there's nothing to do except spin; all this patch adds is a variable decrement/test to the spin loop, but that's not going to waste any more CPU than the non-counting case.  And once it falls into the blocking path, its a win because the VCPU isn't burning CPU any more.

> 
> Imagine we have a contended host. Every vcpu gets at most 10% of a real CPU's runtime. So chances are 1:10 that you're currently running while you need to be. In such a setup, it's probably a good idea to be very pessimistic. Try to fetch the lock for 100 cycles and then immediately make room for all the other VMs that have real work going on!

Are you saying the threshold should be dynamic depending on how loaded the system is?  How can a guest know what the overall system contention is?  How should a guest use that to work out a good spin time?

One possibility is to use the ticket lock queue depth to work out how contended the lock is, and therefore how long it might be worth waiting for.  I was thinking of something along the lines of "threshold = (THRESHOLD >> queue_depth)".  But that's pure hand wave, and someone would actually need to experiment before coming up with something reasonable.

But all of this is good to consider for future work, rather than being essential for the first version.

> So what I'm trying to get to is that if we had a hypervisor settable spin threshold, we could adjust it according to the host's load, getting VMs to behave differently on different (guest invisible) circumstances.
> 
> Speaking of which - don't we have spin lock counters in the CPUs now? I thought we could set intercepts that notify us when the guest issues too many repz nops or whatever the typical spinlock identifier was. Can't we reuse that and just interrupt the guest if we see this with a special KVM interrupt that kicks off the internal spin lock waiting code? That way we don't slow down all those bare metal boxes.

Yes, that mechanism exists, but it doesn't solve a very interesting problem.

The most important thing to solve is making sure that when *releasing* a ticketlock, the correct next VCPU gets scheduled promptly.  If you don't, you're just relying on the VCPU scheduler getting around to scheduling the correct VCPU, but if it doesn't it just ends up burning a timeslice of PCPU time while the wrong VCPU spins.

Limiting the spin time with a timeout or the rep/nop interrupt somewhat mitigates this, but it still means you end up spending a lot of time slices spinning the wrong VCPU until it finally schedules the correct one.  And the more contended the machine is, the worse the problem gets.

> Speaking of which - have you benchmarked performance degradation of pv ticket locks on bare metal? Last time I checked, enabling all the PV ops did incur significant slowdown which is why I went though the work to split the individual pv ops features up to only enable a few for KVM guests.

The whole point of the pv-ticketlock work is to keep the pvops hooks out of the locking fast path, so that the calls are only made on the slow path - that is, when spinning too long on a contended lock, and when releasing a lock that's in a "slow" state.  In the fast path case of no contention, there are no pvops, and the executed code path is almost identical to native.

But as I mentioned above, I'd like to see some benchmarks to prove that's the case.

	J

> 
>> 
>> Changes in V4:
>> - reabsed to 3.2.0 pre.
>> - use APIC ID for kicking the vcpu and use kvm_apic_match_dest for matching. (Avi)
>> - fold vcpu->kicked flag into vcpu->requests (KVM_REQ_PVLOCK_KICK) and related 
>> changes for UNHALT path to make pv ticket spinlock migration friendly. (Avi, Marcello)
>> - Added Documentation for CPUID, Hypercall (KVM_HC_KICK_CPU)
>> and capabilty (KVM_CAP_PVLOCK_KICK) (Avi)
>> - Remove unneeded kvm_arch_vcpu_ioctl_set_mpstate call. (Marcello)
>> - cumulative variable type changed (int ==> u32) in add_stat (Konrad)
>> - remove unneeded kvm_guest_init for !CONFIG_KVM_GUEST case
>> 
>> Changes in V3:
>> - rebased to 3.2-rc1
>> - use halt() instead of wait for kick hypercall.
>> - modify kick hyper call to do wakeup halted vcpu.
>> - hook kvm_spinlock_init to smp_prepare_cpus call (moved the call out of head##.c).
>> - fix the potential race when zero_stat is read.
>> - export debugfs_create_32 and add documentation to API.
>> - use static inline and enum instead of ADDSTAT macro. 
>> - add  barrier() in after setting kick_vcpu.
>> - empty static inline function for kvm_spinlock_init.
>> - combine the patches one and two readuce overhead.
>> - make KVM_DEBUGFS depends on DEBUGFS.
>> - include debugfs header unconditionally.
>> 
>> Changes in V2:
>> - rebased patchesto -rc9
>> - synchronization related changes based on Jeremy's changes 
>> (Jeremy Fitzhardinge <jeremy.fitzhardinge@citrix.com>) pointed by 
>> Stephan Diestelhorst <stephan.diestelhorst@amd.com>
>> - enabling 32 bit guests
>> - splitted patches into two more chunks
>> 
>> Srivatsa Vaddagiri, Suzuki Poulose, Raghavendra K T (5): 
>> Add debugfs support to print u32-arrays in debugfs
>> Add a hypercall to KVM hypervisor to support pv-ticketlocks
>> Added configuration support to enable debug information for KVM Guests
>> pv-ticketlocks support for linux guests running on KVM hypervisor
>> Add documentation on Hypercalls and features used for PV spinlock
>> 
>> Test Set up :
>> The BASE patch is pre 3.2.0 + Jeremy's following patches.
>> xadd (https://lkml.org/lkml/2011/10/4/328)
>> x86/ticketlocklock  (https://lkml.org/lkml/2011/10/12/496).
>> Kernel for host/guest : 3.2.0 + Jeremy's xadd, pv spinlock patches as BASE
>> (Note:locked add change is not taken yet)
>> 
>> Results:
>> The performance gain is mainly because of reduced busy-wait time.
>> From the results we can see that patched kernel performance is similar to
>> BASE when there is no lock contention. But once we start seeing more
>> contention, patched kernel outperforms BASE (non PLE).
>> On PLE machine we do not see greater performance improvement because of PLE
>> complimenting halt()
>> 
>> 3 guests with 8VCPU, 4GB RAM, 1 used for kernbench
>> (kernbench -f -H -M -o 20) other for cpuhog (shell script while
>> true with an instruction)
>> 
>> scenario A: unpinned
>> 
>> 1x: no hogs
>> 2x: 8hogs in one guest
>> 3x: 8hogs each in two guest
>> 
>> scenario B: unpinned, run kernbench on all the guests no hogs.
>> 
>> Dbench on PLE machine:
>> dbench run on all the guest simultaneously with
>> dbench --warmup=30 -t 120 with NRCLIENTS=(8/16/32).
>> 
>> Result for Non PLE machine :
>> ============================
>> Machine : IBM xSeries with Intel(R) Xeon(R) x5570 2.93GHz CPU with 8 core , 64GB RAM
>> 		 BASE                    BASE+patch            %improvement
>> 		 mean (sd)               mean (sd)
>> Scenario A:
>> case 1x:	 164.233 (16.5506) 	 163.584 (15.4598 	0.39517
>> case 2x:	 897.654 (543.993) 	 328.63 (103.771) 	63.3901
>> case 3x:	 2855.73 (2201.41) 	 315.029 (111.854) 	88.9685
>> 
>> Dbench:
>> Throughput is in MB/sec
>> NRCLIENTS	 BASE                    BASE+patch            %improvement
>>              	 mean (sd)               mean (sd)
>> 8       	1.774307  (0.061361) 	1.725667  (0.034644) 	-2.74135
>> 16      	1.445967  (0.044805) 	1.463173  (0.094399) 	1.18993
>> 32        	2.136667  (0.105717) 	2.193792  (0.129357) 	2.67356
>> 
>> Result for PLE machine:
>> ======================
>> Machine : IBM xSeries with Intel(R) Xeon(R)  X7560 2.27GHz CPU with 32/64 core, with 8
>>        online cores and 4*64GB RAM
>> 
>> Kernbench:
>> 		 BASE                    BASE+patch            %improvement
>> 		 mean (sd)               mean (sd)
>> Scenario A:	 			
>> case 1x:	 161.263 (56.518) 	 159.635 (40.5621) 	1.00953
>> case 2x:	 190.748 (61.2745) 	 190.606 (54.4766) 	0.0744438
>> case 3x:	 227.378 (100.215) 	 225.442 (92.0809) 	0.851446
>> 
>> Scenario B:
>> 		 446.104 (58.54 )	 433.12733 (54.476)	2.91
>> 
>> Dbench:
>> Throughput is in MB/sec
>> NRCLIENTS	 BASE                    BASE+patch            %improvement
>>              	 mean (sd)               mean (sd)
>> 8       	1.101190  (0.875082) 	1.700395  (0.846809) 	54.4143
>> 16      	1.524312  (0.120354) 	1.477553  (0.058166) 	-3.06755
>> 32        	2.143028  (0.157103) 	2.090307  (0.136778) 	-2.46012
> 
> So on a very contended system we're actually slower? Is this expected?
> 
> 
> Alex
> 

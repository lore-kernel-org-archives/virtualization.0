From: Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH v1 4/4] KVM/vmx: enable lbr for the guest
Date: Tue, 26 Sep 2017 09:41:14 -0700
Message-ID: <20170926164114.GQ4311__19018.9387453303$1506444101$gmane$org@tassilo.jf.intel.com>
References: <1506314696-4632-1-git-send-email-wei.w.wang@intel.com>
	<1506314696-4632-5-git-send-email-wei.w.wang@intel.com>
	<20170925145720.GM4311@tassilo.jf.intel.com>
	<59CA164B.1080707@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <59CA164B.1080707@intel.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Wei Wang <wei.w.wang@intel.com>
Cc: kvm@vger.kernel.org, mst@redhat.com, rkrcmar@redhat.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, mingo@redhat.com, pbonzini@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

> 1) vCPU context switching and guest side task switching are not identical.
> That is, when the vCPU is scheduled out, the guest task on the vCPU may not

guest task lifetime has nothing to do with this. It's completely independent
of what you do here on the VCPU level.

> run out its time slice yet, so the task will continue to run when the vCPU
> is
> scheduled in by the host (lbr wasn't save by the guest task when the vCPU is
> scheduled out in this case).
> 
> It is possible to have the vCPU which runs the guest task (in use of lbr)
> scheduled
> out, followed by a new host task being scheduled in on the pCPU to run.
> It is not guaranteed that the new host task does not use the LBR feature on
> the
> pCPU.

Sure it may use the LBR, and the normal perf context switch
will switch it and everything works fine.

It's like any other per-task LBR user.

> 
> 2) Sometimes, people may want this usage: "perf record -b
> ./qemu-system-x86_64 ...",
> which will need lbr to be used in KVM as well.

In this obscure case you can disable LBR support for the guest.
The common case is far more important.

It sounds like you didn't do any performance measurements.
I expect the performance of your current solution to be terrible.

e.g. a normal perf PMI does at least 1 MSR reads and 4+ MSR writes
for a single counter. With multiple counters it gets worse.

For each of those you'll need to exit. Adding something
to the entry/exit list is similar to the cost of doing 
explicit RD/WRMSRs.

On Skylake we have 32*3=96 MSRs for the LBRs.

So with the 5 exits and entries, you're essentually doing
5*2*96=18432 extra MSR accesses for each PMI.

MSR access is 100+ cycles at least, for writes it is far more
expensive.

-Andi

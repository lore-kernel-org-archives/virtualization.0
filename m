From: Will Deacon <will@kernel.org>
Subject: Re: [PATCH v2 0/6] KVM: arm64: VCPU preempted check support
Date: Mon, 13 Jan 2020 12:12:41 +0000
Message-ID: <20200113121240.GC3260@willie-the-truck>
References: <20191226135833.1052-1-yezengruan@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20191226135833.1052-1-yezengruan@huawei.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: Zengruan Ye <yezengruan@huawei.com>
Cc: mark.rutland@arm.com, daniel.lezcano@linaro.org, kvm@vger.kernel.org, linux-doc@vger.kernel.org, peterz@infradead.org, maz@kernel.org, suzuki.poulose@arm.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, james.morse@arm.com, julien.thierry.kdev@gmail.com, catalin.marinas@arm.com, linux@armlinux.org.uk, steven.price@arm.com, kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org
List-Id: virtualization@lists.linuxfoundation.org

[+PeterZ]

On Thu, Dec 26, 2019 at 09:58:27PM +0800, Zengruan Ye wrote:
> This patch set aims to support the vcpu_is_preempted() functionality
> under KVM/arm64, which allowing the guest to obtain the VCPU is
> currently running or not. This will enhance lock performance on
> overcommitted hosts (more runnable VCPUs than physical CPUs in the
> system) as doing busy waits for preempted VCPUs will hurt system
> performance far worse than early yielding.
> 
> We have observed some performace improvements in uninx benchmark tests.
> 
> unix benchmark result:
>   host:  kernel 5.5.0-rc1, HiSilicon Kunpeng920, 8 CPUs
>   guest: kernel 5.5.0-rc1, 16 VCPUs
> 
>                test-case                |    after-patch    |   before-patch
> ----------------------------------------+-------------------+------------------
>  Dhrystone 2 using register variables   | 334600751.0 lps   | 335319028.3 lps
>  Double-Precision Whetstone             |     32856.1 MWIPS |     32849.6 MWIPS
>  Execl Throughput                       |      3662.1 lps   |      2718.0 lps
>  File Copy 1024 bufsize 2000 maxblocks  |    432906.4 KBps  |    158011.8 KBps
>  File Copy 256 bufsize 500 maxblocks    |    116023.0 KBps  |     37664.0 KBps
>  File Copy 4096 bufsize 8000 maxblocks  |   1432769.8 KBps  |    441108.8 KBps
>  Pipe Throughput                        |   6405029.6 lps   |   6021457.6 lps
>  Pipe-based Context Switching           |    185872.7 lps   |    184255.3 lps
>  Process Creation                       |      4025.7 lps   |      3706.6 lps
>  Shell Scripts (1 concurrent)           |      6745.6 lpm   |      6436.1 lpm
>  Shell Scripts (8 concurrent)           |       998.7 lpm   |       931.1 lpm
>  System Call Overhead                   |   3913363.1 lps   |   3883287.8 lps
> ----------------------------------------+-------------------+------------------
>  System Benchmarks Index Score          |      1835.1       |      1327.6

Interesting, thanks for the numbers.

So it looks like there is a decent improvement to be had from targetted vCPU
wakeup, but I really dislike the explicit PV interface and it's already been
shown to interact badly with the WFE-based polling in smp_cond_load_*().

Rather than expose a divergent interface, I would instead like to explore an
improvement to smp_cond_load_*() and see how that performs before we commit
to something more intrusive. Marc and I looked at this very briefly in the
past, and the basic idea is to register all of the WFE sites with the
hypervisor, indicating which register contains the address being spun on
and which register contains the "bad" value. That way, you don't bother
rescheduling a vCPU if the value at the address is still bad, because you
know it will exit immediately.

Of course, the devil is in the details because when I say "address", that's
a guest virtual address, so you need to play some tricks in the hypervisor
so that you have a separate mapping for the lockword (it's enough to keep
track of the physical address).

Our hacks are here but we basically ran out of time to work on them beyond
an unoptimised and hacky prototype:

https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git/log/?h=kvm-arm64/pvcy

Marc -- how would you prefer to handle this?

Will

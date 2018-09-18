From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [patch 09/11] x86/vdso: Simplify the invalid vclock case
Date: Tue, 18 Sep 2018 14:48:00 +0200
Message-ID: <20180918124800.GL24106@hirez.programming.kicks-ass.net>
References: <20180914125006.349747096@linutronix.de>
	<20180914125118.909646643@linutronix.de>
	<CALCETrXh70oFHfT0Z-JXcnAumhAgLqSea5UiPY3WXu=v2GcKTg@mail.gmail.com>
	<CALAqxLUv9Rd_eA7u9gZNFvTNrT1Z67RpHLozdeNC0W2yZm=Heg@mail.gmail.com>
	<alpine.DEB.2.21.1809180948570.3558@nanos.tec.linutronix.de>
	<20180918083055.GJ24106@hirez.programming.kicks-ass.net>
	<alpine.DEB.2.21.1809181050020.4167@nanos.tec.linutronix.de>
	<alpine.DEB.2.21.1809181204460.4167@nanos.tec.linutronix.de>
	<alpine.DEB.2.21.1809181237140.4167@nanos.tec.linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1809181237140.4167@nanos.tec.linutronix.de>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Florian Weimer <fweimer@redhat.com>, Juergen Gross <jgross@suse.com>, Arnd Bergmann <arnd@arndb.de>, Stephen Boyd <sboyd@kernel.org>, X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Linux Virtualization <virtualization@lists.linux-foundation.org>, John Stultz <john.stultz@linaro.org>, Andy Lutomirski <luto@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, devel@linuxdriverproject.org, Matt Rickard <matt@softrans.com.au>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Sep 18, 2018 at 12:41:57PM +0200, Thomas Gleixner wrote:
> On Tue, 18 Sep 2018, Thomas Gleixner wrote:
> > On Tue, 18 Sep 2018, Thomas Gleixner wrote:
> > > On Tue, 18 Sep 2018, Peter Zijlstra wrote:
> > > > > Your memory serves you right. That's indeed observable on CPUs which
> > > > > lack TSC_ADJUST.
> > > > 
> > > > But, if the gtod code can observe this, then why doesn't the code that
> > > > checks the sync?
> > > 
> > > Because it depends where the involved CPUs are in the topology. The sync
> > > code might just run on the same package an simply not see it. Yes, w/o
> > > TSC_ADJUST the TSC sync code can just fail to see the havoc.
> > 
> > Even with TSC adjust the TSC can be slightly off by design on multi-socket
> > systems.
> 
> Here are the gory details:
> 
>    https://lore.kernel.org/lkml/3c1737210708230408i7a8049a9m5db49e6c4d89ab62@mail.gmail.com/
> 
> The changelog has an explanation as well.
> 
>     d8bb6f4c1670 ("x86: tsc prevent time going backwards")
> 
> I still have one of the machines which is affected by this.

Are we sure this isn't a load vs rdtsc reorder? Because if I look at the
current code:

notrace static u64 vread_tsc(void)
{
	u64 ret = (u64)rdtsc_ordered();
	u64 last = gtod->cycle_last;

	if (likely(ret >= last))
		return ret;

	/*
	 * GCC likes to generate cmov here, but this branch is extremely
	 * predictable (it's just a function of time and the likely is
	 * very likely) and there's a data dependence, so force GCC
	 * to generate a branch instead.  I don't barrier() because
	 * we don't actually need a barrier, and if this function
	 * ever gets inlined it will generate worse code.
	 */
	asm volatile ("");
	return last;
}

That does:

	lfence
	rdtsc
	load gtod->cycle_last

Which obviously allows us to observe a cycles_last that is later than
the rdtsc itself, and thus time can trivially go backwards.

The new code:

		last = gtod->cycle_last;
		cycles = vgetcyc(gtod->vclock_mode);
		if (unlikely((s64)cycles < 0))
			return vdso_fallback_gettime(clk, ts);
		if (cycles > last)
			ns += (cycles - last) * gtod->mult;

looks like:

	load gtod->cycle_last
	lfence
	rdtsc

which avoids that possibility, the cycle_last load must have completed
before the rdtsc.

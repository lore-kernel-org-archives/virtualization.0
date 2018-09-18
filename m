From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [patch 09/11] x86/vdso: Simplify the invalid vclock case
Date: Tue, 18 Sep 2018 15:38:52 +0200
Message-ID: <20180918133852.GO24106@hirez.programming.kicks-ass.net>
References: <20180914125118.909646643@linutronix.de>
	<CALCETrXh70oFHfT0Z-JXcnAumhAgLqSea5UiPY3WXu=v2GcKTg@mail.gmail.com>
	<CALAqxLUv9Rd_eA7u9gZNFvTNrT1Z67RpHLozdeNC0W2yZm=Heg@mail.gmail.com>
	<alpine.DEB.2.21.1809180948570.3558@nanos.tec.linutronix.de>
	<20180918083055.GJ24106@hirez.programming.kicks-ass.net>
	<alpine.DEB.2.21.1809181050020.4167@nanos.tec.linutronix.de>
	<alpine.DEB.2.21.1809181204460.4167@nanos.tec.linutronix.de>
	<alpine.DEB.2.21.1809181237140.4167@nanos.tec.linutronix.de>
	<20180918124800.GL24106@hirez.programming.kicks-ass.net>
	<alpine.DEB.2.21.1809181515170.6950@nanos.tec.linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1809181515170.6950@nanos.tec.linutronix.de>
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

On Tue, Sep 18, 2018 at 03:23:08PM +0200, Thomas Gleixner wrote:
> On Tue, 18 Sep 2018, Peter Zijlstra wrote:
> > On Tue, Sep 18, 2018 at 12:41:57PM +0200, Thomas Gleixner wrote:
> > > I still have one of the machines which is affected by this.
> > 
> > Are we sure this isn't a load vs rdtsc reorder? Because if I look at the
> > current code:
> 
> The load order of last vs. rdtsc does not matter at all.
> 
> CPU0					CPU1
> 
> ....
> now0 = rdtsc_ordered();
> ...
> tk->cycle_last = now0;
> 
> gtod->seq++;
> gtod->cycle_last = tk->cycle_last;
> ...
> gtod->seq++;
> 					seq_begin(gtod->seq);
> 					now1 = rdtsc_ordered();
> 
> So if the TSC on CPU1 is slightly behind the TSC on CPU0 then now1 can be
> smaller than cycle_last. The TSC sync stuff does not catch the small delta
> for unknown raisins. I'll go and find that machine and test that again.

Yeah, somehow I forgot about rseq.. maybe I should go sleep or
something.

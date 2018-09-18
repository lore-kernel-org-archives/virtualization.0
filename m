From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [patch 09/11] x86/vdso: Simplify the invalid vclock case
Date: Tue, 18 Sep 2018 10:52:58 +0200 (CEST)
Message-ID: <alpine.DEB.2.21.1809181050020.4167__44118.9950136051$1537260682$gmane$org@nanos.tec.linutronix.de>
References: <20180914125006.349747096@linutronix.de>
	<20180914125118.909646643@linutronix.de>
	<CALCETrXh70oFHfT0Z-JXcnAumhAgLqSea5UiPY3WXu=v2GcKTg@mail.gmail.com>
	<CALAqxLUv9Rd_eA7u9gZNFvTNrT1Z67RpHLozdeNC0W2yZm=Heg@mail.gmail.com>
	<alpine.DEB.2.21.1809180948570.3558@nanos.tec.linutronix.de>
	<20180918083055.GJ24106@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20180918083055.GJ24106@hirez.programming.kicks-ass.net>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Florian Weimer <fweimer@redhat.com>, Juergen Gross <jgross@suse.com>, Arnd Bergmann <arnd@arndb.de>, Stephen Boyd <sboyd@kernel.org>, X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Linux Virtualization <virtualization@lists.linux-foundation.org>, John Stultz <john.stultz@linaro.org>, Andy Lutomirski <luto@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, devel@linuxdriverproject.org, Matt Rickard <matt@softrans.com.au>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, 18 Sep 2018, Peter Zijlstra wrote:
> On Tue, Sep 18, 2018 at 09:52:26AM +0200, Thomas Gleixner wrote:
> > On Mon, 17 Sep 2018, John Stultz wrote:
> > > On Mon, Sep 17, 2018 at 12:25 PM, Andy Lutomirski <luto@kernel.org> wrote:
> > > > Also, I'm not entirely convinced that this "last" thing is needed at
> > > > all.  John, what's the scenario under which we need it?
> > > 
> > > So my memory is probably a bit foggy, but I recall that as we
> > > accelerated gettimeofday, we found that even on systems that claimed
> > > to have synced TSCs, they were actually just slightly out of sync.
> > > Enough that right after cycles_last had been updated, a read on
> > > another cpu could come in just behind cycles_last, resulting in a
> > > negative interval causing lots of havoc.
> > > 
> > > So the sanity check is needed to avoid that case.
> > 
> > Your memory serves you right. That's indeed observable on CPUs which
> > lack TSC_ADJUST.
> 
> But, if the gtod code can observe this, then why doesn't the code that
> checks the sync?

Because it depends where the involved CPUs are in the topology. The sync
code might just run on the same package an simply not see it. Yes, w/o
TSC_ADJUST the TSC sync code can just fail to see the havoc.

Thanks,

	tglx

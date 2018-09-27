From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [patch 09/11] x86/vdso: Simplify the invalid vclock case
Date: Thu, 27 Sep 2018 16:41:12 +0200 (CEST)
Message-ID: <alpine.DEB.2.21.1809271638110.8118__6524.83699745989$1538059166$gmane$org@nanos.tec.linutronix.de>
References: <20180914125006.349747096@linutronix.de>
	<20180914125118.909646643@linutronix.de>
	<CALCETrXh70oFHfT0Z-JXcnAumhAgLqSea5UiPY3WXu=v2GcKTg@mail.gmail.com>
	<CALAqxLUv9Rd_eA7u9gZNFvTNrT1Z67RpHLozdeNC0W2yZm=Heg@mail.gmail.com>
	<alpine.DEB.2.21.1809180948570.3558@nanos.tec.linutronix.de>
	<20180918083055.GJ24106@hirez.programming.kicks-ass.net>
	<alpine.DEB.2.21.1809181050020.4167@nanos.tec.linutronix.de>
	<alpine.DEB.2.21.1809181204460.4167@nanos.tec.linutronix.de>
	<alpine.DEB.2.21.1809181237140.4167@nanos.tec.linutronix.de>
	<20180918124800.GL24106@hirez.programming.kicks-ass.net>
	<alpine.DEB.2.21.1809181515170.6950@nanos.tec.linutronix.de>
	<alpine.DEB.2.21.1809181731570.7302@nanos.tec.linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <alpine.DEB.2.21.1809181731570.7302@nanos.tec.linutronix.de>
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

On Tue, 18 Sep 2018, Thomas Gleixner wrote:
> On Tue, 18 Sep 2018, Thomas Gleixner wrote:
> > So if the TSC on CPU1 is slightly behind the TSC on CPU0 then now1 can be
> > smaller than cycle_last. The TSC sync stuff does not catch the small delta
> > for unknown raisins. I'll go and find that machine and test that again.
> 
> Of course it does not trigger anymore. We accumulated code between the
> point in timekeeping_advance() where the TSC is read and the update of the
> VDSO data.
> 
> I'll might have to get an 2.6ish kernel booted on that machine and try with
> that again. /me shudders

Actually it does happen, because the TSC is very slowly drifting apart due
to SMI wreckage trying to hide itself. It just takes a very long time.

Thanks,

	tglx

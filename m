From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [patch 00/11] x86/vdso: Cleanups, simmplifications and CLOCK_TAI
	support
Date: Thu, 4 Oct 2018 10:11:00 +0200
Message-ID: <20181004081100.GI19272__23789.6711835221$1538641168$gmane$org@hirez.programming.kicks-ass.net>
References: <20180914125006.349747096@linutronix.de>
	<CALCETrU+jP2hPLoJWTYJKTvr7-=YLwtk1=cZ_uizHYQZ1z4P-w@mail.gmail.com>
	<87sh1ne64t.fsf@vitty.brq.redhat.com>
	<20181003190617.GC21381@amt.cnet>
	<87k1mycfju.fsf@vitty.brq.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <87k1mycfju.fsf@vitty.brq.redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: Wanpeng Li <kernellwp@gmail.com>, Florian Weimer <fweimer@redhat.com>, X86 ML <x86@kernel.org>, Juergen Gross <jgross@suse.com>, Arnd Bergmann <arnd@arndb.de>, Radim Krcmar <rkrcmar@redhat.com>, Stephen Boyd <sboyd@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Linux Virtualization <virtualization@lists.linux-foundation.org>, John Stultz <john.stultz@linaro.org>, Andy Lutomirski <luto@kernel.org>, devel@linuxdriverproject.org, Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Matt Rickard <matt@softrans.com.au>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Oct 04, 2018 at 09:54:45AM +0200, Vitaly Kuznetsov wrote:
> I was hoping to hear this from you :-) If I am to suggest how we can
> move forward I'd propose:
> - Check if pure TSC can be used on SkyLake+ systems (where TSC scaling
> is supported).
> - Check if non-masterclock mode is still needed. E.g. HyperV's TSC page
> clocksource is a single page for the whole VM, not a per-cpu thing. Can
> we think that all the buggy hardware is already gone?

No, and it is not the hardware you have to worry about (mostly), it is
the frigging PoS firmware people put on it.

Ever since Nehalem TSC is stable (unless you get to >4 socket systems,
after which it still can be, but bets are off). But even relatively
recent systems fail the TSC sync test because firmware messes it up by
writing to either MSR_TSC or MSR_TSC_ADJUST.

But the thing is, if the TSC is not synced, you cannot use it for
timekeeping, full stop. So having a single page is fine, it either
contains a mult/shift that is valid, or it indicates TSC is messed up
and you fall back to something else.

There is no inbetween there.

For sched_clock we can still use the global page, because the rate will
still be the same for each cpu, it's just offset between CPUs and the
code compensates for that.

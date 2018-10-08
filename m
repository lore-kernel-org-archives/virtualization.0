From: Marcelo Tosatti <mtosatti@redhat.com>
Subject: Re: [patch 00/11] x86/vdso: Cleanups, simmplifications and CLOCK_TAI
	support
Date: Mon, 8 Oct 2018 12:26:53 -0300
Message-ID: <20181008152650.GB27822__29685.9636590399$1539012328$gmane$org@amt.cnet>
References: <87sh1ne64t.fsf@vitty.brq.redhat.com>
	<20181003190617.GC21381@amt.cnet>
	<87k1mycfju.fsf@vitty.brq.redhat.com>
	<20181004081100.GI19272@hirez.programming.kicks-ass.net>
	<B8C05946-43BB-40A4-A564-53904FAF8CC0@amacapital.net>
	<20181004193150.GQ19272@hirez.programming.kicks-ass.net>
	<499807AB-E779-40C3-AA3F-E8C77A7770EC@amacapital.net>
	<CALCETrXNKCNZzUXj=2sp1vBd_o7HHzfW6RwyY5v3-wMfbVaZnQ@mail.gmail.com>
	<20181006202731.GC7129@amt.cnet>
	<CALCETrWqze2mifOdFc0GJYHtHGKiKX2Zdi5Kz87OyUogbqD15w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <CALCETrWqze2mifOdFc0GJYHtHGKiKX2Zdi5Kz87OyUogbqD15w@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Andy Lutomirski <luto@kernel.org>
Cc: Wanpeng Li <kernellwp@gmail.com>, Florian Weimer <fweimer@redhat.com>, Juergen Gross <jgross@suse.com>, Arnd Bergmann <arnd@arndb.de>, Radim Krcmar <rkrcmar@redhat.com>, Peter Zijlstra <peterz@infradead.org>, X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Linux Virtualization <virtualization@lists.linux-foundation.org>, Stephen Boyd <sboyd@kernel.org>, John Stultz <john.stultz@linaro.org>, devel@linuxdriverproject.org, Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Matt Rickard <matt@softrans.com.au>
List-Id: virtualization@lists.linuxfoundation.org

On Sat, Oct 06, 2018 at 03:28:05PM -0700, Andy Lutomirski wrote:
> On Sat, Oct 6, 2018 at 1:29 PM Marcelo Tosatti <mtosatti@redhat.com> wrote:
> >
> > On Thu, Oct 04, 2018 at 03:15:32PM -0700, Andy Lutomirski wrote:
> > > For better or for worse, I'm trying to understand this code.  So far,
> > > I've come up with this patch:
> > >
> > > https://git.kernel.org/pub/scm/linux/kernel/git/luto/linux.git/commit/?h=x86/vdso-tglx&id=14fd71e12b1c4492a06f368f75041f263e6862bf
> > >
> > > Is it correct, or am I missing some subtlety?
> >
> > The master clock, when initialized, has a pair
> >
> > masterclockvalues=(TSC value, time-of-day data).
> >
> > When updating the guest clock, we only update relative to (TSC value)
> > that was read on masterclock initialization.
> 
> I don't see the problem.  The masterclock data is updated here:
> 
>     host_tsc_clocksource = kvm_get_time_and_clockread(
>                     &ka->master_kernel_ns,
>                     &ka->master_cycle_now);
> 
> kvm_get_time_and_clockread() gets those values from
> do_monotonic_boot(), which, barring bugs, should cause
> get_kvmclock_ns() to return exactly the same thing as
> ktime_get_boot_ns() + ka->kvmclock_offset, albeit in a rather
> roundabout manner.
> 
> So what am I missing?  Is there actually something wrong with my patch?

For the bug mentioned in the comment not to happen, you must only read
TSC and add it as offset to (TSC value, time-of-day data).

Its more than "a roundabout manner".

Read the comment again.

> 
> 
> >
> > See the following comment on x86.c:
> 
> I read that comment, and it's not obvious to me how it's related.

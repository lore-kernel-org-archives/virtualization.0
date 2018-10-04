From: Andy Lutomirski <luto@kernel.org>
Subject: Re: [patch 00/11] x86/vdso: Cleanups,
	simmplifications and CLOCK_TAI support
Date: Thu, 4 Oct 2018 10:08:11 -0700
Message-ID: <CALCETrWbWLM5Jjm7iJCE7S=BJ9OFw2QQGJ2Ao-qsuaN50z=y0A__18806.7471994602$1538672784$gmane$org@mail.gmail.com>
References: <20180914125006.349747096@linutronix.de>
	<CALCETrU+jP2hPLoJWTYJKTvr7-=YLwtk1=cZ_uizHYQZ1z4P-w@mail.gmail.com>
	<20181003190026.GB21381@amt.cnet>
	<CALCETrXwEDGNry=9KKvWyc7Eot3eEDifkJ234igDLrea2mVfuA@mail.gmail.com>
	<20181004163705.GA25129@amt.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20181004163705.GA25129@amt.cnet>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Marcelo Tosatti <mtosatti@redhat.com>
Cc: Wanpeng Li <kernellwp@gmail.com>, Florian Weimer <fweimer@redhat.com>, Juergen Gross <jgross@suse.com>, Arnd Bergmann <arnd@arndb.de>, Radim Krcmar <rkrcmar@redhat.com>, Peter Zijlstra <peterz@infradead.org>, X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Linux Virtualization <virtualization@lists.linux-foundation.org>, Stephen Boyd <sboyd@kernel.org>, John Stultz <john.stultz@linaro.org>, Andrew Lutomirski <luto@kernel.org>, devel@linuxdriverproject.org, Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Matt Rickard <matt@softrans.com.au>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Oct 4, 2018 at 9:43 AM Marcelo Tosatti <mtosatti@redhat.com> wrote:
>
> On Wed, Oct 03, 2018 at 03:32:08PM -0700, Andy Lutomirski wrote:
> > On Wed, Oct 3, 2018 at 12:01 PM Marcelo Tosatti <mtosatti@redhat.com> wrote:
> > >
> > > On Tue, Oct 02, 2018 at 10:15:49PM -0700, Andy Lutomirski wrote:
> > > > Hi Vitaly, Paolo, Radim, etc.,
> > > >
> > > > On Fri, Sep 14, 2018 at 5:52 AM Thomas Gleixner <tglx@linutronix.de> wrote:
> > > > >
> > > > > Matt attempted to add CLOCK_TAI support to the VDSO clock_gettime()
> > > > > implementation, which extended the clockid switch case and added yet
> > > > > another slightly different copy of the same code.
> > > > >
> > > > > Especially the extended switch case is problematic as the compiler tends to
> > > > > generate a jump table which then requires to use retpolines. If jump tables
> > > > > are disabled it adds yet another conditional to the existing maze.
> > > > >
> > > > > This series takes a different approach by consolidating the almost
> > > > > identical functions into one implementation for high resolution clocks and
> > > > > one for the coarse grained clock ids by storing the base data for each
> > > > > clock id in an array which is indexed by the clock id.
> > > > >
> > > >
> > > > I was trying to understand more of the implications of this patch
> > > > series, and I was again reminded that there is an entire extra copy of
> > > > the vclock reading code in arch/x86/kvm/x86.c.  And the purpose of
> > > > that code is very, very opaque.
> > > >
> > > > Can one of you explain what the code is even doing?  From a couple of
> > > > attempts to read through it, it's a whole bunch of
> > > > probably-extremely-buggy code that,
> > >
> > > Yes, probably.
> > >
> > > > drumroll please, tries to atomically read the TSC value and the time.  And decide whether the
> > > > result is "based on the TSC".
> > >
> > > I think "based on the TSC" refers to whether TSC clocksource is being
> > > used.
> > >
> > > > And then synthesizes a TSC-to-ns
> > > > multiplier and shift, based on *something other than the actual
> > > > multiply and shift used*.
> > > >
> > > > IOW, unless I'm totally misunderstanding it, the code digs into the
> > > > private arch clocksource data intended for the vDSO, uses a poorly
> > > > maintained copy of the vDSO code to read the time (instead of doing
> > > > the sane thing and using the kernel interfaces for this), and
> > > > propagates a totally made up copy to the guest.
> > >
> > > I posted kernel interfaces for this, and it was suggested to
> > > instead write a "in-kernel user of pvclock data".
> > >
> > > If you can get kernel interfaces to replace that, go for it. I prefer
> > > kernel interfaces as well.
> > >
> > > >  And gets it entirely
> > > > wrong when doing nested virt, since, unless there's some secret in
> > > > this maze, it doesn't acutlaly use the scaling factor from the host
> > > > when it tells the guest what to do.
> > > >
> > > > I am really, seriously tempted to send a patch to simply delete all
> > > > this code.
> > >
> > > If your patch which deletes the code gets the necessary features right,
> > > sure, go for it.
> > >
> > > > The correct way to do it is to hook
> > >
> > > Can you expand on the correct way to do it?
> > >
> > > > And I don't see how it's even possible to pass kvmclock correctly to
> > > > the L2 guest when L0 is hyperv.  KVM could pass *hyperv's* clock, but
> > > > L1 isn't notified when the data structure changes, so how the heck is
> > > > it supposed to update the kvmclock structure?
> > >
> > > I don't parse your question.
> >
> > Let me ask it more intelligently: when the "reenlightenment" IRQ
> > happens, what tells KVM to do its own update for its guests?
>
> Update of what, and why it needs to update anything from IRQ?
>
> The update i can think of is from host kernel clocksource,
> which there is a notifier for.
>
>

Unless I've missed some serious magic, L2 guests see kvmclock, not hv.
So we have the following sequence of events:

 - L0 migrates the whole VM.  Starting now, RDTSC is emulated to match
the old host, which applies in L1 and L2.

 - An IRQ is queued to L1.

 - L1 acknowledges that it noticed the TSC change.  RDTSC stops being
emulated for L1 and L2.

 - L2 reads the TSC.  It has no idea that anything changed, and it
gets the wrong answer.

 - At some point, kvm clock updates.

What prevents this?  Vitaly, am I missing some subtlety of what
actually happens?

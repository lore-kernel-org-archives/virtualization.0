From: Marcelo Tosatti <mtosatti@redhat.com>
Subject: Re: [patch 00/11] x86/vdso: Cleanups, simmplifications and CLOCK_TAI
	support
Date: Wed, 3 Oct 2018 16:06:20 -0300
Message-ID: <20181003190617.GC21381__39004.4181295254$1538593564$gmane$org@amt.cnet>
References: <20180914125006.349747096@linutronix.de>
	<CALCETrU+jP2hPLoJWTYJKTvr7-=YLwtk1=cZ_uizHYQZ1z4P-w@mail.gmail.com>
	<87sh1ne64t.fsf@vitty.brq.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <87sh1ne64t.fsf@vitty.brq.redhat.com>
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
Cc: Wanpeng Li <kernellwp@gmail.com>, Florian Weimer <fweimer@redhat.com>, Juergen Gross <jgross@suse.com>, Arnd Bergmann <arnd@arndb.de>, Radim Krcmar <rkrcmar@redhat.com>, Peter Zijlstra <peterz@infradead.org>, X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Linux Virtualization <virtualization@lists.linux-foundation.org>, Stephen Boyd <sboyd@kernel.org>, John Stultz <john.stultz@linaro.org>, Andy Lutomirski <luto@kernel.org>, devel@linuxdriverproject.org, Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Matt Rickard <matt@softrans.com.au>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Oct 03, 2018 at 11:22:58AM +0200, Vitaly Kuznetsov wrote:
> Andy Lutomirski <luto@kernel.org> writes:
> 
> > Hi Vitaly, Paolo, Radim, etc.,
> >
> > On Fri, Sep 14, 2018 at 5:52 AM Thomas Gleixner <tglx@linutronix.de> wrote:
> >>
> >> Matt attempted to add CLOCK_TAI support to the VDSO clock_gettime()
> >> implementation, which extended the clockid switch case and added yet
> >> another slightly different copy of the same code.
> >>
> >> Especially the extended switch case is problematic as the compiler tends to
> >> generate a jump table which then requires to use retpolines. If jump tables
> >> are disabled it adds yet another conditional to the existing maze.
> >>
> >> This series takes a different approach by consolidating the almost
> >> identical functions into one implementation for high resolution clocks and
> >> one for the coarse grained clock ids by storing the base data for each
> >> clock id in an array which is indexed by the clock id.
> >>
> >
> > I was trying to understand more of the implications of this patch
> > series, and I was again reminded that there is an entire extra copy of
> > the vclock reading code in arch/x86/kvm/x86.c.  And the purpose of
> > that code is very, very opaque.
> >
> > Can one of you explain what the code is even doing?  From a couple of
> > attempts to read through it, it's a whole bunch of
> > probably-extremely-buggy code that, drumroll please, tries to
> > atomically read the TSC value and the time.  And decide whether the
> > result is "based on the TSC".  And then synthesizes a TSC-to-ns
> > multiplier and shift, based on *something other than the actual
> > multiply and shift used*.
> >
> > IOW, unless I'm totally misunderstanding it, the code digs into the
> > private arch clocksource data intended for the vDSO, uses a poorly
> > maintained copy of the vDSO code to read the time (instead of doing
> > the sane thing and using the kernel interfaces for this), and
> > propagates a totally made up copy to the guest.  And gets it entirely
> > wrong when doing nested virt, since, unless there's some secret in
> > this maze, it doesn't acutlaly use the scaling factor from the host
> > when it tells the guest what to do.
> >
> > I am really, seriously tempted to send a patch to simply delete all
> > this code.  The correct way to do it is to hook
> 
> "I have discovered a truly marvelous proof of this, which this margin is
> too narrow to contain" :-)
> 
> There is a very long history of different (hardware) issues Marcelo was
> fighting with and the current code is the survived Frankenstein.

Right, the code has to handle different TSC modes.

>  E.g. it
> is very, very unclear what "catchup", "always catchup" and
> masterclock-less mode in general are and if we still need them.

Catchup means handling exposed (to guest) TSC frequency smaller than
HW TSC frequency.

That is "frankenstein" code, could be removed.

> That said I'm all for simplification. I'm not sure if we still need to
> care about buggy hardware though.

What simplification is that again? 


> >
> > And I don't see how it's even possible to pass kvmclock correctly to
> > the L2 guest when L0 is hyperv.  KVM could pass *hyperv's* clock, but
> > L1 isn't notified when the data structure changes, so how the heck is
> > it supposed to update the kvmclock structure?
> 
> Well, this kind of works in the the followin way:
> L1's clocksource is 'tsc_page' which is, basically, a compliment to TSC:
> two numbers provided by L0: offset and scale and KVM was tought to treat
> this clocksource as a good one (see b0c39dc68e3b "x86/kvm: Pass stable
> clocksource to guests when running nested on Hyper-V").
> 
> The notification you're talking about exists, it is called
> Reenligntenment, see 0092e4346f49 "x86/kvm: Support Hyper-V
> reenlightenment"). When TSC page changes (and this only happens when L1
> is migrated to a different host with a different TSC frequency and TSC
> scaling is not supported by the CPU) we receive an interrupt in L1 (at
> this moment all TSC accesses are emulated which guarantees the
> correctness of the readings), pause all L2 guests, update their kvmclock
> structures with new data (we already know the new TSC frequency) and
> then tell L0 that we're done and it can stop emulating TSC accesses.
> 
> (Nothing like this exists for KVM-on-KVM, by the way, when L1's
> clocksource is 'kvmclock' L2s won't get a stable kvmclock clocksource.)
> 
> -- 
> Vitaly

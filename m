From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: + stupid-hack-to-make-mainline-build.patch added to -mm tree
Date: Wed, 07 Mar 2007 22:40:39 +0100
Message-ID: <1173303639.24738.814.camel@localhost.localdomain>
References: <200703060654.l266sVxr014860@shell0.pdx.osdl.net>
	<45ED16D2.3000202@vmware.com> <20070306084258.GA15745@elte.hu>
	<20070306084647.GA16280@elte.hu>  <45ED2C82.3080008@vmware.com>
	<1173178774.24738.311.camel@localhost.localdomain>
	<45EDD82F.90204@vmware.com>
	<1173225182.24738.507.camel@localhost.localdomain>
	<45EE0628.1080108@goop.org>  <45EE08E8.2020008@vmware.com>
	<1173228544.24738.514.camel@localhost.localdomain>
	<45EE0D10.7070807@vmware.com>
	<1173230305.24738.529.camel@localhost.localdomain>
	<45EE1EA3.90803@vmware.com>
	<1173256666.24738.576.camel@localhost.localdomain>
	<45EEF966.6060902@goop.org>
	<1173300032.24738.750.camel@localhost.localdomain>
	<45EF2991.1020204@goop.org>
Reply-To: tglx@linutronix.de
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <45EF2991.1020204@goop.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Virtualization Mailing List <virtualization@lists.osdl.org>, john stultz <johnstul@us.ibm.com>, LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>, akpm@linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Wed, 2007-03-07 at 13:07 -0800, Jeremy Fitzhardinge wrote:
> Thomas Gleixner wrote:
> > I tend to disagree. The clockevents infrastructure was designed to cope
> > with the existing mess of real hardware. The discussion over the last
> > days exposed me to even more exotic designs than the hardware vendors
> > were able to deliver until now.
> >   =

> =

> It's a different but related problem domain.  It's also an increasingly
> common execution environment for a kernel to find itself in.  Dealing
> with proper paravirtualized timer devices is a big improvement over
> trying to reliably deal with fully virtualized hardware timers, which
> simply can't make the same guarantees that real hardware can make - such
> as "you will definitely get N ns of CPU time between doing the
> delta->absolute computation and programming the match register".

That's exactly the reason why we want only _ONE_ proper virtualized
timer device instead of 10 new variants of broken hardware.

> > I know exactly where you are heading:
> >
> > Offload the handling of hypervisor design decisions to the kernel and
> > let us deal with that. So we need to implement 128 bit math to convert
> > back and forth and I expect more interesting things to creep up. =

> >   =

> =

> I wouldn't put it that way.  We've been getting a lot of pressure to
> keep the pv_ops interface as small as possible.  Reusing existing kernel
> interfaces rather than making up new ones is a good way to do that.  The
> clock infrastructure certainly cleans things up; earlier Xen patches
> made a complete copy of the old kernel/time.c and hacked it around,
> which isn't what anyone wants to do.

All you need is exactly ONE paravirt clockevent device and ONE paravirt
clocksource for _ALL_ hypervisors. Cast that into stone with a
paravirt_ops->clockwahtever interface and we are all happy.

> > All this is of _NO_ use and benefit for the kernel itself.
> >   =

> =

> Lots of people want to run Linux in virtual machines.  If we can make
> sane kernel changes to help those users, then that is of use an benefit
> to the kernel.

The above will give a real benefit as it is a well defined interface,
which can be verified on both ends.

> > Real hardware copes well with relative deltas for the events, even when
> > it is match register based. I thought long about the support for
> > absolute expiry values in cycles and decided against them to avoid that
> > math hackery, which you folks now demand.
> >   =

> =

> Not really.  Xen and VMI interfaces both use absolute monotonic time for
> timeouts, which is certainly a common case for such interfaces
> (pthread_cond_timedwait, for example).  Converting delta to absolute is
> clearly simple, but it does introduce an added bit of non-determinism if
> your CPU can be preempted from outside at any time.  I presume SMM or
> similar interrupts can cause the same problem on real hardware.

As I said before: I have no objection against expanding / changing the
clockevents interface to deliver absolute expiry time, which we have
already handy.

I just refuse for a good reason to convert it from ktime_t (nanoseconds)
to an absolute cycle value. This can be done on the hypervisor side of
the paravirt clock event device. Same applies for clocksources. The ones
which need nanosecond from/to whatever conversion can do it _IN_ the
hypervisor and not in 10 different grades of madness in the kernel code.

> > We can optimize this by skipping the conversion via a feature flag.
  =

> The clocksource needed the shift for ntp warping.  Does the clockevent
> need a shift at all?  Could I just set mult/shift to 1/0?

Yes.

> > Your implementation is almost the perfect prototype, if you move the
> > 128 bit hackery into the hypervisor and hide it away from the kernel :)
> >   =

> The point is to use the tsc to avoid making any hypercalls, so dealing
> with the tsc->ns conversion has to happen on the guest side somehow.

I understand that you want to make this as fast as possible, but TSC is
broken in more than one way and it just makes me barf, when we have yet
another way of dealing with it in the kernel.

Please keep the paravirt interface abstract and treat it in the same way
we treat the kernel - userspace API. The kernel hides all this hardware
crap away from the user space and the same applies for a sane paravirt
interface. This is also a benefit in terms of portability. =


For devices, which already live on top of an abstraction layer in the
kernel, e.g. clocksources, clockevents, interrupts, we can share one
implementation accross multiple platforms.

> > One of these is perfectly fine for _ALL_ of the hypervisor folks.
> > Anything else is just a backwards decision for the kernel.
> >   =

> That would certainly be ideal.  We'll look at the xen, vmi, lguest and
> kvm paravirtualized time models and see how much they really have in
> common.  I'm a bit curious about how vmi's time events make their way
> back into the system.

By the crude mechanism I'm fighting.

	tglx

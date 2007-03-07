From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: + stupid-hack-to-make-mainline-build.patch added to -mm tree
Date: Wed, 07 Mar 2007 13:07:29 -0800
Message-ID: <45EF2991.1020204@goop.org>
References: <200703060654.l266sVxr014860@shell0.pdx.osdl.net>	
	<45ED16D2.3000202@vmware.com> <20070306084258.GA15745@elte.hu>	
	<20070306084647.GA16280@elte.hu> <45ED2C82.3080008@vmware.com>	
	<1173178774.24738.311.camel@localhost.localdomain>	
	<45EDD82F.90204@vmware.com>	
	<1173225182.24738.507.camel@localhost.localdomain>	
	<45EE0628.1080108@goop.org> <45EE08E8.2020008@vmware.com>	
	<1173228544.24738.514.camel@localhost.localdomain>	
	<45EE0D10.7070807@vmware.com>	
	<1173230305.24738.529.camel@localhost.localdomain>	
	<45EE1EA3.90803@vmware.com>	
	<1173256666.24738.576.camel@localhost.localdomain>	
	<45EEF966.6060902@goop.org>
	<1173300032.24738.750.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <1173300032.24738.750.camel@localhost.localdomain>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: tglx@linutronix.de
Cc: Virtualization Mailing List <virtualization@lists.osdl.org>, john stultz <johnstul@us.ibm.com>, LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>, akpm@linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Thomas Gleixner wrote:
> I tend to disagree. The clockevents infrastructure was designed to cope
> with the existing mess of real hardware. The discussion over the last
> days exposed me to even more exotic designs than the hardware vendors
> were able to deliver until now.
>   =


It's a different but related problem domain.  It's also an increasingly
common execution environment for a kernel to find itself in.  Dealing
with proper paravirtualized timer devices is a big improvement over
trying to reliably deal with fully virtualized hardware timers, which
simply can't make the same guarantees that real hardware can make - such
as "you will definitely get N ns of CPU time between doing the
delta->absolute computation and programming the match register".

> I know exactly where you are heading:
>
> Offload the handling of hypervisor design decisions to the kernel and
> let us deal with that. So we need to implement 128 bit math to convert
> back and forth and I expect more interesting things to creep up. =

>   =


I wouldn't put it that way.  We've been getting a lot of pressure to
keep the pv_ops interface as small as possible.  Reusing existing kernel
interfaces rather than making up new ones is a good way to do that.  The
clock infrastructure certainly cleans things up; earlier Xen patches
made a complete copy of the old kernel/time.c and hacked it around,
which isn't what anyone wants to do.

> All this is of _NO_ use and benefit for the kernel itself.
>   =


Lots of people want to run Linux in virtual machines.  If we can make
sane kernel changes to help those users, then that is of use an benefit
to the kernel.

> Real hardware copes well with relative deltas for the events, even when
> it is match register based. I thought long about the support for
> absolute expiry values in cycles and decided against them to avoid that
> math hackery, which you folks now demand.
>   =


Not really.  Xen and VMI interfaces both use absolute monotonic time for
timeouts, which is certainly a common case for such interfaces
(pthread_cond_timedwait, for example).  Converting delta to absolute is
clearly simple, but it does introduce an added bit of non-determinism if
your CPU can be preempted from outside at any time.  I presume SMM or
similar interrupts can cause the same problem on real hardware.

I guess the worst case for real hardware is an absolute-time match
register which only compares for match=3D=3Dnow rather than match<=3Dnow,
since you could completely lose the time event if you miss the deadline.

>> static const struct clock_event_device xen_clockevent =3D {
>> 	.name =3D "xen",
>> 	.features =3D CLOCK_EVT_FEAT_ONESHOT,
>>
>> 	.max_delta_ns =3D 0x7fffffff,
>> 	.min_delta_ns =3D 100,	/* ? */
>>
>> 	.mult =3D 1<<XEN_SHIFT,
>> 	.shift =3D XEN_SHIFT,
>>     =

>
> We can optimize this by skipping the conversion via a feature flag.
>   =


The clocksource needed the shift for ntp warping.  Does the clockevent
need a shift at all?  Could I just set mult/shift to 1/0?

> Your implementation is almost the perfect prototype, if you move the
> 128 bit hackery into the hypervisor and hide it away from the kernel :)
>   =


The point is to use the tsc to avoid making any hypercalls, so dealing
with the tsc->ns conversion has to happen on the guest side somehow.

> One of these is perfectly fine for _ALL_ of the hypervisor folks.
> Anything else is just a backwards decision for the kernel.
>   =


That would certainly be ideal.  We'll look at the xen, vmi, lguest and
kvm paravirtualized time models and see how much they really have in
common.  I'm a bit curious about how vmi's time events make their way
back into the system.

    J

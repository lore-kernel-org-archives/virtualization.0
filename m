From: Ingo Molnar <mingo@elte.hu>
Subject: Re: Xen & VMI?
Date: Wed, 7 Mar 2007 09:15:10 +0100
Message-ID: <20070307081510.GB15111@elte.hu>
References: <45ED82D9.6050204@codemonkey.ws>
	<8FFF7E42E93CC646B632AB40643802A80229779B@scsmsx412.amr.corp.intel.com>
	<20070306203712.GC21736@elte.hu>
	<1173228246.4644.85.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <1173228246.4644.85.camel@localhost.localdomain>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: virtualization <virtualization@lists.osdl.org>, Jan Beulich <jbeulich@novell.com>, Anthony Liguori <anthony@codemonkey.ws>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Roland McGrath <roland@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org


* Rusty Russell <rusty@rustcorp.com.au> wrote:

> On Tue, 2007-03-06 at 21:37 +0100, Ingo Molnar wrote:
> > maybe i shouldnt call it 'VMI' but 'the paravirt ABI'. I dont mind if =

> > it's the Xen ABI or the VMWare ABI or a mesh of the two - everyone can =

> > map their own internals to that /one/ ABI.
> =

> I think it's an excellent aim, but it's *HARD*.  I rejected this =

> approach earlier because I'm just not smart enough.  (Yet?)
> =

> The Linux side is fairly stable.  The hardware side is changing, and =

> the hypervisor side is changing.  This means the ABI will churn fairly =

> fast. The hypervisors are very different, which means the ABI will be =

> very wide.

the 'hardware is changing fast so we cannot do a sane API' argument =

sounds good at first but in this context it is still fundamentally =

wrong. Hardware has changed /dramatically/ since we started Linux, still =

we didnt have to do dramatic changes to the system call API/ABI. Why? =

Because hardware too is fundamentally controlled by the rules of this =

world. So if you know the laws of physics, math and computer science, =

you /CAN/ do a sane API that lives for quite some time. We had these =

kinds of discussions when Linux was just a few years old - many people =

were worried about 'the hardware changes too fast' - but if the =

fundamentals are strong, it _doesnt really matter_, as long as our =

interfaces are sane and we quickly adopt our internals.

On the other hand, Linux's internal details, semantics, approaches are a =

lot more ad-hoc and alot more affected by changes in the hardware =

environment - that's why i'd not like to see some external ABI =

constraint limit aspects of those internals.

For example, VMI_CALL_SetAlarm takes a 'cycles' argument. Cycles is a =

quite bad unit for an API, it should be absolute time, nanosec or =

picosec based instead. We could easily see CPUs that have /no concept of =

cycles/, at all! Even today's CPUs have hardly any fix concept of =

cycles, due to cpufreq. It's as if 15 years ago we had based sys_mmap() =

around the concept of '16-bit segments'. We could certainly make it work =

on current hardware but it would look pretty awkward today.

in fact hardware changes alot more by just going from one Linux arch to =

another - still the system call API is essentially the same. (with =

small, non-fundamental variations)

furthermore, most of the details in VMI or in Xen's lowlevel APIs (where =

most of the overlap is currently - VMI doesnt have all that many =

highlevel APIs) are cast into stone. The i386 arch is not going to =

change, ever. Most details of the x86_64 arch is not going to change, =

ever. It's unclear whether there will ever be the need for any x86_128 =

arch (for humans). So it should be quite possible to come up with =

something sane for these lowlevel details, and cast it into stone, for =

everyone. Just like the chip makers cast it into silicon.

the more nontrivial (and thus more harmful, because more =

design-limiting) bits are the highlevel APIs.

> We could start with VMI and try to support Xen, KVM and lguest.  It =

> would at least give us a better idea of the scope of the problem.  But =

> IMHO it's a *huge* job.

yeah, it's a nontrivial job - like writing a sane OS. But it's doable =

and we are in fact out here trying to do exactly that, right? ;-)

	Ingo

From: Zachary Amsden <zach@vmware.com>
Subject: Re: [RFC] CPUID usage for interaction between Hypervisors and	Linux.
Date: Wed, 01 Oct 2008 16:47:04 -0700
Message-ID: <1222904824.7330.83.camel__24600.1118132428$1222905276$gmane$org@bodhitayantram.eng.vmware.com>
References: <1222881242.9381.17.camel@alok-dev1> <48E3BBC1.2050607@goop.org>
	<1222894878.9381.63.camel@alok-dev1> <48E3E8DE.1080602@goop.org>
	<48E3ECD1.30809@codemonkey.ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <48E3ECD1.30809@codemonkey.ws>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Anthony Liguori <anthony@codemonkey.ws>
Cc: the arch/x86 maintainers <x86@kernel.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, Daniel Hecht <dhecht@vmware.com>, LKML <linux-kernel@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "H. Peter Anvin" <hpa@zytor.com>, Alok Kataria <akataria@vmware.com>, Ingo Molnar <mingo@elte.hu>, "avi@redhat.com" <avi@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, 2008-10-01 at 14:34 -0700, Anthony Liguori wrote:
> Jeremy Fitzhardinge wrote:
> > Alok Kataria wrote:
> >
> > I guess, but the bulk of the uses of this stuff are going to be
> > hypervisor-specific.  You're hard-pressed to come up with any other
> > generic uses beyond tsc.
> 
> And arguably, storing TSC frequency in CPUID is a terrible interface
> because the TSC frequency can change any time a guest is entered.  It
> really should be a shared memory area so that a guest doesn't have to
> vmexit to read it (like it is with the Xen/KVM paravirt clock).

It's not terrible, it's actually brilliant.  TSC is part of the
processor architecture, the processor should a way to tell us what speed
it is.

Having a TSC with no interface to determine the frequency is a terrible
design flaw.  This is what caused the problem in the first place.

And now we're trying to fiddle around with software wizardry what should
be done in hardware in the first place.  Once again, para-virtualization
is basically useless.  We can't agree on a solution without
over-designing some complex system with interface signatures and
multi-vendor cooperation and nonsense.  Solve the non-virtualized
problem and the virtualized problem goes away.

Jun, you work at Intel.  Can you ask for a new architecturally defined
MSR that returns the TSC frequency?  Not a virtualization specific MSR.
A real MSR that would exist on physical processors.  The TSC started as
an MSR anyway.  There should be another MSR that tells the frequency.
If it's hard to do in hardware, it can be a write-once MSR that gets
initialized by the BIOS.  It's really a very simple solution to a very
common problem.  Other MSRs are dedicated to bus speed and so on, this
seems remarkably similar.

Once the physical problem is solved, the virtualized problem doesn't
even exist.  We simply add support for the newly defined MSR and voilla.
Other chipmakers probably agree it's a good idea and go along with it
too, and in the meantime, reading a non-existent MSR is a fairly
harmlessly handled #GP.

I realize it's the wrong thing for us now, but long term, it's the only
architecturally 'correct' approach.  You can even extend it to have
visible TSC frequency changes clocked via performance counter events
(and then get interrupts on those events if you so wish), solving the
dynamic problem too.

Paravirtualization is a symptom of an architectural problem.  We should
always be trying to fix the architecture first.

Zach

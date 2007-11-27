From: "Stephen C. Tweedie" <sct@redhat.com>
Subject: Re: Re: Next steps with pv_ops for Xen
Date: Tue, 27 Nov 2007 17:15:18 +0000
Message-ID: <1196183718.13079.27.camel@sisko.scot.redhat.com>
References: <1195682725.6726.48.camel@sisko.scot.redhat.com>
	<4744BB54.4040803@goop.org>
	<de87b960711260602m799b365fw62af3976913d64cc@mail.gmail.com>
	<de87b960711260602m799b365fw62af3976913d64cc@mail.gmail.com>
	<474B15FC.4050901@goop.org> <474BE3D1.76E4.0078.0@novell.com>
	<474C4D1D.9020700@goop.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <xen-devel-bounces@lists.xensource.com>
In-Reply-To: <474C4D1D.9020700@goop.org>
List-Unsubscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: "xen-devel@lists.xensource.com" <xen-devel@lists.xensource.com>, Eduardo Habkost <ehabkost@redhat.com>, Juan Quintela <quintela@redhat.com>, Stephen Tweedie <sct@redhat.com>, Jan Beulich <jbeulich@novell.com>, Glauber de Oliveira Costa <gcosta@redhat.com>, Chris Wright <chrisw@sous-sol.org>, "virtualization@lists.osdl.org" <virtualization@lists.osdl.org>, Juan Quintela <juan.quintela@gmail.com>
List-Id: virtualization@lists.linuxfoundation.org

Hi,

On Tue, 2007-11-27 at 09:00 -0800, Jeremy Fitzhardinge wrote:

> > Why do you think that's a CR0 write? 
> 
> Well, the oops says "EIP is at native_write_cr0+0x0/0x4", and the caller
> is prepare_set(), which does:
> 
> 	/*  Enter the no-fill (CD=1, NW=0) cache mode and flush caches. */
> 	cr0 = read_cr0() | X86_CR0_CD;
> 	write_cr0(cr0);
> 	wbinvd();
> 
> This is in preparation to setting up the MTRRs, 

Right: cpu 0 gets past the early mtrr init (on the boot CPU, all the
kernel does is to probe the existing mtrr config), but it dies on cpu 1
trying to copy the mtrr config across.  (As a consequence, we don't hit
this problem on UP configs.)

> which needs to be all skipped anyway.

We _could_ just skip it, but we still want some mtrr support for dom0.
Fortunately the kernel's mtrr interfaces are nicely modular already, so
I'm currently starting to plug the 2.6.18 mtrr/main-xen.c into pv_ops as
a modular mtrr provider.

> > The messages clearly indicate an
> > MSR write, and these writes are clearly visible in intel_p{4,6}_mcheck_init()
> > and amd_mcheck_init(). The question is why intel_p4_mcheck_init() doesn't
> > check CPUID bits before trying to touch any registers... (And similarly
> > amd_mcheck_init() is checking only the MCE bit, not the MCA one.)

> The oops and backtrace doesn't suggest it's an MSR write.  Does a crX
> write take the same path through the emulator as an MSR write?

We get a slew of MCE-related MSR write warnings from the HV on both boot
and auxiliary processor bring-up, but the kernel doesn't crash at those
points.  (Which is not necessarily a good thing, as it implies the
kernel thinks it has registered its MCE handling, but the MSR writes
have not actually been honoured.)  So it's not a showstopper right now,
but is something we'll still want to deal with at some stage.

> > A simple workaround would be to force mce_disabled to 1 in early Xen
> > initialization.

> That's probably necessary too.

It doesn't seem to be necessary, given that the kernel does get past
this point; it's probably desirable, though, at least until such time as
we can actually do the MCE support correctly.

--Stephen

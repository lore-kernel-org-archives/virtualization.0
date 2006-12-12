From: Andi Kleen <ak@suse.de>
Subject: Re: Why disable vdso by default with CONFIG_PARAVIRT?
Date: Tue, 12 Dec 2006 08:27:56 +0100
Message-ID: <200612120827.56363.ak@suse.de>
References: <457E0460.4030107@goop.org> <200612120402.19958.ak@suse.de>
	<457E5144.7020406@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <457E5144.7020406@goop.org>
Content-Disposition: inline
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
Cc: Virtualization Mailing List <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org


> So the SUSE 9 =


SL9.0 (not to be confused with SLES9). But it's all distributions
with an older glibc.

> libc needs COMPAT_VDSO, or it just can't deal with the =

> vdso moving around?  Can it deal with the current kernel's mobile vdso?

It needs COMPAT_VDSO

[which is basically COMPAT_NO_OLD_GLIBC and imho always
was a big mistake to have a config anyways -- one shouldn't gamble
with binary compatibility so lightly] =


> >> (in fact, its actually very useful so that it picks up the
> >> right libc with Xen-friendly TLS).
> >>     =

> >
> > AFAIK libc selection comes from the aux vector, not the vdso.
> =

> No, it seems to be done by adding a .note segment to the vdso share
> object. =


Hmm, i had assumed it used the same mechanism as the CPU optimized
libcs -- and that comes from the aux vector AT_PLATFORM.  =


> Without the vdso, my Xen test system doesn't boot because it =

> can't find the nosegneg versions of the libraries (it doesn't seem to
> know where to look).  I'm not sure how all this stuff fits together. =


Why does it not boot? At least in the past nosegneg was only a optimization
to avoid some unnecessary traps to the hypervisor, but it should handle it.
Has that changed?

> But the auxv is supposed to point to the vdso...

create_elf_tables() puts the AT_PLATFORM string onto the stack,
unless i'm misreading the code badly. No dependency on vdso.

-Andi

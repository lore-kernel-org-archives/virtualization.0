From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: Why disable vdso by default with CONFIG_PARAVIRT?
Date: Tue, 12 Dec 2006 02:23:09 -0800
Message-ID: <457E830D.6010801@goop.org>
References: <457E0460.4030107@goop.org> <200612120402.19958.ak@suse.de>
	<457E5144.7020406@goop.org> <200612120827.56363.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <200612120827.56363.ak@suse.de>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Andi Kleen <ak@suse.de>
Cc: Virtualization Mailing List <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

Andi Kleen wrote:
> It needs COMPAT_VDSO
>
> [which is basically COMPAT_NO_OLD_GLIBC and imho always
> was a big mistake to have a config anyways -- one shouldn't gamble
> with binary compatibility so lightly] =

>   =


It's unfortunate; there's a fundamental address space clash, and there's
no nice resolution.

Will your system boot with vdso=3D0 on the kernel command line? =

Presumably it will boot paravirt-native without it (since native makes
no claims on the address space), so its something you could put in your
Xen config file, no?

> Hmm, i had assumed it used the same mechanism as the CPU optimized
> libcs -- and that comes from the aux vector AT_PLATFORM.  =

>   =


There's some magic that involves a .note segment in the vdso itself, and
a ld.so.conf entry which maps the string in there ("nosegneg") to a
pseudo-hardware capability, and ld.so uses the result of that to look
for more places for libraries.  I don't really understand how all the
pieces fit together.

> Why does it not boot? At least in the past nosegneg was only a optimizati=
on
> to avoid some unnecessary traps to the hypervisor, but it should handle i=
t.
> Has that changed?
>   =


No, but my (very stripped down) test system has no other libraries.

    J

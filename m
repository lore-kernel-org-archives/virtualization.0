From: Andi Kleen <ak@suse.de>
Subject: Re: [PATCH 1/5] Skip timer works.patch
Date: Thu, 16 Nov 2006 20:46:04 +0100
Message-ID: <200611162046.04264.ak@suse.de>
References: <20061027145650.GA37582@muc.de> <200611161416.45624.ak@suse.de>
	<20061116190334.GF1397@sequoia.sous-sol.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <20061116190334.GF1397@sequoia.sous-sol.org>
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
To: Chris Wright <chrisw@sous-sol.org>
Cc: Andrew Morton <akpm@osdl.org>, virtualization@lists.osdl.org
List-Id: virtualization@lists.linuxfoundation.org

On Thursday 16 November 2006 20:03, Chris Wright wrote:
> * Andi Kleen (ak@suse.de) wrote:
> > I merged everything together.  Synced out to ff now.
> =

> OK, thanks.
> =

> > CONFIG_PARAVIRT=3Dn kernel runs now, but when I run a defconfig + CONFI=
G_PARAVIRT=3Dy =

> > kernel on bare metal init still breaks with a long stream of =

> > =

> > INIT: Entering runlevel: 3
> > Inconsistency detected by ld.so: rtld.c: 1250: dl_main: Assertion `(voi=
d *) ph->
> > p_vaddr =3D=3D _rtld_local._dl_sysinfo_dso' failed!
> > Inconsistency detected by ld.so: rtld.c: 1250: dl_main: Assertion `(voi=
d *) ph->
> > p_vaddr =3D=3D _rtld_local._dl_sysinfo_dso' failed!
> > Inconsistency detected by ld.so: rtld.c: 1250: dl_main: Assertion `(voi=
d *) ph->
> > p_vaddr =3D=3D _rtld_local._dl_sysinfo_dso' failed!
> > Inconsistency detected by ld.so: rtld.c: 1250: dl_main: Assertion `(voi=
d *) ph->
> > p_vaddr =3D=3D _rtld_local._dl_sysinfo_dso' failed!
> > ...
> > =

> > before giving up. So it looks like something is still broken
> =

> Another one that was working here.  I'll debug with your config.

I started some bisecting (it's difficult because many intermediaries
don't compile -- something to clean up). Anyways, for this order of
paravirt patches:

header-and-stubs-for-paravirtualisation
patch-inline-replacements-for
paravirt-compile
cpu_detect-extraction
more-generic-paravirtualization
allow-selected-bug-checks-to-be
allow-disabling-legacy-power
add-apic-accessors-to-paravirt-ops.
add-mmu-virtualization-to
be-careful-about-touching-bios-address-space
mmu-header-movement
fix-bad-mmu-names
fix-missing-pte-update
fix-x86_64-mm-patch-inline-replacements-for
paravirt-pae
skip-timer-works

it's already broken at more-generic-paravirtualization.  Surprised
me a little, i was suspecting the MMU changes.

-Andi

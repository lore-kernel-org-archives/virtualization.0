From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH] Fix CONFIG_PARAVIRT for 2.6.19-rc5-mm1
Date: Sat, 11 Nov 2006 15:34:08 +1100
Message-ID: <1163219648.30123.31.camel@localhost.localdomain>
References: <1163034102.15681.6.camel@localhost.localdomain>
	<200611090812.37599.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <200611090812.37599.ak@suse.de>
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
Cc: Andrew Morton <akpm@osdl.org>, virtualization@lists.osdl.org, Chris Wright <chrisw@sous-sol.org>, Andi Kleen <ak@muc.de>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, 2006-11-09 at 08:12 +0100, Andi Kleen wrote:
> On Thursday 09 November 2006 02:01, Rusty Russell wrote:
> > OK, at least two patches got dropped on the way from the mm tree to
> > Andi's tree: the desc.h cleanup, and the processor.h rearrangement.
> =

> Can you please resend the patchkit with these patches included?
> =

> (and any further changes folded in into the respective patches) =


No, I'm supposed to be on leave for 3 weeks, starting yesterday.

They went into Andrew Morton's tree.  They were fine there, and had been
there for a few weeks!

You can either go back and pull them out of the -mm tree before -rc5-mm1
(say -rc4-mm2), or drop all of them and have Andrew can reinstate the
ones he dropped.

The relevant patches from -rc4-mm2 seem to be:

prep-for-paravirt-be-careful-about-touching-bios.patch
  Prep for paravirt: Be careful about touching BIOS address space

prep-for-paravirt-be-careful-about-touching-bios-warning-fix.patch
  prep-for-paravirt-be-careful-about-touching-bios-warning-fix

prep-for-paravirt-cpu_detect-extraction.patch
  Prep for paravirt: cpu_detect extraction

prep-for-paravirt-desch-clearer-parameter-names.patch
  Prep for paravirt: desc.h clearer parameter names, some code motion

prep-for-paravirt-desch-clearer-parameter-names-fix.patch
  prep-for-paravirt-desch-clearer-parameter-names fix

prep-for-paravirt-rearrange-processorh.patch
  Prep for paravirt: rearrange processor.h

paravirtualization-header-and-stubs-for.patch
  paravirtualization: header and stubs for paravirtualizing critical operat=
ions

paravirtualization-patch-inline-replacements-for.patch
  paravirtualization: Patch inline replacements for common paravirt operati=
ons.

paravirtualization-patch-inline-replacements-for-fix.patch
  paravirtualization-patch-inline-replacements-for (fix)

paravirtualization-more-generic-paravirtualization.patch
  paravirtualization: More generic paravirtualization entry point.

paravirtualization-allow-selected-bug-checks-to-be.patch
  paravirtualization: Allow selected bug checks to be skipped by paravirt k=
ernels

paravirtualization-allow-disabling-legacy-power.patch
  paravirtualization: Allow disabling legacy power management modes with pa=
ravirt kernels

paravirtualization-add-apic-accessors-to-paravirt-ops.patch
  paravirtualization: Add APIC accessors to paravirt-ops.

paravirtualization-add-apic-accessors-to-paravirt-ops-tidy.patch
  paravirtualization: Add APIC accessors to paravirt-ops

paravirtualization-add-mmu-virtualization-to.patch
  paravirtualization: Add mmu virtualization to paravirt-ops.

There were then some fixes which went in after that, in rc5-mm1:

paravirtualization-header-and-stubs-for-fix.patch
  fix "paravirtualization: header and stubs for paravirtualizing critical o=
perations"

paravirtualization-header-and-stubs-for-headers_check-fix.patch
  paravirtualization: header and stubs for paravirtualizing critical operat=
ions (headers_check fix)

paravirtualization-patch-inline-replacements-for-fix-2.patch
  paravirtualization-patch-inline-replacements-for fix 2

paravirtualization-patch-inline-replacements-for-fix-3.patch
  Fix 'arch/i386/kernel/alternative.c:355: warning: unused variable 'i''

paravirtualization-more-generic-paravirtualization-warning-fix.patch
  Fix 'arch/i386/kernel/paravirt.c:481: warning: initialization from incomp=
atible pointer type'

Rusty.

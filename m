From: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] Fix CONFIG_PARAVIRT for 2.6.19-rc5-mm1
Date: Thu, 9 Nov 2006 00:09:39 -0800
Message-ID: <20061109000939.7a48851f.akpm@osdl.org>
References: <1163034102.15681.6.camel@localhost.localdomain>
	<200611090812.37599.ak@suse.de>
	<20061108233904.e631c7c6.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <20061108233904.e631c7c6.akpm@osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Andi Kleen <ak@suse.de>, virtualization@lists.osdl.org, Rusty Russell <rusty@rustcorp.com.au>, Andi Kleen <ak@muc.de>, Chris Wright <chrisw@sous-sol.org>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, 8 Nov 2006 23:39:04 -0800
Andrew Morton <akpm@osdl.org> wrote:

> > Can you please resend the patchkit with these patches included?
> > =

> > (and any further changes folded in into the respective patches) =

> > =

> =

> argh.
> =

> I'll do it.

OK, all done.

I kept prep-for-paravirt-be-careful-about-touching-bios.patch (below)
separate, because it's dependent on
x86_64-mm-i386-create-e820.c-to-handle-standard-io-mem-resources.patch.  It
could be folded into one of the other patches I guess.

So I have:

paravirt-i386-header-and-stubs-for-paravirtualisation.patch
paravirt-i386-patch-inline-replacements-for.patch
paravirt-i386-more-generic-paravirtualization.patch
paravirt-i386-allow-selected-bug-checks-to-be.patch
paravirt-i386-allow-disabling-legacy-power.patch
paravirt-i386-add-apic-accessors-to-paravirt-ops.patch
paravirt-i386-add-mmu-virtualization-to.patch
prep-for-paravirt-be-careful-about-touching-bios.patch



From: Rusty Russell <rusty@rustcorp.com.au>

BIOS ROM areas may not be mapped into the guest address space, so be careful
when touching those addresses to make sure they appear to be mapped.

[akpm@osdl.org: fix unused var warning]
Signed-off-by: Jeremy Fitzhardinge <jeremy@xensource.com>
Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Andi Kleen <ak@suse.de>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 arch/i386/kernel/e820.c |    9 ++++++++-
 arch/i386/pci/pcbios.c  |   11 +++++++++--
 2 files changed, 17 insertions(+), 3 deletions(-)

diff -puN arch/i386/kernel/e820.c~prep-for-paravirt-be-careful-about-touchi=
ng-bios arch/i386/kernel/e820.c
--- a/arch/i386/kernel/e820.c~prep-for-paravirt-be-careful-about-touching-b=
ios
+++ a/arch/i386/kernel/e820.c
@@ -155,7 +155,14 @@ static struct resource standard_io_resou
 	.flags	=3D IORESOURCE_BUSY | IORESOURCE_IO
 } };
 =

-#define romsignature(x) (*(unsigned short *)(x) =3D=3D 0xaa55)
+static int romsignature(const unsigned char *x)
+{
+	unsigned short sig;
+	int ret =3D 0;
+	if (__get_user(sig, (const unsigned short *)x) =3D=3D 0)
+		ret =3D (sig =3D=3D 0xaa55);
+	return ret;
+}
 =

 static int __init romchecksum(unsigned char *rom, unsigned long length)
 {
diff -puN arch/i386/pci/pcbios.c~prep-for-paravirt-be-careful-about-touchin=
g-bios arch/i386/pci/pcbios.c
--- a/arch/i386/pci/pcbios.c~prep-for-paravirt-be-careful-about-touching-bi=
os
+++ a/arch/i386/pci/pcbios.c
@@ -5,6 +5,7 @@
 #include <linux/pci.h>
 #include <linux/init.h>
 #include <linux/module.h>
+#include <asm/uaccess.h>
 #include "pci.h"
 #include "pci-functions.h"
 =

@@ -314,6 +315,10 @@ static struct pci_raw_ops * __devinit pc
 	for (check =3D (union bios32 *) __va(0xe0000);
 	     check <=3D (union bios32 *) __va(0xffff0);
 	     ++check) {
+		long sig;
+		if (__get_user(sig, &check->fields.signature))
+			continue;
+
 		if (check->fields.signature !=3D BIOS32_SIGNATURE)
 			continue;
 		length =3D check->fields.length * 16;
@@ -331,11 +336,13 @@ static struct pci_raw_ops * __devinit pc
 		}
 		DBG("PCI: BIOS32 Service Directory structure at 0x%p\n", check);
 		if (check->fields.entry >=3D 0x100000) {
-			printk("PCI: BIOS32 entry (0x%p) in high memory, cannot use.\n", check);
+			printk("PCI: BIOS32 entry (0x%p) in high memory, "
+					"cannot use.\n", check);
 			return NULL;
 		} else {
 			unsigned long bios32_entry =3D check->fields.entry;
-			DBG("PCI: BIOS32 Service Directory entry at 0x%lx\n", bios32_entry);
+			DBG("PCI: BIOS32 Service Directory entry at 0x%lx\n",
+					bios32_entry);
 			bios32_indirect.address =3D bios32_entry + PAGE_OFFSET;
 			if (check_pcibios())
 				return &pci_bios_access;
_

From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Handling PCI/ROM space
Date: Wed, 18 Oct 2006 14:42:44 -0700
Message-ID: <45369FD4.3030303@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Chris Wright <chrisw@sous-sol.org>, Zachary Amsden <zach@vmware.com>, Rusty Russell <rusty@rustcorp.com.au>
Cc: Virtualization Mailing List <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

I'm seeing oopses in probe_roms() and pci_find_bios(), apparently =

because those pages are not mapped under Xen.  I'm not sure why I'm =

seeing this now and not before, but I suspect its because I enabled =

CONFIG_DEBUG_PAGEALLOC.  Anyway, I've got these patches to deal with =

these cases:

--- a/arch/i386/kernel/setup.c
+++ b/arch/i386/kernel/setup.c
@@ -276,7 +276,14 @@ static struct resource standard_io_resou
 #define STANDARD_IO_RESOURCES \
 	(sizeof standard_io_resources / sizeof standard_io_resources[0])
 =

-#define romsignature(x) (*(unsigned short *)(x) =3D=3D 0xaa55)
+static inline int romsignature(const unsigned char *x)
+{
+     unsigned short sig;
+     int ret =3D 0;
+     if (__get_user(sig, (const unsigned short *)x) =3D=3D 0)
+	  ret =3D (sig =3D=3D 0xaa55);
+     return ret;
+}
 =

 static int __init romchecksum(unsigned char *rom, unsigned long length)
 {
--- a/arch/i386/pci/pcbios.c
+++ b/arch/i386/pci/pcbios.c
@@ -5,6 +5,7 @@
 #include <linux/pci.h>
 #include <linux/init.h>
 #include <linux/module.h>
+#include <asm/uaccess.h>
 #include "pci.h"
 #include "pci-functions.h"
 =

@@ -301,7 +302,7 @@ static struct pci_raw_ops pci_bios_acces
 =

 static struct pci_raw_ops * __devinit pci_find_bios(void)
 {
-	union bios32 *check;
+	union bios32 *check, sig;
 	unsigned char sum;
 	int i, length;
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


Does this seem reasonable, or should there be some other fix?

    J

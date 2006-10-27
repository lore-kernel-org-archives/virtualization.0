From: Rusty Russell <rusty@rustcorp.com.au>
Subject: [PATCH 1/4] Prep for paravirt: Be careful about touching BIOS
	address space
Date: Fri, 27 Oct 2006 13:42:14 +1000
Message-ID: <1161920535.17807.33.camel@localhost.localdomain>
References: <1161920325.17807.29.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1946144AbWJ0DmR@vger.kernel.org>
In-Reply-To: <1161920325.17807.29.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>
Cc: lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>, virtualization <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

(Andrew had already taken that last one, I meant to send this)

Subject: Be careful about touching BIOS address space

BIOS ROM areas may not be mapped into the guest address space, so be careful
when touching those addresses to make sure they appear to be mapped.

Signed-off-by: Jeremy Fitzhardinge <jeremy@xensource.com>
Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>

===================================================================
--- a/arch/i386/kernel/setup.c
+++ b/arch/i386/kernel/setup.c
@@ -270,7 +270,14 @@ static struct resource standard_io_resou
 	.flags	= IORESOURCE_BUSY | IORESOURCE_IO
 } };
 
-#define romsignature(x) (*(unsigned short *)(x) == 0xaa55)
+static inline int romsignature(const unsigned char *x)
+{
+     unsigned short sig;
+     int ret = 0;
+     if (__get_user(sig, (const unsigned short *)x) == 0)
+	  ret = (sig == 0xaa55);
+     return ret;
+}
 
 static int __init romchecksum(unsigned char *rom, unsigned long length)
 {
===================================================================
--- a/arch/i386/pci/pcbios.c
+++ b/arch/i386/pci/pcbios.c
@@ -5,6 +5,7 @@
 #include <linux/pci.h>
 #include <linux/init.h>
 #include <linux/module.h>
+#include <asm/uaccess.h>
 #include "pci.h"
 #include "pci-functions.h"
 
@@ -301,7 +302,7 @@ static struct pci_raw_ops pci_bios_acces
 
 static struct pci_raw_ops * __devinit pci_find_bios(void)
 {
-	union bios32 *check;
+	union bios32 *check, sig;
 	unsigned char sum;
 	int i, length;
 
@@ -314,6 +315,10 @@ static struct pci_raw_ops * __devinit pc
 	for (check = (union bios32 *) __va(0xe0000);
 	     check <= (union bios32 *) __va(0xffff0);
 	     ++check) {
+		long sig;
+		if (__get_user(sig, &check->fields.signature))
+			continue;
+
 		if (check->fields.signature != BIOS32_SIGNATURE)
 			continue;
 		length = check->fields.length * 16;

-- 
 ccontrol: http://ccontrol.ozlabs.org

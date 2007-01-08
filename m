From: kraxel@suse.de (Gers Knorr)
Subject: [patch] asm/i386/kernel/paravirt.c buildfix
Date: Mon, 08 Jan 2007 16:28:52 +0100
Message-ID: <20070108152852.7819D1ED200@linux.local>
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
To: virtualization@lists.osdl.org
List-Id: virtualization@lists.linuxfoundation.org

asm/i386/kernel/paravirt.c buildfix.

drop apic_* duplicates which are defined in asm/paravirt.h

Signed-off-by: Gerd Hoffmann <kraxel@suse.de>
---
 arch/i386/kernel/paravirt.c |   14 --------------
 1 file changed, 14 deletions(-)

Index: paravirt-2.6.19-hg686/arch/i386/kernel/paravirt.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- paravirt-2.6.19-hg686.orig/arch/i386/kernel/paravirt.c
+++ paravirt-2.6.19-hg686/arch/i386/kernel/paravirt.c
@@ -693,20 +693,6 @@ void halt(void)
 }
 EXPORT_SYMBOL_GPL(halt);
 =

-#ifdef CONFIG_X86_LOCAL_APIC
-void apic_write(unsigned long reg, unsigned long v)
-{
-	paravirt_ops.apic_write(reg,v);
-}
-EXPORT_SYMBOL_GPL(apic_write);
-
-unsigned long apic_read(unsigned long reg)
-{
-	return paravirt_ops.apic_read(reg);
-}
-EXPORT_SYMBOL_GPL(apic_read);
-#endif
-
 void __cpuid(unsigned int *eax, unsigned int *ebx,
 	     unsigned int *ecx, unsigned int *edx)
 {

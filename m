From: Ian Campbell <Ian.Campbell@xensource.com>
Subject: [PATCH 4/5] XEN: Remove __xen_guest section
Date: Wed, 23 Aug 2006 16:09:45 +0100
Message-ID: <1156345785.12949.126.camel@localhost.localdomain>
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
To: Jeremy Fitzhardinge <jeremy@goop.org>, Chris Wright <chrisw@sous-sol.org>
Cc: Virtualization Mailing List <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

With a suitably recent xen the __xen_guest string is no longer required
so remove it. See the caveat in 0/5 though!

Should be merged into 024-head.patch

Signed-off-by: Ian Campbell <ian.campbell@xensource.com>

diff -r 82192f4547ab arch/i386/paravirt-xen/xen-head.S
--- a/arch/i386/paravirt-xen/xen-head.S	Wed Aug 23 15:15:18 2006 +0100
+++ b/arch/i386/paravirt-xen/xen-head.S	Wed Aug 23 15:16:01 2006 +0100
@@ -3,7 +3,7 @@
 =

 #include <linux/elfnote.h>
 #include <xen/interface/elfnote.h>
-	=

+
 #define VIRT_ENTRY_OFFSET	0x1000
 .org VIRT_ENTRY_OFFSET
 ENTRY(startup_xen)
@@ -20,43 +20,7 @@ 1:	jmp 1b	# should never return
 .org HYPERCALL_PAGE_OFFSET
 ENTRY(hypercall_page)
 .skip 0x1000
-
 	=

-/*
- * __xen_guest information
- */
-.macro utoa value
- .if (\value) < 0 || (\value) >=3D 0x10
-	utoa (((\value)>>4)&0x0fffffff)
- .endif
- .if ((\value) & 0xf) < 10
-  .byte '0' + ((\value) & 0xf)
- .else
-  .byte 'A' + ((\value) & 0xf) - 10
- .endif
-.endm
-	=

-.section __xen_guest
-	.ascii	"GUEST_OS=3Dlinux,GUEST_VER=3D2.6"
-	.ascii	",XEN_VER=3Dxen-3.0"
-	.ascii	",VIRT_BASE=3D0x"
-		utoa __PAGE_OFFSET
-	.ascii	",ELF_PADDR_OFFSET=3D0x0"
-	.ascii	",VIRT_ENTRY=3D0x"
-		utoa (__PAGE_OFFSET + __PHYSICAL_START + VIRT_ENTRY_OFFSET)
-	.ascii	",HYPERCALL_PAGE=3D0x"
-		utoa ((__PHYSICAL_START+HYPERCALL_PAGE_OFFSET)>>PAGE_SHIFT)
-	.ascii	",FEATURES=3D!writable_page_tables"
-	.ascii		 "|!auto_translated_physmap"
-#ifdef CONFIG_X86_PAE
-	.ascii	",PAE=3Dyes"
-#else
-	.ascii	",PAE=3Dno"
-#endif
-	.ascii	",LOADER=3Dgeneric"
-	.byte	0
-.previous
-
 	ELFNOTE(Xen, XEN_ELFNOTE_GUEST_OS,       .asciz, "linux")
 	ELFNOTE(Xen, XEN_ELFNOTE_GUEST_VERSION,  .asciz, "2.6")
 	ELFNOTE(Xen, XEN_ELFNOTE_XEN_VERSION,    .asciz, "xen-3.0")

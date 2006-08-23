From: Ian Campbell <Ian.Campbell@xensource.com>
Subject: [PATCH 3/5] XEN: Update ELF notes to xen-head.S to the new interface
Date: Wed, 23 Aug 2006 16:09:39 +0100
Message-ID: <1156345779.12949.125.camel@localhost.localdomain>
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

Again pretty self explanatory. Should be merged into 024-head.patch

Signed-off-by: Ian Campbell <ian.campbell@xensource.com>

diff -r bc6940cd08ed arch/i386/paravirt-xen/xen-head.S
--- a/arch/i386/paravirt-xen/xen-head.S	Wed Aug 23 15:12:48 2006 +0100
+++ b/arch/i386/paravirt-xen/xen-head.S	Wed Aug 23 15:14:47 2006 +0100
@@ -2,6 +2,7 @@
 	place in head.S */
 =

 #include <linux/elfnote.h>
+#include <xen/interface/elfnote.h>
 	=

 #define VIRT_ENTRY_OFFSET	0x1000
 .org VIRT_ENTRY_OFFSET
@@ -56,19 +57,16 @@ ENTRY(hypercall_page)
 	.byte	0
 .previous
 =

-#define XEN_INFO	0	/* name=3Dvalue pair */
-#define XEN_ENTRY	1	/* entrypoint */
-#define XEN_HYPERCALL	2	/* hypercall page address (not pfn)	 */
-	=

-	ELFNOTE "Xen", XEN_INFO,	.asciz "GUEST_OS=3Dlinux"
-	ELFNOTE "Xen", XEN_INFO,	.asciz "GUEST_VER=3D2.6"
-	ELFNOTE "Xen", XEN_INFO,	.asciz "XEN_VER=3Dxen-3.0"
-	ELFNOTE "Xen", XEN_ENTRY,	.long startup_xen
-	ELFNOTE "Xen", XEN_HYPERCALL,	.long hypercall_page
-	ELFNOTE "Xen", XEN_INFO,	.asciz "FEATURES=3D!writable_page_tables|!auto_t=
ranslated_physmap"
+	ELFNOTE(Xen, XEN_ELFNOTE_GUEST_OS,       .asciz, "linux")
+	ELFNOTE(Xen, XEN_ELFNOTE_GUEST_VERSION,  .asciz, "2.6")
+	ELFNOTE(Xen, XEN_ELFNOTE_XEN_VERSION,    .asciz, "xen-3.0")
+	ELFNOTE(Xen, XEN_ELFNOTE_VIRT_BASE,      .long,  __PAGE_OFFSET)
+	ELFNOTE(Xen, XEN_ELFNOTE_ENTRY,          .long,  startup_xen)
+	ELFNOTE(Xen, XEN_ELFNOTE_HYPERCALL_PAGE, .long,  hypercall_page)
+	ELFNOTE(Xen, XEN_ELFNOTE_FEATURES,       .asciz, "!writable_page_tables|!=
auto_translated_physmap")
 #ifdef CONFIG_X86_PAE
-	ELFNOTE "Xen", XEN_INFO,	.asciz "PAE=3Dyes"
+	ELFNOTE(Xen, XEN_ELFNOTE_PAE_MODE,       .asciz, "yes")
 #else
-	ELFNOTE "Xen", XEN_INFO,	.asciz "PAE=3Dno"
+	ELFNOTE(Xen, XEN_ELFNOTE_PAE_MODE,       .asciz, "no")
 #endif
-	ELFNOTE "Xen", XEN_INFO,	.asciz "LOADER=3Dgeneric"
+	ELFNOTE(Xen, XEN_ELFNOTE_LOADER,         .asciz, "generic")

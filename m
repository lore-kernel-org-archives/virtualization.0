From: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
Subject: [PATCH] Xen i386 xen-head.S fix sections mixup (updated)
Date: Mon, 20 Aug 2007 13:19:12 -0400
Message-ID: <20070820171912.GB9478@Krystal>
References: <20070820030420.GA11070@Krystal> <46C9311D.2030702@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <xen-devel-bounces@lists.xensource.com>
Content-Disposition: inline
In-Reply-To: <46C9311D.2030702@goop.org>
List-Unsubscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: chrisw@sous-sol.org, virtualization@lists.osdl.org, Andrew Morton <akpm@linux-foundation.org>, xen-devel@lists.xensource.com, jeremy@xensource.com
List-Id: virtualization@lists.linuxfoundation.org

Xen i386 xen-head.S fix sections mixup

xen-head.S does not come back to the data section, leaving the text section
as current section. It causes problems with a slightly enhanced DEBUG_RODATA
that supports CONFIG_HOTPLUG and bringing a CPU up after the text has been
marked read-only: reference to early_gdt_descr causes a page fault.

Update:

It should be using pushsection/popsection.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
CC: jeremy@xensource.com
CC: chrisw@sous-sol.org
CC: virtualization@lists.osdl.org
CC: xen-devel@lists.xensource.com
---
 arch/i386/xen/xen-head.S |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

Index: linux-2.6-lttng/arch/i386/xen/xen-head.S
===================================================================
--- linux-2.6-lttng.orig/arch/i386/xen/xen-head.S	2007-08-20 00:22:16.000000000 -0400
+++ linux-2.6-lttng/arch/i386/xen/xen-head.S	2007-08-20 13:02:38.000000000 -0400
@@ -7,20 +7,21 @@
 #include <asm/boot.h>
 #include <xen/interface/elfnote.h>
 
-	.section .init.text
+.pushsection .init.text
 ENTRY(startup_xen)
 	movl %esi,xen_start_info
 	cld
 	movl $(init_thread_union+THREAD_SIZE),%esp
 	jmp xen_start_kernel
+.popsection
 
-.pushsection ".bss.page_aligned"
+.pushsection .bss.page_aligned
 	.align PAGE_SIZE_asm
 ENTRY(hypercall_page)
 	.skip 0x1000
 .popsection
 
-	.section .text
+.pushsection .text
 	ELFNOTE(Xen, XEN_ELFNOTE_GUEST_OS,       .asciz "linux")
 	ELFNOTE(Xen, XEN_ELFNOTE_GUEST_VERSION,  .asciz "2.6")
 	ELFNOTE(Xen, XEN_ELFNOTE_XEN_VERSION,    .asciz "xen-3.0")
@@ -34,5 +35,6 @@ ENTRY(hypercall_page)
 	ELFNOTE(Xen, XEN_ELFNOTE_PAE_MODE,       .asciz "no")
 #endif
 	ELFNOTE(Xen, XEN_ELFNOTE_LOADER,         .asciz "generic")
+.popsection
 
 #endif /*CONFIG_XEN */

-- 
Mathieu Desnoyers
Computer Engineering Ph.D. Student, Ecole Polytechnique de Montreal
OpenPGP key fingerprint: 8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68

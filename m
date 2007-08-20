From: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
Subject: [PATCH] Xen i386 xen-head.S fix sections mixup
Date: Sun, 19 Aug 2007 23:04:20 -0400
Message-ID: <20070820030420.GA11070@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Andrew Morton <akpm@linux-foundation.org>, jeremy@xensource.com, chrisw@sous-sol.org
Cc: virtualization@lists.osdl.org, xen-devel@lists.xensource.com
List-Id: virtualization@lists.linuxfoundation.org

Xen i386 xen-head.S fix sections mixup

xen-head.S does not come back to the data section, leaving the text section
as current section. It causes problems with a slightly enhanced DEBUG_RODATA
that supports CONFIG_HOTPLUG and bringing a CPU up after the text has been
marked read-only: reference to early_gdt_descr causes a page fault.

It applies on 2.6.22-rc2-mm2.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
CC: jeremy@xensource.com
CC: chrisw@sous-sol.org
CC: virtualization@lists.osdl.org
CC: xen-devel@lists.xensource.com
---
 arch/i386/xen/xen-head.S |    2 ++
 1 file changed, 2 insertions(+)

Index: linux-2.6-lttng/arch/i386/xen/xen-head.S
===================================================================
--- linux-2.6-lttng.orig/arch/i386/xen/xen-head.S	2007-08-19 22:45:58.000000000 -0400
+++ linux-2.6-lttng/arch/i386/xen/xen-head.S	2007-08-19 22:46:19.000000000 -0400
@@ -13,6 +13,7 @@ ENTRY(startup_xen)
 	cld
 	movl $(init_thread_union+THREAD_SIZE),%esp
 	jmp xen_start_kernel
+	.previous
 
 .pushsection ".bss.page_aligned"
 	.align PAGE_SIZE_asm
@@ -34,5 +35,6 @@ ENTRY(hypercall_page)
 	ELFNOTE(Xen, XEN_ELFNOTE_PAE_MODE,       .asciz "no")
 #endif
 	ELFNOTE(Xen, XEN_ELFNOTE_LOADER,         .asciz "generic")
+	.previous
 
 #endif /*CONFIG_XEN */

-- 
Mathieu Desnoyers
Computer Engineering Ph.D. Student, Ecole Polytechnique de Montreal
OpenPGP key fingerprint: 8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68

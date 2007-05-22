From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: [patch 02/33] xen: paravirt: add a hook for once the
	allocator is ready
Date: Tue, 22 May 2007 15:09:43 +0100
Message-ID: <20070522141250.930553805@goop.org>
References: <20070522140941.802382212@goop.org>
Return-path: <xen-devel-bounces@lists.xensource.com>
Content-Disposition: inline; filename=paravirt-add-post_allocator_init.patch
List-Unsubscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: Andrew Morton <akpm@linux-foundation.org>, Andi Kleen <ak@suse.de>
Cc: Chris Wright <chrisw@sous-sol.org>, virtualization@lists.osdl.org, Xen-devel <xen-devel@lists.xensource.com>, Linus Torvalds <torvalds@linux-foundation.org>, lkml <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

Add a hook so that the paravirt backend knows when the allocator is
ready.  This is useful for the obvious reason that the allocator is
available, but the other side-effect of having the bootmem allocator
available is that each page now has an associated "struct page".

Signed-off-by: Jeremy Fitzhardinge <jeremy@xensource.com>

---
 arch/i386/kernel/setup.c    |    2 ++
 include/asm-i386/paravirt.h |    8 ++++++++
 include/asm-i386/setup.h    |    4 ++++
 3 files changed, 14 insertions(+)

===================================================================
--- a/arch/i386/kernel/setup.c
+++ b/arch/i386/kernel/setup.c
@@ -611,6 +611,8 @@ void __init setup_arch(char **cmdline_p)
 	 * NOTE: at this point the bootmem allocator is fully available.
 	 */
 
+	paravirt_post_allocator_init();
+
 	dmi_scan_machine();
 
 #ifdef CONFIG_X86_GENERICARCH
===================================================================
--- a/include/asm-i386/paravirt.h
+++ b/include/asm-i386/paravirt.h
@@ -52,6 +52,8 @@ struct paravirt_ops
 	/* Basic arch-specific setup */
 	void (*arch_setup)(void);
 	char *(*memory_setup)(void);
+	void (*post_allocator_init)(void);
+
 	void (*init_IRQ)(void);
 	void (*time_init)(void);
 
@@ -669,6 +671,12 @@ static inline void setup_secondary_clock
 }
 #endif
 
+static inline void paravirt_post_allocator_init(void)
+{
+	if (paravirt_ops.post_allocator_init)
+		(*paravirt_ops.post_allocator_init)();
+}
+
 static inline void paravirt_pagetable_setup_start(pgd_t *base)
 {
 	if (paravirt_ops.pagetable_setup_start)
===================================================================
--- a/include/asm-i386/setup.h
+++ b/include/asm-i386/setup.h
@@ -79,6 +79,10 @@ void __init add_memory_region(unsigned l
 
 extern unsigned long init_pg_tables_end;
 
+#ifndef CONFIG_PARAVIRT
+#define paravirt_post_allocator_init()	do {} while(0)
+#endif
+
 #endif /* __ASSEMBLY__ */
 
 #endif  /*  __KERNEL__  */

-- 

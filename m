From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: Next steps with pv_ops for Xen
Date: Wed, 21 Nov 2007 15:12:20 -0800
Message-ID: <4744BB54.4040803@goop.org>
References: <1195682725.6726.48.camel@sisko.scot.redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------090202060205000703060608"
Return-path: <xen-devel-bounces@lists.xensource.com>
In-Reply-To: <1195682725.6726.48.camel@sisko.scot.redhat.com>
List-Unsubscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: "Stephen C. Tweedie" <sct@redhat.com>
Cc: "xen-devel@lists.xensource.com" <xen-devel@lists.xensource.com>, Eduardo Habkost <ehabkost@redhat.com>, Juan Quintela <quintela@redhat.com>, Jan Beulich <jbeulich@novell.com>, Glauber de Oliveira Costa <gcosta@redhat.com>, Chris Wright <chrisw@sous-sol.org>, "virtualization@lists.osdl.org" <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

This is a multi-part message in MIME format.
--------------090202060205000703060608
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

Stephen C. Tweedie wrote:
> I've been looking at the next steps to try to get Xen running fully on
> top of pv_ops.  To that end, I've (just) started looking at one of the
> next major jobs --- i686 dom0 on pv_ops.
>   

Great!

> There are still a number of things needing done to reach parity with
> xen-unstable:
>
>   x86_64 xen on pv_ops
>   

I think once pvops has been unified, Xen support should be fairly
straightforward.  I wrote most of the existing code with 64-bit in mind,
so I'm hoping I got it right...

>   Paravirt framebuffer/keyboard
>   CPU hotplug
>   Balloon
>   

I've done some preliminary work on balloon and hotplug.  I think balloon
should make more use of memory hotplug, but a straight port would be a
good first step.

>   kexec
>   driver domains
>
> but it looks like these can largely proceed in parallel if desired.
>
> My short-term goal with this is simply to come up with a first-pass
> merge of the linux-2.6.18-xen.hg dom0 support into the current
> kernel.org tree's pv_ops support.  No major refactoring in the first
> pass, but absolutely no *-xen.c code copying.
>   

Yes.  #ifdefs are the way to go here.

> I'm just starting this, but at least with the version magic check (see
>
> 	http://lists.xensource.com/archives/html/xen-devel/2007-11/msg00601.html
>   

I was just about to post a fix for this.

> ) out of the way, an SMP dom0 running pv_ops gets all the way through
> start_kernel() and into rest_init() before dying with an unsupported cr0
> write.  (I'm using direct console hypercalls for printk for now, full
> xencons is not working yet.)
>   

I have some early dom0 patches already, though they're a few months old
now.  Not much there, but I did do an early console implementation.

> I'm happy to put up a git tree for this once it gets anywhere.  We'd
> need to decide which tree to track for that purpose --- Linus's, or
> perhaps the tglx or mingo x86 merge tree might make more sense.
>   

Yes, I think the x86 tree is where we need to be, since there's a lot of
activity there.

I'll attach my dom0 patches for whatever use you can make of them.  The
definitely won't apply to anything, not least because of the arch merge
(though it looks like they did get converted by script), but also
because they're based on some defunct experimental booting-from-bzImage
patches.  But perhaps there's some useful stuff in there.

I've also attached my xen-balloon and hotplug patches as-is.  They don't
work completely, but they should be closer to applying.

    J

--------------090202060205000703060608
Content-Type: text/x-patch;
 name="xen-dom0-boot.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="xen-dom0-boot.patch"

---
 arch/x86/boot/compressed/notes-xen.c |   16 ---------
 arch/x86/xen/Makefile                |    2 -
 arch/x86/xen/early.c                 |    5 +-
 arch/x86/xen/enlighten.c             |    4 +-
 arch/x86/xen/legacy_boot.c           |   60 ++++++++++++++++++++++++++++++++++
 arch/x86/xen/notes.c                 |   19 ++++++++++
 arch/x86/xen/xen-ops.h               |    3 +
 7 files changed, 89 insertions(+), 20 deletions(-)

===================================================================
--- a/arch/x86/boot/compressed/notes-xen.c
+++ b/arch/x86/boot/compressed/notes-xen.c
@@ -1,17 +1,3 @@
 #ifdef CONFIG_XEN
-#include <linux/elfnote.h>
-#include <xen/interface/elfnote.h>
-
-ELFNOTE("Xen", XEN_ELFNOTE_GUEST_OS,       "linux");
-ELFNOTE("Xen", XEN_ELFNOTE_GUEST_VERSION,  "2.6");
-ELFNOTE("Xen", XEN_ELFNOTE_XEN_VERSION,    "xen-3.0");
-ELFNOTE("Xen", XEN_ELFNOTE_FEATURES,
-	"!writable_page_tables|pae_pgdir_above_4gb");
-ELFNOTE("Xen", XEN_ELFNOTE_LOADER,         "generic");
-
-#ifdef CONFIG_X86_PAE
-	ELFNOTE("Xen", XEN_ELFNOTE_PAE_MODE,       "yes");
-#else
-	ELFNOTE("Xen", XEN_ELFNOTE_PAE_MODE,       "no");
+#include "../../xen/notes.c"
 #endif
-#endif
===================================================================
--- a/arch/x86/xen/Makefile
+++ b/arch/x86/xen/Makefile
@@ -1,4 +1,4 @@ obj-y		:= early.o enlighten.o setup.o fe
 obj-y		:= early.o enlighten.o setup.o features.o multicalls.o mmu.o \
-			events.o time.o manage.o xen-asm.o
+			events.o time.o manage.o xen-asm.o notes.o legacy_boot.o
 
 obj-$(CONFIG_SMP)	+= smp.o
===================================================================
--- a/arch/x86/xen/early.c
+++ b/arch/x86/xen/early.c
@@ -50,7 +50,7 @@ static __init unsigned long early_m2p(un
 	return ret;
 }
 
-static __init void setup_hypercall_page(struct start_info *info)
+__init void xen_setup_hypercall_page(struct start_info *info)
 {
 	unsigned long *mfn_list = (unsigned long *)info->mfn_list;
 	unsigned eax, ebx, ecx, edx;
@@ -183,7 +183,7 @@ void __init xen_entry(void)
 	BUG_ON(memcmp(info->magic, PA(&"xen-3.0"), 7) != 0);
 
 	/* establish a hypercall page */
-	setup_hypercall_page(info);
+	xen_setup_hypercall_page(info);
 
 	/* work out how far we need to remap */
 	limit = __pa(_end);
@@ -203,6 +203,7 @@ void __init xen_entry(void)
 	/* repoint things to their new virtual addresses */
 	info->pt_base = (unsigned long)__va(info->pt_base);
 	info->mfn_list = (unsigned long)__va(info->mfn_list);
+	boot_params.hdr.hardware_subarch_data = (unsigned long)__va(info);
 
 	init_pg_tables_end = limit;
 
===================================================================
--- a/arch/x86/xen/enlighten.c
+++ b/arch/x86/xen/enlighten.c
@@ -1106,8 +1106,8 @@ void __init xen_start_kernel(void)
 {
 	pgd_t *pgd;
 
-	xen_start_info = (struct start_info *)
-		__va(boot_params.hdr.hardware_subarch_data);
+	xen_start_info = (struct start_info *)(unsigned long)
+		boot_params.hdr.hardware_subarch_data;
 
 	/* Get mfn list */
 	phys_to_machine_mapping = (unsigned long *)xen_start_info->mfn_list;
===================================================================
--- /dev/null
+++ b/arch/x86/xen/legacy_boot.c
@@ -0,0 +1,60 @@
+/*
+ * Notes and setup needed for legacy booting.  This is used either
+ * when loading a domU with vmlinux directly, or for booting
+ * dom0. Normally we'd expect to be booted via the normal boot
+ * protocol.
+ */
+#include <linux/sched.h>
+#include <linux/elfnote.h>
+#include <linux/linkage.h>
+#include <linux/init.h>
+
+#include <asm/setup.h>
+#include <asm/page.h>
+#include <asm/bootparam.h>
+
+#include <xen/interface/xen.h>
+#include <xen/interface/elfnote.h>
+
+#include "xen-ops.h"
+
+extern void xen_legacy_entry(void *);
+
+/* Extra notes needed to set the xen-specific
+   entrypoint and virtual offset */
+ELFNOTE("Xen", XEN_ELFNOTE_ENTRY,		&xen_legacy_entry);
+ELFNOTE("Xen", XEN_ELFNOTE_VIRT_BASE,		PAGE_OFFSET);
+
+static __init __used fastcall void xen_legacy_setup(struct start_info *info)
+{
+	memset(&boot_params, 0, sizeof(boot_params));
+
+	boot_params.hdr.type_of_loader = 0x90;	/* xen */
+
+	boot_params.hdr.hardware_subarch = 2;	/* xen */
+	boot_params.hdr.hardware_subarch_data = (unsigned long)info;
+
+	boot_params.hdr.ramdisk_image = info->mod_start;
+	boot_params.hdr.ramdisk_size = info->mod_len;
+
+	boot_params.hdr.cmd_line_ptr = (unsigned long)info->cmd_line;
+	boot_params.hdr.cmdline_size = sizeof(info->cmd_line);
+
+	xen_setup_hypercall_page(info);
+
+	/* jump to xen_start_kernel with appropriate stack */
+	asm volatile("mov %0,%%esp;"
+		     "push $0;"
+		     "jmp xen_start_kernel"
+		     :
+		     : "i" (&init_thread_union.stack[THREAD_SIZE/sizeof(long)])
+		     : "memory");
+}
+
+
+asm(".section \".init.text\",\"ax\",@progbits	\n"
+    ".globl xen_legacy_entry			\n"
+    "xen_legacy_entry:				\n"
+    "	mov %esi, %eax				\n"
+    "	jmp xen_legacy_setup			\n"
+    ".previous");
===================================================================
--- /dev/null
+++ b/arch/x86/xen/notes.c
@@ -0,0 +1,19 @@
+/*
+ * Common ELF notes needed for all Xen kernel images
+ */
+#include <linux/elfnote.h>
+#include <xen/interface/elfnote.h>
+
+ELFNOTE("Xen", XEN_ELFNOTE_GUEST_OS,		"linux");
+ELFNOTE("Xen", XEN_ELFNOTE_GUEST_VERSION,	"2.6");
+ELFNOTE("Xen", XEN_ELFNOTE_XEN_VERSION,		"xen-3.0");
+ELFNOTE("Xen", XEN_ELFNOTE_FEATURES,
+	"!writable_page_tables|pae_pgdir_above_4gb");
+ELFNOTE("Xen", XEN_ELFNOTE_LOADER,		"generic");
+
+#ifdef CONFIG_X86_PAE
+	ELFNOTE("Xen", XEN_ELFNOTE_PAE_MODE,	"yes");
+#else
+	ELFNOTE("Xen", XEN_ELFNOTE_PAE_MODE,	"no");
+#endif
+
===================================================================
--- a/arch/x86/xen/xen-ops.h
+++ b/arch/x86/xen/xen-ops.h
@@ -2,10 +2,13 @@
 #define XEN_OPS_H
 
 #include <linux/init.h>
+#include <linux/percpu.h>
 
 /* These are code, but not functions.  Defined in entry.S */
 extern const char xen_hypervisor_callback[];
 extern const char xen_failsafe_callback[];
+
+void xen_setup_hypercall_page(struct start_info *info);
 
 void xen_copy_trap_info(struct trap_info *traps);
 

--------------090202060205000703060608
Content-Type: text/x-patch;
 name="xen-dom0-xenbus.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="xen-dom0-xenbus.patch"

---
 drivers/xen/xenbus/xenbus_probe.c |   30 +++++++++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

===================================================================
--- a/drivers/xen/xenbus/xenbus_probe.c
+++ b/drivers/xen/xenbus/xenbus_probe.c
@@ -786,6 +786,7 @@ static int __init xenbus_probe_init(void
 static int __init xenbus_probe_init(void)
 {
 	int err = 0;
+	unsigned long page = 0;
 
 	DPRINTK("");
 
@@ -806,7 +807,31 @@ static int __init xenbus_probe_init(void
 	 * Domain0 doesn't have a store_evtchn or store_mfn yet.
 	 */
 	if (is_initial_xendomain()) {
-		/* dom0 not yet supported */
+		struct evtchn_alloc_unbound alloc_unbound;
+
+		/* Allocate page. */
+		page = get_zeroed_page(GFP_KERNEL);
+		if (!page)
+			return -ENOMEM;
+
+		xen_store_mfn = xen_start_info->store_mfn =
+			pfn_to_mfn(virt_to_phys((void *)page) >>
+				   PAGE_SHIFT);
+
+		/* Next allocate a local port which xenstored can bind to */
+		alloc_unbound.dom        = DOMID_SELF;
+		alloc_unbound.remote_dom = 0;
+
+		err = HYPERVISOR_event_channel_op(EVTCHNOP_alloc_unbound,
+						  &alloc_unbound);
+		if (err == -ENOSYS)
+			goto out_unreg_front;
+
+		BUG_ON(err);
+		xen_store_evtchn = xen_start_info->store_evtchn =
+			alloc_unbound.port;
+
+		xen_store_interface = mfn_to_virt(xen_store_mfn);
 	} else {
 		xenstored_ready = 1;
 		xen_store_evtchn = xen_start_info->store_evtchn;
@@ -834,6 +859,9 @@ static int __init xenbus_probe_init(void
 	bus_unregister(&xenbus_frontend.bus);
 
   out_error:
+	if (page != 0)
+		free_page(page);
+
 	return err;
 }
 

--------------090202060205000703060608
Content-Type: text/x-patch;
 name="xen-dom0-ide.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="xen-dom0-ide.patch"

---
 arch/x86/mm/ioremap_32.c |    3 ---
 arch/x86/xen/enlighten.c |   20 ++++++++++++++++++++
 arch/x86/xen/setup.c     |    3 ++-
 include/asm-x86/io_32.h  |    4 ++++
 4 files changed, 26 insertions(+), 4 deletions(-)

===================================================================
--- a/arch/x86/mm/ioremap_32.c
+++ b/arch/x86/mm/ioremap_32.c
@@ -18,9 +18,6 @@
 #include <asm/tlbflush.h>
 #include <asm/pgtable.h>
 
-#define ISA_START_ADDRESS	0xa0000
-#define ISA_END_ADDRESS		0x100000
-
 /*
  * Generic mapping function (not visible outside):
  */
===================================================================
--- a/arch/x86/xen/enlighten.c
+++ b/arch/x86/xen/enlighten.c
@@ -45,6 +45,7 @@
 #include <asm/smp.h>
 #include <asm/tlbflush.h>
 #include <asm/reboot.h>
+#include <asm/io.h>
 
 #include "xen-ops.h"
 #include "mmu.h"
@@ -826,6 +827,19 @@ static __init void xen_pagetable_setup_d
 		if (HYPERVISOR_mmuext_op(&op, 1, NULL, DOMID_SELF))
 			BUG();
 	}
+
+	/*
+	 * If we're dom0, then 1:1 map the ISA machine addresses into
+	 * the kernel's address space.
+	 */
+	if (is_initial_xendomain()) {
+		unsigned i;
+
+		for(i = ISA_START_ADDRESS; i < ISA_END_ADDRESS; i += PAGE_SIZE)
+			set_pte_mfn(PAGE_OFFSET + i, PFN_DOWN(i), PAGE_KERNEL);
+
+		reserve_bootmem(ISA_START_ADDRESS, ISA_END_ADDRESS - ISA_START_ADDRESS);
+	}
 }
 
 /* This is called once we have the cpu_possible_map */
@@ -1144,6 +1158,12 @@ void __init xen_start_kernel(void)
 	if (xen_feature(XENFEAT_supervisor_mode_kernel))
 		paravirt_ops.kernel_rpl = 0;
 
+	if (is_initial_xendomain()) {
+		struct physdev_set_iopl set_iopl;
+		set_iopl.iopl = 1;
+		HYPERVISOR_physdev_op(PHYSDEVOP_set_iopl, &set_iopl);
+	}
+
 	/* set the limit of our address space */
 	xen_reserve_top();
 
===================================================================
--- a/arch/x86/xen/setup.c
+++ b/arch/x86/xen/setup.c
@@ -92,5 +92,6 @@ void __init xen_arch_setup(void)
 	xen_fill_possible_map();
 #endif
 
-	paravirt_disable_iospace();
+	if (!is_initial_xendomain())
+		paravirt_disable_iospace();
 }
===================================================================
--- a/include/asm-x86/io_32.h
+++ b/include/asm-x86/io_32.h
@@ -135,6 +135,10 @@ extern void __iomem *fix_ioremap(unsigne
 #define dmi_ioremap bt_ioremap
 #define dmi_iounmap bt_iounmap
 #define dmi_alloc alloc_bootmem
+
+
+#define ISA_START_ADDRESS	0xa0000
+#define ISA_END_ADDRESS		0x100000
 
 /*
  * ISA I/O bus memory addresses are 1:1 with the physical address.

--------------090202060205000703060608
Content-Type: text/x-patch;
 name="xen-dom0-console.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="xen-dom0-console.patch"

---
 arch/x86/xen/events.c  |    2 -
 drivers/char/hvc_xen.c |   61 +++++++++++++++++++++++++++++++++++++++++-------
 include/xen/events.h   |    2 +
 3 files changed, 56 insertions(+), 9 deletions(-)

===================================================================
--- a/arch/x86/xen/events.c
+++ b/arch/x86/xen/events.c
@@ -308,7 +308,7 @@ static int bind_ipi_to_irq(unsigned int 
 }
 
 
-static int bind_virq_to_irq(unsigned int virq, unsigned int cpu)
+int bind_virq_to_irq(unsigned int virq, unsigned int cpu)
 {
 	struct evtchn_bind_virq bind_virq;
 	int evtchn, irq;
===================================================================
--- a/drivers/char/hvc_xen.c
+++ b/drivers/char/hvc_xen.c
@@ -50,7 +50,7 @@ static inline void notify_daemon(void)
 	notify_remote_via_evtchn(xen_start_info->console.domU.evtchn);
 }
 
-static int write_console(uint32_t vtermno, const char *data, int len)
+static int domU_write_console(uint32_t vtermno, const char *data, int len)
 {
 	struct xencons_interface *intf = xencons_interface();
 	XENCONS_RING_IDX cons, prod;
@@ -71,7 +71,28 @@ static int write_console(uint32_t vtermn
 	return sent;
 }
 
-static int read_console(uint32_t vtermno, char *buf, int len)
+static int dom0_write_console(uint32_t vtermno, const char *data, int len)
+{
+	int ret;
+
+	ret = HYPERVISOR_console_io(CONSOLEIO_write, len, (char *)data);
+
+	return ret < 0 ? 0 : len;
+}
+
+static int write_console(uint32_t vtermno, const char *data, int len)
+{
+	int ret;
+
+	if (is_initial_xendomain())
+		ret = dom0_write_console(vtermno, data, len);
+	else
+		ret = domU_write_console(vtermno, data, len);
+
+	return ret;
+}
+
+static int domU_read_console(uint32_t vtermno, char *buf, int len)
 {
 	struct xencons_interface *intf = xencons_interface();
 	XENCONS_RING_IDX cons, prod;
@@ -92,22 +113,40 @@ static int read_console(uint32_t vtermno
 	return recv;
 }
 
-static struct hv_ops hvc_ops = {
-	.get_chars = read_console,
-	.put_chars = write_console,
+static int dom0_read_console(uint32_t vtermno, char *buf, int len)
+{
+	return HYPERVISOR_console_io(CONSOLEIO_read, len, buf);
+}
+
+static struct hv_ops domU_hvc_ops = {
+	.get_chars = domU_read_console,
+	.put_chars = domU_write_console,
+};
+
+static struct hv_ops dom0_hvc_ops = {
+	.get_chars = dom0_read_console,
+	.put_chars = dom0_write_console,
 };
 
 static int __init xen_init(void)
 {
 	struct hvc_struct *hp;
+	struct hv_ops *ops;
 
 	if (!is_running_on_xen())
 		return 0;
 
-	xencons_irq = bind_evtchn_to_irq(xen_start_info->console.domU.evtchn);
+	if (is_initial_xendomain()) {
+		ops = &dom0_hvc_ops;
+		xencons_irq = bind_virq_to_irq(VIRQ_CONSOLE, smp_processor_id());
+	} else {
+		ops = &domU_hvc_ops;
+		xencons_irq = bind_evtchn_to_irq(xen_start_info->console.domU.evtchn);
+	}
+
 	if (xencons_irq < 0)
 		xencons_irq = 0 /* NO_IRQ */;
-	hp = hvc_alloc(HVC_COOKIE, xencons_irq, &hvc_ops, 256);
+	hp = hvc_alloc(HVC_COOKIE, xencons_irq, ops, 256);
 	if (IS_ERR(hp))
 		return PTR_ERR(hp);
 
@@ -123,10 +162,16 @@ static void __exit xen_fini(void)
 
 static int xen_cons_init(void)
 {
+	struct hv_ops *ops;
+
 	if (!is_running_on_xen())
 		return 0;
 
-	hvc_instantiate(HVC_COOKIE, 0, &hvc_ops);
+	ops = &domU_hvc_ops;
+	if (is_initial_xendomain())
+		ops = &dom0_hvc_ops;
+
+	hvc_instantiate(HVC_COOKIE, 0, ops);
 	return 0;
 }
 
===================================================================
--- a/include/xen/events.h
+++ b/include/xen/events.h
@@ -18,6 +18,8 @@ int bind_evtchn_to_irqhandler(unsigned i
 			      irq_handler_t handler,
 			      unsigned long irqflags, const char *devname,
 			      void *dev_id);
+int bind_virq_to_irq(unsigned int virq, unsigned int cpu);
+
 int bind_virq_to_irqhandler(unsigned int virq, unsigned int cpu,
 			    irq_handler_t handler,
 			    unsigned long irqflags, const char *devname,

--------------090202060205000703060608
Content-Type: text/x-patch;
 name="xen-dom0-set_fixmap.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="xen-dom0-set_fixmap.patch"

---
 arch/x86/kernel/paravirt_32.c |    2 ++
 arch/x86/mm/pgtable_32.c      |   16 ++++++++++------
 arch/x86/xen/enlighten.c      |   41 +++++++++++++++++++++++++++++++++++++----
 arch/x86/xen/mmu.c            |   30 +-----------------------------
 include/asm-x86/fixmap_32.h   |   13 +++++++++++--
 include/asm-x86/paravirt.h    |   13 +++++++++++++
 include/asm-x86/pgtable_32.h  |    3 +++
 7 files changed, 77 insertions(+), 41 deletions(-)

===================================================================
--- a/arch/x86/kernel/paravirt_32.c
+++ b/arch/x86/kernel/paravirt_32.c
@@ -377,6 +377,8 @@ struct paravirt_ops paravirt_ops = {
 	.dup_mmap = paravirt_nop,
 	.exit_mmap = paravirt_nop,
 	.activate_mm = paravirt_nop,
+
+	.set_fixmap = native_set_fixmap,
 };
 
 EXPORT_SYMBOL(paravirt_ops);
===================================================================
--- a/arch/x86/mm/pgtable_32.c
+++ b/arch/x86/mm/pgtable_32.c
@@ -73,7 +73,7 @@ void show_mem(void)
  * Associate a virtual page frame with a given physical page frame 
  * and protection flags for that frame.
  */ 
-static void set_pte_pfn(unsigned long vaddr, unsigned long pfn, pgprot_t flags)
+void set_pte_vaddr(unsigned long vaddr, pte_t pteval)
 {
 	pgd_t *pgd;
 	pud_t *pud;
@@ -96,9 +96,8 @@ static void set_pte_pfn(unsigned long va
 		return;
 	}
 	pte = pte_offset_kernel(pmd, vaddr);
-	if (pgprot_val(flags))
-		/* <pfn,flags> stored as-is, to permit clearing entries */
-		set_pte(pte, pfn_pte(pfn, flags));
+	if (pte_val(pteval))
+		set_pte_at(&init_mm, vaddr, pte, pteval);
 	else
 		pte_clear(&init_mm, vaddr, pte);
 
@@ -148,7 +147,7 @@ unsigned long __FIXADDR_TOP = 0xfffff000
 unsigned long __FIXADDR_TOP = 0xfffff000;
 EXPORT_SYMBOL(__FIXADDR_TOP);
 
-void __set_fixmap (enum fixed_addresses idx, unsigned long phys, pgprot_t flags)
+void __native_set_fixmap(enum fixed_addresses idx, pte_t pte)
 {
 	unsigned long address = __fix_to_virt(idx);
 
@@ -156,8 +155,13 @@ void __set_fixmap (enum fixed_addresses 
 		BUG();
 		return;
 	}
-	set_pte_pfn(address, phys >> PAGE_SHIFT, flags);
+	set_pte_vaddr(address, pte);
 	fixmaps++;
+}
+
+void native_set_fixmap(enum fixed_addresses idx, unsigned long phys, pgprot_t flags)
+{
+	__native_set_fixmap(idx, pfn_pte(phys >> PAGE_SHIFT, flags));
 }
 
 /**
===================================================================
--- a/arch/x86/xen/enlighten.c
+++ b/arch/x86/xen/enlighten.c
@@ -131,10 +131,12 @@ static void xen_cpuid(unsigned int *eax,
 	 * Mask out inconvenient features, to try and disable as many
 	 * unsupported kernel subsystems as possible.
 	 */
-	if (*eax == 1)
-		maskedx = ~((1 << X86_FEATURE_APIC) |  /* disable APIC */
-			    (1 << X86_FEATURE_ACPI) |  /* disable ACPI */
-			    (1 << X86_FEATURE_ACC));   /* thermal monitoring */
+	if (*eax == 1) {
+		maskedx = ~(1 << X86_FEATURE_APIC);  /* disable local APIC */
+		if (!is_initial_xendomain())
+			maskedx &= ~((1 << X86_FEATURE_ACPI) |  /* disable ACPI */
+				     (1 << X86_FEATURE_ACC));   /* thermal monitoring */
+	}
 
 	asm(XEN_EMULATE_PREFIX "cpuid"
 		: "=a" (*eax),
@@ -916,6 +918,35 @@ static unsigned xen_patch(u8 type, u16 c
 	return ret;
 }
 
+static void xen_set_fixmap(unsigned idx, unsigned long phys, pgprot_t prot)
+{
+	pte_t pte;
+
+	phys >>= PAGE_SHIFT;
+
+	switch (idx) {
+#ifdef CONFIG_X86_F00F_BUG
+	case FIX_F00F_IDT:
+#endif
+	case FIX_WP_TEST:
+	case FIX_VDSO:
+#ifdef CONFIG_X86_LOCAL_APIC
+	case FIX_APIC_BASE:	/* maps dummy local APIC */
+#endif
+		pte = pfn_pte(phys, prot);
+		break;
+
+	default:
+		pte = mfn_pte(phys, prot);
+		break;
+	}
+
+	printk("xen_set_fixmap: idx=%d phys=%lx prot=%lx\n",
+	       idx, phys, (unsigned long)pgprot_val(prot));
+
+	__native_set_fixmap(idx, pte);
+}
+
 static const struct paravirt_ops xen_paravirt_ops __initdata = {
 	.paravirt_enabled = 1,
 	.shared_kernel_pmd = 0,
@@ -1046,6 +1077,8 @@ static const struct paravirt_ops xen_par
 	.exit_mmap = xen_exit_mmap,
 
 	.set_lazy_mode = xen_set_lazy_mode,
+
+	.set_fixmap = xen_set_fixmap,
 };
 
 #ifdef CONFIG_SMP
===================================================================
--- a/arch/x86/xen/mmu.c
+++ b/arch/x86/xen/mmu.c
@@ -117,35 +117,7 @@ void xen_set_pmd(pmd_t *ptr, pmd_t val)
  */
 void set_pte_mfn(unsigned long vaddr, unsigned long mfn, pgprot_t flags)
 {
-	pgd_t *pgd;
-	pud_t *pud;
-	pmd_t *pmd;
-	pte_t *pte;
-
-	pgd = swapper_pg_dir + pgd_index(vaddr);
-	if (pgd_none(*pgd)) {
-		BUG();
-		return;
-	}
-	pud = pud_offset(pgd, vaddr);
-	if (pud_none(*pud)) {
-		BUG();
-		return;
-	}
-	pmd = pmd_offset(pud, vaddr);
-	if (pmd_none(*pmd)) {
-		BUG();
-		return;
-	}
-	pte = pte_offset_kernel(pmd, vaddr);
-	/* <mfn,flags> stored as-is, to permit clearing entries */
-	xen_set_pte(pte, mfn_pte(mfn, flags));
-
-	/*
-	 * It's enough to flush this one mapping.
-	 * (PGE mappings get flushed as well)
-	 */
-	__flush_tlb_one(vaddr);
+	set_pte_vaddr(vaddr, mfn_pte(mfn, flags));
 }
 
 void xen_set_pte_at(struct mm_struct *mm, unsigned long addr,
===================================================================
--- a/include/asm-x86/fixmap_32.h
+++ b/include/asm-x86/fixmap_32.h
@@ -98,8 +98,17 @@ enum fixed_addresses {
 	__end_of_fixed_addresses
 };
 
-extern void __set_fixmap (enum fixed_addresses idx,
-					unsigned long phys, pgprot_t flags);
+void __native_set_fixmap(enum fixed_addresses idx, pte_t pte);
+void native_set_fixmap(enum fixed_addresses idx,
+		       unsigned long phys, pgprot_t flags);
+
+#ifndef CONFIG_PARAVIRT
+static inline void __set_fixmap(enum fixed_addresses idx,
+				unsigned long phys, pgprot_t flags)
+{
+	native_set_fixmap(idx, phys, flags);
+}
+#endif
 extern void reserve_top_address(unsigned long reserve);
 
 #define set_fixmap(idx, phys) \
===================================================================
--- a/include/asm-x86/paravirt.h
+++ b/include/asm-x86/paravirt.h
@@ -222,6 +222,13 @@ struct paravirt_ops
 	/* These two are jmp to, not actually called. */
 	void (*irq_enable_sysexit)(void);
 	void (*iret)(void);
+
+	/* dom0 ops */
+
+	/* Sometimes the physical address is a pfn, and sometimes its
+	   an mfn.  We can tell which is which from the index. */
+	void (*set_fixmap)(unsigned /* enum fixed_addresses */ idx,
+			   unsigned long phys, pgprot_t flags);
 };
 
 extern struct paravirt_ops paravirt_ops;
@@ -931,6 +938,12 @@ static inline void arch_flush_lazy_mmu_m
 	PVOP_VCALL1(set_lazy_mode, PARAVIRT_LAZY_FLUSH);
 }
 
+static inline void __set_fixmap(unsigned /* enum fixed_addresses */ idx,
+				unsigned long phys, pgprot_t flags)
+{
+	paravirt_ops.set_fixmap(idx, phys, flags);
+}
+
 void _paravirt_nop(void);
 #define paravirt_nop	((void *)_paravirt_nop)
 
===================================================================
--- a/include/asm-x86/pgtable_32.h
+++ b/include/asm-x86/pgtable_32.h
@@ -522,6 +522,9 @@ void native_pagetable_setup_start(pgd_t 
 void native_pagetable_setup_start(pgd_t *base);
 void native_pagetable_setup_done(pgd_t *base);
 
+/* Install a pte for a particular vaddr in kernel space. */
+void set_pte_vaddr(unsigned long vaddr, pte_t pte);
+
 #ifndef CONFIG_PARAVIRT
 static inline void paravirt_pagetable_setup_start(pgd_t *base)
 {

--------------090202060205000703060608
Content-Type: text/x-patch;
 name="xen-signature-check.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="xen-signature-check.patch"

Subject: xen: relax signature check

Some versions of Xen 3.x set their magic number to "xen-3.[12]", so
relax the test to match them.

Signed-off-by: Jeremy Fitzhardinge <jeremy@xensource.com>

---
 arch/x86/xen/enlighten.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

===================================================================
--- a/arch/x86/xen/enlighten.c
+++ b/arch/x86/xen/enlighten.c
@@ -1131,7 +1131,7 @@ asmlinkage void __init xen_start_kernel(
 	if (!xen_start_info)
 		return;
 
-	BUG_ON(memcmp(xen_start_info->magic, "xen-3.0", 7) != 0);
+	BUG_ON(memcmp(xen_start_info->magic, "xen-3", 5) != 0);
 
 	/* Install Xen paravirt ops */
 	pv_info = xen_info;

--------------090202060205000703060608
Content-Type: text/x-patch;
 name="xen-balloon.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="xen-balloon.patch"

---
 drivers/Kconfig                |    2 
 drivers/xen/Kconfig            |   19 +
 drivers/xen/Makefile           |    2 
 drivers/xen/balloon.c          |  712 ++++++++++++++++++++++++++++++++++++++++
 include/xen/balloon.h          |   61 +++
 include/xen/interface/memory.h |   12 
 6 files changed, 800 insertions(+), 8 deletions(-)

===================================================================
--- a/drivers/Kconfig
+++ b/drivers/Kconfig
@@ -95,4 +95,6 @@ source "drivers/uio/Kconfig"
 source "drivers/uio/Kconfig"
 
 source "drivers/virtio/Kconfig"
+
+source "drivers/xen/Kconfig"
 endmenu
===================================================================
--- /dev/null
+++ b/drivers/xen/Kconfig
@@ -0,0 +1,19 @@
+config XEN_BALLOON
+	bool "Xen memory balloon driver"
+	depends on XEN
+	default y
+	help
+	  The balloon driver allows the Xen domain to request more memory from
+	  the system to expand the domain's memory allocation, or alternatively
+	  return unneeded memory to the system.
+
+config XEN_SCRUB_PAGES
+	bool "Scrub pages before returning them to system"
+	depends on XEN_BALLOON
+	default y
+	help
+	  Scrub pages before returning them to the system for reuse by
+	  other domains.  This makes sure that any confidential data
+	  is not accidentally visible to other domains.  Is it more
+	  secure, but slightly less efficient.
+	  If in doubt, say yes.
===================================================================
--- a/drivers/xen/Makefile
+++ b/drivers/xen/Makefile
@@ -1,2 +1,4 @@ obj-y	+= grant-table.o
 obj-y	+= grant-table.o
 obj-y	+= xenbus/
+
+obj-$(CONFIG_XEN_BALLOON) += balloon.o
===================================================================
--- /dev/null
+++ b/drivers/xen/balloon.c
@@ -0,0 +1,712 @@
+/******************************************************************************
+ * balloon.c
+ *
+ * Xen balloon driver - enables returning/claiming memory to/from Xen.
+ *
+ * Copyright (c) 2003, B Dragovic
+ * Copyright (c) 2003-2004, M Williamson, K Fraser
+ * Copyright (c) 2005 Dan M. Smith, IBM Corporation
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License version 2
+ * as published by the Free Software Foundation; or, when distributed
+ * separately from the Linux kernel or incorporated into other
+ * software packages, subject to the following license:
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this source file (the "Software"), to deal in the Software without
+ * restriction, including without limitation the rights to use, copy, modify,
+ * merge, publish, distribute, sublicense, and/or sell copies of the Software,
+ * and to permit persons to whom the Software is furnished to do so, subject to
+ * the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
+ * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+ * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
+ * IN THE SOFTWARE.
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/sched.h>
+#include <linux/errno.h>
+#include <linux/mm.h>
+#include <linux/bootmem.h>
+#include <linux/pagemap.h>
+#include <linux/highmem.h>
+#include <linux/mutex.h>
+#include <linux/highmem.h>
+#include <linux/list.h>
+#include <linux/sysdev.h>
+
+#include <asm/xen/hypervisor.h>
+#include <asm/page.h>
+#include <asm/pgalloc.h>
+#include <asm/pgtable.h>
+#include <asm/uaccess.h>
+#include <asm/tlb.h>
+
+#include <xen/interface/memory.h>
+#include <xen/balloon.h>
+#include <xen/xenbus.h>
+#include <xen/features.h>
+#include <xen/page.h>
+
+#define PAGES2KB(_p) ((_p)<<(PAGE_SHIFT-10))
+
+#define BALLOON_CLASS_NAME "memory"
+
+struct balloon_stats {
+	/* We aim for 'current allocation' == 'target allocation'. */
+	unsigned long current_pages;
+	unsigned long target_pages;
+	/* We may hit the hard limit in Xen. If we do then we remember it. */
+	unsigned long hard_limit;
+	/*
+	 * Drivers may alter the memory reservation independently, but they
+	 * must inform the balloon driver so we avoid hitting the hard limit.
+	 */
+	unsigned long driver_pages;
+	/* Number of pages in high- and low-memory balloons. */
+	unsigned long balloon_low;
+	unsigned long balloon_high;
+};
+
+static DEFINE_MUTEX(balloon_mutex);
+
+static struct sys_device balloon_sysdev;
+
+static int register_balloon(struct sys_device *sysdev);
+
+/*
+ * Protects atomic reservation decrease/increase against concurrent increases.
+ * Also protects non-atomic updates of current_pages and driver_pages, and
+ * balloon lists.
+ */
+static DEFINE_SPINLOCK(balloon_lock);
+
+static struct balloon_stats balloon_stats;
+
+/* We increase/decrease in batches which fit in a page */
+static unsigned long frame_list[PAGE_SIZE / sizeof(unsigned long)];
+
+/* VM /proc information for memory */
+extern unsigned long totalram_pages;
+
+#ifdef CONFIG_HIGHMEM
+extern unsigned long totalhigh_pages;
+#define inc_totalhigh_pages() (totalhigh_pages++)
+#define dec_totalhigh_pages() (totalhigh_pages--)
+#else
+#define inc_totalhigh_pages() do {} while(0)
+#define dec_totalhigh_pages() do {} while(0)
+#endif
+
+/* List of ballooned pages, threaded through the mem_map array. */
+static LIST_HEAD(ballooned_pages);
+
+/* Main work function, always executed in process context. */
+static void balloon_process(struct work_struct *work);
+static DECLARE_WORK(balloon_worker, balloon_process);
+static struct timer_list balloon_timer;
+
+/* When ballooning out (allocating memory to return to Xen) we don't really
+   want the kernel to try too hard since that can trigger the oom killer. */
+#define GFP_BALLOON \
+	(GFP_HIGHUSER | __GFP_NOWARN | __GFP_NORETRY | __GFP_NOMEMALLOC)
+
+static void scrub_page(struct page *page)
+{
+#ifdef CONFIG_XEN_SCRUB_PAGES
+	if (PageHighMem(page)) {
+		void *v = kmap(page);
+		clear_page(v);
+		kunmap(v);
+	} else {
+		void *v = page_address(page);
+		clear_page(v);
+	}
+#endif
+}
+
+/* balloon_append: add the given page to the balloon. */
+static void balloon_append(struct page *page)
+{
+	/* Lowmem is re-populated first, so highmem pages go at list tail. */
+	if (PageHighMem(page)) {
+		list_add_tail(&page->lru, &ballooned_pages);
+		balloon_stats.balloon_high++;
+		dec_totalhigh_pages();
+	} else {
+		list_add(&page->lru, &ballooned_pages);
+		balloon_stats.balloon_low++;
+	}
+}
+
+/* balloon_retrieve: rescue a page from the balloon, if it is not empty. */
+static struct page *balloon_retrieve(void)
+{
+	struct page *page;
+
+	if (list_empty(&ballooned_pages))
+		return NULL;
+
+	page = list_entry(ballooned_pages.next, struct page, lru);
+	list_del(&page->lru);
+
+	if (PageHighMem(page)) {
+		balloon_stats.balloon_high--;
+		inc_totalhigh_pages();
+	}
+	else
+		balloon_stats.balloon_low--;
+
+	return page;
+}
+
+static struct page *balloon_first_page(void)
+{
+	if (list_empty(&ballooned_pages))
+		return NULL;
+	return list_entry(ballooned_pages.next, struct page, lru);
+}
+
+static struct page *balloon_next_page(struct page *page)
+{
+	struct list_head *next = page->lru.next;
+	if (next == &ballooned_pages)
+		return NULL;
+	return list_entry(next, struct page, lru);
+}
+
+static void balloon_alarm(unsigned long unused)
+{
+	schedule_work(&balloon_worker);
+}
+
+static unsigned long current_target(void)
+{
+	unsigned long target = min(balloon_stats.target_pages, balloon_stats.hard_limit);
+
+	target = min(target,
+		     balloon_stats.current_pages +
+		     balloon_stats.balloon_low +
+		     balloon_stats.balloon_high);
+
+	return target;
+}
+
+static int increase_reservation(unsigned long nr_pages)
+{
+	unsigned long  pfn, i, flags;
+	struct page   *page;
+	long           rc;
+	struct xen_memory_reservation reservation = {
+		.address_bits = 0,
+		.extent_order = 0,
+		.domid        = DOMID_SELF
+	};
+
+	if (nr_pages > ARRAY_SIZE(frame_list))
+		nr_pages = ARRAY_SIZE(frame_list);
+
+	spin_lock_irqsave(&balloon_lock, flags);
+
+	page = balloon_first_page();
+	for (i = 0; i < nr_pages; i++) {
+		BUG_ON(page == NULL);
+		frame_list[i] = page_to_pfn(page);;
+		page = balloon_next_page(page);
+	}
+
+	reservation.extent_start = (unsigned long)frame_list;
+	reservation.nr_extents   = nr_pages;
+	rc = HYPERVISOR_memory_op(
+		XENMEM_populate_physmap, &reservation);
+	if (rc < nr_pages) {
+		if (rc > 0) {
+			int ret;
+
+			/* We hit the Xen hard limit: reprobe. */
+			reservation.nr_extents = rc;
+			ret = HYPERVISOR_memory_op(XENMEM_decrease_reservation,
+					&reservation);
+			BUG_ON(ret != rc);
+		}
+		if (rc >= 0)
+			balloon_stats.hard_limit = (balloon_stats.current_pages + rc -
+						    balloon_stats.driver_pages);
+		goto out;
+	}
+
+	for (i = 0; i < nr_pages; i++) {
+		page = balloon_retrieve();
+		BUG_ON(page == NULL);
+
+		pfn = page_to_pfn(page);
+		BUG_ON(!xen_feature(XENFEAT_auto_translated_physmap) &&
+		       phys_to_machine_mapping_valid(pfn));
+
+		set_phys_to_machine(pfn, frame_list[i]);
+
+		/* Link back into the page tables if not highmem. */
+		if (pfn < max_low_pfn) {
+			int ret;
+			ret = HYPERVISOR_update_va_mapping(
+				(unsigned long)__va(pfn << PAGE_SHIFT),
+				mfn_pte(frame_list[i], PAGE_KERNEL),
+				0);
+			BUG_ON(ret);
+		}
+
+		/* Relinquish the page back to the allocator. */
+		ClearPageReserved(page);
+		init_page_count(page);
+		__free_page(page);
+	}
+
+	balloon_stats.current_pages += nr_pages;
+	totalram_pages = balloon_stats.current_pages;
+
+ out:
+	spin_unlock_irqrestore(&balloon_lock, flags);
+
+	return 0;
+}
+
+static int decrease_reservation(unsigned long nr_pages)
+{
+	unsigned long  pfn, i, flags;
+	struct page   *page;
+	int            need_sleep = 0;
+	int ret;
+	struct xen_memory_reservation reservation = {
+		.address_bits = 0,
+		.extent_order = 0,
+		.domid        = DOMID_SELF
+	};
+
+	if (nr_pages > ARRAY_SIZE(frame_list))
+		nr_pages = ARRAY_SIZE(frame_list);
+
+	for (i = 0; i < nr_pages; i++) {
+		if ((page = alloc_page(GFP_BALLOON)) == NULL) {
+			nr_pages = i;
+			need_sleep = 1;
+			break;
+		}
+
+		pfn = page_to_pfn(page);
+		frame_list[i] = pfn_to_mfn(pfn);
+
+		scrub_page(page);
+	}
+
+	/* Ensure that ballooned highmem pages don't have kmaps. */
+	kmap_flush_unused();
+	flush_tlb_all();
+
+	spin_lock_irqsave(&balloon_lock, flags);
+
+	/* No more mappings: invalidate P2M and add to balloon. */
+	for (i = 0; i < nr_pages; i++) {
+		pfn = mfn_to_pfn(frame_list[i]);
+		set_phys_to_machine(pfn, INVALID_P2M_ENTRY);
+		balloon_append(pfn_to_page(pfn));
+	}
+
+	reservation.extent_start = (unsigned long)frame_list;
+	reservation.nr_extents   = nr_pages;
+	ret = HYPERVISOR_memory_op(XENMEM_decrease_reservation, &reservation);
+	BUG_ON(ret != nr_pages);
+
+	balloon_stats.current_pages -= nr_pages;
+	totalram_pages = balloon_stats.current_pages;
+
+	spin_unlock_irqrestore(&balloon_lock, flags);
+
+	return need_sleep;
+}
+
+/*
+ * We avoid multiple worker processes conflicting via the balloon mutex.
+ * We may of course race updates of the target counts (which are protected
+ * by the balloon lock), or with changes to the Xen hard limit, but we will
+ * recover from these in time.
+ */
+static void balloon_process(struct work_struct *work)
+{
+	int need_sleep = 0;
+	long credit;
+
+	mutex_lock(&balloon_mutex);
+
+	do {
+		credit = current_target() - balloon_stats.current_pages;
+		if (credit > 0)
+			need_sleep = (increase_reservation(credit) != 0);
+		if (credit < 0)
+			need_sleep = (decrease_reservation(-credit) != 0);
+
+#ifndef CONFIG_PREEMPT
+		if (need_resched())
+			schedule();
+#endif
+	} while ((credit != 0) && !need_sleep);
+
+	/* Schedule more work if there is some still to be done. */
+	if (current_target() != balloon_stats.current_pages)
+		mod_timer(&balloon_timer, jiffies + HZ);
+
+	mutex_unlock(&balloon_mutex);
+}
+
+/* Resets the Xen limit, sets new target, and kicks off processing. */
+void balloon_set_new_target(unsigned long target)
+{
+	/* No need for lock. Not read-modify-write updates. */
+	balloon_stats.hard_limit   = ~0UL;
+	balloon_stats.target_pages = target;
+	schedule_work(&balloon_worker);
+}
+
+static struct xenbus_watch target_watch =
+{
+	.node = "memory/target"
+};
+
+/* React to a change in the target key */
+static void watch_target(struct xenbus_watch *watch,
+			 const char **vec, unsigned int len)
+{
+	unsigned long long new_target;
+	int err;
+
+	err = xenbus_scanf(XBT_NIL, "memory", "target", "%llu", &new_target);
+	if (err != 1) {
+		/* This is ok (for domain0 at least) - so just return */
+		return;
+	}
+
+	/* The given memory/target value is in KiB, so it needs converting to
+	 * pages. PAGE_SHIFT converts bytes to pages, hence PAGE_SHIFT - 10.
+	 */
+	balloon_set_new_target(new_target >> (PAGE_SHIFT - 10));
+}
+
+static int balloon_init_watcher(struct notifier_block *notifier,
+				unsigned long event,
+				void *data)
+{
+	int err;
+
+	err = register_xenbus_watch(&target_watch);
+	if (err)
+		printk(KERN_ERR "Failed to set balloon watcher\n");
+
+	return NOTIFY_DONE;
+}
+
+static struct notifier_block xenstore_notifier;
+
+static int __init balloon_init(void)
+{
+	unsigned long pfn;
+	struct page *page;
+
+	if (!is_running_on_xen())
+		return -ENODEV;
+
+	pr_info("xen_balloon: Initialising balloon driver.\n");
+
+	balloon_stats.current_pages = min(xen_start_info->nr_pages, max_pfn);
+	totalram_pages   = balloon_stats.current_pages;
+	balloon_stats.target_pages  = balloon_stats.current_pages;
+	balloon_stats.balloon_low   = 0;
+	balloon_stats.balloon_high  = 0;
+	balloon_stats.driver_pages  = 0UL;
+	balloon_stats.hard_limit    = ~0UL;
+
+	init_timer(&balloon_timer);
+	balloon_timer.data = 0;
+	balloon_timer.function = balloon_alarm;
+
+	register_balloon(&balloon_sysdev);
+
+	/* Initialise the balloon with excess memory space. */
+	for (pfn = xen_start_info->nr_pages; pfn < max_pfn; pfn++) {
+		page = pfn_to_page(pfn);
+		if (!PageReserved(page))
+			balloon_append(page);
+	}
+
+	target_watch.callback = watch_target;
+	xenstore_notifier.notifier_call = balloon_init_watcher;
+
+	register_xenstore_notifier(&xenstore_notifier);
+
+	return 0;
+}
+
+subsys_initcall(balloon_init);
+
+static void balloon_exit(void)
+{
+    /* XXX - release balloon here */
+    return;
+}
+
+module_exit(balloon_exit);
+
+static void balloon_update_driver_allowance(long delta)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&balloon_lock, flags);
+	balloon_stats.driver_pages += delta;
+	spin_unlock_irqrestore(&balloon_lock, flags);
+}
+
+static int dealloc_pte_fn(
+	pte_t *pte, struct page *pmd_page, unsigned long addr, void *data)
+{
+	unsigned long mfn = pte_mfn(*pte);
+	int ret;
+	struct xen_memory_reservation reservation = {
+		.nr_extents   = 1,
+		.extent_order = 0,
+		.domid        = DOMID_SELF
+	};
+	reservation.extent_start = (unsigned long)&mfn;
+	set_pte_at(&init_mm, addr, pte, __pte_ma(0ull));
+	set_phys_to_machine(__pa(addr) >> PAGE_SHIFT, INVALID_P2M_ENTRY);
+	ret = HYPERVISOR_memory_op(XENMEM_decrease_reservation, &reservation);
+	BUG_ON(ret != 1);
+	return 0;
+}
+
+static struct page **alloc_empty_pages_and_pagevec(int nr_pages)
+{
+	unsigned long vaddr, flags;
+	struct page *page, **pagevec;
+	int i, ret;
+
+	pagevec = kmalloc(sizeof(page) * nr_pages, GFP_KERNEL);
+	if (pagevec == NULL)
+		return NULL;
+
+	for (i = 0; i < nr_pages; i++) {
+		page = pagevec[i] = alloc_page(GFP_KERNEL);
+		if (page == NULL)
+			goto err;
+
+		vaddr = (unsigned long)page_address(page);
+
+		scrub_page(page);
+
+		spin_lock_irqsave(&balloon_lock, flags);
+
+		if (xen_feature(XENFEAT_auto_translated_physmap)) {
+			unsigned long gmfn = page_to_pfn(page);
+			struct xen_memory_reservation reservation = {
+				.nr_extents   = 1,
+				.extent_order = 0,
+				.domid        = DOMID_SELF
+			};
+			reservation.extent_start = (unsigned long)&gmfn;
+			ret = HYPERVISOR_memory_op(XENMEM_decrease_reservation,
+						   &reservation);
+			if (ret == 1)
+				ret = 0; /* success */
+		} else {
+			ret = apply_to_page_range(&init_mm, vaddr, PAGE_SIZE,
+						  dealloc_pte_fn, NULL);
+		}
+
+		if (ret != 0) {
+			spin_unlock_irqrestore(&balloon_lock, flags);
+			__free_page(page);
+			goto err;
+		}
+
+		totalram_pages = --balloon_stats.current_pages;
+
+		spin_unlock_irqrestore(&balloon_lock, flags);
+	}
+
+ out:
+	schedule_work(&balloon_worker);
+	flush_tlb_all();
+	return pagevec;
+
+ err:
+	spin_lock_irqsave(&balloon_lock, flags);
+	while (--i >= 0)
+		balloon_append(pagevec[i]);
+	spin_unlock_irqrestore(&balloon_lock, flags);
+	kfree(pagevec);
+	pagevec = NULL;
+	goto out;
+}
+
+static void free_empty_pages_and_pagevec(struct page **pagevec, int nr_pages)
+{
+	unsigned long flags;
+	int i;
+
+	if (pagevec == NULL)
+		return;
+
+	spin_lock_irqsave(&balloon_lock, flags);
+	for (i = 0; i < nr_pages; i++) {
+		BUG_ON(page_count(pagevec[i]) != 1);
+		balloon_append(pagevec[i]);
+	}
+	spin_unlock_irqrestore(&balloon_lock, flags);
+
+	kfree(pagevec);
+
+	schedule_work(&balloon_worker);
+}
+
+static void balloon_release_driver_page(struct page *page)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&balloon_lock, flags);
+	balloon_append(page);
+	balloon_stats.driver_pages--;
+	spin_unlock_irqrestore(&balloon_lock, flags);
+
+	schedule_work(&balloon_worker);
+}
+
+
+#define BALLOON_SHOW(name, format, args...)			\
+	static ssize_t show_##name(struct sys_device *dev,	\
+				   char *buf)			\
+	{							\
+		return sprintf(buf, format, ##args);		\
+	}							\
+	static SYSDEV_ATTR(name, S_IRUGO, show_##name, NULL)
+
+BALLOON_SHOW(current_kb, "%lu\n", PAGES2KB(balloon_stats.current_pages));
+BALLOON_SHOW(low_kb, "%lu\n", PAGES2KB(balloon_stats.balloon_low));
+BALLOON_SHOW(high_kb, "%lu\n", PAGES2KB(balloon_stats.balloon_high));
+BALLOON_SHOW(hard_limit_kb,
+	     (balloon_stats.hard_limit!=~0UL) ? "%lu\n" : "???\n",
+	     (balloon_stats.hard_limit!=~0UL) ? PAGES2KB(balloon_stats.hard_limit) : 0);
+BALLOON_SHOW(driver_kb, "%lu\n", PAGES2KB(balloon_stats.driver_pages));
+
+static ssize_t show_target_kb(struct sys_device *dev, char *buf)
+{
+	return sprintf(buf, "%lu\n", PAGES2KB(balloon_stats.target_pages));
+}
+
+static ssize_t store_target_kb(struct sys_device *dev,
+			       const char *buf,
+			       size_t count)
+{
+	char memstring[64], *endchar;
+	unsigned long long target_bytes;
+
+	if (!capable(CAP_SYS_ADMIN))
+		return -EPERM;
+
+	if (count <= 1)
+		return -EBADMSG; /* runt */
+	if (count > sizeof(memstring))
+		return -EFBIG;   /* too long */
+	strcpy(memstring, buf);
+
+	target_bytes = memparse(memstring, &endchar);
+	balloon_set_new_target(target_bytes >> PAGE_SHIFT);
+
+	return count;
+}
+
+static SYSDEV_ATTR(target_kb, S_IRUGO | S_IWUSR,
+		   show_target_kb, store_target_kb);
+
+static struct sysdev_attribute *balloon_attrs[] = {
+	&attr_target_kb,
+};
+
+static struct attribute *balloon_info_attrs[] = {
+	&attr_current_kb.attr,
+	&attr_low_kb.attr,
+	&attr_high_kb.attr,
+	&attr_hard_limit_kb.attr,
+	&attr_driver_kb.attr,
+	NULL
+};
+
+static struct attribute_group balloon_info_group = {
+	.name = "info",
+	.attrs = balloon_info_attrs,
+};
+
+static struct sysdev_class balloon_sysdev_class = {
+	set_kset_name(BALLOON_CLASS_NAME),
+};
+
+static int register_balloon(struct sys_device *sysdev)
+{
+	int i, error;
+
+	error = sysdev_class_register(&balloon_sysdev_class);
+	if (error)
+		return error;
+
+	sysdev->id = 0;
+	sysdev->cls = &balloon_sysdev_class;
+
+	error = sysdev_register(sysdev);
+	if (error) {
+		sysdev_class_unregister(&balloon_sysdev_class);
+		return error;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(balloon_attrs); i++) {
+		error = sysdev_create_file(sysdev, balloon_attrs[i]);
+		if (error)
+			goto fail;
+	}
+
+	error = sysfs_create_group(&sysdev->kobj, &balloon_info_group);
+	if (error)
+		goto fail;
+
+	return 0;
+
+ fail:
+	while (--i >= 0)
+		sysdev_remove_file(sysdev, balloon_attrs[i]);
+	sysdev_unregister(sysdev);
+	sysdev_class_unregister(&balloon_sysdev_class);
+	return error;
+}
+
+static void unregister_balloon(struct sys_device *sysdev)
+{
+	int i;
+
+	sysfs_remove_group(&sysdev->kobj, &balloon_info_group);
+	for (i = 0; i < ARRAY_SIZE(balloon_attrs); i++)
+		sysdev_remove_file(sysdev, balloon_attrs[i]);
+	sysdev_unregister(sysdev);
+	sysdev_class_unregister(&balloon_sysdev_class);
+}
+
+static void balloon_sysfs_exit(void)
+{
+	unregister_balloon(&balloon_sysdev);
+}
+
+MODULE_LICENSE("GPL");
===================================================================
--- /dev/null
+++ b/include/xen/balloon.h
@@ -0,0 +1,61 @@
+/******************************************************************************
+ * balloon.h
+ *
+ * Xen balloon driver - enables returning/claiming memory to/from Xen.
+ *
+ * Copyright (c) 2003, B Dragovic
+ * Copyright (c) 2003-2004, M Williamson, K Fraser
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License version 2
+ * as published by the Free Software Foundation; or, when distributed
+ * separately from the Linux kernel or incorporated into other
+ * software packages, subject to the following license:
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this source file (the "Software"), to deal in the Software without
+ * restriction, including without limitation the rights to use, copy, modify,
+ * merge, publish, distribute, sublicense, and/or sell copies of the Software,
+ * and to permit persons to whom the Software is furnished to do so, subject to
+ * the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
+ * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+ * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
+ * IN THE SOFTWARE.
+ */
+
+#ifndef __XEN_BALLOON_H__
+#define __XEN_BALLOON_H__
+
+#include <linux/spinlock.h>
+
+#if 0
+/*
+ * Inform the balloon driver that it should allow some slop for device-driver
+ * memory activities.
+ */
+void balloon_update_driver_allowance(long delta);
+
+/* Allocate/free a set of empty pages in low memory (i.e., no RAM mapped). */
+struct page **alloc_empty_pages_and_pagevec(int nr_pages);
+void free_empty_pages_and_pagevec(struct page **pagevec, int nr_pages);
+
+void balloon_release_driver_page(struct page *page);
+
+/*
+ * Prevent the balloon driver from changing the memory reservation during
+ * a driver critical region.
+ */
+extern spinlock_t balloon_lock;
+#define balloon_lock(__flags)   spin_lock_irqsave(&balloon_lock, __flags)
+#define balloon_unlock(__flags) spin_unlock_irqrestore(&balloon_lock, __flags)
+#endif
+
+#endif /* __XEN_BALLOON_H__ */
===================================================================
--- a/include/xen/interface/memory.h
+++ b/include/xen/interface/memory.h
@@ -29,7 +29,7 @@ struct xen_memory_reservation {
      *   OUT: GMFN bases of extents that were allocated
      *   (NB. This command also updates the mach_to_phys translation table)
      */
-    GUEST_HANDLE(ulong) extent_start;
+    ulong extent_start;
 
     /* Number of extents, and size/alignment of each (2^extent_order pages). */
     unsigned long  nr_extents;
@@ -50,7 +50,6 @@ struct xen_memory_reservation {
     domid_t        domid;
 
 };
-DEFINE_GUEST_HANDLE_STRUCT(xen_memory_reservation);
 
 /*
  * Returns the maximum machine frame number of mapped RAM in this system.
@@ -86,7 +85,7 @@ struct xen_machphys_mfn_list {
      * any large discontiguities in the machine address space, 2MB gaps in
      * the machphys table will be represented by an MFN base of zero.
      */
-    GUEST_HANDLE(ulong) extent_start;
+    ulong extent_start;
 
     /*
      * Number of extents written to the above array. This will be smaller
@@ -94,7 +93,6 @@ struct xen_machphys_mfn_list {
      */
     unsigned int nr_extents;
 };
-DEFINE_GUEST_HANDLE_STRUCT(xen_machphys_mfn_list);
 
 /*
  * Sets the GPFN at which a particular page appears in the specified guest's
@@ -117,7 +115,6 @@ struct xen_add_to_physmap {
     /* GPFN where the source mapping page should appear. */
     unsigned long gpfn;
 };
-DEFINE_GUEST_HANDLE_STRUCT(xen_add_to_physmap);
 
 /*
  * Translates a list of domain-specific GPFNs into MFNs. Returns a -ve error
@@ -132,14 +129,13 @@ struct xen_translate_gpfn_list {
     unsigned long nr_gpfns;
 
     /* List of GPFNs to translate. */
-    GUEST_HANDLE(ulong) gpfn_list;
+    ulong gpfn_list;
 
     /*
      * Output list to contain MFN translations. May be the same as the input
      * list (in which case each input GPFN is overwritten with the output MFN).
      */
-    GUEST_HANDLE(ulong) mfn_list;
+    ulong mfn_list;
 };
-DEFINE_GUEST_HANDLE_STRUCT(xen_translate_gpfn_list);
 
 #endif /* __XEN_PUBLIC_MEMORY_H__ */

--------------090202060205000703060608
Content-Type: text/x-patch;
 name="xen-cpu-hotplug.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="xen-cpu-hotplug.patch"

---
 arch/x86/kernel/smp_32.c     |    2 +
 arch/x86/kernel/smpboot_32.c |    6 ++--
 arch/x86/xen/enlighten.c     |   15 ++++++++++-
 arch/x86/xen/smp.c           |   54 ++++++++++++++++++++++++++++--------------
 arch/x86/xen/xen-ops.h       |    1 
 include/asm-x86/smp_32.h     |   18 ++++++++++++--
 6 files changed, 72 insertions(+), 24 deletions(-)

===================================================================
--- a/arch/x86/kernel/smp_32.c
+++ b/arch/x86/kernel/smp_32.c
@@ -704,4 +704,6 @@ struct smp_ops smp_ops = {
 	.smp_send_stop = native_smp_send_stop,
 	.smp_send_reschedule = native_smp_send_reschedule,
 	.smp_call_function_mask = native_smp_call_function_mask,
+
+	.cpu_disable = native_cpu_disable,
 };
===================================================================
--- a/arch/x86/kernel/smpboot_32.c
+++ b/arch/x86/kernel/smpboot_32.c
@@ -1166,7 +1166,7 @@ void remove_siblinginfo(int cpu)
 	cpu_clear(cpu, cpu_sibling_setup_map);
 }
 
-int __cpu_disable(void)
+int native_cpu_disable(void)
 {
 	cpumask_t map = cpu_online_map;
 	int cpu = smp_processor_id();
@@ -1216,12 +1216,12 @@ void __cpu_die(unsigned int cpu)
  	printk(KERN_ERR "CPU %u didn't die...\n", cpu);
 }
 #else /* ... !CONFIG_HOTPLUG_CPU */
-int __cpu_disable(void)
+int native_cpu_disable(void)
 {
 	return -ENOSYS;
 }
 
-void __cpu_die(unsigned int cpu)
+void native_cpu_die(unsigned int cpu)
 {
 	/* We said "no" in __cpu_disable */
 	BUG();
===================================================================
--- a/arch/x86/xen/enlighten.c
+++ b/arch/x86/xen/enlighten.c
@@ -254,10 +254,21 @@ static void xen_safe_halt(void)
 		BUG();
 }
 
+static void xen_shutdown_cpu(void)
+{
+	int cpu = smp_processor_id();
+
+	/* make sure we're not pinning something down */
+	load_cr3(swapper_pg_dir);
+	/* GDT too? */
+
+	HYPERVISOR_vcpu_op(VCPUOP_down, cpu, NULL);
+}
+
 static void xen_halt(void)
 {
 	if (irqs_disabled())
-		HYPERVISOR_vcpu_op(VCPUOP_down, smp_processor_id(), NULL);
+		xen_shutdown_cpu();
 	else
 		xen_safe_halt();
 }
@@ -1069,6 +1080,8 @@ static const struct smp_ops xen_smp_ops 
 	.smp_send_stop = xen_smp_send_stop,
 	.smp_send_reschedule = xen_smp_send_reschedule,
 	.smp_call_function_mask = xen_smp_call_function_mask,
+
+	.cpu_disable = xen_cpu_disable,
 };
 #endif	/* CONFIG_SMP */
 
===================================================================
--- a/arch/x86/xen/smp.c
+++ b/arch/x86/xen/smp.c
@@ -189,8 +189,14 @@ void __init xen_smp_prepare_cpus(unsigne
 			panic("failed fork for CPU %d", cpu);
 
 		cpu_set(cpu, cpu_present_map);
-	}
-
+
+		smp_store_cpu_info(cpu);
+		init_gdt(cpu);
+		irq_ctx_init(cpu);
+		xen_setup_timer(cpu);
+		xen_smp_intr_init(cpu);
+	}
+
 	//init_xenbus_allowed_cpumask();
 }
 
@@ -198,7 +204,7 @@ cpu_initialize_context(unsigned int cpu,
 cpu_initialize_context(unsigned int cpu, struct task_struct *idle)
 {
 	struct vcpu_guest_context *ctxt;
-	struct gdt_page *gdt = &per_cpu(gdt_page, cpu);
+	struct desc_struct *gdt = get_cpu_gdt_table(cpu);
 
 	if (cpu_test_and_set(cpu, cpu_initialized_map))
 		return 0;
@@ -222,11 +228,11 @@ cpu_initialize_context(unsigned int cpu,
 
 	ctxt->ldt_ents = 0;
 
-	BUG_ON((unsigned long)gdt->gdt & ~PAGE_MASK);
-	make_lowmem_page_readonly(gdt->gdt);
-
-	ctxt->gdt_frames[0] = virt_to_mfn(gdt->gdt);
-	ctxt->gdt_ents      = ARRAY_SIZE(gdt->gdt);
+	BUG_ON((unsigned long)gdt & ~PAGE_MASK);
+	make_lowmem_page_readonly(gdt);
+
+	ctxt->gdt_frames[0] = virt_to_mfn(gdt);
+	ctxt->gdt_ents      = GDT_ENTRIES;
 
 	ctxt->user_regs.cs = __KERNEL_CS;
 	ctxt->user_regs.esp = idle->thread.esp0 - sizeof(struct pt_regs);
@@ -260,26 +266,20 @@ int __cpuinit xen_cpu_up(unsigned int cp
 		return rc;
 #endif
 
-	init_gdt(cpu);
 	per_cpu(current_task, cpu) = idle;
-	irq_ctx_init(cpu);
-	xen_setup_timer(cpu);
 
 	/* make sure interrupts start blocked */
 	per_cpu(xen_vcpu, cpu)->evtchn_upcall_mask = 1;
 
 	rc = cpu_initialize_context(cpu, idle);
 	if (rc)
-		return rc;
+		goto out;
 
 	if (num_online_cpus() == 1)
 		alternatives_smp_switch(1);
 
-	rc = xen_smp_intr_init(cpu);
-	if (rc)
-		return rc;
-
-	smp_store_cpu_info(cpu);
+	get_cpu();		/* set_cpu_sibling_map wants no preempt */
+
 	set_cpu_sibling_map(cpu);
 	/* This must be done before setting cpu_online_map */
 	wmb();
@@ -289,7 +289,10 @@ int __cpuinit xen_cpu_up(unsigned int cp
 	rc = HYPERVISOR_vcpu_op(VCPUOP_up, cpu, NULL);
 	BUG_ON(rc);
 
-	return 0;
+	put_cpu();
+
+  out:
+	return rc;
 }
 
 void xen_smp_cpus_done(unsigned int max_cpus)
@@ -408,3 +411,18 @@ int xen_smp_call_function_mask(cpumask_t
 
 	return 0;
 }
+
+int xen_cpu_disable(void)
+{
+	cpumask_t map = cpu_online_map;
+	int cpu = smp_processor_id();
+
+	remove_siblinginfo(cpu);
+
+	cpu_clear(cpu, map);
+	fixup_irqs(map);
+	/* It's now safe to remove this processor from the online map */
+	cpu_clear(cpu, cpu_online_map);
+
+	return 0;
+}
===================================================================
--- a/arch/x86/xen/xen-ops.h
+++ b/arch/x86/xen/xen-ops.h
@@ -39,6 +39,7 @@ void xen_smp_prepare_cpus(unsigned int m
 void xen_smp_prepare_cpus(unsigned int max_cpus);
 int xen_cpu_up(unsigned int cpu);
 void xen_smp_cpus_done(unsigned int max_cpus);
+int xen_cpu_disable(void);
 
 void xen_smp_send_stop(void);
 void xen_smp_send_reschedule(int cpu);
===================================================================
--- a/include/asm-x86/smp_32.h
+++ b/include/asm-x86/smp_32.h
@@ -63,6 +63,9 @@ struct smp_ops
 	int (*smp_call_function_mask)(cpumask_t mask,
 				      void (*func)(void *info), void *info,
 				      int wait);
+
+	int (*cpu_disable)(void);
+	void (*cpu_die)(unsigned int cpu);
 };
 
 extern struct smp_ops smp_ops;
@@ -71,14 +74,17 @@ static inline void smp_prepare_boot_cpu(
 {
 	smp_ops.smp_prepare_boot_cpu();
 }
+
 static inline void smp_prepare_cpus(unsigned int max_cpus)
 {
 	smp_ops.smp_prepare_cpus(max_cpus);
 }
+
 static inline int __cpu_up(unsigned int cpu)
 {
 	return smp_ops.cpu_up(cpu);
 }
+
 static inline void smp_cpus_done(unsigned int max_cpus)
 {
 	smp_ops.smp_cpus_done(max_cpus);
@@ -88,10 +94,12 @@ static inline void smp_send_stop(void)
 {
 	smp_ops.smp_send_stop();
 }
+
 static inline void smp_send_reschedule(int cpu)
 {
 	smp_ops.smp_send_reschedule(cpu);
 }
+
 static inline int smp_call_function_mask(cpumask_t mask,
 					 void (*func) (void *info), void *info,
 					 int wait)
@@ -99,10 +107,18 @@ static inline int smp_call_function_mask
 	return smp_ops.smp_call_function_mask(mask, func, info, wait);
 }
 
+static inline int __cpu_disable(void)
+{
+	return smp_ops.cpu_disable();
+}
+
+
 void native_smp_prepare_boot_cpu(void);
 void native_smp_prepare_cpus(unsigned int max_cpus);
 int native_cpu_up(unsigned int cpunum);
 void native_smp_cpus_done(unsigned int max_cpus);
+extern int native_cpu_disable(void);
+extern void __cpu_die(unsigned int cpu);
 
 #ifndef CONFIG_PARAVIRT
 #define startup_ipi_hook(phys_apicid, start_eip, start_esp) 		\
@@ -128,8 +144,6 @@ static inline int num_booting_cpus(void)
 }
 
 extern int safe_smp_processor_id(void);
-extern int __cpu_disable(void);
-extern void __cpu_die(unsigned int cpu);
 extern unsigned int num_processors;
 
 void __cpuinit smp_store_cpu_info(int id);

--------------090202060205000703060608
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Xen-devel mailing list
Xen-devel@lists.xensource.com
http://lists.xensource.com/xen-devel

--------------090202060205000703060608--

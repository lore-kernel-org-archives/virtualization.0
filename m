From: Gerd Hoffmann <kraxel@suse.de>
Subject: Re: paravirt & xen & SMP
Date: Wed, 10 Jan 2007 17:27:15 +0100
Message-ID: <45A513E3.3010104@suse.de>
References: <45A504EE.5050409@suse.de>
	<27c823430701100818i5ec586ffm65d5678f4fe1bbea@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------070001000102060009010605"
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <27c823430701100818i5ec586ffm65d5678f4fe1bbea@mail.gmail.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Chuck Short <zulcss@gmail.com>
Cc: Virtualization Mailing List <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

This is a multi-part message in MIME format.
--------------070001000102060009010605
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Chuck Short wrote:
> Hi Gerd,
> 
> I was wondering how you got it to work this far?

It's almost at userspace now (virtual machine is UP only, kernel built
with CONFIG_SMP=y though), just by avoiding multicalls in the boot path
before pda being setup.  Patch attached, goes on top of the complete
paravirt patch queue.

cheers,

  Gerd

-- 
Gerd Hoffmann <kraxel@suse.de>

--------------070001000102060009010605
Content-Type: text/plain;
 name="kraxel.buildfix"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="kraxel.buildfix"

---
 arch/i386/paravirt-xen/enlighten.c |   28 +++++++++++++++++++++++++++-
 drivers/Makefile                   |    2 +-
 include/asm-i386/paravirt.h        |   20 ++++++++++----------
 3 files changed, 38 insertions(+), 12 deletions(-)

Index: paravirt-2.6.20-rc4-hg691/include/asm-i386/paravirt.h
===================================================================
--- paravirt-2.6.20-rc4-hg691.orig/include/asm-i386/paravirt.h
+++ paravirt-2.6.20-rc4-hg691/include/asm-i386/paravirt.h
@@ -493,6 +493,16 @@ static inline void apic_write_atomic(uns
 	paravirt_ops.apic_write_atomic(reg,v);
 }
 unsigned long apic_read(unsigned long reg);
+
+static inline void setup_boot_clock(void)
+{
+	paravirt_ops.setup_boot_clock();
+}
+
+static inline void setup_secondary_clock(void)
+{
+	paravirt_ops.setup_secondary_clock();
+}
 #endif
 
 /* These will be unexported once raid6 is fixed... */
@@ -525,16 +535,6 @@ static inline void pmd_clear(pmd_t *pmdp
 {
 	paravirt_ops.pmd_clear(pmdp);
 }
-
-static inline void setup_boot_clock(void)
-{
-	paravirt_ops.setup_boot_clock();
-}
-
-static inline void setup_secondary_clock(void)
-{
-	paravirt_ops.setup_secondary_clock();
-}
 #endif
 
 /* Lazy mode for batching updates / context switch */
Index: paravirt-2.6.20-rc4-hg691/arch/i386/paravirt-xen/enlighten.c
===================================================================
--- paravirt-2.6.20-rc4-hg691.orig/arch/i386/paravirt-xen/enlighten.c
+++ paravirt-2.6.20-rc4-hg691/arch/i386/paravirt-xen/enlighten.c
@@ -240,6 +240,25 @@ static fastcall void xen_load_gdt(const 
 		xen_mc_flush();
 }
 
+static fastcall void xen_load_gdt_boot(const struct Xgt_desc_struct *dtr)
+{
+        unsigned long va;
+        int f;
+	unsigned size = dtr->size + 1;
+	unsigned long frames[16];
+
+	BUG_ON(size > 16*PAGE_SIZE);
+
+        for (va = dtr->address, f = 0;
+             va < dtr->address + size;
+             va += PAGE_SIZE, f++) {
+                frames[f] = virt_to_mfn(va);
+		make_lowmem_page_readonly((void *)va);
+        }
+
+	HYPERVISOR_set_gdt(frames, size/8);
+}
+
 static void load_TLS_descriptor(struct thread_struct *t,
 				unsigned int cpu, unsigned int i)
 {
@@ -522,6 +541,7 @@ static fastcall void xen_alloc_pd(u32 pf
 static fastcall void xen_release_pd(u32 pfn)
 {
 	make_lowmem_page_readwrite(__va(PFN_PHYS(pfn)));
+	memset(__va(PFN_PHYS(pfn)), 0, PAGE_SIZE);
 }
 
 static fastcall void xen_release_pt(u32 pfn)
@@ -757,12 +777,18 @@ static asmlinkage void __init xen_start_
 	/* set up the boot-time gdt and segments */
 	init_mm.pgd = pgd; /* use the Xen pagetables to start */
 
-	xen_load_gdt(&cpu_gdt_descr);
+	xen_load_gdt_boot(&cpu_gdt_descr);
 
 	/* set up PDA descriptor */
 	pack_descriptor(&low, &high, (unsigned)&boot_pda, sizeof(boot_pda)-1,
 			0x80 | DESCTYPE_S | 0x02, 0);
+#if 0
 	xen_write_gdt_entry(cpu_gdt_table, GDT_ENTRY_PDA, low, high);
+#else
+	if (HYPERVISOR_update_descriptor(virt_to_machine(cpu_gdt_table + GDT_ENTRY_PDA).maddr,
+					 (u64)high << 32 | low))
+		BUG();
+#endif
 
 	/* set up %gs and init Xen parts of the PDA */
 	asm volatile("mov %0, %%gs" : : "r" (__KERNEL_PDA) : "memory");
Index: paravirt-2.6.20-rc4-hg691/drivers/Makefile
===================================================================
--- paravirt-2.6.20-rc4-hg691.orig/drivers/Makefile
+++ paravirt-2.6.20-rc4-hg691/drivers/Makefile
@@ -18,6 +18,7 @@ obj-$(CONFIG_ARM_AMBA)		+= amba/
 # char/ comes before serial/ etc so that the VT console is the boot-time
 # default.
 obj-y				+= char/
+obj-$(CONFIG_XEN)		+= xen/
 
 obj-$(CONFIG_CONNECTOR)		+= connector/
 
@@ -31,7 +32,6 @@ obj-y				+= base/ block/ misc/ mfd/ net/
 obj-$(CONFIG_NUBUS)		+= nubus/
 obj-$(CONFIG_ATM)		+= atm/
 obj-$(CONFIG_PPC_PMAC)		+= macintosh/
-obj-$(CONFIG_XEN)		+= xen/
 obj-$(CONFIG_IDE)		+= ide/
 obj-$(CONFIG_FC4)		+= fc4/
 obj-$(CONFIG_SCSI)		+= scsi/

--------------070001000102060009010605
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.osdl.org
https://lists.osdl.org/mailman/listinfo/virtualization

--------------070001000102060009010605--

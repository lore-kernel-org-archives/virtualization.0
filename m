From: Chris Wright <chrisw@sous-sol.org>
Subject: Re: [patch] asm/i386/kernel/paravirt.c buildfix
Date: Mon, 8 Jan 2007 15:05:36 -0800
Message-ID: <20070108230536.GC19575@sequoia.sous-sol.org>
References: <20070108152852.7819D1ED200@linux.local>
	<20070108200202.GB19575@sequoia.sous-sol.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <20070108200202.GB19575@sequoia.sous-sol.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Gers Knorr <kraxel@suse.de>
Cc: virtualization@lists.osdl.org
List-Id: virtualization@lists.linuxfoundation.org

* Chris Wright (chrisw@sous-sol.org) wrote:
> * Gers Knorr (kraxel@suse.de) wrote:
> > asm/i386/kernel/paravirt.c buildfix.
> > =

> > drop apic_* duplicates which are defined in asm/paravirt.h
> =

> Thanks, but did you build test w/ smth like allmodconfig (paravirt_ops
> not being exported anymore means those inline wrappers can easily break)?

OK, after some mucking about here's one that removes the issues with
with pv allmodconfig.

thanks,
-chris
--

diff -r d1e90752bb71 include/asm-i386/paravirt.h
--- a/include/asm-i386/paravirt.h	Mon Jan 08 14:32:00 2007 -0500
+++ b/include/asm-i386/paravirt.h	Mon Jan 08 17:32:12 2007 -0500
@@ -367,36 +367,6 @@ void __cpuid(unsigned int *eax, unsigned
 #define pmd_val(x)	paravirt_ops.pmd_val(x)
 #endif
 =

-/* The paravirtualized I/O functions */
-static inline void slow_down_io(void) {
-	paravirt_ops.io_delay();
-#ifdef REALLY_SLOW_IO
-	paravirt_ops.io_delay();
-	paravirt_ops.io_delay();
-	paravirt_ops.io_delay();
-#endif
-}
-
-#ifdef CONFIG_X86_LOCAL_APIC
-/*
- * Basic functions accessing APICs.
- */
-static inline void apic_write(unsigned long reg, unsigned long v)
-{
-	paravirt_ops.apic_write(reg,v);
-}
-
-static inline void apic_write_atomic(unsigned long reg, unsigned long v)
-{
-	paravirt_ops.apic_write_atomic(reg,v);
-}
-
-static inline unsigned long apic_read(unsigned long reg)
-{
-	return paravirt_ops.apic_read(reg);
-}
-#endif
-
 static inline void paravirt_pagetable_setup_start(pgd_t *base)
 {
 	if (paravirt_ops.pagetable_setup_start)
@@ -495,13 +465,33 @@ void paravirt_irq_disable(void);
 void paravirt_irq_disable(void);
 void paravirt_irq_enable(void);
 void paravirt_const_udelay(unsigned long loops);
-void paravirt_io_delay(void);
 u64 paravirt_read_msr(unsigned int msr, int *err);
 int paravirt_write_msr(unsigned int msr, u64 val);
 u64 paravirt_read_tsc(void);
 void raw_safe_halt(void);
 void halt(void);
 void wbinvd(void);
+void paravirt_io_delay(void);
+static inline void slow_down_io(void) {
+	paravirt_io_delay();
+#ifdef REALLY_SLOW_IO
+	paravirt_io_delay();
+	paravirt_io_delay();
+	paravirt_io_delay();
+#endif
+}
+
+#ifdef CONFIG_X86_LOCAL_APIC
+/*
+ * Basic functions accessing APICs.
+ */
+void apic_write(unsigned long reg, unsigned long v);
+static inline void apic_write_atomic(unsigned long reg, unsigned long v)
+{
+	paravirt_ops.apic_write_atomic(reg,v);
+}
+unsigned long apic_read(unsigned long reg);
+#endif
 =

 /* These will be unexported once raid6 is fixed... */
 void clts(void);

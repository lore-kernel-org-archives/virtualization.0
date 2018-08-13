From: Juergen Gross <jgross@suse.com>
Subject: [PATCH v2 09/11] x86/paravirt: move the Xen-only pv_irq_ops under the
	PARAVIRT_XXL umbrella
Date: Mon, 13 Aug 2018 09:37:37 +0200
Message-ID: <20180813073739.26108-10-jgross__17971.1199285977$1534146965$gmane$org@suse.com>
References: <20180813073739.26108-1-jgross@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20180813073739.26108-1-jgross@suse.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org, x86@kernel.org, virtualization@lists.linux-foundation.org
Cc: Juergen Gross <jgross@suse.com>, boris.ostrovsky@oracle.com, rusty@rustcorp.com.au, peterz@infradead.org, mingo@redhat.com, hpa@zytor.com, akataria@vmware.com, tglx@linutronix.de
List-Id: virtualization@lists.linuxfoundation.org

Some of the paravirt ops defined in pv_irq_ops are for Xen PV guests
only. Define them only if CONFIG_PARAVIRT_XXL is set.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
 arch/x86/include/asm/irqflags.h       | 38 ++++++++++++++++++-----------------
 arch/x86/include/asm/paravirt.h       |  2 --
 arch/x86/include/asm/paravirt_types.h |  2 ++
 arch/x86/kernel/paravirt.c            |  2 ++
 4 files changed, 24 insertions(+), 20 deletions(-)

diff --git a/arch/x86/include/asm/irqflags.h b/arch/x86/include/asm/irqflags.h
index 03bb451e4e6b..205e43e55144 100644
--- a/arch/x86/include/asm/irqflags.h
+++ b/arch/x86/include/asm/irqflags.h
@@ -88,24 +88,6 @@ static inline notrace void arch_local_irq_enable(void)
 }
 
 /*
- * Used in the idle loop; sti takes one instruction cycle
- * to complete:
- */
-static inline __cpuidle void arch_safe_halt(void)
-{
-	native_safe_halt();
-}
-
-/*
- * Used when interrupts are already enabled or to
- * shutdown the processor:
- */
-static inline __cpuidle void halt(void)
-{
-	native_halt();
-}
-
-/*
  * For spinlocks, etc:
  */
 static inline notrace unsigned long arch_local_irq_save(void)
@@ -154,6 +136,26 @@ static inline notrace unsigned long arch_local_irq_save(void)
 #define INTERRUPT_RETURN		iret
 #endif
 
+#else
+
+/*
+ * Used in the idle loop; sti takes one instruction cycle
+ * to complete:
+ */
+static inline __cpuidle void arch_safe_halt(void)
+{
+	native_safe_halt();
+}
+
+/*
+ * Used when interrupts are already enabled or to
+ * shutdown the processor:
+ */
+static inline __cpuidle void halt(void)
+{
+	native_halt();
+}
+
 #endif /* __ASSEMBLY__ */
 #endif /* CONFIG_PARAVIRT_XXL */
 
diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
index 7ce17f361503..334bc2e7cd78 100644
--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -91,7 +91,6 @@ static inline void write_cr8(unsigned long x)
 	PVOP_VCALL1(cpu.write_cr8, x);
 }
 #endif
-#endif
 
 static inline void arch_safe_halt(void)
 {
@@ -103,7 +102,6 @@ static inline void halt(void)
 	PVOP_VCALL0(irq.halt);
 }
 
-#ifdef CONFIG_PARAVIRT_XXL
 static inline void wbinvd(void)
 {
 	PVOP_VCALL0(cpu.wbinvd);
diff --git a/arch/x86/include/asm/paravirt_types.h b/arch/x86/include/asm/paravirt_types.h
index e652ec27d945..ae53ee36d8fb 100644
--- a/arch/x86/include/asm/paravirt_types.h
+++ b/arch/x86/include/asm/paravirt_types.h
@@ -197,8 +197,10 @@ struct pv_irq_ops {
 	struct paravirt_callee_save irq_disable;
 	struct paravirt_callee_save irq_enable;
 
+#ifdef CONFIG_PARAVIRT_XXL
 	void (*safe_halt)(void);
 	void (*halt)(void);
+#endif
 
 } __no_randomize_layout;
 
diff --git a/arch/x86/kernel/paravirt.c b/arch/x86/kernel/paravirt.c
index e4899f3252f1..4dd12cc15daa 100644
--- a/arch/x86/kernel/paravirt.c
+++ b/arch/x86/kernel/paravirt.c
@@ -379,8 +379,10 @@ struct paravirt_patch_template pv_ops = {
 	.irq.restore_fl = __PV_IS_CALLEE_SAVE(native_restore_fl),
 	.irq.irq_disable = __PV_IS_CALLEE_SAVE(native_irq_disable),
 	.irq.irq_enable = __PV_IS_CALLEE_SAVE(native_irq_enable),
+#ifdef CONFIG_PARAVIRT_XXL
 	.irq.safe_halt = native_safe_halt,
 	.irq.halt = native_halt,
+#endif
 
 	/* Mmu ops. */
 	.mmu.read_cr2 = native_read_cr2,
-- 
2.13.7

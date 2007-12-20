From: Glauber de Oliveira Costa <gcosta@redhat.com>
Subject: [PATCH 04/15] provide paravirtualized hook for rdtscp
Date: Thu, 20 Dec 2007 18:03:59 -0200
Message-ID: <1198181215625-git-send-email-gcosta@redhat.com>
References: <11981810504172-git-send-email-gcosta@redhat.com>
	<11981811293763-git-send-email-gcosta@redhat.com>
	<11981811852758-git-send-email-gcosta@redhat.com>
	<11981812041672-git-send-email-gcosta@redhat.com>
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <11981812041672-git-send-email-gcosta@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-kernel@vger.kernel.org
Cc: ehabkost@redhat.com, ak@suse.de, virtualization@lists.linux-foundation.org, chrisw@sous-sol.org, tglx@linutronix.de, anthony@codemonkey.ws, hpa@zytor.com, akpm@linux-foundation.org, Glauber de Oliveira Costa <gcosta@redhat.com>, mingo@elte.hu, roland@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

This patch adds a field in pv_cpu_ops for a paravirtualized hook
for rdtscp, needed for x86_64.

Signed-off-by: Glauber de Oliveira Costa <gcosta@redhat.com>
---
 arch/x86/kernel/paravirt.c |    1 +
 include/asm-x86/paravirt.h |   22 ++++++++++++++++++++++
 2 files changed, 23 insertions(+), 0 deletions(-)

Index: linux-2.6-x86/arch/x86/kernel/paravirt.c
===================================================================
--- linux-2.6-x86.orig/arch/x86/kernel/paravirt.c	2007-12-20 19:07:15.000000000 -0800
+++ linux-2.6-x86/arch/x86/kernel/paravirt.c	2007-12-20 19:07:22.000000000 -0800
@@ -374,6 +374,7 @@
 	.write_msr = native_write_msr_safe,
 	.read_tsc = native_read_tsc,
 	.read_pmc = native_read_pmc,
+	.read_tscp = native_read_tscp,
 	.load_tr_desc = native_load_tr_desc,
 	.set_ldt = native_set_ldt,
 	.load_gdt = native_load_gdt,
Index: linux-2.6-x86/include/asm-x86/paravirt.h
===================================================================
--- linux-2.6-x86.orig/include/asm-x86/paravirt.h	2007-12-20 19:07:18.000000000 -0800
+++ linux-2.6-x86/include/asm-x86/paravirt.h	2007-12-20 19:07:22.000000000 -0800
@@ -120,6 +120,7 @@
 
 	u64 (*read_tsc)(void);
 	u64 (*read_pmc)(int counter);
+	unsigned long long (*read_tscp)(unsigned int *aux);
 
 	/* These two are jmp to, not actually called. */
 	void (*irq_enable_syscall_ret)(void);
@@ -668,6 +669,27 @@
 	high = _l >> 32;			\
 } while(0)
 
+static inline unsigned long long paravirt_rdtscp(unsigned int *aux)
+{
+	return PVOP_CALL1(u64, pv_cpu_ops.read_tscp, aux);
+}
+
+#define rdtscp(low, high, aux)				\
+do {							\
+	int __aux;					\
+	unsigned long __val = paravirt_rdtscp(&__aux);	\
+	(low) = (u32)__val;				\
+	(high) = (u32)(__val >> 32);			\
+	(aux) = __aux;					\
+} while (0)
+
+#define rdtscpll(val, aux)				\
+do {							\
+	unsigned long __aux; 				\
+	val = paravirt_rdtscp(&__aux);			\
+	(aux) = __aux;					\
+} while (0)
+
 static inline void load_TR_desc(void)
 {
 	PVOP_VCALL0(pv_cpu_ops.load_tr_desc);

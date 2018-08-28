From: Juergen Gross <jgross@suse.com>
Subject: [PATCH v3 11/15] x86/paravirt: move items in pv_info under
	PARAVIRT_XXL umbrella
Date: Tue, 28 Aug 2018 09:40:22 +0200
Message-ID: <20180828074026.820-12-jgross__34184.2478992932$1535442486$gmane$org@suse.com>
References: <20180828074026.820-1-jgross@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20180828074026.820-1-jgross@suse.com>
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
Cc: Juergen Gross <jgross@suse.com>, boris.ostrovsky@oracle.com, rusty@rustcorp.com.au, mingo@redhat.com, hpa@zytor.com, akataria@vmware.com, tglx@linutronix.de
List-Id: virtualization@lists.linuxfoundation.org

All items but name in pv_info are needed by Xen PV only. Define them
with CONFIG_PARAVIRT_XXL set only.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
 arch/x86/include/asm/paravirt.h             | 2 ++
 arch/x86/include/asm/paravirt_types.h       | 2 ++
 arch/x86/include/asm/pgtable-3level_types.h | 2 +-
 arch/x86/include/asm/ptrace.h               | 2 +-
 arch/x86/include/asm/segment.h              | 2 +-
 arch/x86/kernel/paravirt.c                  | 2 ++
 6 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
index 2ba23e98c5cd..dbaedf1ed622 100644
--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -104,7 +104,9 @@ static inline void wbinvd(void)
 	PVOP_VCALL0(cpu.wbinvd);
 }
 
+#ifdef CONFIG_PARAVIRT_XXL
 #define get_kernel_rpl()  (pv_info.kernel_rpl)
+#endif
 
 static inline u64 paravirt_read_msr(unsigned msr)
 {
diff --git a/arch/x86/include/asm/paravirt_types.h b/arch/x86/include/asm/paravirt_types.h
index 462a54b2bb53..98e1110354b8 100644
--- a/arch/x86/include/asm/paravirt_types.h
+++ b/arch/x86/include/asm/paravirt_types.h
@@ -66,11 +66,13 @@ struct paravirt_callee_save {
 
 /* general info */
 struct pv_info {
+#ifdef CONFIG_PARAVIRT_XXL
 	unsigned int kernel_rpl;
 	int shared_kernel_pmd;
 
 #ifdef CONFIG_X86_64
 	u16 extra_user_64bit_cs;  /* __USER_CS if none */
+#endif
 #endif
 
 	const char *name;
diff --git a/arch/x86/include/asm/pgtable-3level_types.h b/arch/x86/include/asm/pgtable-3level_types.h
index 858358a82b14..33845d36897c 100644
--- a/arch/x86/include/asm/pgtable-3level_types.h
+++ b/arch/x86/include/asm/pgtable-3level_types.h
@@ -20,7 +20,7 @@ typedef union {
 } pte_t;
 #endif	/* !__ASSEMBLY__ */
 
-#ifdef CONFIG_PARAVIRT
+#ifdef CONFIG_PARAVIRT_XXL
 #define SHARED_KERNEL_PMD	((!static_cpu_has(X86_FEATURE_PTI) &&	\
 				 (pv_info.shared_kernel_pmd)))
 #else
diff --git a/arch/x86/include/asm/ptrace.h b/arch/x86/include/asm/ptrace.h
index 6de1fd3d0097..250be50aa257 100644
--- a/arch/x86/include/asm/ptrace.h
+++ b/arch/x86/include/asm/ptrace.h
@@ -144,7 +144,7 @@ static inline int v8086_mode(struct pt_regs *regs)
 static inline bool user_64bit_mode(struct pt_regs *regs)
 {
 #ifdef CONFIG_X86_64
-#ifndef CONFIG_PARAVIRT
+#ifndef CONFIG_PARAVIRT_XXL
 	/*
 	 * On non-paravirt systems, this is the only long mode CPL 3
 	 * selector.  We do not allow long mode selectors in the LDT.
diff --git a/arch/x86/include/asm/segment.h b/arch/x86/include/asm/segment.h
index e293c122d0d5..0ffbe9519e68 100644
--- a/arch/x86/include/asm/segment.h
+++ b/arch/x86/include/asm/segment.h
@@ -211,7 +211,7 @@
 
 #endif
 
-#ifndef CONFIG_PARAVIRT
+#ifndef CONFIG_PARAVIRT_XXL
 # define get_kernel_rpl()		0
 #endif
 
diff --git a/arch/x86/kernel/paravirt.c b/arch/x86/kernel/paravirt.c
index 5fc2b94e1591..ee7da9ec3ea2 100644
--- a/arch/x86/kernel/paravirt.c
+++ b/arch/x86/kernel/paravirt.c
@@ -293,12 +293,14 @@ enum paravirt_lazy_mode paravirt_get_lazy_mode(void)
 
 struct pv_info pv_info = {
 	.name = "bare hardware",
+#ifdef CONFIG_PARAVIRT_XXL
 	.kernel_rpl = 0,
 	.shared_kernel_pmd = 1,	/* Only used when CONFIG_X86_PAE is set */
 
 #ifdef CONFIG_X86_64
 	.extra_user_64bit_cs = __USER_CS,
 #endif
+#endif
 };
 
 #if defined(CONFIG_X86_32) && !defined(CONFIG_X86_PAE)
-- 
2.16.4

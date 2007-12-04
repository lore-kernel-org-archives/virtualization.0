From: Glauber de Oliveira Costa <gcosta@redhat.com>
Subject: [PATCH 2/10] unify msr smp funcs
Date: Tue,  4 Dec 2007 09:09:56 -0200
Message-ID: <11967666161585-git-send-email-gcosta__46352.6636515327$1196776595$gmane$org@redhat.com>
References: <11967666042130-git-send-email-gcosta@redhat.com>
	<11967666111489-git-send-email-gcosta@redhat.com>
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <11967666111489-git-send-email-gcosta@redhat.com>
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
Cc: ehabkost@redhat.com, ak@suse.de, virtualization@lists.linux-foundation.org, chrisw@sous-sol.org, tglx@linutronix.de, anthony@codemonkey.ws, hpa@zytor.com, akpm@linux-foundation.org, Glauber de Oliveira Costa <gcosta@redhat.com>, mingo@elte.hu
List-Id: virtualization@lists.linuxfoundation.org

The functions under #ifdef CONFIG_SMP in msr.h are the same
for both x86_64 and i386, and this patches removes one of them,
putting them in a single location

Signed-off-by: Glauber de Oliveira Costa <gcosta@redhat.com>
---
 include/asm-x86/msr.h |   33 +++++++--------------------------
 1 files changed, 7 insertions(+), 26 deletions(-)

diff --git a/include/asm-x86/msr.h b/include/asm-x86/msr.h
index ba4b314..b3cd509 100644
--- a/include/asm-x86/msr.h
+++ b/include/asm-x86/msr.h
@@ -135,29 +135,6 @@ static inline int wrmsr_safe(u32 __msr, u32 __low, u32 __high)
 	} while(0)
 #endif	/* !CONFIG_PARAVIRT */
 
-#ifdef CONFIG_SMP
-void rdmsr_on_cpu(unsigned int cpu, u32 msr_no, u32 *l, u32 *h);
-void wrmsr_on_cpu(unsigned int cpu, u32 msr_no, u32 l, u32 h);
-int rdmsr_safe_on_cpu(unsigned int cpu, u32 msr_no, u32 *l, u32 *h);
-int wrmsr_safe_on_cpu(unsigned int cpu, u32 msr_no, u32 l, u32 h);
-#else  /*  CONFIG_SMP  */
-static inline void rdmsr_on_cpu(unsigned int cpu, u32 msr_no, u32 *l, u32 *h)
-{
-	rdmsr(msr_no, *l, *h);
-}
-static inline void wrmsr_on_cpu(unsigned int cpu, u32 msr_no, u32 l, u32 h)
-{
-	wrmsr(msr_no, l, h);
-}
-static inline int rdmsr_safe_on_cpu(unsigned int cpu, u32 msr_no, u32 *l, u32 *h)
-{
-	return rdmsr_safe(msr_no, l, h);
-}
-static inline int wrmsr_safe_on_cpu(unsigned int cpu, u32 msr_no, u32 l, u32 h)
-{
-	return wrmsr_safe(msr_no, l, h);
-}
-#endif  /*  CONFIG_SMP  */
 #endif  /* ! __ASSEMBLY__ */
 #endif  /* __KERNEL__ */
 
@@ -320,6 +297,12 @@ static inline unsigned int cpuid_edx(unsigned int op)
 	return edx;
 }
 
+#endif  /* __ASSEMBLY__ */
+
+#endif  /* !__i386__ */
+
+#ifndef __ASSEMBLY__
+
 #ifdef CONFIG_SMP
 void rdmsr_on_cpu(unsigned int cpu, u32 msr_no, u32 *l, u32 *h);
 void wrmsr_on_cpu(unsigned int cpu, u32 msr_no, u32 l, u32 h);
@@ -343,8 +326,6 @@ static inline int wrmsr_safe_on_cpu(unsigned int cpu, u32 msr_no, u32 l, u32 h)
 	return wrmsr_safe(msr_no, l, h);
 }
 #endif  /* CONFIG_SMP */
-#endif  /* __ASSEMBLY__ */
-
-#endif  /* !__i386__ */
+#endif /* __ASSEMBLY__ */
 
 #endif
-- 
1.4.4.2

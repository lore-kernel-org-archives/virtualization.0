From: Borislav Petkov <bp@alien8.de>
Subject: [PATCH] x86/asm/entry: Drop now unused ENABLE_INTERRUPTS_SYSEXIT32
Date: Fri,  3 Apr 2015 10:28:34 +0200
Message-ID: <1428049714-829-1-git-send-email-bp__36698.7725873061$1428050415$gmane$org@alien8.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Denys Vlasenko <dvlasenk@redhat.com>, Brian Gerst <brgerst@gmail.com>, LKML <linux-kernel@vger.kernel.org>, Andy Lutomirski <luto@amacapital.net>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, virtualization@lists.linux-foundation.org, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

From: Borislav Petkov <bp@suse.de>

Commit

  4214a16b0297 ("x86/asm/entry/64/compat: Use SYSRETL to return from compat mode SYSENTER")

removed the last user of ENABLE_INTERRUPTS_SYSEXIT32. Kill the macro now
too.

Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: virtualization@lists.linux-foundation.org
---
 arch/x86/include/asm/irqflags.h | 4 ----
 arch/x86/include/asm/paravirt.h | 5 -----
 2 files changed, 9 deletions(-)

diff --git a/arch/x86/include/asm/irqflags.h b/arch/x86/include/asm/irqflags.h
index 9a63eae04e4b..b77f5edb03b0 100644
--- a/arch/x86/include/asm/irqflags.h
+++ b/arch/x86/include/asm/irqflags.h
@@ -136,10 +136,6 @@ static inline notrace unsigned long arch_local_irq_save(void)
 #define USERGS_SYSRET32				\
 	swapgs;					\
 	sysretl
-#define ENABLE_INTERRUPTS_SYSEXIT32		\
-	swapgs;					\
-	sti;					\
-	sysexit
 
 #else
 #define INTERRUPT_RETURN		iret
diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
index 965c47d254aa..5f6051d5d139 100644
--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -976,11 +976,6 @@ extern void default_banner(void);
 	PARA_SITE(PARA_PATCH(pv_cpu_ops, PV_CPU_usergs_sysret64),	\
 		  CLBR_NONE,						\
 		  jmp PARA_INDIRECT(pv_cpu_ops+PV_CPU_usergs_sysret64))
-
-#define ENABLE_INTERRUPTS_SYSEXIT32					\
-	PARA_SITE(PARA_PATCH(pv_cpu_ops, PV_CPU_irq_enable_sysexit),	\
-		  CLBR_NONE,						\
-		  jmp PARA_INDIRECT(pv_cpu_ops+PV_CPU_irq_enable_sysexit))
 #endif	/* CONFIG_X86_32 */
 
 #endif /* __ASSEMBLY__ */
-- 
2.3.3

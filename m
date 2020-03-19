From: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 67/70] x86/head/64: Rename start_cpu0
Date: Thu, 19 Mar 2020 10:14:04 +0100
Message-ID: <20200319091407.1481-68-joro@8bytes.org>
References: <20200319091407.1481-1-joro@8bytes.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200319091407.1481-1-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
To: x86@kernel.org
Cc: hpa@zytor.com, Andy Lutomirski <luto@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Thomas Hellstrom <thellstrom@vmware.com>, Jiri Slaby <jslaby@suse.cz>, Dan Williams <dan.j.williams@intel.com>, Tom Lendacky <thomas.lendacky@amd.com>, Juergen Gross <jgross@suse.com>, Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, Joerg Roedel <joro@8bytes.org>, Joerg Roedel <jroedel@suse.de>
List-Id: virtualization@lists.linuxfoundation.org

From: Joerg Roedel <jroedel@suse.de>

For SEV-ES this entry point will be used for restarting APs after they
have been offlined. Remove the '0' from the name to reflect that.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 arch/x86/include/asm/cpu.h | 2 +-
 arch/x86/kernel/head_32.S  | 4 ++--
 arch/x86/kernel/head_64.S  | 6 +++---
 arch/x86/kernel/smpboot.c  | 4 ++--
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/x86/include/asm/cpu.h b/arch/x86/include/asm/cpu.h
index adc6cc86b062..00668daf8991 100644
--- a/arch/x86/include/asm/cpu.h
+++ b/arch/x86/include/asm/cpu.h
@@ -29,7 +29,7 @@ struct x86_cpu {
 #ifdef CONFIG_HOTPLUG_CPU
 extern int arch_register_cpu(int num);
 extern void arch_unregister_cpu(int);
-extern void start_cpu0(void);
+extern void start_cpu(void);
 #ifdef CONFIG_DEBUG_HOTPLUG_CPU0
 extern int _debug_hotplug_cpu(int cpu, int action);
 #endif
diff --git a/arch/x86/kernel/head_32.S b/arch/x86/kernel/head_32.S
index 3923ab4630d7..1a280152bd10 100644
--- a/arch/x86/kernel/head_32.S
+++ b/arch/x86/kernel/head_32.S
@@ -180,12 +180,12 @@ SYM_CODE_END(startup_32)
  * up already except stack. We just set up stack here. Then call
  * start_secondary().
  */
-SYM_FUNC_START(start_cpu0)
+SYM_FUNC_START(start_cpu)
 	movl initial_stack, %ecx
 	movl %ecx, %esp
 	call *(initial_code)
 1:	jmp 1b
-SYM_FUNC_END(start_cpu0)
+SYM_FUNC_END(start_cpu)
 #endif
 
 /*
diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index c935d6d07393..f2e793213fa7 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -299,15 +299,15 @@ SYM_CODE_END(secondary_startup_64)
 
 #ifdef CONFIG_HOTPLUG_CPU
 /*
- * Boot CPU0 entry point. It's called from play_dead(). Everything has been set
+ * CPU entry point. It's called from play_dead(). Everything has been set
  * up already except stack. We just set up stack here. Then call
  * start_secondary() via .Ljump_to_C_code.
  */
-SYM_CODE_START(start_cpu0)
+SYM_CODE_START(start_cpu)
 	UNWIND_HINT_EMPTY
 	movq	initial_stack(%rip), %rsp
 	jmp	.Ljump_to_C_code
-SYM_CODE_END(start_cpu0)
+SYM_CODE_END(start_cpu)
 #endif
 
 	/* Both SMP bootup and ACPI suspend change these variables */
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 69881b2d446c..19aa18f1e307 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -1717,7 +1717,7 @@ static inline void mwait_play_dead(void)
 		 * If NMI wants to wake up CPU0, start CPU0.
 		 */
 		if (wakeup_cpu0())
-			start_cpu0();
+			start_cpu();
 	}
 }
 
@@ -1732,7 +1732,7 @@ void hlt_play_dead(void)
 		 * If NMI wants to wake up CPU0, start CPU0.
 		 */
 		if (wakeup_cpu0())
-			start_cpu0();
+			start_cpu();
 	}
 }
 
-- 
2.17.1

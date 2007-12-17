From: Glauber de Oliveira Costa <gcosta@redhat.com>
Subject: [PATCH 4/21] [PATCH] move load_cr3 to a common place.
Date: Mon, 17 Dec 2007 20:52:27 -0200
Message-ID: <11979319853319-git-send-email-gcosta__28724.9289489866$1197942142$gmane$org@redhat.com>
References: <11979319641796-git-send-email-gcosta@redhat.com>
	<1197931971748-git-send-email-gcosta@redhat.com>
	<11979319763641-git-send-email-gcosta@redhat.com>
	<11979319811234-git-send-email-gcosta@redhat.com>
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <11979319811234-git-send-email-gcosta@redhat.com>
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

There are currently two definitions of load_cr3, that essentially do the
same thing. This patch moves them all to processor.h.

Signed-off-by: Glauber de Oliveira Costa <gcosta@redhat.com>
---
 include/asm-x86/mmu_context_64.h |    5 -----
 include/asm-x86/processor.h      |    7 +++++++
 include/asm-x86/processor_32.h   |    1 -
 3 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/include/asm-x86/mmu_context_64.h b/include/asm-x86/mmu_context_64.h
index 98bfe43..7e2aa23 100644
--- a/include/asm-x86/mmu_context_64.h
+++ b/include/asm-x86/mmu_context_64.h
@@ -23,11 +23,6 @@ static inline void enter_lazy_tlb(struct mm_struct *mm, struct task_struct *tsk)
 #endif
 }
 
-static inline void load_cr3(pgd_t *pgd)
-{
-	asm volatile("movq %0,%%cr3" :: "r" (__pa(pgd)) : "memory");
-}
-
 static inline void switch_mm(struct mm_struct *prev, struct mm_struct *next, 
 			     struct task_struct *tsk)
 {
diff --git a/include/asm-x86/processor.h b/include/asm-x86/processor.h
index e8dd394..36ee988 100644
--- a/include/asm-x86/processor.h
+++ b/include/asm-x86/processor.h
@@ -3,6 +3,9 @@
 
 #include <asm/processor-flags.h>
 
+#include <asm/page.h>
+#include <asm/system.h>
+
 static inline void native_cpuid(unsigned int *eax, unsigned int *ebx,
 					 unsigned int *ecx, unsigned int *edx)
 {
@@ -15,6 +18,10 @@ static inline void native_cpuid(unsigned int *eax, unsigned int *ebx,
 		: "0" (*eax), "2" (*ecx));
 }
 
+static inline void load_cr3(pgd_t *pgdir)
+{
+	write_cr3(__pa(pgdir));
+}
 
 #ifdef CONFIG_X86_32
 # include "processor_32.h"
diff --git a/include/asm-x86/processor_32.h b/include/asm-x86/processor_32.h
index cadeffb..b586902 100644
--- a/include/asm-x86/processor_32.h
+++ b/include/asm-x86/processor_32.h
@@ -120,7 +120,6 @@ extern void detect_ht(struct cpuinfo_x86 *c);
 static inline void detect_ht(struct cpuinfo_x86 *c) {}
 #endif
 
-#define load_cr3(pgdir) write_cr3(__pa(pgdir))
 
 /*
  * Save the cr4 feature set we're using (ie
-- 
1.4.4.2

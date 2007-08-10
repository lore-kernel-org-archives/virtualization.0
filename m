From: Glauber de Oliveira Costa <gcosta@redhat.com>
Subject: [PATCH 15/25 -v2] introducing paravirt_activate_mm
Date: Fri, 10 Aug 2007 16:12:27 -0300
Message-ID: <11867732323106-git-send-email-gcosta__49082.8716232956$1186784313$gmane$org@redhat.com>
References: <1186773157329-git-send-email-gcosta@redhat.com>
	<11867731633002-git-send-email-gcosta@redhat.com>
	<11867731681763-git-send-email-gcosta@redhat.com>
	<11867731732274-git-send-email-gcosta@redhat.com>
	<11867731781610-git-send-email-gcosta@redhat.com>
	<11867731831138-git-send-email-gcosta@redhat.com>
	<11867731882768-git-send-email-gcosta@redhat.com>
	<11867731932688-git-send-email-gcosta@redhat.com>
	<11867731981891-git-send-email-gcosta@redhat.com>
	<1186773203887-git-send-email-gcosta@redhat.com>
	<11867732082735-git-send-email-gcosta@redhat.com>
	<11867732121974-git-send-email-gcosta@redhat.com>
	<1186773217875-git-send-email-gcosta@redhat.com>
	<11867732221652-git-send-email-gcosta@redhat.com>
	<11867732273108-git-send-email-gcosta@redhat.com>
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <11867732273108-git-send-email-gcosta@redhat.com>
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
Cc: lguest@ozlabs.org, virtualization@lists.linux-foundation.org, chrisw@sous-sol.org, anthony@codemonkey.ws, akpm@linux-foundation.org, Glauber de Oliveira Costa <gcosta@redhat.com>, mingo@elte.hu
List-Id: virtualization@lists.linuxfoundation.org

This function/macro will allow a paravirt guest to be notified we changed
the current task cr3, and act upon it. It's up to them

Signed-off-by: Glauber de Oliveira Costa <gcosta@redhat.com>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 include/asm-x86_64/mmu_context.h |   17 ++++++++++++++---
 1 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/include/asm-x86_64/mmu_context.h b/include/asm-x86_64/mmu_context.h
index 9592698..77ce047 100644
--- a/include/asm-x86_64/mmu_context.h
+++ b/include/asm-x86_64/mmu_context.h
@@ -7,7 +7,16 @@
 #include <asm/pda.h>
 #include <asm/pgtable.h>
 #include <asm/tlbflush.h>
+
+#ifdef CONFIG_PARAVIRT
+#include <asm/paravirt.h>
+#else
 #include <asm-generic/mm_hooks.h>
+static inline void paravirt_activate_mm(struct mm_struct *prev,
+					struct mm_struct *next)
+{
+}
+#endif /* CONFIG_PARAVIRT */
 
 /*
  * possibly do the LDT unload here?
@@ -67,8 +76,10 @@ static inline void switch_mm(struct mm_struct *prev, struct mm_struct *next,
 	asm volatile("movl %0,%%fs"::"r"(0));  \
 } while(0)
 
-#define activate_mm(prev, next) \
-	switch_mm((prev),(next),NULL)
-
+#define activate_mm(prev, next) 		\
+do {						\
+	paravirt_activate_mm(prev, next);	\
+	switch_mm((prev),(next),NULL);		\
+} while (0)
 
 #endif
-- 
1.4.4.2

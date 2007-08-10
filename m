From: Glauber de Oliveira Costa <gcosta@redhat.com>
Subject: [PATCH 14/25 -v2] get rid of inline asm for load_cr3
Date: Fri, 10 Aug 2007 16:12:26 -0300
Message-ID: <11867732273108-git-send-email-gcosta__12240.823559887$1186784204$gmane$org@redhat.com>
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
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <11867732221652-git-send-email-gcosta@redhat.com>
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

Besides not elegant, it is now even forbidden, since it can
break paravirtualized guests. load_cr3 should call write_cr3()
instead.

Signed-off-by: Glauber de Oliveira Costa <gcosta@redhat.com>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 include/asm-x86_64/mmu_context.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/include/asm-x86_64/mmu_context.h b/include/asm-x86_64/mmu_context.h
index c8cdc1e..9592698 100644
--- a/include/asm-x86_64/mmu_context.h
+++ b/include/asm-x86_64/mmu_context.h
@@ -25,7 +25,7 @@ static inline void enter_lazy_tlb(struct mm_struct *mm, struct task_struct *tsk)
 
 static inline void load_cr3(pgd_t *pgd)
 {
-	asm volatile("movq %0,%%cr3" :: "r" (__pa(pgd)) : "memory");
+	write_cr3(__pa(pgd));
 }
 
 static inline void switch_mm(struct mm_struct *prev, struct mm_struct *next, 
-- 
1.4.4.2

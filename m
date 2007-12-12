From: Glauber de Oliveira Costa <gcosta@redhat.com>
Subject: [PATCH 16/19] modify get_desc_base
Date: Wed, 12 Dec 2007 10:54:01 -0200
Message-ID: <1197464145737-git-send-email-gcosta__441.172431647097$1197474860$gmane$org@redhat.com>
References: <1196957800568-git-send-email-gcosta@redhat.com>
	<11974640441088-git-send-email-gcosta@redhat.com>
	<11974640522688-git-send-email-gcosta@redhat.com>
	<1197464057242-git-send-email-gcosta@redhat.com>
	<11974640653022-git-send-email-gcosta@redhat.com>
	<1197464070228-git-send-email-gcosta@redhat.com>
	<11974640752137-git-send-email-gcosta@redhat.com>
	<11974640813511-git-send-email-gcosta@redhat.com>
	<11974640872474-git-send-email-gcosta@redhat.com>
	<11974640932406-git-send-email-gcosta@redhat.com>
	<11974640983333-git-send-email-gcosta@redhat.com>
	<11974641042757-git-send-email-gcosta@redhat.com>
	<11974641102691-git-send-email-gcosta@redhat.com>
	<11974641172402-git-send-email-gcosta@redhat.com>
	<11974641243264-git-send-email-gcosta@redhat.com>
	<11974641314148-git-send-email-gcosta@redhat.com>
	<1197464139284-git-send-email-gcosta@redhat.com>
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1197464139284-git-send-email-gcosta@redhat.com>
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

This patch makes get_desc_base() receive a struct desc_struct,
and then uses its internal fields to compute the base address.

Signed-off-by: Glauber de Oliveira Costa <gcosta@redhat.com>
---
 arch/x86/kernel/tls.c  |    2 +-
 arch/x86/mm/fault_32.c |    2 +-
 include/asm-x86/desc.h |    8 ++------
 3 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kernel/tls.c b/arch/x86/kernel/tls.c
index 74d2b65..98f428b 100644
--- a/arch/x86/kernel/tls.c
+++ b/arch/x86/kernel/tls.c
@@ -112,7 +112,7 @@ int do_get_thread_area(struct task_struct *p, int idx,
 
 	memset(&info, 0, sizeof(struct user_desc));
 	info.entry_number = idx;
-	info.base_addr = get_desc_base((void *)desc);
+	info.base_addr = get_desc_base((struct desc_struct *)desc);
 	info.limit = GET_LIMIT(desc);
 	info.seg_32bit = GET_32BIT(desc);
 	info.contents = GET_CONTENTS(desc);
diff --git a/arch/x86/mm/fault_32.c b/arch/x86/mm/fault_32.c
index 6056c6d..ef5ab2b 100644
--- a/arch/x86/mm/fault_32.c
+++ b/arch/x86/mm/fault_32.c
@@ -115,7 +115,7 @@ static inline unsigned long get_segment_eip(struct pt_regs *regs,
 	}
 
 	/* Decode the code segment base from the descriptor */
-	base = get_desc_base((unsigned long *)desc);
+	base = get_desc_base((struct desc_struct *)desc);
 
 	if (seg & (1<<2)) { 
 		mutex_unlock(&current->mm->context.lock);
diff --git a/include/asm-x86/desc.h b/include/asm-x86/desc.h
index 926d6f8..3480cb1 100644
--- a/include/asm-x86/desc.h
+++ b/include/asm-x86/desc.h
@@ -55,13 +55,9 @@ static inline void load_LDT(mm_context_t *pc)
 	preempt_enable();
 }
 
-static inline unsigned long get_desc_base(unsigned long *desc)
+static inline unsigned long get_desc_base(struct desc_struct *desc)
 {
-	unsigned long base;
-	base = ((desc[0] >> 16)  & 0x0000ffff) |
-		((desc[1] << 16) & 0x00ff0000) |
-		(desc[1] & 0xff000000);
-	return base;
+	return desc->base0 | ((desc->base1) << 16) | ((desc->base2) << 24);
 }
 
 #else
-- 
1.5.0.6

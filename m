Return-Path: <SRS0=nl1Y=CC=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 469D7C433E1
	for <virtualization@archiver.kernel.org>; Mon, 24 Aug 2020 09:08:07 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1CF44206F0
	for <virtualization@archiver.kernel.org>; Mon, 24 Aug 2020 09:08:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CF44206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id B342420535;
	Mon, 24 Aug 2020 09:08:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dwCiKZF0iCUp; Mon, 24 Aug 2020 09:07:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id A5AE82076B;
	Mon, 24 Aug 2020 09:07:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 904EDC089E;
	Mon, 24 Aug 2020 09:07:14 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F27A1C016F
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Aug 2020 09:07:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id D42042052C
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Aug 2020 09:07:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WZ346m22dnUA
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Aug 2020 09:06:55 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
 by silver.osuosl.org (Postfix) with ESMTPS id 158D520516
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Aug 2020 09:06:51 +0000 (UTC)
Received: from cap.home.8bytes.org (p4ff2bb8d.dip0.t-ipconnect.de
 [79.242.187.141])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by theia.8bytes.org (Postfix) with ESMTPSA id 53DCCF8E;
 Mon, 24 Aug 2020 10:56:14 +0200 (CEST)
From: Joerg Roedel <joro@8bytes.org>
To: x86@kernel.org
Subject: [PATCH v6 45/76] x86/sev-es: Allocate and Map IST stack for #VC
 handler
Date: Mon, 24 Aug 2020 10:54:40 +0200
Message-Id: <20200824085511.7553-46-joro@8bytes.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200824085511.7553-1-joro@8bytes.org>
References: <20200824085511.7553-1-joro@8bytes.org>
MIME-Version: 1.0
Cc: Juergen Gross <jgross@suse.com>, Tom Lendacky <thomas.lendacky@amd.com>,
 Joerg Roedel <jroedel@suse.de>, Mike Stunes <mstunes@vmware.com>,
 Kees Cook <keescook@chromium.org>, kvm@vger.kernel.org,
 Peter Zijlstra <peterz@infradead.org>, Cfir Cohen <cfir@google.com>,
 Joerg Roedel <joro@8bytes.org>, Dave Hansen <dave.hansen@linux.intel.com>,
 linux-kernel@vger.kernel.org,
 Sean Christopherson <sean.j.christopherson@intel.com>,
 virtualization@lists.linux-foundation.org,
 Martin Radev <martin.b.radev@gmail.com>,
 Masami Hiramatsu <mhiramat@kernel.org>, Andy Lutomirski <luto@kernel.org>,
 hpa@zytor.com, Erdem Aktas <erdemaktas@google.com>,
 David Rientjes <rientjes@google.com>, Dan Williams <dan.j.williams@intel.com>,
 Jiri Slaby <jslaby@suse.cz>
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

From: Joerg Roedel <jroedel@suse.de>

Allocate and map an IST stack and an additional fall-back stack for
the #VC handler.  The memory for the stacks is allocated only when
SEV-ES is active.

The #VC handler needs to use an IST stack because it could be raised
from kernel space with unsafe stack, e.g. in the SYSCALL entry path.

Since the #VC exception can be nested, the #VC handler switches back to
the interrupted stack when entered from kernel space. If switching back
is not possible the fall-back stack is used.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
Link: https://lore.kernel.org/r/20200724160336.5435-45-joro@8bytes.org
---
 arch/x86/include/asm/cpu_entry_area.h | 33 +++++++++++++++++----------
 arch/x86/include/asm/page_64_types.h  |  1 +
 arch/x86/kernel/cpu/common.c          |  2 ++
 arch/x86/kernel/dumpstack_64.c        |  8 +++++--
 arch/x86/kernel/sev-es.c              | 33 +++++++++++++++++++++++++++
 5 files changed, 63 insertions(+), 14 deletions(-)

diff --git a/arch/x86/include/asm/cpu_entry_area.h b/arch/x86/include/asm/cpu_entry_area.h
index 8902fdb7de13..f87e4c0c16f4 100644
--- a/arch/x86/include/asm/cpu_entry_area.h
+++ b/arch/x86/include/asm/cpu_entry_area.h
@@ -11,25 +11,29 @@
 #ifdef CONFIG_X86_64
 
 /* Macro to enforce the same ordering and stack sizes */
-#define ESTACKS_MEMBERS(guardsize)		\
-	char	DF_stack_guard[guardsize];	\
-	char	DF_stack[EXCEPTION_STKSZ];	\
-	char	NMI_stack_guard[guardsize];	\
-	char	NMI_stack[EXCEPTION_STKSZ];	\
-	char	DB_stack_guard[guardsize];	\
-	char	DB_stack[EXCEPTION_STKSZ];	\
-	char	MCE_stack_guard[guardsize];	\
-	char	MCE_stack[EXCEPTION_STKSZ];	\
-	char	IST_top_guard[guardsize];	\
+#define ESTACKS_MEMBERS(guardsize, optional_stack_size)		\
+	char	DF_stack_guard[guardsize];			\
+	char	DF_stack[EXCEPTION_STKSZ];			\
+	char	NMI_stack_guard[guardsize];			\
+	char	NMI_stack[EXCEPTION_STKSZ];			\
+	char	DB_stack_guard[guardsize];			\
+	char	DB_stack[EXCEPTION_STKSZ];			\
+	char	MCE_stack_guard[guardsize];			\
+	char	MCE_stack[EXCEPTION_STKSZ];			\
+	char	VC_stack_guard[guardsize];			\
+	char	VC_stack[optional_stack_size];			\
+	char	VC2_stack_guard[guardsize];			\
+	char	VC2_stack[optional_stack_size];			\
+	char	IST_top_guard[guardsize];			\
 
 /* The exception stacks' physical storage. No guard pages required */
 struct exception_stacks {
-	ESTACKS_MEMBERS(0)
+	ESTACKS_MEMBERS(0, 0)
 };
 
 /* The effective cpu entry area mapping with guard pages. */
 struct cea_exception_stacks {
-	ESTACKS_MEMBERS(PAGE_SIZE)
+	ESTACKS_MEMBERS(PAGE_SIZE, EXCEPTION_STKSZ)
 };
 
 /*
@@ -40,6 +44,8 @@ enum exception_stack_ordering {
 	ESTACK_NMI,
 	ESTACK_DB,
 	ESTACK_MCE,
+	ESTACK_VC,
+	ESTACK_VC2,
 	N_EXCEPTION_STACKS
 };
 
@@ -139,4 +145,7 @@ static inline struct entry_stack *cpu_entry_stack(int cpu)
 #define __this_cpu_ist_top_va(name)					\
 	CEA_ESTACK_TOP(__this_cpu_read(cea_exception_stacks), name)
 
+#define __this_cpu_ist_bot_va(name)					\
+	CEA_ESTACK_BOT(__this_cpu_read(cea_exception_stacks), name)
+
 #endif
diff --git a/arch/x86/include/asm/page_64_types.h b/arch/x86/include/asm/page_64_types.h
index 288b065955b7..d0c6c10c18a0 100644
--- a/arch/x86/include/asm/page_64_types.h
+++ b/arch/x86/include/asm/page_64_types.h
@@ -28,6 +28,7 @@
 #define	IST_INDEX_NMI		1
 #define	IST_INDEX_DB		2
 #define	IST_INDEX_MCE		3
+#define	IST_INDEX_VC		4
 
 /*
  * Set __PAGE_OFFSET to the most negative possible address +
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 8aa20bc2f1ca..1d65365363a1 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1821,6 +1821,8 @@ static inline void tss_setup_ist(struct tss_struct *tss)
 	tss->x86_tss.ist[IST_INDEX_NMI] = __this_cpu_ist_top_va(NMI);
 	tss->x86_tss.ist[IST_INDEX_DB] = __this_cpu_ist_top_va(DB);
 	tss->x86_tss.ist[IST_INDEX_MCE] = __this_cpu_ist_top_va(MCE);
+	/* Only mapped when SEV-ES is active */
+	tss->x86_tss.ist[IST_INDEX_VC] = __this_cpu_ist_top_va(VC);
 }
 
 #else /* CONFIG_X86_64 */
diff --git a/arch/x86/kernel/dumpstack_64.c b/arch/x86/kernel/dumpstack_64.c
index 4a94d38cd141..c49cf594714b 100644
--- a/arch/x86/kernel/dumpstack_64.c
+++ b/arch/x86/kernel/dumpstack_64.c
@@ -24,11 +24,13 @@ static const char * const exception_stack_names[] = {
 		[ ESTACK_NMI	]	= "NMI",
 		[ ESTACK_DB	]	= "#DB",
 		[ ESTACK_MCE	]	= "#MC",
+		[ ESTACK_VC	]	= "#VC",
+		[ ESTACK_VC2	]	= "#VC2",
 };
 
 const char *stack_type_name(enum stack_type type)
 {
-	BUILD_BUG_ON(N_EXCEPTION_STACKS != 4);
+	BUILD_BUG_ON(N_EXCEPTION_STACKS != 6);
 
 	if (type == STACK_TYPE_IRQ)
 		return "IRQ";
@@ -79,6 +81,8 @@ struct estack_pages estack_pages[CEA_ESTACK_PAGES] ____cacheline_aligned = {
 	EPAGERANGE(NMI),
 	EPAGERANGE(DB),
 	EPAGERANGE(MCE),
+	EPAGERANGE(VC),
+	EPAGERANGE(VC2),
 };
 
 static bool in_exception_stack(unsigned long *stack, struct stack_info *info)
@@ -88,7 +92,7 @@ static bool in_exception_stack(unsigned long *stack, struct stack_info *info)
 	struct pt_regs *regs;
 	unsigned int k;
 
-	BUILD_BUG_ON(N_EXCEPTION_STACKS != 4);
+	BUILD_BUG_ON(N_EXCEPTION_STACKS != 6);
 
 	begin = (unsigned long)__this_cpu_read(cea_exception_stacks);
 	/*
diff --git a/arch/x86/kernel/sev-es.c b/arch/x86/kernel/sev-es.c
index 734afaee378d..64002d86a237 100644
--- a/arch/x86/kernel/sev-es.c
+++ b/arch/x86/kernel/sev-es.c
@@ -17,6 +17,7 @@
 #include <linux/kernel.h>
 #include <linux/mm.h>
 
+#include <asm/cpu_entry_area.h>
 #include <asm/sev-es.h>
 #include <asm/insn-eval.h>
 #include <asm/fpu/internal.h>
@@ -37,10 +38,41 @@ static struct ghcb __initdata *boot_ghcb;
 /* #VC handler runtime per-cpu data */
 struct sev_es_runtime_data {
 	struct ghcb ghcb_page;
+
+	/* Physical storage for the per-cpu IST stack of the #VC handler */
+	char ist_stack[EXCEPTION_STKSZ] __aligned(PAGE_SIZE);
+
+	/*
+	 * Physical storage for the per-cpu fall-back stack of the #VC handler.
+	 * The fall-back stack is used when it is not safe to switch back to the
+	 * interrupted stack in the #VC entry code.
+	 */
+	char fallback_stack[EXCEPTION_STKSZ] __aligned(PAGE_SIZE);
 };
 
 static DEFINE_PER_CPU(struct sev_es_runtime_data*, runtime_data);
 
+static void __init sev_es_setup_vc_stacks(int cpu)
+{
+	struct sev_es_runtime_data *data;
+	struct cpu_entry_area *cea;
+	unsigned long vaddr;
+	phys_addr_t pa;
+
+	data = per_cpu(runtime_data, cpu);
+	cea  = get_cpu_entry_area(cpu);
+
+	/* Map #VC IST stack */
+	vaddr = CEA_ESTACK_BOT(&cea->estacks, VC);
+	pa    = __pa(data->ist_stack);
+	cea_set_pte((void *)vaddr, pa, PAGE_KERNEL);
+
+	/* Map VC fall-back stack */
+	vaddr = CEA_ESTACK_BOT(&cea->estacks, VC2);
+	pa    = __pa(data->fallback_stack);
+	cea_set_pte((void *)vaddr, pa, PAGE_KERNEL);
+}
+
 /* Needed in vc_early_forward_exception */
 void do_early_exception(struct pt_regs *regs, int trapnr);
 
@@ -249,6 +281,7 @@ void __init sev_es_init_vc_handling(void)
 	for_each_possible_cpu(cpu) {
 		sev_es_alloc_runtime_data(cpu);
 		sev_es_init_ghcb(cpu);
+		sev_es_setup_vc_stacks(cpu);
 	}
 }
 
-- 
2.28.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

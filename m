Return-Path: <SRS0=nl1Y=CC=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED3C9C433DF
	for <virtualization@archiver.kernel.org>; Mon, 24 Aug 2020 09:07:09 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5E43206F0
	for <virtualization@archiver.kernel.org>; Mon, 24 Aug 2020 09:07:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5E43206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 7E580860FD;
	Mon, 24 Aug 2020 09:07:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cCQBN67wiNN9; Mon, 24 Aug 2020 09:07:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 8EB8B85F94;
	Mon, 24 Aug 2020 09:07:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 834E5C0895;
	Mon, 24 Aug 2020 09:07:05 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9EBC9C0051
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Aug 2020 09:06:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 83F0320794
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Aug 2020 09:06:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qrG2wbcWv15u
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Aug 2020 09:06:50 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
 by silver.osuosl.org (Postfix) with ESMTPS id 028BE204EB
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Aug 2020 09:06:50 +0000 (UTC)
Received: from cap.home.8bytes.org (p4ff2bb8d.dip0.t-ipconnect.de
 [79.242.187.141])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by theia.8bytes.org (Postfix) with ESMTPSA id F2009DE0;
 Mon, 24 Aug 2020 10:56:28 +0200 (CEST)
From: Joerg Roedel <joro@8bytes.org>
To: x86@kernel.org
Subject: [PATCH v6 70/76] x86/smpboot: Setup TSS for starting AP
Date: Mon, 24 Aug 2020 10:55:05 +0200
Message-Id: <20200824085511.7553-71-joro@8bytes.org>
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

Set up the TSS for starting APs before they are kicked. This allows the
APs to use IST in early exception handling.

Also load the TSS early if the TSS entry in the GDT is present. This
makes sure a TSS is only loaded when it has been set up.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
Link: https://lore.kernel.org/r/20200724160336.5435-70-joro@8bytes.org
---
 arch/x86/include/asm/processor.h |  7 ++++++
 arch/x86/include/asm/setup.h     |  1 +
 arch/x86/kernel/cpu/common.c     | 37 +++++++++++++++++++-------------
 arch/x86/kernel/head64.c         | 11 ++++++++++
 arch/x86/kernel/head_64.S        |  5 +++++
 arch/x86/kernel/smpboot.c        |  6 ++++++
 6 files changed, 52 insertions(+), 15 deletions(-)

diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 97143d87994c..2cc72d583003 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -697,6 +697,13 @@ extern void load_fixmap_gdt(int);
 extern void load_percpu_segment(int);
 extern void cpu_init(void);
 extern void cr4_init(void);
+extern void tss_setup(int cpu);
+
+#ifdef CONFIG_X86_64
+extern void setup_getcpu(int cpu);
+#else
+static inline void setup_getcpu(int cpu) { }
+#endif
 
 static inline unsigned long get_debugctlmsr(void)
 {
diff --git a/arch/x86/include/asm/setup.h b/arch/x86/include/asm/setup.h
index 0ce6453c9272..bbd40dd20be7 100644
--- a/arch/x86/include/asm/setup.h
+++ b/arch/x86/include/asm/setup.h
@@ -54,6 +54,7 @@ extern void startup_64_setup_env(unsigned long physbase);
 extern void early_idt_setup_early_handler(unsigned long physaddr);
 extern void early_load_idt(void);
 extern void early_idt_setup(unsigned long physbase);
+extern void early_load_tss(void);
 extern void __init do_early_exception(struct pt_regs *regs, int trapnr);
 
 #ifdef CONFIG_X86_INTEL_MID
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 1d65365363a1..f98efb6f988f 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1787,7 +1787,7 @@ static void wait_for_master_cpu(int cpu)
 }
 
 #ifdef CONFIG_X86_64
-static inline void setup_getcpu(int cpu)
+void setup_getcpu(int cpu)
 {
 	unsigned long cpudata = vdso_encode_cpunode(cpu, early_cpu_to_node(cpu));
 	struct desc_struct d = { };
@@ -1814,27 +1814,26 @@ static inline void ucode_cpu_init(int cpu)
 		load_ucode_ap();
 }
 
-static inline void tss_setup_ist(struct tss_struct *tss)
+static inline void tss_setup_ist(struct tss_struct *tss,
+				 struct cpu_entry_area *cea)
 {
 	/* Set up the per-CPU TSS IST stacks */
-	tss->x86_tss.ist[IST_INDEX_DF] = __this_cpu_ist_top_va(DF);
-	tss->x86_tss.ist[IST_INDEX_NMI] = __this_cpu_ist_top_va(NMI);
-	tss->x86_tss.ist[IST_INDEX_DB] = __this_cpu_ist_top_va(DB);
-	tss->x86_tss.ist[IST_INDEX_MCE] = __this_cpu_ist_top_va(MCE);
+	tss->x86_tss.ist[IST_INDEX_DF]  = CEA_ESTACK_TOP(&cea->estacks, DF);
+	tss->x86_tss.ist[IST_INDEX_NMI] = CEA_ESTACK_TOP(&cea->estacks, NMI);
+	tss->x86_tss.ist[IST_INDEX_DB]  = CEA_ESTACK_TOP(&cea->estacks, DB);
+	tss->x86_tss.ist[IST_INDEX_MCE] = CEA_ESTACK_TOP(&cea->estacks, MCE);
 	/* Only mapped when SEV-ES is active */
-	tss->x86_tss.ist[IST_INDEX_VC] = __this_cpu_ist_top_va(VC);
+	tss->x86_tss.ist[IST_INDEX_VC]	= CEA_ESTACK_TOP(&cea->estacks, VC);
 }
 
 #else /* CONFIG_X86_64 */
 
-static inline void setup_getcpu(int cpu) { }
-
 static inline void ucode_cpu_init(int cpu)
 {
 	show_ucode_info_early();
 }
 
-static inline void tss_setup_ist(struct tss_struct *tss) { }
+static inline void tss_setup_ist(struct tss_struct *tss, struct cpu_entry_area *cea) { }
 
 #endif /* !CONFIG_X86_64 */
 
@@ -1854,6 +1853,17 @@ static inline void tss_setup_io_bitmap(struct tss_struct *tss)
 #endif
 }
 
+void tss_setup(int cpu)
+{
+	struct tss_struct *tss = per_cpu_ptr(&cpu_tss_rw, cpu);
+	struct cpu_entry_area *cea = get_cpu_entry_area(cpu);
+
+	/* Initialize the TSS for cpu. */
+	tss_setup_ist(tss, cea);
+	tss_setup_io_bitmap(tss);
+	set_tss_desc(cpu, &cea->tss.x86_tss);
+}
+
 /*
  * cpu_init() initializes state that is per-CPU. Some data is already
  * initialized (naturally) in the bootstrap process, such as the GDT
@@ -1862,7 +1872,6 @@ static inline void tss_setup_io_bitmap(struct tss_struct *tss)
  */
 void cpu_init(void)
 {
-	struct tss_struct *tss = this_cpu_ptr(&cpu_tss_rw);
 	struct task_struct *cur = current;
 	int cpu = raw_smp_processor_id();
 
@@ -1908,10 +1917,8 @@ void cpu_init(void)
 	initialize_tlbstate_and_flush();
 	enter_lazy_tlb(&init_mm, cur);
 
-	/* Initialize the TSS. */
-	tss_setup_ist(tss);
-	tss_setup_io_bitmap(tss);
-	set_tss_desc(cpu, &get_cpu_entry_area(cpu)->tss.x86_tss);
+	/* Initialize the TSS - Only needed on the boot-CPU */
+	tss_setup(cpu);
 
 	load_TR_desc();
 	/*
diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index ce2d8284edb9..b26a7f1bd6fe 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -545,3 +545,14 @@ void __head startup_64_setup_env(unsigned long physbase)
 	gsbase = (unsigned long)fixup_pointer((void *)initial_gs, physbase);
 	__wrmsr(MSR_GS_BASE, (u32)gsbase, (u32)(gsbase >> 32));
 }
+
+void __head early_load_tss(void)
+{
+	struct desc_struct *gdt = (struct desc_struct *)early_gdt_descr.address;
+	tss_desc tss;
+
+	/* Load TSS only if entry in GDT is marked present */
+	memcpy(&tss, &gdt[GDT_ENTRY_TSS], sizeof(tss_desc));
+	if (tss.p)
+		asm volatile("ltr %w0"::"q" (GDT_ENTRY_TSS*8));
+}
diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index 12bf6f11fd83..8d5bf7c568a4 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -220,6 +220,11 @@ SYM_CODE_START(secondary_startup_64)
 	 */
 	movq initial_stack(%rip), %rsp
 
+	/* Setup a TSS for early IST handlers - needs %gs to be set up */
+	pushq	%rsi
+	call	early_load_tss
+	popq	%rsi
+
 	/* Load IDT */
 	pushq	%rsi
 	call	early_load_idt
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 27aa04a95702..fb55d28332e2 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -1040,6 +1040,12 @@ static int do_boot_cpu(int apicid, int cpu, struct task_struct *idle,
 	/* Enable the espfix hack for this CPU */
 	init_espfix_ap(cpu);
 
+	/* Set up GDT_ENTRY_CPUNODE for early exception handling */
+	setup_getcpu(cpu);
+
+	/* Setup TSS so that AP can use IST early */
+	tss_setup(cpu);
+
 	/* So we see what's up */
 	announce_cpu(cpu, apicid);
 
-- 
2.28.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

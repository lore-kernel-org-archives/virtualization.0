Return-Path: <SRS0=H/CR=HL=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C3DEC433DB
	for <virtualization@archiver.kernel.org>; Tue,  9 Feb 2021 22:21:26 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C52BC64E4F
	for <virtualization@archiver.kernel.org>; Tue,  9 Feb 2021 22:21:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C52BC64E4F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 9D1B885B3B;
	Tue,  9 Feb 2021 22:21:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oN29J8ZBSXY6; Tue,  9 Feb 2021 22:21:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 5A7FC85B25;
	Tue,  9 Feb 2021 22:21:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 52291C0174;
	Tue,  9 Feb 2021 22:21:24 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A8EEEC013A
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Feb 2021 22:21:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 9612386C10
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Feb 2021 22:21:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cO-dme5Nf6sE
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Feb 2021 22:21:22 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com
 [209.85.214.175])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 5E3B6868E2
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Feb 2021 22:21:22 +0000 (UTC)
Received: by mail-pl1-f175.google.com with SMTP id b8so66322plh.12
 for <virtualization@lists.linux-foundation.org>;
 Tue, 09 Feb 2021 14:21:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=jOyYx1TDjb2A4gHSVOiGYO/bJUu5bLpN/42e2o+FxXM=;
 b=ZudShlgecDcgL2Wf7EG99R2XM3pqdJk3GWkX8vluBL6fzf8DqgL/EzorucwyMsx473
 cWp4bOxGdoorhZtXy7Tr0y1KlPEImuVeXVMi3aIYKeYFmsEGAWYZ4r1y5xDQglrr889X
 NL7wsA8Vp6Tak9bbZi4PWSpfHM5dcxpZ9rkveVr53WNiLM//4j+SpsZXoB5wdDi4C+dI
 NN+OA9jejs5MTmkLQKWHNCRrHffajpvUi6XNEXyxRG9f9fvB8a0qHZxPuNYKe61jRasg
 MIAm1hLLu6hshupMPGoLrP0BL9DLL3SmxlC1gHjdFuC4JmTPNsiwBdutV/opH2MChwlF
 4oHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=jOyYx1TDjb2A4gHSVOiGYO/bJUu5bLpN/42e2o+FxXM=;
 b=kt7O84G+wpPbCsQOYdtKDKnmymKf46afgH+5lw70+kPiQpFG2Wh6x8GGK7zt0YdPzy
 MtyWxXYSPJB9X2pw0E2NoeJz8TN0xXz5ZkoYqezjYrsLKOPxUdy1JAsADMppCUor5DFa
 7sxZSLkRxpHkl2dGjBRgTJ2HIhRvZG9gGJ2GjeSUCULXsgwWA1u0CvoZVpXb4N67yhMc
 QR1fd7Em6D4ORf7UT2q47JSns/OLmoS4GUZTcUxAYSubWrNrKoG88J7VyDhvIpg5AlmL
 0NpK+5T9WC+XW5qsKytpZLOKralEDEkRe1flqWoL3cQfu5WTR6xmxGyJq8KBNDcbx231
 H4EQ==
X-Gm-Message-State: AOAM531pa1TfEcZdOwQgn5QQrKuzFZ7xf7/Xw2DXMnHri6d9vLcbFVEn
 G7xTMaf4vUoAjlhfflS3mgQ=
X-Google-Smtp-Source: ABdhPJwGDIgAQd0D3Bj7K7xE4Obh8SaZ1xW5cnD9EhQUhLiG0OIrXKXpw3elA2mYDupV4v1VuXjmJQ==
X-Received: by 2002:a17:90a:fc3:: with SMTP id 61mr8462pjz.197.1612909281819; 
 Tue, 09 Feb 2021 14:21:21 -0800 (PST)
Received: from sc2-haas01-esx0118.eng.vmware.com ([66.170.99.1])
 by smtp.gmail.com with ESMTPSA id v9sm58601pju.33.2021.02.09.14.21.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Feb 2021 14:21:21 -0800 (PST)
From: Nadav Amit <nadav.amit@gmail.com>
X-Google-Original-From: Nadav Amit
To: Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH v5 4/8] x86/mm/tlb: Flush remote and local TLBs concurrently
Date: Tue,  9 Feb 2021 14:16:49 -0800
Message-Id: <20210209221653.614098-5-namit@vmware.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210209221653.614098-1-namit@vmware.com>
References: <20210209221653.614098-1-namit@vmware.com>
MIME-Version: 1.0
Cc: Sasha Levin <sashal@kernel.org>, Juergen Gross <jgross@suse.com>,
 linux-hyperv@vger.kernel.org, x86@kernel.org,
 Stephen Hemminger <sthemmin@microsoft.com>, xen-devel@lists.xenproject.org,
 kvm@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
 Haiyang Zhang <haiyangz@microsoft.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, Ingo Molnar <mingo@redhat.com>,
 Nadav Amit <namit@vmware.com>, Andy Lutomirski <luto@kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Michael Kelley <mikelley@microsoft.com>
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

From: Nadav Amit <namit@vmware.com>

To improve TLB shootdown performance, flush the remote and local TLBs
concurrently. Introduce flush_tlb_multi() that does so. Introduce
paravirtual versions of flush_tlb_multi() for KVM, Xen and hyper-v (Xen
and hyper-v are only compile-tested).

While the updated smp infrastructure is capable of running a function on
a single local core, it is not optimized for this case. The multiple
function calls and the indirect branch introduce some overhead, and
might make local TLB flushes slower than they were before the recent
changes.

Before calling the SMP infrastructure, check if only a local TLB flush
is needed to restore the lost performance in this common case. This
requires to check mm_cpumask() one more time, but unless this mask is
updated very frequently, this should impact performance negatively.

Cc: "K. Y. Srinivasan" <kys@microsoft.com>
Cc: Haiyang Zhang <haiyangz@microsoft.com>
Cc: Stephen Hemminger <sthemmin@microsoft.com>
Cc: Sasha Levin <sashal@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org
Cc: Juergen Gross <jgross@suse.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: linux-hyperv@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: virtualization@lists.linux-foundation.org
Cc: kvm@vger.kernel.org
Cc: xen-devel@lists.xenproject.org
Reviewed-by: Michael Kelley <mikelley@microsoft.com> # Hyper-v parts
Reviewed-by: Juergen Gross <jgross@suse.com> # Xen and paravirt parts
Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Nadav Amit <namit@vmware.com>
---
 arch/x86/hyperv/mmu.c                 | 10 +++---
 arch/x86/include/asm/paravirt.h       |  6 ++--
 arch/x86/include/asm/paravirt_types.h |  4 +--
 arch/x86/include/asm/tlbflush.h       |  4 +--
 arch/x86/include/asm/trace/hyperv.h   |  2 +-
 arch/x86/kernel/kvm.c                 | 11 ++++--
 arch/x86/mm/tlb.c                     | 49 +++++++++++++++++----------
 arch/x86/xen/mmu_pv.c                 | 11 +++---
 include/trace/events/xen.h            |  2 +-
 9 files changed, 58 insertions(+), 41 deletions(-)

diff --git a/arch/x86/hyperv/mmu.c b/arch/x86/hyperv/mmu.c
index 2c87350c1fb0..681dba8de4f2 100644
--- a/arch/x86/hyperv/mmu.c
+++ b/arch/x86/hyperv/mmu.c
@@ -52,8 +52,8 @@ static inline int fill_gva_list(u64 gva_list[], int offset,
 	return gva_n - offset;
 }
 
-static void hyperv_flush_tlb_others(const struct cpumask *cpus,
-				    const struct flush_tlb_info *info)
+static void hyperv_flush_tlb_multi(const struct cpumask *cpus,
+				   const struct flush_tlb_info *info)
 {
 	int cpu, vcpu, gva_n, max_gvas;
 	struct hv_tlb_flush **flush_pcpu;
@@ -61,7 +61,7 @@ static void hyperv_flush_tlb_others(const struct cpumask *cpus,
 	u64 status = U64_MAX;
 	unsigned long flags;
 
-	trace_hyperv_mmu_flush_tlb_others(cpus, info);
+	trace_hyperv_mmu_flush_tlb_multi(cpus, info);
 
 	if (!hv_hypercall_pg)
 		goto do_native;
@@ -164,7 +164,7 @@ static void hyperv_flush_tlb_others(const struct cpumask *cpus,
 	if (!(status & HV_HYPERCALL_RESULT_MASK))
 		return;
 do_native:
-	native_flush_tlb_others(cpus, info);
+	native_flush_tlb_multi(cpus, info);
 }
 
 static u64 hyperv_flush_tlb_others_ex(const struct cpumask *cpus,
@@ -239,6 +239,6 @@ void hyperv_setup_mmu_ops(void)
 		return;
 
 	pr_info("Using hypercall for remote TLB flush\n");
-	pv_ops.mmu.flush_tlb_others = hyperv_flush_tlb_others;
+	pv_ops.mmu.flush_tlb_multi = hyperv_flush_tlb_multi;
 	pv_ops.mmu.tlb_remove_table = tlb_remove_table;
 }
diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
index f8dce11d2bc1..515e49204c8b 100644
--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -50,7 +50,7 @@ static inline void slow_down_io(void)
 void native_flush_tlb_local(void);
 void native_flush_tlb_global(void);
 void native_flush_tlb_one_user(unsigned long addr);
-void native_flush_tlb_others(const struct cpumask *cpumask,
+void native_flush_tlb_multi(const struct cpumask *cpumask,
 			     const struct flush_tlb_info *info);
 
 static inline void __flush_tlb_local(void)
@@ -68,10 +68,10 @@ static inline void __flush_tlb_one_user(unsigned long addr)
 	PVOP_VCALL1(mmu.flush_tlb_one_user, addr);
 }
 
-static inline void __flush_tlb_others(const struct cpumask *cpumask,
+static inline void __flush_tlb_multi(const struct cpumask *cpumask,
 				      const struct flush_tlb_info *info)
 {
-	PVOP_VCALL2(mmu.flush_tlb_others, cpumask, info);
+	PVOP_VCALL2(mmu.flush_tlb_multi, cpumask, info);
 }
 
 static inline void paravirt_tlb_remove_table(struct mmu_gather *tlb, void *table)
diff --git a/arch/x86/include/asm/paravirt_types.h b/arch/x86/include/asm/paravirt_types.h
index b6b02b7c19cc..541fe7193526 100644
--- a/arch/x86/include/asm/paravirt_types.h
+++ b/arch/x86/include/asm/paravirt_types.h
@@ -201,8 +201,8 @@ struct pv_mmu_ops {
 	void (*flush_tlb_user)(void);
 	void (*flush_tlb_kernel)(void);
 	void (*flush_tlb_one_user)(unsigned long addr);
-	void (*flush_tlb_others)(const struct cpumask *cpus,
-				 const struct flush_tlb_info *info);
+	void (*flush_tlb_multi)(const struct cpumask *cpus,
+				const struct flush_tlb_info *info);
 
 	void (*tlb_remove_table)(struct mmu_gather *tlb, void *table);
 
diff --git a/arch/x86/include/asm/tlbflush.h b/arch/x86/include/asm/tlbflush.h
index a7a598af116d..3c6681def912 100644
--- a/arch/x86/include/asm/tlbflush.h
+++ b/arch/x86/include/asm/tlbflush.h
@@ -175,7 +175,7 @@ extern void initialize_tlbstate_and_flush(void);
  *  - flush_tlb_page(vma, vmaddr) flushes one page
  *  - flush_tlb_range(vma, start, end) flushes a range of pages
  *  - flush_tlb_kernel_range(start, end) flushes a range of kernel pages
- *  - flush_tlb_others(cpumask, info) flushes TLBs on other cpus
+ *  - flush_tlb_multi(cpumask, info) flushes TLBs on multiple cpus
  *
  * ..but the i386 has somewhat limited tlb flushing capabilities,
  * and page-granular flushes are available only on i486 and up.
@@ -209,7 +209,7 @@ struct flush_tlb_info {
 void flush_tlb_local(void);
 void flush_tlb_one_user(unsigned long addr);
 void flush_tlb_one_kernel(unsigned long addr);
-void flush_tlb_others(const struct cpumask *cpumask,
+void flush_tlb_multi(const struct cpumask *cpumask,
 		      const struct flush_tlb_info *info);
 
 #ifdef CONFIG_PARAVIRT
diff --git a/arch/x86/include/asm/trace/hyperv.h b/arch/x86/include/asm/trace/hyperv.h
index 4d705cb4d63b..a8e5a7a2b460 100644
--- a/arch/x86/include/asm/trace/hyperv.h
+++ b/arch/x86/include/asm/trace/hyperv.h
@@ -8,7 +8,7 @@
 
 #if IS_ENABLED(CONFIG_HYPERV)
 
-TRACE_EVENT(hyperv_mmu_flush_tlb_others,
+TRACE_EVENT(hyperv_mmu_flush_tlb_multi,
 	    TP_PROTO(const struct cpumask *cpus,
 		     const struct flush_tlb_info *info),
 	    TP_ARGS(cpus, info),
diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
index 5e78e01ca3b4..38ea9dee2456 100644
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -613,7 +613,7 @@ static int kvm_cpu_down_prepare(unsigned int cpu)
 }
 #endif
 
-static void kvm_flush_tlb_others(const struct cpumask *cpumask,
+static void kvm_flush_tlb_multi(const struct cpumask *cpumask,
 			const struct flush_tlb_info *info)
 {
 	u8 state;
@@ -627,6 +627,11 @@ static void kvm_flush_tlb_others(const struct cpumask *cpumask,
 	 * queue flush_on_enter for pre-empted vCPUs
 	 */
 	for_each_cpu(cpu, flushmask) {
+		/*
+		 * The local vCPU is never preempted, so we do not explicitly
+		 * skip check for local vCPU - it will never be cleared from
+		 * flushmask.
+		 */
 		src = &per_cpu(steal_time, cpu);
 		state = READ_ONCE(src->preempted);
 		if ((state & KVM_VCPU_PREEMPTED)) {
@@ -636,7 +641,7 @@ static void kvm_flush_tlb_others(const struct cpumask *cpumask,
 		}
 	}
 
-	native_flush_tlb_others(flushmask, info);
+	native_flush_tlb_multi(flushmask, info);
 }
 
 static void __init kvm_guest_init(void)
@@ -654,7 +659,7 @@ static void __init kvm_guest_init(void)
 	}
 
 	if (pv_tlb_flush_supported()) {
-		pv_ops.mmu.flush_tlb_others = kvm_flush_tlb_others;
+		pv_ops.mmu.flush_tlb_multi = kvm_flush_tlb_multi;
 		pv_ops.mmu.tlb_remove_table = tlb_remove_table;
 		pr_info("KVM setup pv remote TLB flush\n");
 	}
diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 07b6701a540a..78fcbd58716e 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -24,7 +24,7 @@
 # define __flush_tlb_local		native_flush_tlb_local
 # define __flush_tlb_global		native_flush_tlb_global
 # define __flush_tlb_one_user(addr)	native_flush_tlb_one_user(addr)
-# define __flush_tlb_others(msk, info)	native_flush_tlb_others(msk, info)
+# define __flush_tlb_multi(msk, info)	native_flush_tlb_multi(msk, info)
 #endif
 
 /*
@@ -490,7 +490,7 @@ void switch_mm_irqs_off(struct mm_struct *prev, struct mm_struct *next,
 		/*
 		 * Even in lazy TLB mode, the CPU should stay set in the
 		 * mm_cpumask. The TLB shootdown code can figure out from
-		 * from cpu_tlbstate.is_lazy whether or not to send an IPI.
+		 * cpu_tlbstate.is_lazy whether or not to send an IPI.
 		 */
 		if (WARN_ON_ONCE(real_prev != &init_mm &&
 				 !cpumask_test_cpu(cpu, mm_cpumask(next))))
@@ -697,7 +697,7 @@ static void flush_tlb_func(void *info)
 		 * garbage into our TLB.  Since switching to init_mm is barely
 		 * slower than a minimal flush, just switch to init_mm.
 		 *
-		 * This should be rare, with native_flush_tlb_others skipping
+		 * This should be rare, with native_flush_tlb_multi() skipping
 		 * IPIs to lazy TLB mode CPUs.
 		 */
 		switch_mm_irqs_off(NULL, &init_mm, NULL);
@@ -795,9 +795,14 @@ static bool tlb_is_not_lazy(int cpu)
 
 static DEFINE_PER_CPU(cpumask_t, flush_tlb_mask);
 
-STATIC_NOPV void native_flush_tlb_others(const struct cpumask *cpumask,
+STATIC_NOPV void native_flush_tlb_multi(const struct cpumask *cpumask,
 					 const struct flush_tlb_info *info)
 {
+	/*
+	 * Do accounting and tracing. Note that there are (and have always been)
+	 * cases in which a remote TLB flush will be traced, but eventually
+	 * would not happen.
+	 */
 	count_vm_tlb_event(NR_TLB_REMOTE_FLUSH);
 	if (info->end == TLB_FLUSH_ALL)
 		trace_tlb_flush(TLB_REMOTE_SEND_IPI, TLB_FLUSH_ALL);
@@ -816,8 +821,8 @@ STATIC_NOPV void native_flush_tlb_others(const struct cpumask *cpumask,
 	 * doing a speculative memory access.
 	 */
 	if (info->freed_tables) {
-		smp_call_function_many(cpumask, flush_tlb_func,
-			       (void *)info, 1);
+		on_each_cpu_cond_mask(NULL, flush_tlb_func, (void *)info, true,
+				      cpumask);
 	} else {
 		/*
 		 * Although we could have used on_each_cpu_cond_mask(),
@@ -844,14 +849,15 @@ STATIC_NOPV void native_flush_tlb_others(const struct cpumask *cpumask,
 			if (tlb_is_not_lazy(cpu))
 				__cpumask_set_cpu(cpu, cond_cpumask);
 		}
-		smp_call_function_many(cond_cpumask, flush_tlb_func, (void *)info, 1);
+		on_each_cpu_cond_mask(NULL, flush_tlb_func, (void *)info, true,
+				      cpumask);
 	}
 }
 
-void flush_tlb_others(const struct cpumask *cpumask,
+void flush_tlb_multi(const struct cpumask *cpumask,
 		      const struct flush_tlb_info *info)
 {
-	__flush_tlb_others(cpumask, info);
+	__flush_tlb_multi(cpumask, info);
 }
 
 /*
@@ -931,16 +937,20 @@ void flush_tlb_mm_range(struct mm_struct *mm, unsigned long start,
 	info = get_flush_tlb_info(mm, start, end, stride_shift, freed_tables,
 				  new_tlb_gen);
 
-	if (mm == this_cpu_read(cpu_tlbstate.loaded_mm)) {
+	/*
+	 * flush_tlb_multi() is not optimized for the common case in which only
+	 * a local TLB flush is needed. Optimize this use-case by calling
+	 * flush_tlb_func_local() directly in this case.
+	 */
+	if (cpumask_any_but(mm_cpumask(mm), cpu) < nr_cpu_ids) {
+		flush_tlb_multi(mm_cpumask(mm), info);
+	} else if (mm == this_cpu_read(cpu_tlbstate.loaded_mm)) {
 		lockdep_assert_irqs_enabled();
 		local_irq_disable();
 		flush_tlb_func(info);
 		local_irq_enable();
 	}
 
-	if (cpumask_any_but(mm_cpumask(mm), cpu) < nr_cpu_ids)
-		flush_tlb_others(mm_cpumask(mm), info);
-
 	put_flush_tlb_info();
 	put_cpu();
 }
@@ -1151,17 +1161,20 @@ void arch_tlbbatch_flush(struct arch_tlbflush_unmap_batch *batch)
 
 	int cpu = get_cpu();
 
-	info = get_flush_tlb_info(NULL, 0, TLB_FLUSH_ALL, 0, false, 0);
-	if (cpumask_test_cpu(cpu, &batch->cpumask)) {
+	/*
+	 * flush_tlb_multi() is not optimized for the common case in which only
+	 * a local TLB flush is needed. Optimize this use-case by calling
+	 * flush_tlb_func_local() directly in this case.
+	 */
+	if (cpumask_any_but(&batch->cpumask, cpu) < nr_cpu_ids) {
+		flush_tlb_multi(&batch->cpumask, info);
+	} else if (cpumask_test_cpu(cpu, &batch->cpumask)) {
 		lockdep_assert_irqs_enabled();
 		local_irq_disable();
 		flush_tlb_func(info);
 		local_irq_enable();
 	}
 
-	if (cpumask_any_but(&batch->cpumask, cpu) < nr_cpu_ids)
-		flush_tlb_others(&batch->cpumask, info);
-
 	cpumask_clear(&batch->cpumask);
 
 	put_flush_tlb_info();
diff --git a/arch/x86/xen/mmu_pv.c b/arch/x86/xen/mmu_pv.c
index cf2ade864c30..09b95c0e876e 100644
--- a/arch/x86/xen/mmu_pv.c
+++ b/arch/x86/xen/mmu_pv.c
@@ -1247,8 +1247,8 @@ static void xen_flush_tlb_one_user(unsigned long addr)
 	preempt_enable();
 }
 
-static void xen_flush_tlb_others(const struct cpumask *cpus,
-				 const struct flush_tlb_info *info)
+static void xen_flush_tlb_multi(const struct cpumask *cpus,
+				const struct flush_tlb_info *info)
 {
 	struct {
 		struct mmuext_op op;
@@ -1258,7 +1258,7 @@ static void xen_flush_tlb_others(const struct cpumask *cpus,
 	const size_t mc_entry_size = sizeof(args->op) +
 		sizeof(args->mask[0]) * BITS_TO_LONGS(num_possible_cpus());
 
-	trace_xen_mmu_flush_tlb_others(cpus, info->mm, info->start, info->end);
+	trace_xen_mmu_flush_tlb_multi(cpus, info->mm, info->start, info->end);
 
 	if (cpumask_empty(cpus))
 		return;		/* nothing to do */
@@ -1267,9 +1267,8 @@ static void xen_flush_tlb_others(const struct cpumask *cpus,
 	args = mcs.args;
 	args->op.arg2.vcpumask = to_cpumask(args->mask);
 
-	/* Remove us, and any offline CPUS. */
+	/* Remove any offline CPUs */
 	cpumask_and(to_cpumask(args->mask), cpus, cpu_online_mask);
-	cpumask_clear_cpu(smp_processor_id(), to_cpumask(args->mask));
 
 	args->op.cmd = MMUEXT_TLB_FLUSH_MULTI;
 	if (info->end != TLB_FLUSH_ALL &&
@@ -2086,7 +2085,7 @@ static const struct pv_mmu_ops xen_mmu_ops __initconst = {
 	.flush_tlb_user = xen_flush_tlb,
 	.flush_tlb_kernel = xen_flush_tlb,
 	.flush_tlb_one_user = xen_flush_tlb_one_user,
-	.flush_tlb_others = xen_flush_tlb_others,
+	.flush_tlb_multi = xen_flush_tlb_multi,
 	.tlb_remove_table = tlb_remove_table,
 
 	.pgd_alloc = xen_pgd_alloc,
diff --git a/include/trace/events/xen.h b/include/trace/events/xen.h
index 3b61b587e137..44a3f565264d 100644
--- a/include/trace/events/xen.h
+++ b/include/trace/events/xen.h
@@ -346,7 +346,7 @@ TRACE_EVENT(xen_mmu_flush_tlb_one_user,
 	    TP_printk("addr %lx", __entry->addr)
 	);
 
-TRACE_EVENT(xen_mmu_flush_tlb_others,
+TRACE_EVENT(xen_mmu_flush_tlb_multi,
 	    TP_PROTO(const struct cpumask *cpus, struct mm_struct *mm,
 		     unsigned long addr, unsigned long end),
 	    TP_ARGS(cpus, mm, addr, end),
-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

Return-Path: <SRS0=oNZg=CQ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5632C2BB84
	for <virtualization@archiver.kernel.org>; Mon,  7 Sep 2020 13:17:19 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78BC520838
	for <virtualization@archiver.kernel.org>; Mon,  7 Sep 2020 13:17:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78BC520838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 6375085335;
	Mon,  7 Sep 2020 13:17:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ogHW4uueR4OG; Mon,  7 Sep 2020 13:17:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 81F478680C;
	Mon,  7 Sep 2020 13:17:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 786E5C0894;
	Mon,  7 Sep 2020 13:17:06 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 58E88C0893
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Sep 2020 13:17:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 53D3B87141
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Sep 2020 13:17:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VzG4jCjba6lf
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Sep 2020 13:17:02 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 6E7868714E
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Sep 2020 13:17:02 +0000 (UTC)
Received: from cap.home.8bytes.org (p549add56.dip0.t-ipconnect.de
 [84.154.221.86])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by theia.8bytes.org (Postfix) with ESMTPSA id 05E3BFF4;
 Mon,  7 Sep 2020 15:16:59 +0200 (CEST)
From: Joerg Roedel <joro@8bytes.org>
To: x86@kernel.org
Subject: [PATCH v7 33/72] x86/head/64: Install a CPU bringup IDT
Date: Mon,  7 Sep 2020 15:15:34 +0200
Message-Id: <20200907131613.12703-34-joro@8bytes.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200907131613.12703-1-joro@8bytes.org>
References: <20200907131613.12703-1-joro@8bytes.org>
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

Add a separate bringup IDT used by CPU bringup code that will be used
until the kernel switches to the idt_table. There are two reasons for
a separate IDT:

	1) When the idt_table is set up and the secondary CPUs are
	   booted, it contains entries (e.g. IST entries) which
	   require certain CPU state to be set up. This includes a
	   working TSS (for IST), MSR_GS_BASE (for stack protector) or
	   CR4.FSGSBASE (for paranoid_entry) path. By using a
	   dedicated IDT for early boot this state need not to be set
	   up early.

	2) The idt_table is static to idt.c, so any function
	   using/modifying must be in idt.c too. That means that all
	   compiler driven instrumentation like tracing or KASAN is
	   also active in this code. But during early CPU bringup the
	   environment is not set up for this instrumentation to work
	   correctly.

To avoid all of these hassles and make early exception handling
robust, use a dedicated bringup IDT.

The IDT is loaded two times, first on the boot CPU while the kernel is
still running on direct mapped addresses, and again later when the
switch to kernel addresses happened. The second IDT load happens on
the boot and secondary CPUs.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 arch/x86/include/asm/setup.h |  1 +
 arch/x86/kernel/head64.c     | 39 ++++++++++++++++++++++++++++++++++++
 arch/x86/kernel/head_64.S    |  5 +++++
 3 files changed, 45 insertions(+)

diff --git a/arch/x86/include/asm/setup.h b/arch/x86/include/asm/setup.h
index 5c2fd05bd52c..4b3ca5ade2fd 100644
--- a/arch/x86/include/asm/setup.h
+++ b/arch/x86/include/asm/setup.h
@@ -50,6 +50,7 @@ extern unsigned long __startup_64(unsigned long physaddr, struct boot_params *bp
 extern unsigned long __startup_secondary_64(void);
 extern void startup_64_setup_env(unsigned long physbase);
 extern int early_make_pgtable(unsigned long address);
+extern void early_setup_idt(void);
 
 #ifdef CONFIG_X86_INTEL_MID
 extern void x86_intel_mid_early_setup(void);
diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index 8c82be44be94..7bfd5c27c773 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -36,6 +36,8 @@
 #include <asm/microcode.h>
 #include <asm/kasan.h>
 #include <asm/fixmap.h>
+#include <asm/realmode.h>
+#include <asm/desc.h>
 
 /*
  * Manage page tables very early on.
@@ -508,6 +510,41 @@ void __init x86_64_start_reservations(char *real_mode_data)
 	start_kernel();
 }
 
+/*
+ * Data structures and code used for IDT setup in head_64.S. The bringup-IDT is
+ * used until the idt_table takes over. On the boot CPU this happens in
+ * x86_64_start_kernel(), on secondary CPUs in start_secondary(). In both cases
+ * this happens in the functions called from head_64.S.
+ *
+ * The idt_table can't be used that early because all the code modifying it is
+ * in idt.c and can be instrumented by tracing or KASAN, which both don't work
+ * during early CPU bringup. Also the idt_table has the runtime vectors
+ * configured which require certain CPU state to be setup already (like TSS),
+ * which also hasn't happened yet in early CPU bringup.
+ */
+static gate_desc bringup_idt_table[NUM_EXCEPTION_VECTORS] __page_aligned_data;
+
+static struct desc_ptr bringup_idt_descr = {
+	.size		= (NUM_EXCEPTION_VECTORS * sizeof(gate_desc)) - 1,
+	.address	= 0, /* Set at runtime */
+};
+
+/* This runs while still in the direct mapping */
+static void startup_64_load_idt(unsigned long physbase)
+{
+	struct desc_ptr *desc = fixup_pointer(&bringup_idt_descr, physbase);
+
+	desc->address = (unsigned long)fixup_pointer(bringup_idt_table, physbase);
+	native_load_idt(desc);
+}
+
+/* This is used when running on kernel addresses */
+void early_setup_idt(void)
+{
+	bringup_idt_descr.address = (unsigned long)bringup_idt_table;
+	native_load_idt(&bringup_idt_descr);
+}
+
 /*
  * Setup boot CPU state needed before kernel switches to virtual addresses.
  */
@@ -521,4 +558,6 @@ void __head startup_64_setup_env(unsigned long physbase)
 	asm volatile("movl %%eax, %%ds\n"
 		     "movl %%eax, %%ss\n"
 		     "movl %%eax, %%es\n" : : "a"(__KERNEL_DS) : "memory");
+
+	startup_64_load_idt(physbase);
 }
diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index 83050c9e54d9..1de09b58e578 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -198,6 +198,11 @@ SYM_CODE_START(secondary_startup_64)
 	 */
 	movq initial_stack(%rip), %rsp
 
+	/* Setup and Load IDT */
+	pushq	%rsi
+	call	early_setup_idt
+	popq	%rsi
+
 	/* Check if nx is implemented */
 	movl	$0x80000001, %eax
 	cpuid
-- 
2.28.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

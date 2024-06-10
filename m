Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49E2E81720
	for <virtualization@lists.linux-foundation.org>; Mon, 10 Jun 2024 10:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718014899; cv=none; b=AIPuuS/gHWHvqBOKGxFktpQPY0br2/u2Biw6W5V5F0OujLCi/Ykc1mkBLEDNLwtxMc09vhLkX83MSuOV/sSyr6D6M/63Sv3SQfFXCg2i2pSlP5Q4EntfAbg42F/80Y7bRQ8rOAH72QHHSqtxQWbq3pgwg+JmpJ+5uFbsl4YNNf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718014899; c=relaxed/simple;
	bh=mLymI2YoX0b3NV9bnLYtsE9H+OoS+zhSI+TS4E7Vahs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=t3RPgnI+rZVsMUYyFpJqMqK/XWTPXPnjJ+92rpuQvwo5OSP1jc8fOuQ92ITLfVISzga3nmzHhEIRhBLxOMu1IOKnauvYQBwYisafWjvsLwcPmVToLwhucb9GSIDkSNmyd/R6Pzs0NEHjg2aellbMBnuslgk1e3LvyRDtFD72Gjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bgUyEbjT; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bgUyEbjT"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1731A40693
	for <virtualization@lists.linux-foundation.org>; Mon, 10 Jun 2024 10:21:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.849
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eL0JKcsV3QyG for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Jun 2024 10:21:36 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::52b; helo=mail-ed1-x52b.google.com; envelope-from=vsntk18@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 7A2324067D
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none) header.from=gmail.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7A2324067D
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=bgUyEbjT
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 7A2324067D
	for <virtualization@lists.linux-foundation.org>; Mon, 10 Jun 2024 10:21:36 +0000 (UTC)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-57a1fe63947so5332117a12.1
        for <virtualization@lists.linux-foundation.org>; Mon, 10 Jun 2024 03:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718014894; x=1718619694; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QQ7oMYGDWvKPuxrsHJ0AyJxr89wmDw3wSCbvoeSBHx8=;
        b=bgUyEbjTR1k6Dvz4EE5u5in1GYkbhJ7MjjPgdpvxHLPhQvEmylZYypOX5Zc3GPF9SV
         yFRI/E72ZcWZd8HCj3RJPiYvAePW0Op4FrQt9B54L77sepUbXrJokroCIBTe5mlbkhph
         uHKFaZDSlomV+TNGlS3nDdEvQrgsOiXVqJFXGF9pQy5fTASmHV1BudVNRePCTOpxkRkf
         LlT6iN1HpH+Yo5FJE20DX/p/Njt2E5tI7R/NJkp2LNGVGgliPFNt66gIXnvrT59F8Wr5
         VjV9TXLlIauXixXlUaU9XYk4s9Km22cdsLIxIivocTcB0NadBb/AwRel8Yb116Jd1H0k
         6ADQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718014894; x=1718619694;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QQ7oMYGDWvKPuxrsHJ0AyJxr89wmDw3wSCbvoeSBHx8=;
        b=OeO5oJVBY79BFQMGOe3nMfRfSHkgOOMyIQs+Nazb3036vWEHveugshd2YAE2GFAnh+
         YmLuqbBQTQ6Heq9zxtuv2X5n8TYmdtRJkr0CyXSWxAYXKi9C9iRGzBmXFiwr5KvMFvJn
         J4y0RfIsQ127Ql1iv0DYLizySnngPOZwNLhiBqIL4qyKI6GcVkwUmiTgrhZI6iIooObv
         WJuiiJvjU5+u5XwsqYtPNjWIDbrwA6oereMy5y50yPOL3JG0ICQC5z//7bkttrCdUuE4
         mILS3QrVORWt7YyqKoEFu6jKRgo5E8J4rRTpANakZPoecVb8GwBJzqMIU8DDe0urz9S2
         muxg==
X-Forwarded-Encrypted: i=1; AJvYcCXfZY69g/mCm8EEB3q/gzFwy1lJOmCb6ozt4O5yRhXHR+M6P6tI1/x2/IhcD1qd6GFjnQGLuhu7Azc3T/8tlFDhNidBtHl/mpOPGKdjaCDYAWEcXlAQbqQhOw==
X-Gm-Message-State: AOJu0YygQHIkRoDHjmetQSeWZVDlLoR0vMgl0w7/f/dRTTB3vNuSyA1u
	WizwSRlSHZqG2u6fJ/YnrLXPnx1StOiRpMAl/tPZ+4Y0YUr5hrsK
X-Google-Smtp-Source: AGHT+IEjbMSU2+suJHGHFq7yEAKbFwmW31zmvuxiyeHo2z4EIwpvWflJZoDXR60H3CgaABGqRX7uog==
X-Received: by 2002:a17:906:45a:b0:a6f:7c8:4fd6 with SMTP id a640c23a62f3a-a6f07c8518bmr357125966b.0.1718014893650;
        Mon, 10 Jun 2024 03:21:33 -0700 (PDT)
Received: from vasant-suse.fritz.box ([2001:9e8:ab68:af00:6f43:17ee:43bd:e0a9])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f0d7b35d5sm290887766b.192.2024.06.10.03.21.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jun 2024 03:21:33 -0700 (PDT)
From: vsntk18@gmail.com
To: vsntk18@gmail.com
Cc: x86@kernel.org,
	Borislav.Petkov@amd.com,
	Dhaval.Giani@amd.com,
	ashish.kalra@amd.com,
	cfir@google.com,
	dan.j.williams@intel.com,
	dave.hansen@linux.intel.com,
	ebiederm@xmission.com,
	erdemaktas@google.com,
	hpa@zytor.com,
	jgross@suse.com,
	jroedel@suse.de,
	jslaby@suse.cz,
	keescook@chromium.org,
	kexec@lists.infradead.org,
	kvm@vger.kernel.org,
	linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	luto@kernel.org,
	martin.b.radev@gmail.com,
	mhiramat@kernel.org,
	michael.roth@amd.com,
	mstunes@vmware.com,
	nivedita@alum.mit.edu,
	peterz@infradead.org,
	rientjes@google.com,
	seanjc@google.com,
	stable@vger.kernel.org,
	thomas.lendacky@amd.com,
	virtualization@lists.linux-foundation.org,
	vkarasulli@suse.de
Subject: [PATCH v6 05/10] x86/sev: Park APs on AP Jump Table with GHCB protocol version 2
Date: Mon, 10 Jun 2024 12:21:08 +0200
Message-Id: <20240610102113.20969-6-vsntk18@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240610102113.20969-1-vsntk18@gmail.com>
References: <20240610102113.20969-1-vsntk18@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Joerg Roedel <jroedel@suse.de>

GHCB protocol version 2 adds the MSR-based AP-reset-hold VMGEXIT which
does not need a GHCB. Use that to park APs in 16-bit protected mode on
the AP jump table.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Vasant Karasulli <vkarasulli@suse.de>
---
 arch/x86/include/asm/realmode.h |  3 ++
 arch/x86/kernel/sev.c           | 55 ++++++++++++++++++---
 arch/x86/realmode/rm/Makefile   | 11 +++--
 arch/x86/realmode/rm/header.S   |  3 ++
 arch/x86/realmode/rm/sev.S      | 85 +++++++++++++++++++++++++++++++++
 5 files changed, 146 insertions(+), 11 deletions(-)
 create mode 100644 arch/x86/realmode/rm/sev.S

diff --git a/arch/x86/include/asm/realmode.h b/arch/x86/include/asm/realmode.h
index bd54a48fe077..b0a2aa9b8366 100644
--- a/arch/x86/include/asm/realmode.h
+++ b/arch/x86/include/asm/realmode.h
@@ -23,6 +23,9 @@ struct real_mode_header {
 	u32	trampoline_header;
 #ifdef CONFIG_AMD_MEM_ENCRYPT
 	u32	sev_es_trampoline_start;
+	u32	sev_ap_park;
+	u32	sev_ap_park_seg;
+	u32	sev_ap_park_gdt;
 #endif
 #ifdef CONFIG_X86_64
 	u32	trampoline_start64;
diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index c15d3568cab9..84b79630f065 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -35,6 +35,7 @@
 #include <asm/fpu/xcr.h>
 #include <asm/processor.h>
 #include <asm/realmode.h>
+#include <asm/tlbflush.h>
 #include <asm/setup.h>
 #include <asm/traps.h>
 #include <asm/svm.h>
@@ -1147,8 +1148,9 @@ void __init snp_set_wakeup_secondary_cpu(void)
 void __init sev_es_setup_ap_jump_table_data(void *base, u32 pa)
 {
 	struct sev_ap_jump_table_header *header;
+	u64 *ap_jumptable_gdt, *sev_ap_park_gdt;
 	struct desc_ptr *gdt_descr;
-	u64 *ap_jumptable_gdt;
+	int idx;
 
 	header = base;
 
@@ -1158,9 +1160,16 @@ void __init sev_es_setup_ap_jump_table_data(void *base, u32 pa)
 	 * real-mode.
 	 */
 	ap_jumptable_gdt = (u64 *)(base + header->ap_jumptable_gdt);
-	ap_jumptable_gdt[SEV_APJT_CS16 / 8] = GDT_ENTRY(0x9b, pa, 0xffff);
-	ap_jumptable_gdt[SEV_APJT_DS16 / 8] = GDT_ENTRY(0x93, pa, 0xffff);
-	ap_jumptable_gdt[SEV_RM_DS / 8] = GDT_ENTRY(0x93, 0, 0xffff);
+	sev_ap_park_gdt  = __va(real_mode_header->sev_ap_park_gdt);
+
+	idx = SEV_APJT_CS16 / 8;
+	ap_jumptable_gdt[idx] = sev_ap_park_gdt[idx] = GDT_ENTRY(0x9b, pa, 0xffff);
+
+	idx = SEV_APJT_DS16 / 8;
+	ap_jumptable_gdt[idx] = sev_ap_park_gdt[idx] = GDT_ENTRY(0x93, pa, 0xffff);
+
+	idx = SEV_RM_DS / 8;
+	ap_jumptable_gdt[idx] = GDT_ENTRY(0x93, 0x0, 0xffff);
 
 	/* Write correct GDT base address into GDT descriptor */
 	gdt_descr = (struct desc_ptr *)(base + header->ap_jumptable_gdt);
@@ -1349,6 +1358,38 @@ void setup_ghcb(void)
 }
 
 #ifdef CONFIG_HOTPLUG_CPU
+void __noreturn sev_jumptable_ap_park(void)
+{
+	local_irq_disable();
+
+	write_cr3(real_mode_header->trampoline_pgd);
+
+	/* Exiting long mode will fail if CR4.PCIDE is set. */
+	if (cpu_feature_enabled(X86_FEATURE_PCID))
+		cr4_clear_bits(X86_CR4_PCIDE);
+
+	/*
+	 * Set all GPRs except EAX, EBX, ECX, and EDX to reset state to prepare
+	 * for software reset.
+	 */
+	asm volatile("xorl	%%r15d, %%r15d\n"
+		     "xorl	%%r14d, %%r14d\n"
+		     "xorl	%%r13d, %%r13d\n"
+		     "xorl	%%r12d, %%r12d\n"
+		     "xorl	%%r11d, %%r11d\n"
+		     "xorl	%%r10d, %%r10d\n"
+		     "xorl	%%r9d,  %%r9d\n"
+		     "xorl	%%r8d,  %%r8d\n"
+		     "xorl	%%esi, %%esi\n"
+		     "xorl	%%edi, %%edi\n"
+		     "xorl	%%esp, %%esp\n"
+		     "xorl	%%ebp, %%ebp\n"
+		     "ljmpl	*%0" : :
+		     "m" (real_mode_header->sev_ap_park));
+	unreachable();
+}
+STACK_FRAME_NON_STANDARD(sev_jumptable_ap_park);
+
 static void sev_es_ap_hlt_loop(void)
 {
 	struct ghcb_state state;
@@ -1385,8 +1426,10 @@ static void sev_es_play_dead(void)
 	play_dead_common();
 
 	/* IRQs now disabled */
-
-	sev_es_ap_hlt_loop();
+	if (sev_ap_jumptable_blob_installed)
+		sev_jumptable_ap_park();
+	else
+		sev_es_ap_hlt_loop();
 
 	/*
 	 * If we get here, the VCPU was woken up again. Jump to CPU
diff --git a/arch/x86/realmode/rm/Makefile b/arch/x86/realmode/rm/Makefile
index a0fb39abc5c8..9c5892219cb1 100644
--- a/arch/x86/realmode/rm/Makefile
+++ b/arch/x86/realmode/rm/Makefile
@@ -19,11 +19,12 @@ wakeup-objs	+= video-vga.o
 wakeup-objs	+= video-vesa.o
 wakeup-objs	+= video-bios.o
 
-realmode-y			+= header.o
-realmode-y			+= trampoline_$(BITS).o
-realmode-y			+= stack.o
-realmode-y			+= reboot.o
-realmode-$(CONFIG_ACPI_SLEEP)	+= $(wakeup-objs)
+realmode-y				+= header.o
+realmode-y				+= trampoline_$(BITS).o
+realmode-y				+= stack.o
+realmode-y				+= reboot.o
+realmode-$(CONFIG_ACPI_SLEEP)		+= $(wakeup-objs)
+realmode-$(CONFIG_AMD_MEM_ENCRYPT)	+= sev.o
 
 targets	+= $(realmode-y)
 
diff --git a/arch/x86/realmode/rm/header.S b/arch/x86/realmode/rm/header.S
index 2eb62be6d256..17eae256d443 100644
--- a/arch/x86/realmode/rm/header.S
+++ b/arch/x86/realmode/rm/header.S
@@ -22,6 +22,9 @@ SYM_DATA_START(real_mode_header)
 	.long	pa_trampoline_header
 #ifdef CONFIG_AMD_MEM_ENCRYPT
 	.long	pa_sev_es_trampoline_start
+	.long	pa_sev_ap_park_asm
+	.long	__KERNEL32_CS
+	.long	pa_sev_ap_park_gdt;
 #endif
 #ifdef CONFIG_X86_64
 	.long	pa_trampoline_start64
diff --git a/arch/x86/realmode/rm/sev.S b/arch/x86/realmode/rm/sev.S
new file mode 100644
index 000000000000..ae6eea2d53f7
--- /dev/null
+++ b/arch/x86/realmode/rm/sev.S
@@ -0,0 +1,85 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#include <linux/linkage.h>
+#include <asm/segment.h>
+#include <asm/page_types.h>
+#include <asm/processor-flags.h>
+#include <asm/msr-index.h>
+#include <asm/sev-ap-jumptable.h>
+#include "realmode.h"
+
+	.section ".text32", "ax"
+	.code32
+/*
+ * The following code switches to 16-bit protected mode and sets up the
+ * execution environment for the AP jump table blob. Then it jumps to the AP
+ * jump table to park the AP.
+ *
+ * The code was copied from reboot.S and modified to fit the SEV-ES requirements
+ * for AP parking. When this code is entered, all registers except %EAX-%EDX are
+ * in reset state.
+ *
+ * %EAX, %EBX, %ECX, %EDX and EFLAGS are undefined. Only use registers %EAX-%EDX and
+ * %ESP in this code.
+ */
+SYM_CODE_START(sev_ap_park_asm)
+
+	/* Switch to trampoline GDT as it is guaranteed < 4 GiB */
+	movl	$__KERNEL_DS, %eax
+	movl	%eax, %ds
+	lgdt	pa_tr_gdt
+
+	/* Disable paging to drop us out of long mode */
+	movl	%cr0, %eax
+	btcl	$X86_CR0_PG_BIT, %eax
+	movl	%eax, %cr0
+
+	ljmpl	$__KERNEL32_CS, $pa_sev_ap_park_paging_off
+
+SYM_INNER_LABEL(sev_ap_park_paging_off, SYM_L_GLOBAL)
+	/* Clear EFER */
+	xorl	%eax, %eax
+	xorl	%edx, %edx
+	movl	$MSR_EFER, %ecx
+	wrmsr
+
+	/* Clear CR3 */
+	xorl	%ecx, %ecx
+	movl	%ecx, %cr3
+
+	/* Set up the IDT for real mode. */
+	lidtl	pa_machine_real_restart_idt
+
+	/* Load the GDT with the 16-bit segments for the AP jump table */
+	lgdtl	pa_sev_ap_park_gdt
+
+	/* Setup code and data segments for AP jump table */
+	movw	$SEV_APJT_DS16, %ax
+	movw	%ax, %ds
+	movw	%ax, %ss
+
+	/* Jump to the AP jump table into 16 bit protected mode */
+	ljmpw	$SEV_APJT_CS16, $SEV_APJT_ENTRY
+SYM_CODE_END(sev_ap_park_asm)
+
+	.data
+	.balign	16
+SYM_DATA_START(sev_ap_park_gdt)
+	/* Self-pointer */
+	.word	sev_ap_park_gdt_end - sev_ap_park_gdt - 1
+	.long	pa_sev_ap_park_gdt
+	.word	0
+
+	/*
+	 * Offset 0x8
+	 * 32 bit code segment descriptor pointing to AP jump table base
+	 * Setup at runtime in sev_es_setup_ap_jump_table_data().
+	 */
+	.quad	0
+
+	/*
+	 * Offset 0x10
+	 * 32 bit data segment descriptor pointing to AP jump table base
+	 * Setup at runtime in sev_es_setup_ap_jump_table_data().
+	 */
+	.quad	0
+SYM_DATA_END_LABEL(sev_ap_park_gdt, SYM_L_GLOBAL, sev_ap_park_gdt_end)
-- 
2.34.1


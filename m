Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DD7A41C7C
	for <virtualization@lists.linux-foundation.org>; Mon,  8 Apr 2024 07:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712562077; cv=none; b=EzmhTSxAm4TnDcCxek+RLbJNU9TwQRSwGbxoBIJ4xg4mIVy/nHBnMYfgwqG7w1uwaTyV8WVh5ti31iVYwX0Ob06yHVfCf2YTVzGlgpCLtkNWiO3tt+6RS2JL1pRSI3MJfANnk5DDaikxE16pDXq4a7PyaJNE+Vj4HCdNVCbXkZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712562077; c=relaxed/simple;
	bh=gC5t4+RC9wypYzUzbN2ybe4JvevDxdd9vd/kchALLDA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WuZVCDRQGAfjt3KzYoeJijmnwU/7juXuNcAznYgqonf3potrDbfhw6GnWYe6LjenN0/pjeBS0IYYrrSpAzzdPrkNbC29cgiYrurdnn5+npgPaGgKGjdKT87zf6cbCjtmovWSpz7Hllt3uHLjcMy0EoZZxDfvBTZwzr8n60hO1YE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WO7IXiHe; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WO7IXiHe"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E6C1A81490
	for <virtualization@lists.linux-foundation.org>; Mon,  8 Apr 2024 07:41:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.849
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mYiXT5vQ2Mn0 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Apr 2024 07:41:13 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::334; helo=mail-wm1-x334.google.com; envelope-from=vsntk18@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 8191381B7B
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none) header.from=gmail.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8191381B7B
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=WO7IXiHe
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 8191381B7B
	for <virtualization@lists.linux-foundation.org>; Mon,  8 Apr 2024 07:41:13 +0000 (UTC)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-4165d03308fso8360945e9.2
        for <virtualization@lists.linux-foundation.org>; Mon, 08 Apr 2024 00:41:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712562071; x=1713166871; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FzkdlMCm8u5vOsg45yDXb+miZ/z9u223TeiBRO07n5A=;
        b=WO7IXiHeayMeT1jEnjfmTdaKSmbcqIc+EIZP/N7g2mpm5aIiZJs/ydc6diOYeR0kIP
         /peTJi8aoovBez76HguK4rSvfZtTnKiheGvpUlEE7sPOUFPoNuX4mVIVfy2/E1feCvLE
         DfCSz13NMCKn6l9pFKegQOnznmPhbLt4RSo/BJYSnSjg1kRgeeAMUTfz/H63QvV7crPx
         vJAQdHTlEVdCL9/oDNN3slnHvchpkvWcMSGVD3e9oVfIH53yS6A8ZbnyR+3N7/E21fab
         v0RKZaKMlReXOhsMX+lj087a8AquB4kKJ5h+GLR58yjNOUYA3W0rwfFIhbzEaZx6lDhj
         R/SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712562071; x=1713166871;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FzkdlMCm8u5vOsg45yDXb+miZ/z9u223TeiBRO07n5A=;
        b=kB80TVXpj4oWci2Oh7aOYD8VQgwVX/jQhENwnb7WOZx0ws2555R3NvRpkUeCU4Xibe
         pSYlfhlaicRvxW4Jz3YcEdo1Ax5ysQYDppthbdg4w9Xbsr1Ao40mcZvljr3Izn4AnWKi
         Y7YsiB1BTxw2PzT2y1TME58S4rbtbyo9z9KipGYm0K48ssmT95jlhS500WlWcRpgp/2+
         ZpQG3mBdyUSEoXZhMT+k8prLlFxUtAzPpBDgufJxanAvmmW310XPCS48eLYjjBU0uW8z
         xyaqDQRD6UvhlJf59q7YbFxA22z5C2FtGm4CxMYMHvQL/lFFn2W/iyh3r/0/g0keG9Yi
         oNFQ==
X-Forwarded-Encrypted: i=1; AJvYcCX81ssLJMhcz326jsltQiMIC2B06QC8FvoccgA4iDyVwKTXdqkJQsvHNo7ZNDxjjlQE3y85WXNiEeDAf1h0+vVj/o7oHx1kyVEbQHjq8NwBmG8+l9xQQxOMNg==
X-Gm-Message-State: AOJu0YwV9IQV3t0HGgjA17Dz9h5B0E37A257Kfi0zbRGXUXmBucDjUg5
	T2QUUEUnWEW4hsTWNdGxm0PlmDk8cMFN9DP+tfi4mwfQYCzIOnOT
X-Google-Smtp-Source: AGHT+IFkO1agxvaEtWTa7PwdRWfTUJmVFRWPPvwRoXyImb4NGK8ekKkvvupX1NawwTiN/lXC8mY8Sg==
X-Received: by 2002:a05:600c:3485:b0:416:4e19:2e5a with SMTP id a5-20020a05600c348500b004164e192e5amr3563226wmq.11.1712562071061;
        Mon, 08 Apr 2024 00:41:11 -0700 (PDT)
Received: from vasant-suse.suse.cz ([2001:9e8:ab70:9c00:7f0b:c18e:56a6:4f2])
        by smtp.gmail.com with ESMTPSA id j3-20020adfff83000000b00341e2146b53sm8271413wrr.106.2024.04.08.00.41.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 00:41:10 -0700 (PDT)
From: vsntk18@gmail.com
To: x86@kernel.org
Cc: cfir@google.com,
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
	mstunes@vmware.com,
	nivedita@alum.mit.edu,
	peterz@infradead.org,
	rientjes@google.com,
	seanjc@google.com,
	stable@vger.kernel.org,
	thomas.lendacky@amd.com,
	virtualization@lists.linux-foundation.org,
	vkarasulli@suse.de,
	ashish.kalra@amd.com,
	michael.roth@amd.com,
	Borislav.Petkov@amd.com,
	Dhaval.Giani@amd.com
Subject: [PATCH v5 05/10] x86/sev: Park APs on AP Jump Table with GHCB protocol version 2
Date: Mon,  8 Apr 2024 09:40:44 +0200
Message-Id: <20240408074049.7049-6-vsntk18@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240408074049.7049-1-vsntk18@gmail.com>
References: <20240408074049.7049-1-vsntk18@gmail.com>
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
index 91f84b8bfa28..4c235e310487 100644
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
index f614009d3e4e..7fa22159f7d8 100644
--- a/arch/x86/realmode/rm/Makefile
+++ b/arch/x86/realmode/rm/Makefile
@@ -28,11 +28,12 @@ wakeup-objs	+= video-vga.o
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


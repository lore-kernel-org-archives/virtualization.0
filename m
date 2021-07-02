Return-Path: <SRS0=Lmm9=L2=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C131C11F6A
	for <virtualization@archiver.kernel.org>; Fri,  2 Jul 2021 11:48:59 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0144E61413
	for <virtualization@archiver.kernel.org>; Fri,  2 Jul 2021 11:48:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0144E61413
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CE8EA83DCC;
	Fri,  2 Jul 2021 11:48:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id P6y-m75UeBLC; Fri,  2 Jul 2021 11:48:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 7969783DCA;
	Fri,  2 Jul 2021 11:48:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 538BFC0010;
	Fri,  2 Jul 2021 11:48:57 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A4E1FC002A
 for <virtualization@lists.linux-foundation.org>;
 Fri,  2 Jul 2021 11:48:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A925540455
 for <virtualization@lists.linux-foundation.org>;
 Fri,  2 Jul 2021 11:48:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=suse.com header.b="CDtHo6Id";
 dkim=pass (1024-bit key) header.d=suse.com header.b="CDtHo6Id"
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id J88pkRiKHO8L
 for <virtualization@lists.linux-foundation.org>;
 Fri,  2 Jul 2021 11:48:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 by smtp4.osuosl.org (Postfix) with ESMTPS id BE79E40465
 for <virtualization@lists.linux-foundation.org>;
 Fri,  2 Jul 2021 11:48:51 +0000 (UTC)
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
 (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 0FDA82055A;
 Fri,  2 Jul 2021 11:48:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1625226530; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NWVtsIZNVyli015FxwN2RGU3q5E2rKCEUllZcSA6C4A=;
 b=CDtHo6IdWNwWCIDk6UmBa1rnZ82B2bNRnzU0o9zJQnsU+VWB/zKN7nQKY8K5+EsnpkdHxw
 RG7dxeLZJWL1j8Skejt6jLylCBC8QxvJWXAxw9SmpYzw+2W+A7Z6SDU/h/YmIij2P4fH86
 IW1+wBUS+8QpqRTMynd/Xwz/9pnZFYc=
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
 by imap.suse.de (Postfix) with ESMTP id AA22711C84;
 Fri,  2 Jul 2021 11:48:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1625226530; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NWVtsIZNVyli015FxwN2RGU3q5E2rKCEUllZcSA6C4A=;
 b=CDtHo6IdWNwWCIDk6UmBa1rnZ82B2bNRnzU0o9zJQnsU+VWB/zKN7nQKY8K5+EsnpkdHxw
 RG7dxeLZJWL1j8Skejt6jLylCBC8QxvJWXAxw9SmpYzw+2W+A7Z6SDU/h/YmIij2P4fH86
 IW1+wBUS+8QpqRTMynd/Xwz/9pnZFYc=
Received: from director2.suse.de ([192.168.254.72]) by imap3-int with ESMTPSA
 id iPHlJyH93mDDDAAALh3uQQ
 (envelope-from <varad.gautam@suse.com>); Fri, 02 Jul 2021 11:48:49 +0000
To: kvm@vger.kernel.org,
	virtualization@lists.linux-foundation.org
Subject: [kvm-unit-tests PATCH 5/6] cstart64.S: x86_64 bootstrapping after
 exiting EFI
Date: Fri,  2 Jul 2021 13:48:19 +0200
Message-Id: <20210702114820.16712-6-varad.gautam@suse.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210702114820.16712-1-varad.gautam@suse.com>
References: <20210702114820.16712-1-varad.gautam@suse.com>
MIME-Version: 1.0
Cc: thomas.lendacky@amd.com, drjones@redhat.com, jroedel@suse.de,
 brijesh.singh@amd.com, pbonzini@redhat.com, bp@suse.de
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
From: Varad Gautam via Virtualization
 <virtualization@lists.linux-foundation.org>
Reply-To: Varad Gautam <varad.gautam@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

EFI sets up long mode with arbitrary state before calling the
image entrypoint. To run the testcases at hand, it is necessary
to redo some of the bootstrapping to not rely on what EFI
provided.

Adapt start64() for EFI testcases to fixup %rsp/GDT/IDT/TSS and
friends, and jump here after relocation from efi_main. Switch to
RIP-relative addressing where necessary.

Initially leave out:
- AP init - leave EFI to single CPU
- Testcase arg passing

Signed-off-by: Varad Gautam <varad.gautam@suse.com>
---
 x86/cstart64.S | 57 ++++++++++++++++++++++++++++++++++++++++++++------
 x86/efi_main.c |  1 +
 2 files changed, 52 insertions(+), 6 deletions(-)

diff --git a/x86/cstart64.S b/x86/cstart64.S
index 98e7848..d4448c2 100644
--- a/x86/cstart64.S
+++ b/x86/cstart64.S
@@ -242,16 +242,17 @@ ap_start32:
 
 .code64
 save_id:
-#ifndef CONFIG_EFI
 	movl $(APIC_DEFAULT_PHYS_BASE + APIC_ID), %eax
 	movl (%rax), %eax
 	shrl $24, %eax
+#ifdef CONFIG_EFI
+	lock btsl %eax, online_cpus(%rip)
+#else
 	lock btsl %eax, online_cpus
 #endif
 	retq
 
 ap_start64:
-#ifndef CONFIG_EFI
 	call reset_apic
 	call load_tss
 	call enable_apic
@@ -259,12 +260,37 @@ ap_start64:
 	call enable_x2apic
 	sti
 	nop
+#ifdef CONFIG_EFI
+	lock incw cpu_online_count(%rip)
+#else
 	lock incw cpu_online_count
 #endif
+
 1:	hlt
 	jmp 1b
 
 #ifdef CONFIG_EFI
+setup_gdt64:
+	lgdt gdt64_desc(%rip)
+
+	setup_segments
+
+	movabsq $flush_cs, %rax
+	pushq $0x8
+	pushq %rax
+	retfq
+flush_cs:
+	ret
+
+setup_idt64:
+	lidtq idt_descr(%rip)
+	ret
+
+setup_cr3:
+	movabsq $ptl4, %rax
+	mov %rax, %cr3
+	ret
+
 .globl _efi_pe_entry
 _efi_pe_entry:
 	# EFI image loader calls this with rcx=efi_handle,
@@ -276,15 +302,25 @@ _efi_pe_entry:
 	pushq   %rsi
 
 	call efi_main
-#endif
 
+.globl start64
 start64:
-#ifndef CONFIG_EFI
+	cli
+	lea stacktop(%rip), %rsp
+
+	setup_percpu_area
+	call setup_gdt64
+	call setup_idt64
+	call setup_cr3
+#else
+start64:
+#endif
 	call reset_apic
 	call load_tss
 	call mask_pic_interrupts
 	call enable_apic
 	call save_id
+#ifndef CONFIG_EFI
 	mov mb_boot_info(%rip), %rbx
 	mov %rbx, %rdi
 	call setup_multiboot
@@ -292,18 +328,24 @@ start64:
 	mov mb_cmdline(%rbx), %eax
 	mov %rax, __args(%rip)
 	call __setup_args
+#endif
 
 	call ap_init
 	call enable_x2apic
 	call smp_init
 
+#ifdef CONFIG_EFI
+	mov $0, %edi
+	mov $0, %rsi
+	mov $0, %rdx
+#else
 	mov __argc(%rip), %edi
 	lea __argv(%rip), %rsi
 	lea __environ(%rip), %rdx
+#endif
 	call main
 	mov %eax, %edi
 	call exit
-#endif
 
 .globl setup_5level_page_table
 setup_5level_page_table:
@@ -328,7 +370,10 @@ online_cpus:
 	.fill (max_cpus + 7) / 8, 1, 0
 
 load_tss:
-#ifndef CONFIG_EFI
+#ifdef CONFIG_EFI
+	mov $(tss_descr - gdt64), %rax
+	ltr %ax
+#else
 	lidtq idt_descr
 	mov $(APIC_DEFAULT_PHYS_BASE + APIC_ID), %eax
 	mov (%rax), %eax
diff --git a/x86/efi_main.c b/x86/efi_main.c
index be3f9ab..c542fb9 100644
--- a/x86/efi_main.c
+++ b/x86/efi_main.c
@@ -7,6 +7,7 @@ efi_system_table_t *efi_system_table = NULL;
 
 extern char ImageBase;
 extern char _DYNAMIC;
+extern void start64(void);
 
 static void efi_free_pool(void *ptr)
 {
-- 
2.30.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

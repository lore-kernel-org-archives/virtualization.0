Return-Path: <SRS0=oNZg=CQ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3D51C2D0A7
	for <virtualization@archiver.kernel.org>; Mon,  7 Sep 2020 13:17:00 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90D8520838
	for <virtualization@archiver.kernel.org>; Mon,  7 Sep 2020 13:17:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90D8520838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 4451B8605E;
	Mon,  7 Sep 2020 13:17:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vKa-MUGkVG3v; Mon,  7 Sep 2020 13:16:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 7A7CB85FD7;
	Mon,  7 Sep 2020 13:16:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4D0A0C0893;
	Mon,  7 Sep 2020 13:16:58 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F201DC0051
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Sep 2020 13:16:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id E1D0885F93
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Sep 2020 13:16:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Z-5g2fKiT0Gb
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Sep 2020 13:16:55 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 4AB8585FA3
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Sep 2020 13:16:54 +0000 (UTC)
Received: from cap.home.8bytes.org (p549add56.dip0.t-ipconnect.de
 [84.154.221.86])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by theia.8bytes.org (Postfix) with ESMTPSA id D9277EFF;
 Mon,  7 Sep 2020 15:16:50 +0200 (CEST)
From: Joerg Roedel <joro@8bytes.org>
To: x86@kernel.org
Subject: [PATCH v7 17/72] x86/boot/compressed/64: Don't pre-map memory in
 KASLR code
Date: Mon,  7 Sep 2020 15:15:18 +0200
Message-Id: <20200907131613.12703-18-joro@8bytes.org>
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

With the page-fault handler in place the identity mapping can be built
on-demand. So remove the code which manually creates the mappings and
unexport/remove the functions used for it.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 arch/x86/boot/compressed/ident_map_64.c |  6 ++----
 arch/x86/boot/compressed/kaslr.c        | 24 +-----------------------
 arch/x86/boot/compressed/misc.h         | 10 ----------
 3 files changed, 3 insertions(+), 37 deletions(-)

diff --git a/arch/x86/boot/compressed/ident_map_64.c b/arch/x86/boot/compressed/ident_map_64.c
index ecf9353b064d..c63257bf8373 100644
--- a/arch/x86/boot/compressed/ident_map_64.c
+++ b/arch/x86/boot/compressed/ident_map_64.c
@@ -87,11 +87,9 @@ phys_addr_t physical_mask = (1ULL << __PHYSICAL_MASK_SHIFT) - 1;
 static struct x86_mapping_info mapping_info;
 
 /*
- * Adds the specified range to what will become the new identity mappings.
- * Once all ranges have been added, the new mapping is activated by calling
- * finalize_identity_maps() below.
+ * Adds the specified range to the identity mappings.
  */
-void add_identity_map(unsigned long start, unsigned long size)
+static void add_identity_map(unsigned long start, unsigned long size)
 {
 	unsigned long end = start + size;
 
diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
index 82662869c4cb..b59547ce5b19 100644
--- a/arch/x86/boot/compressed/kaslr.c
+++ b/arch/x86/boot/compressed/kaslr.c
@@ -397,8 +397,6 @@ static void mem_avoid_init(unsigned long input, unsigned long input_size,
 	 */
 	mem_avoid[MEM_AVOID_ZO_RANGE].start = input;
 	mem_avoid[MEM_AVOID_ZO_RANGE].size = (output + init_size) - input;
-	add_identity_map(mem_avoid[MEM_AVOID_ZO_RANGE].start,
-			 mem_avoid[MEM_AVOID_ZO_RANGE].size);
 
 	/* Avoid initrd. */
 	initrd_start  = (u64)boot_params->ext_ramdisk_image << 32;
@@ -416,15 +414,11 @@ static void mem_avoid_init(unsigned long input, unsigned long input_size,
 		cmd_line_size = strnlen((char *)cmd_line, COMMAND_LINE_SIZE-1) + 1;
 		mem_avoid[MEM_AVOID_CMDLINE].start = cmd_line;
 		mem_avoid[MEM_AVOID_CMDLINE].size = cmd_line_size;
-		add_identity_map(mem_avoid[MEM_AVOID_CMDLINE].start,
-				 mem_avoid[MEM_AVOID_CMDLINE].size);
 	}
 
 	/* Avoid boot parameters. */
 	mem_avoid[MEM_AVOID_BOOTPARAMS].start = (unsigned long)boot_params;
 	mem_avoid[MEM_AVOID_BOOTPARAMS].size = sizeof(*boot_params);
-	add_identity_map(mem_avoid[MEM_AVOID_BOOTPARAMS].start,
-			 mem_avoid[MEM_AVOID_BOOTPARAMS].size);
 
 	/* We don't need to set a mapping for setup_data. */
 
@@ -433,11 +427,6 @@ static void mem_avoid_init(unsigned long input, unsigned long input_size,
 
 	/* Enumerate the immovable memory regions */
 	num_immovable_mem = count_immovable_mem_regions();
-
-#ifdef CONFIG_X86_VERBOSE_BOOTUP
-	/* Make sure video RAM can be used. */
-	add_identity_map(0, PMD_SIZE);
-#endif
 }
 
 /*
@@ -884,19 +873,8 @@ void choose_random_location(unsigned long input,
 		warn("Physical KASLR disabled: no suitable memory region!");
 	} else {
 		/* Update the new physical address location. */
-		if (*output != random_addr) {
-			add_identity_map(random_addr, output_size);
+		if (*output != random_addr)
 			*output = random_addr;
-		}
-
-		/*
-		 * This loads the identity mapping page table.
-		 * This should only be done if a new physical address
-		 * is found for the kernel, otherwise we should keep
-		 * the old page table to make it be like the "nokaslr"
-		 * case.
-		 */
-		finalize_identity_maps();
 	}
 
 
diff --git a/arch/x86/boot/compressed/misc.h b/arch/x86/boot/compressed/misc.h
index f0e199174c5f..9840c82a39f1 100644
--- a/arch/x86/boot/compressed/misc.h
+++ b/arch/x86/boot/compressed/misc.h
@@ -98,17 +98,7 @@ static inline void choose_random_location(unsigned long input,
 #endif
 
 #ifdef CONFIG_X86_64
-void initialize_identity_maps(void);
-void add_identity_map(unsigned long start, unsigned long size);
-void finalize_identity_maps(void);
 extern unsigned char _pgtable[];
-#else
-static inline void initialize_identity_maps(void)
-{ }
-static inline void add_identity_map(unsigned long start, unsigned long size)
-{ }
-static inline void finalize_identity_maps(void)
-{ }
 #endif
 
 #ifdef CONFIG_EARLY_PRINTK
-- 
2.28.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

Return-Path: <SRS0=nkKT=LC=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D96EC4743F
	for <virtualization@archiver.kernel.org>; Tue,  8 Jun 2021 09:54:56 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48A706124C
	for <virtualization@archiver.kernel.org>; Tue,  8 Jun 2021 09:54:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48A706124C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 164A583546;
	Tue,  8 Jun 2021 09:54:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0Uy-PaF_k3vX; Tue,  8 Jun 2021 09:54:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTP id AE2A282DFB;
	Tue,  8 Jun 2021 09:54:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 83866C000B;
	Tue,  8 Jun 2021 09:54:51 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DE04EC0001
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Jun 2021 09:54:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id BA6FF82FD5
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Jun 2021 09:54:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tE1xn-OIT4st
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Jun 2021 09:54:48 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 260C982D61
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Jun 2021 09:54:48 +0000 (UTC)
Received: from cap.home.8bytes.org (p4ff2ba7c.dip0.t-ipconnect.de
 [79.242.186.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by theia.8bytes.org (Postfix) with ESMTPSA id 91B0A386;
 Tue,  8 Jun 2021 11:54:44 +0200 (CEST)
From: Joerg Roedel <joro@8bytes.org>
To: x86@kernel.org
Subject: [PATCH v3 1/7] x86/ioremap: Map efi_mem_reserve() memory as encrypted
 for SEV
Date: Tue,  8 Jun 2021 11:54:33 +0200
Message-Id: <20210608095439.12668-2-joro@8bytes.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210608095439.12668-1-joro@8bytes.org>
References: <20210608095439.12668-1-joro@8bytes.org>
MIME-Version: 1.0
Cc: kvm@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 virtualization@lists.linux-foundation.org,
 Arvind Sankar <nivedita@alum.mit.edu>, hpa@zytor.com,
 Jiri Slaby <jslaby@suse.cz>, Joerg Roedel <joro@8bytes.org>,
 David Rientjes <rientjes@google.com>, Martin Radev <martin.b.radev@gmail.com>,
 Tom Lendacky <thomas.lendacky@amd.com>, Joerg Roedel <jroedel@suse.de>,
 Kees Cook <keescook@chromium.org>, Cfir Cohen <cfir@google.com>,
 linux-coco@lists.linux.dev, Andy Lutomirski <luto@kernel.org>,
 Dan Williams <dan.j.williams@intel.com>, Juergen Gross <jgross@suse.com>,
 Mike Stunes <mstunes@vmware.com>, Sean Christopherson <seanjc@google.com>,
 linux-kernel@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
 Erdem Aktas <erdemaktas@google.com>
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

From: Tom Lendacky <thomas.lendacky@amd.com>

Some drivers require memory that is marked as EFI boot services data. So that
this memory is not re-used by the kernel after ExitBootServices(),
efi_mem_reserve() is used to preserve it by inserting a new EFI memory
descriptor and marking it with the EFI_MEMORY_RUNTIME attribute.

Under SEV, memory marked with the EFI_MEMORY_RUNTIME attribute needs to
be mapped encrypted by Linux, otherwise the kernel might crash at boot
like below:

 EFI Variables Facility v0.08 2004-May-17
 general protection fault, probably for non-canonical address 0x3597688770a868b2: 0000 [#1] SMP NOPTI
 CPU: 13 PID: 1 Comm: swapper/0 Not tainted 5.12.4-2-default #1 openSUSE Tumbleweed
 Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 0.0.0 02/06/2015
 RIP: 0010:efi_mokvar_entry_next+0x34/0x40
 Code: c5 01 48 8b 17 48 c7 07 00 00 00 00 48 85 c0 74 24 48 85 d2 74 14 80 3a 00 74 18 48 8b 82 00 01 00 00 48 8d 84 02 08 01 00 00 <80> 38 00 74 04 48 89 07 c3 31 c0 c3 0f 1f 44 00 00 41 54 4c 8b 25
 [...]
 Call Trace:
  efi_mokvar_sysfs_init
  ? efi_mokvar_table_init
  do_one_initcall
  ? __kmalloc
  kernel_init_freeable
  ? rest_init
  kernel_init
  ret_from_fork
 Modules linked in:
 ---[ end trace 0de27ecc25d41b73 ]---

Expand the __ioremap_check_other() function to additionally check for this
other type of "runtime" data and indicate that it should be mapped encrypted
for an SEV guest.

Fixes: 58c909022a5a ("efi: Support for MOK variable config table")
Reported-by: Joerg Roedel <jroedel@suse.de>
Tested-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 arch/x86/mm/ioremap.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/mm/ioremap.c b/arch/x86/mm/ioremap.c
index 12c686c65ea9..60ade7dd71bd 100644
--- a/arch/x86/mm/ioremap.c
+++ b/arch/x86/mm/ioremap.c
@@ -118,7 +118,9 @@ static void __ioremap_check_other(resource_size_t addr, struct ioremap_desc *des
 	if (!IS_ENABLED(CONFIG_EFI))
 		return;
 
-	if (efi_mem_type(addr) == EFI_RUNTIME_SERVICES_DATA)
+	if (efi_mem_type(addr) == EFI_RUNTIME_SERVICES_DATA ||
+	    (efi_mem_type(addr) == EFI_BOOT_SERVICES_DATA &&
+	     efi_mem_attributes(addr) & EFI_MEMORY_RUNTIME))
 		desc->flags |= IORES_MAP_ENCRYPTED;
 }
 
-- 
2.31.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

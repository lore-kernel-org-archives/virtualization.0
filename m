Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C290C43217
	for <virtualization@archiver.kernel.org>; Thu, 27 Jan 2022 10:11:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 170EE40B88;
	Thu, 27 Jan 2022 10:11:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MqhMnDOY0XaG; Thu, 27 Jan 2022 10:11:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 9070C40B9F;
	Thu, 27 Jan 2022 10:11:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 656D7C0070;
	Thu, 27 Jan 2022 10:11:27 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CC8DBC007C
 for <virtualization@lists.linux-foundation.org>;
 Thu, 27 Jan 2022 10:11:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8ADE284EF9
 for <virtualization@lists.linux-foundation.org>;
 Thu, 27 Jan 2022 10:11:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id P9wPjIP7VmCU
 for <virtualization@lists.linux-foundation.org>;
 Thu, 27 Jan 2022 10:11:24 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from theia.8bytes.org (8bytes.org
 [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D2FAE84EEB
 for <virtualization@lists.linux-foundation.org>;
 Thu, 27 Jan 2022 10:11:23 +0000 (UTC)
Received: from cap.home.8bytes.org (p549ad610.dip0.t-ipconnect.de
 [84.154.214.16])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by theia.8bytes.org (Postfix) with ESMTPSA id D545F960;
 Thu, 27 Jan 2022 11:11:20 +0100 (CET)
From: Joerg Roedel <joro@8bytes.org>
To: x86@kernel.org
Subject: [PATCH v3 04/10] x86/sev: Cache AP Jump Table Address
Date: Thu, 27 Jan 2022 11:10:38 +0100
Message-Id: <20220127101044.13803-5-joro@8bytes.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220127101044.13803-1-joro@8bytes.org>
References: <20220127101044.13803-1-joro@8bytes.org>
MIME-Version: 1.0
Cc: kvm@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 virtualization@lists.linux-foundation.org,
 Arvind Sankar <nivedita@alum.mit.edu>, hpa@zytor.com,
 Jiri Slaby <jslaby@suse.cz>, Joerg Roedel <joro@8bytes.org>,
 David Rientjes <rientjes@google.com>, Masami Hiramatsu <mhiramat@kernel.org>,
 Martin Radev <martin.b.radev@gmail.com>,
 Tom Lendacky <thomas.lendacky@amd.com>, Joerg Roedel <jroedel@suse.de>,
 Kees Cook <keescook@chromium.org>, Cfir Cohen <cfir@google.com>,
 linux-coco@lists.linux.dev, Andy Lutomirski <luto@kernel.org>,
 Dan Williams <dan.j.williams@intel.com>, Juergen Gross <jgross@suse.com>,
 Mike Stunes <mstunes@vmware.com>, Sean Christopherson <seanjc@google.com>,
 kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
 Eric Biederman <ebiederm@xmission.com>, Erdem Aktas <erdemaktas@google.com>
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

Store the physical address of the AP jump table in kernel memory so
that it does not need to be fetched from the Hypervisor again.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 arch/x86/kernel/sev.c | 28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index 8a4317fa699a..969ef9855bb5 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -43,6 +43,9 @@ static struct ghcb boot_ghcb_page __bss_decrypted __aligned(PAGE_SIZE);
  */
 static struct ghcb __initdata *boot_ghcb;
 
+/* Cached AP jump table Address */
+static phys_addr_t jump_table_pa;
+
 /* #VC handler runtime per-CPU data */
 struct sev_es_runtime_data {
 	struct ghcb ghcb_page;
@@ -523,12 +526,14 @@ void noinstr __sev_es_nmi_complete(void)
 	__sev_put_ghcb(&state);
 }
 
-static u64 get_jump_table_addr(void)
+static phys_addr_t get_jump_table_addr(void)
 {
 	struct ghcb_state state;
 	unsigned long flags;
 	struct ghcb *ghcb;
-	u64 ret = 0;
+
+	if (jump_table_pa)
+		return jump_table_pa;
 
 	local_irq_save(flags);
 
@@ -544,39 +549,36 @@ static u64 get_jump_table_addr(void)
 
 	if (ghcb_sw_exit_info_1_is_valid(ghcb) &&
 	    ghcb_sw_exit_info_2_is_valid(ghcb))
-		ret = ghcb->save.sw_exit_info_2;
+		jump_table_pa = (phys_addr_t)ghcb->save.sw_exit_info_2;
 
 	__sev_put_ghcb(&state);
 
 	local_irq_restore(flags);
 
-	return ret;
+	return jump_table_pa;
 }
 
 int sev_es_setup_ap_jump_table(struct real_mode_header *rmh)
 {
 	u16 startup_cs, startup_ip;
-	phys_addr_t jump_table_pa;
-	u64 jump_table_addr;
 	u16 __iomem *jump_table;
+	phys_addr_t pa;
 
-	jump_table_addr = get_jump_table_addr();
+	pa = get_jump_table_addr();
 
 	/* On UP guests there is no jump table so this is not a failure */
-	if (!jump_table_addr)
+	if (!pa)
 		return 0;
 
-	/* Check if AP Jump Table is page-aligned */
-	if (jump_table_addr & ~PAGE_MASK)
+	/* Check if AP jump table is page-aligned */
+	if (pa & ~PAGE_MASK)
 		return -EINVAL;
 
-	jump_table_pa = jump_table_addr & PAGE_MASK;
-
 	startup_cs = (u16)(rmh->trampoline_start >> 4);
 	startup_ip = (u16)(rmh->sev_es_trampoline_start -
 			   rmh->trampoline_start);
 
-	jump_table = ioremap_encrypted(jump_table_pa, PAGE_SIZE);
+	jump_table = ioremap_encrypted(pa, PAGE_SIZE);
 	if (!jump_table)
 		return -EIO;
 
-- 
2.34.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

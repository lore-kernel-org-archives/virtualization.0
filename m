Return-Path: <SRS0=hAHP=MN=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE84FC12002
	for <virtualization@archiver.kernel.org>; Wed, 21 Jul 2021 14:20:47 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD0F361242
	for <virtualization@archiver.kernel.org>; Wed, 21 Jul 2021 14:20:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD0F361242
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 876548283D;
	Wed, 21 Jul 2021 14:20:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cjUI3GumYnFE; Wed, 21 Jul 2021 14:20:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 3AB0383026;
	Wed, 21 Jul 2021 14:20:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1389CC0010;
	Wed, 21 Jul 2021 14:20:46 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9742BC0022
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Jul 2021 14:20:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 86E27404F0
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Jul 2021 14:20:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BhWOo6JiWrCt
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Jul 2021 14:20:43 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A8B94404EE
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Jul 2021 14:20:43 +0000 (UTC)
Received: from cap.home.8bytes.org (p4ff2b1ea.dip0.t-ipconnect.de
 [79.242.177.234])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by theia.8bytes.org (Postfix) with ESMTPSA id BC7C49AA;
 Wed, 21 Jul 2021 16:20:26 +0200 (CEST)
From: Joerg Roedel <joro@8bytes.org>
To: x86@kernel.org,
	Eric Biederman <ebiederm@xmission.com>
Subject: [PATCH 04/12] x86/sev: Do not hardcode GHCB protocol version
Date: Wed, 21 Jul 2021 16:20:07 +0200
Message-Id: <20210721142015.1401-5-joro@8bytes.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210721142015.1401-1-joro@8bytes.org>
References: <20210721142015.1401-1-joro@8bytes.org>
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
 kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
 Masami Hiramatsu <mhiramat@kernel.org>, Erdem Aktas <erdemaktas@google.com>
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

Introduce the sev_get_ghcb_proto_ver() which will return the negotiated
GHCB protocol version and use it to set the version field in the GHCB.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 arch/x86/boot/compressed/sev.c | 5 +++++
 arch/x86/kernel/sev-shared.c   | 5 ++++-
 arch/x86/kernel/sev.c          | 5 +++++
 3 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
index 1a2e49730f8b..101e08c67296 100644
--- a/arch/x86/boot/compressed/sev.c
+++ b/arch/x86/boot/compressed/sev.c
@@ -119,6 +119,11 @@ static enum es_result vc_read_mem(struct es_em_ctxt *ctxt,
 /* Include code for early handlers */
 #include "../../kernel/sev-shared.c"
 
+static u64 sev_get_ghcb_proto_ver(void)
+{
+	return GHCB_PROTOCOL_MAX;
+}
+
 static bool early_setup_sev_es(void)
 {
 	if (!sev_es_negotiate_protocol(NULL))
diff --git a/arch/x86/kernel/sev-shared.c b/arch/x86/kernel/sev-shared.c
index 73eeb5897d16..36eaac2773ed 100644
--- a/arch/x86/kernel/sev-shared.c
+++ b/arch/x86/kernel/sev-shared.c
@@ -28,6 +28,9 @@ struct sev_ghcb_protocol_info {
 	unsigned int vm_proto;
 };
 
+/* Returns the negotiated GHCB Protocol version */
+static u64 sev_get_ghcb_proto_ver(void);
+
 static bool __init sev_es_check_cpu_features(void)
 {
 	if (!has_cpuflag(X86_FEATURE_RDRAND)) {
@@ -122,7 +125,7 @@ static enum es_result sev_es_ghcb_hv_call(struct ghcb *ghcb,
 	enum es_result ret;
 
 	/* Fill in protocol and format specifiers */
-	ghcb->protocol_version = GHCB_PROTOCOL_MAX;
+	ghcb->protocol_version = sev_get_ghcb_proto_ver();
 	ghcb->ghcb_usage       = GHCB_DEFAULT_USAGE;
 
 	ghcb_set_sw_exit_code(ghcb, exit_code);
diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index 8084bfd7cce1..5d3422e8b25e 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -498,6 +498,11 @@ static enum es_result vc_slow_virt_to_phys(struct ghcb *ghcb, struct es_em_ctxt
 /* Negotiated GHCB protocol version */
 static struct sev_ghcb_protocol_info ghcb_protocol_info __ro_after_init;
 
+static u64 sev_get_ghcb_proto_ver(void)
+{
+	return ghcb_protocol_info.vm_proto;
+}
+
 static noinstr void __sev_put_ghcb(struct ghcb_state *state)
 {
 	struct sev_es_runtime_data *data;
-- 
2.31.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

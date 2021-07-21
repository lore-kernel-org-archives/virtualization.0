Return-Path: <SRS0=hAHP=MN=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8F55C636CE
	for <virtualization@archiver.kernel.org>; Wed, 21 Jul 2021 14:20:45 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7ED6D61246
	for <virtualization@archiver.kernel.org>; Wed, 21 Jul 2021 14:20:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7ED6D61246
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5BB9382890;
	Wed, 21 Jul 2021 14:20:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kuQ6VdLBKsUb; Wed, 21 Jul 2021 14:20:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 022BD83004;
	Wed, 21 Jul 2021 14:20:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D0A95C0010;
	Wed, 21 Jul 2021 14:20:43 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 75B65C000E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Jul 2021 14:20:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5755F83004
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Jul 2021 14:20:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2wc9zqKI1pHe
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Jul 2021 14:20:41 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from theia.8bytes.org (8bytes.org
 [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6C7B683026
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Jul 2021 14:20:41 +0000 (UTC)
Received: from cap.home.8bytes.org (p4ff2b1ea.dip0.t-ipconnect.de
 [79.242.177.234])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by theia.8bytes.org (Postfix) with ESMTPSA id C917F99D;
 Wed, 21 Jul 2021 16:20:25 +0200 (CEST)
From: Joerg Roedel <joro@8bytes.org>
To: x86@kernel.org,
	Eric Biederman <ebiederm@xmission.com>
Subject: [PATCH 03/12] x86/sev: Save and print negotiated GHCB protocol version
Date: Wed, 21 Jul 2021 16:20:06 +0200
Message-Id: <20210721142015.1401-4-joro@8bytes.org>
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

Save the results of the GHCB protocol negotiation into a data structure
and print information about versions supported and used to the kernel
log.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 arch/x86/boot/compressed/sev.c |  2 +-
 arch/x86/kernel/sev-shared.c   | 22 +++++++++++++++++++++-
 arch/x86/kernel/sev.c          | 13 ++++++++++++-
 3 files changed, 34 insertions(+), 3 deletions(-)

diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
index 670e998fe930..1a2e49730f8b 100644
--- a/arch/x86/boot/compressed/sev.c
+++ b/arch/x86/boot/compressed/sev.c
@@ -121,7 +121,7 @@ static enum es_result vc_read_mem(struct es_em_ctxt *ctxt,
 
 static bool early_setup_sev_es(void)
 {
-	if (!sev_es_negotiate_protocol())
+	if (!sev_es_negotiate_protocol(NULL))
 		sev_es_terminate(GHCB_SEV_ES_REASON_PROTOCOL_UNSUPPORTED);
 
 	if (set_page_decrypted((unsigned long)&boot_ghcb_page))
diff --git a/arch/x86/kernel/sev-shared.c b/arch/x86/kernel/sev-shared.c
index 9f90f460a28c..73eeb5897d16 100644
--- a/arch/x86/kernel/sev-shared.c
+++ b/arch/x86/kernel/sev-shared.c
@@ -14,6 +14,20 @@
 #define has_cpuflag(f)	boot_cpu_has(f)
 #endif
 
+/*
+ * struct sev_ghcb_protocol_info - Used to return GHCB protocol
+ *				   negotiation details.
+ *
+ * @hv_proto_min:	Minimum GHCB protocol version supported by Hypervisor
+ * @hv_proto_max:	Maximum GHCB protocol version supported by Hypervisor
+ * @vm_proto:		Protocol version the VM (this kernel) will use
+ */
+struct sev_ghcb_protocol_info {
+	unsigned int hv_proto_min;
+	unsigned int hv_proto_max;
+	unsigned int vm_proto;
+};
+
 static bool __init sev_es_check_cpu_features(void)
 {
 	if (!has_cpuflag(X86_FEATURE_RDRAND)) {
@@ -42,7 +56,7 @@ static void __noreturn sev_es_terminate(unsigned int reason)
 		asm volatile("hlt\n" : : : "memory");
 }
 
-static bool sev_es_negotiate_protocol(void)
+static bool sev_es_negotiate_protocol(struct sev_ghcb_protocol_info *info)
 {
 	u64 val;
 
@@ -58,6 +72,12 @@ static bool sev_es_negotiate_protocol(void)
 	    GHCB_MSR_PROTO_MIN(val) > GHCB_PROTO_OUR)
 		return false;
 
+	if (info) {
+		info->hv_proto_min = GHCB_MSR_PROTO_MIN(val);
+		info->hv_proto_max = GHCB_MSR_PROTO_MAX(val);
+		info->vm_proto	   = GHCB_PROTO_OUR;
+	}
+
 	return true;
 }
 
diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index a6895e440bc3..8084bfd7cce1 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -495,6 +495,9 @@ static enum es_result vc_slow_virt_to_phys(struct ghcb *ghcb, struct es_em_ctxt
 /* Include code shared with pre-decompression boot stage */
 #include "sev-shared.c"
 
+/* Negotiated GHCB protocol version */
+static struct sev_ghcb_protocol_info ghcb_protocol_info __ro_after_init;
+
 static noinstr void __sev_put_ghcb(struct ghcb_state *state)
 {
 	struct sev_es_runtime_data *data;
@@ -665,7 +668,7 @@ static enum es_result vc_handle_msr(struct ghcb *ghcb, struct es_em_ctxt *ctxt)
 static bool __init sev_es_setup_ghcb(void)
 {
 	/* First make sure the hypervisor talks a supported protocol. */
-	if (!sev_es_negotiate_protocol())
+	if (!sev_es_negotiate_protocol(&ghcb_protocol_info))
 		return false;
 
 	/*
@@ -794,6 +797,14 @@ void __init sev_es_init_vc_handling(void)
 
 	/* Secondary CPUs use the runtime #VC handler */
 	initial_vc_handler = (unsigned long)kernel_exc_vmm_communication;
+
+	/*
+	 * Print information about supported and negotiated GHCB protocol
+	 * versions.
+	 */
+	pr_info("Hypervisor GHCB protocol version support: min=%u max=%u\n",
+		ghcb_protocol_info.hv_proto_min, ghcb_protocol_info.hv_proto_max);
+	pr_info("Using GHCB protocol version %u\n", ghcb_protocol_info.vm_proto);
 }
 
 static void __init vc_early_forward_exception(struct es_em_ctxt *ctxt)
-- 
2.31.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

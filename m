Return-Path: <SRS0=06fY=IK=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D1C8C43381
	for <virtualization@archiver.kernel.org>; Fri, 12 Mar 2021 12:38:42 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E62164D73
	for <virtualization@archiver.kernel.org>; Fri, 12 Mar 2021 12:38:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E62164D73
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B3AD384572;
	Fri, 12 Mar 2021 12:38:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vqhzEVw9WMlv; Fri, 12 Mar 2021 12:38:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTP id 11C0984565;
	Fri, 12 Mar 2021 12:38:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E6514C0012;
	Fri, 12 Mar 2021 12:38:37 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3F8F9C0001
 for <virtualization@lists.linux-foundation.org>;
 Fri, 12 Mar 2021 12:38:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2E2654ED26
 for <virtualization@lists.linux-foundation.org>;
 Fri, 12 Mar 2021 12:38:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EbKqkFku1Pj6
 for <virtualization@lists.linux-foundation.org>;
 Fri, 12 Mar 2021 12:38:35 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from theia.8bytes.org (8bytes.org
 [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
 by smtp4.osuosl.org (Postfix) with ESMTPS id EEFCF4D10E
 for <virtualization@lists.linux-foundation.org>;
 Fri, 12 Mar 2021 12:38:34 +0000 (UTC)
Received: from cap.home.8bytes.org (p549adcf6.dip0.t-ipconnect.de
 [84.154.220.246])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by theia.8bytes.org (Postfix) with ESMTPSA id 82E45412;
 Fri, 12 Mar 2021 13:38:31 +0100 (CET)
From: Joerg Roedel <joro@8bytes.org>
To: x86@kernel.org
Subject: [PATCH v3 2/8] x86/sev: Do not require Hypervisor CPUID bit for SEV
 guests
Date: Fri, 12 Mar 2021 13:38:18 +0100
Message-Id: <20210312123824.306-3-joro@8bytes.org>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210312123824.306-1-joro@8bytes.org>
References: <20210312123824.306-1-joro@8bytes.org>
MIME-Version: 1.0
Cc: kvm@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 virtualization@lists.linux-foundation.org,
 Arvind Sankar <nivedita@alum.mit.edu>, hpa@zytor.com,
 Jiri Slaby <jslaby@suse.cz>, Joerg Roedel <joro@8bytes.org>,
 David Rientjes <rientjes@google.com>, Martin Radev <martin.b.radev@gmail.com>,
 Tom Lendacky <thomas.lendacky@amd.com>, Joerg Roedel <jroedel@suse.de>,
 Kees Cook <keescook@chromium.org>, Cfir Cohen <cfir@google.com>,
 Andy Lutomirski <luto@kernel.org>, Dan Williams <dan.j.williams@intel.com>,
 Juergen Gross <jgross@suse.com>, Mike Stunes <mstunes@vmware.com>,
 Sean Christopherson <seanjc@google.com>, linux-kernel@vger.kernel.org,
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

A malicious hypervisor could disable the CPUID intercept for an SEV or
SEV-ES guest and trick it into the no-SEV boot path, where it could
potentially reveal secrets. This is not an issue for SEV-SNP guests,
as the CPUID intercept can't be disabled for those.

Remove the Hypervisor CPUID bit check from the SEV detection code to
protect against this kind of attack and add a Hypervisor bit equals
zero check to the SME detection path to prevent non-SEV guests from
trying to enable SME.

This handles the following cases:

	1) SEV(-ES) guest where CPUID intercept is disabled. The guest
	   will still see leaf 0x8000001f and the SEV bit. It can
	   retrieve the C-bit and boot normally.

	2) Non-SEV guests with intercepted CPUID will check SEV_STATUS
	   MSR and find it 0 and will try to enable SME. This will
	   fail when the guest finds MSR_K8_SYSCFG to be zero, as it
	   is emulated by KVM. But we can't rely on that, as there
	   might be other hypervisors which return this MSR with bit
	   23 set. The Hypervisor bit check will prevent that the
	   guest tries to enable SME in this case.

	3) Non-SEV guests on SEV capable hosts with CPUID intercept
	   disabled (by a malicious hypervisor) will try to boot into
	   the SME path. This will fail, but it is also not considered
	   a problem because non-encrypted guests have no protection
	   against the hypervisor anyway.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 arch/x86/boot/compressed/mem_encrypt.S |  6 -----
 arch/x86/kernel/sev-es-shared.c        |  6 +----
 arch/x86/mm/mem_encrypt_identity.c     | 35 ++++++++++++++------------
 3 files changed, 20 insertions(+), 27 deletions(-)

diff --git a/arch/x86/boot/compressed/mem_encrypt.S b/arch/x86/boot/compressed/mem_encrypt.S
index aa561795efd1..a6dea4e8a082 100644
--- a/arch/x86/boot/compressed/mem_encrypt.S
+++ b/arch/x86/boot/compressed/mem_encrypt.S
@@ -23,12 +23,6 @@ SYM_FUNC_START(get_sev_encryption_bit)
 	push	%ecx
 	push	%edx
 
-	/* Check if running under a hypervisor */
-	movl	$1, %eax
-	cpuid
-	bt	$31, %ecx		/* Check the hypervisor bit */
-	jnc	.Lno_sev
-
 	movl	$0x80000000, %eax	/* CPUID to check the highest leaf */
 	cpuid
 	cmpl	$0x8000001f, %eax	/* See if 0x8000001f is available */
diff --git a/arch/x86/kernel/sev-es-shared.c b/arch/x86/kernel/sev-es-shared.c
index cdc04d091242..387b71669818 100644
--- a/arch/x86/kernel/sev-es-shared.c
+++ b/arch/x86/kernel/sev-es-shared.c
@@ -186,7 +186,6 @@ void __init do_vc_no_ghcb(struct pt_regs *regs, unsigned long exit_code)
 	 * make it accessible to the hypervisor.
 	 *
 	 * In particular, check for:
-	 *	- Hypervisor CPUID bit
 	 *	- Availability of CPUID leaf 0x8000001f
 	 *	- SEV CPUID bit.
 	 *
@@ -194,10 +193,7 @@ void __init do_vc_no_ghcb(struct pt_regs *regs, unsigned long exit_code)
 	 * can't be checked here.
 	 */
 
-	if ((fn == 1 && !(regs->cx & BIT(31))))
-		/* Hypervisor bit */
-		goto fail;
-	else if (fn == 0x80000000 && (regs->ax < 0x8000001f))
+	if (fn == 0x80000000 && (regs->ax < 0x8000001f))
 		/* SEV leaf check */
 		goto fail;
 	else if ((fn == 0x8000001f && !(regs->ax & BIT(1))))
diff --git a/arch/x86/mm/mem_encrypt_identity.c b/arch/x86/mm/mem_encrypt_identity.c
index 6c5eb6f3f14f..a19374d26101 100644
--- a/arch/x86/mm/mem_encrypt_identity.c
+++ b/arch/x86/mm/mem_encrypt_identity.c
@@ -503,14 +503,10 @@ void __init sme_enable(struct boot_params *bp)
 
 #define AMD_SME_BIT	BIT(0)
 #define AMD_SEV_BIT	BIT(1)
-	/*
-	 * Set the feature mask (SME or SEV) based on whether we are
-	 * running under a hypervisor.
-	 */
-	eax = 1;
-	ecx = 0;
-	native_cpuid(&eax, &ebx, &ecx, &edx);
-	feature_mask = (ecx & BIT(31)) ? AMD_SEV_BIT : AMD_SME_BIT;
+
+	/* Check the SEV MSR whether SEV or SME is enabled */
+	sev_status   = __rdmsr(MSR_AMD64_SEV);
+	feature_mask = (sev_status & MSR_AMD64_SEV_ENABLED) ? AMD_SEV_BIT : AMD_SME_BIT;
 
 	/*
 	 * Check for the SME/SEV feature:
@@ -530,19 +526,26 @@ void __init sme_enable(struct boot_params *bp)
 
 	/* Check if memory encryption is enabled */
 	if (feature_mask == AMD_SME_BIT) {
+		/*
+		 * No SME if Hypervisor bit is set. This check is here to
+		 * prevent a guest from trying to enable SME. For running as a
+		 * KVM guest the MSR_K8_SYSCFG will be sufficient, but there
+		 * might be other hypervisors which emulate that MSR as non-zero
+		 * or even pass it through to the guest.
+		 * A malicious hypervisor can still trick a guest into this
+		 * path, but there is no way to protect against that.
+		 */
+		eax = 1;
+		ecx = 0;
+		native_cpuid(&eax, &ebx, &ecx, &edx);
+		if (ecx & BIT(31))
+			return;
+
 		/* For SME, check the SYSCFG MSR */
 		msr = __rdmsr(MSR_K8_SYSCFG);
 		if (!(msr & MSR_K8_SYSCFG_MEM_ENCRYPT))
 			return;
 	} else {
-		/* For SEV, check the SEV MSR */
-		msr = __rdmsr(MSR_AMD64_SEV);
-		if (!(msr & MSR_AMD64_SEV_ENABLED))
-			return;
-
-		/* Save SEV_STATUS to avoid reading MSR again */
-		sev_status = msr;
-
 		/* SEV state cannot be controlled by a command line option */
 		sme_me_mask = me_mask;
 		sev_enabled = true;
-- 
2.30.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

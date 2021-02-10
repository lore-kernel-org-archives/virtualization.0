Return-Path: <SRS0=QvMg=HM=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6981EC433E9
	for <virtualization@archiver.kernel.org>; Wed, 10 Feb 2021 10:22:07 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0295164E32
	for <virtualization@archiver.kernel.org>; Wed, 10 Feb 2021 10:22:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0295164E32
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id D650985F32;
	Wed, 10 Feb 2021 10:22:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EcNLrREs9fI4; Wed, 10 Feb 2021 10:22:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id E825E85F41;
	Wed, 10 Feb 2021 10:22:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C2C3EC1DA9;
	Wed, 10 Feb 2021 10:22:03 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 19BC5C013A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Feb 2021 10:22:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 115D28650D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Feb 2021 10:22:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mHeUhujr1iVB
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Feb 2021 10:22:01 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 58B83864E6
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Feb 2021 10:22:01 +0000 (UTC)
Received: from cap.home.8bytes.org (p549adcf6.dip0.t-ipconnect.de
 [84.154.220.246])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by theia.8bytes.org (Postfix) with ESMTPSA id 9F5B747C;
 Wed, 10 Feb 2021 11:21:57 +0100 (CET)
From: Joerg Roedel <joro@8bytes.org>
To: x86@kernel.org
Subject: [PATCH 5/7] x86/boot/compressed/64: Add CPUID sanity check to 32-bit
 boot-path
Date: Wed, 10 Feb 2021 11:21:33 +0100
Message-Id: <20210210102135.30667-6-joro@8bytes.org>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210210102135.30667-1-joro@8bytes.org>
References: <20210210102135.30667-1-joro@8bytes.org>
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
 linux-kernel@vger.kernel.org,
 Sean Christopherson <sean.j.christopherson@intel.com>,
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

The 32-bit #VC handler has no GHCB and can only handle CPUID exit codes.
It is needed by the early boot code to handle #VC exceptions raised in
verify_cpu() and to get the position of the C bit.

But the CPUID information comes from the hypervisor, which is untrusted
and might return results which trick the guest into the no-SEV boot path
with no C bit set in the page-tables. All data written to memory would
then be unencrypted and could leak sensitive data to the hypervisor.

Add sanity checks to the 32-bit boot #VC handler to make sure the
hypervisor does not pretend that SEV is not enabled.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 arch/x86/boot/compressed/mem_encrypt.S | 36 ++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/arch/x86/boot/compressed/mem_encrypt.S b/arch/x86/boot/compressed/mem_encrypt.S
index 350ecb56c7e4..091502cde070 100644
--- a/arch/x86/boot/compressed/mem_encrypt.S
+++ b/arch/x86/boot/compressed/mem_encrypt.S
@@ -126,6 +126,34 @@ SYM_CODE_START(startup32_vc_handler)
 	SEV_ES_REQ_CPUID fn=%ebx reg=3
 	movl	%edx, (%esp)
 
+	/*
+	 * Sanity check CPUID results from the Hypervisor. See comment in
+	 * do_vc_no_ghcb() for more details on why this is necessary.
+	 */
+
+	/* Fail if Hypervisor bit not set in CPUID[1].ECX[31] */
+	cmpl    $1, %ebx
+	jne     .Lcheck_leaf
+	btl     $31, 4(%esp)
+	jnc     .Lfail
+	jmp     .Ldone
+
+.Lcheck_leaf:
+	/* Fail if SEV leaf not available in CPUID[0x80000000].EAX */
+	cmpl    $0x80000000, %ebx
+	jne     .Lcheck_sev
+	cmpl    $0x8000001f, 12(%esp)
+	jb      .Lfail
+	jmp     .Ldone
+
+.Lcheck_sev:
+	/* Fail if SEV bit not set in CPUID[0x8000001f].EAX[1] */
+	cmpl    $0x8000001f, %ebx
+	jne     .Ldone
+	btl     $1, 12(%esp)
+	jnc     .Lfail
+
+.Ldone:
 	popl	%edx
 	popl	%ecx
 	popl	%ebx
@@ -139,6 +167,14 @@ SYM_CODE_START(startup32_vc_handler)
 
 	iret
 .Lfail:
+	/* Send terminate request to Hypervisor */
+	movl    $0x100, %eax
+	xorl    %edx, %edx
+	movl    $MSR_AMD64_SEV_ES_GHCB, %ecx
+	wrmsr
+	rep; vmmcall
+
+	/* If request fails, go to hlt loop */
 	hlt
 	jmp .Lfail
 SYM_CODE_END(startup32_vc_handler)
-- 
2.30.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

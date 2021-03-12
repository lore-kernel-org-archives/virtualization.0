Return-Path: <SRS0=06fY=IK=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69DF0C4332B
	for <virtualization@archiver.kernel.org>; Fri, 12 Mar 2021 12:38:44 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2561164FE0
	for <virtualization@archiver.kernel.org>; Fri, 12 Mar 2021 12:38:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2561164FE0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8CE1F6FAD4;
	Fri, 12 Mar 2021 12:38:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bJat6J1_3b3Y; Fri, 12 Mar 2021 12:38:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2A4826FADA;
	Fri, 12 Mar 2021 12:38:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 140C5C0001;
	Fri, 12 Mar 2021 12:38:41 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C224DC0001
 for <virtualization@lists.linux-foundation.org>;
 Fri, 12 Mar 2021 12:38:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9AF064ED3C
 for <virtualization@lists.linux-foundation.org>;
 Fri, 12 Mar 2021 12:38:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VGj26jGG2dmP
 for <virtualization@lists.linux-foundation.org>;
 Fri, 12 Mar 2021 12:38:37 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from theia.8bytes.org (8bytes.org
 [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 604204ED26
 for <virtualization@lists.linux-foundation.org>;
 Fri, 12 Mar 2021 12:38:37 +0000 (UTC)
Received: from cap.home.8bytes.org (p549adcf6.dip0.t-ipconnect.de
 [84.154.220.246])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by theia.8bytes.org (Postfix) with ESMTPSA id 30DA3692;
 Fri, 12 Mar 2021 13:38:33 +0100 (CET)
From: Joerg Roedel <joro@8bytes.org>
To: x86@kernel.org
Subject: [PATCH v3 5/8] x86/boot/compressed/64: Add 32-bit boot #VC handler
Date: Fri, 12 Mar 2021 13:38:21 +0100
Message-Id: <20210312123824.306-6-joro@8bytes.org>
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

Add a #VC exception handler which is used when the kernel still executes
in protected mode. This boot-path already uses CPUID, which will cause #VC
exceptions in an SEV-ES guest.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 arch/x86/boot/compressed/head_64.S     |  6 ++
 arch/x86/boot/compressed/mem_encrypt.S | 96 +++++++++++++++++++++++++-
 2 files changed, 101 insertions(+), 1 deletion(-)

diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
index 2001c3bf0748..ee448aedb8b0 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -34,6 +34,7 @@
 #include <asm/asm-offsets.h>
 #include <asm/bootparam.h>
 #include <asm/desc_defs.h>
+#include <asm/trapnr.h>
 #include "pgtable.h"
 
 /*
@@ -857,6 +858,11 @@ SYM_FUNC_END(startup32_set_idt_entry)
 
 SYM_FUNC_START(startup32_load_idt)
 #ifdef CONFIG_AMD_MEM_ENCRYPT
+	/* #VC handler */
+	leal    rva(startup32_vc_handler)(%ebp), %eax
+	movl    $X86_TRAP_VC, %edx
+	call    startup32_set_idt_entry
+
 	/* Load IDT */
 	leal	rva(boot32_idt)(%ebp), %eax
 	movl	%eax, rva(boot32_idt_desc+2)(%ebp)
diff --git a/arch/x86/boot/compressed/mem_encrypt.S b/arch/x86/boot/compressed/mem_encrypt.S
index a6dea4e8a082..e915f4906477 100644
--- a/arch/x86/boot/compressed/mem_encrypt.S
+++ b/arch/x86/boot/compressed/mem_encrypt.S
@@ -61,10 +61,104 @@ SYM_FUNC_START(get_sev_encryption_bit)
 	ret
 SYM_FUNC_END(get_sev_encryption_bit)
 
+/**
+ * sev_es_req_cpuid - Request a CPUID value from the Hypervisor using
+ *		      the GHCB MSR protocol
+ *
+ * @%eax:	Register to request (0=EAX, 1=EBX, 2=ECX, 3=EDX)
+ * @%edx:	CPUID Function
+ *
+ * Returns 0 in %eax on sucess, non-zero on failure
+ * %edx returns CPUID value on success
+ */
+SYM_CODE_START_LOCAL(sev_es_req_cpuid)
+	shll	$30, %eax
+	orl     $0x00000004, %eax
+	movl    $MSR_AMD64_SEV_ES_GHCB, %ecx
+	wrmsr
+	rep; vmmcall		# VMGEXIT
+	rdmsr
+
+	/* Check response */
+	movl	%eax, %ecx
+	andl	$0x3ffff000, %ecx	# Bits [12-29] MBZ
+	jnz	2f
+
+	/* Check return code */
+	andl    $0xfff, %eax
+	cmpl    $5, %eax
+	jne	2f
+
+	/* All good - return success */
+	xorl	%eax, %eax
+1:
+	ret
+2:
+	movl	$-1, %eax
+	jmp	1b
+SYM_CODE_END(sev_es_req_cpuid)
+
+SYM_CODE_START(startup32_vc_handler)
+	pushl	%eax
+	pushl	%ebx
+	pushl	%ecx
+	pushl	%edx
+
+	/* Keep CPUID function in %ebx */
+	movl	%eax, %ebx
+
+	/* Check if error-code == SVM_EXIT_CPUID */
+	cmpl	$0x72, 16(%esp)
+	jne	.Lfail
+
+	movl	$0, %eax		# Request CPUID[fn].EAX
+	movl	%ebx, %edx		# CPUID fn
+	call	sev_es_req_cpuid	# Call helper
+	testl	%eax, %eax		# Check return code
+	jnz	.Lfail
+	movl	%edx, 12(%esp)		# Store result
+
+	movl	$1, %eax		# Request CPUID[fn].EBX
+	movl	%ebx, %edx		# CPUID fn
+	call	sev_es_req_cpuid	# Call helper
+	testl	%eax, %eax		# Check return code
+	jnz	.Lfail
+	movl	%edx, 8(%esp)		# Store result
+
+	movl	$2, %eax		# Request CPUID[fn].ECX
+	movl	%ebx, %edx		# CPUID fn
+	call	sev_es_req_cpuid	# Call helper
+	testl	%eax, %eax		# Check return code
+	jnz	.Lfail
+	movl	%edx, 4(%esp)		# Store result
+
+	movl	$3, %eax		# Request CPUID[fn].EDX
+	movl	%ebx, %edx		# CPUID fn
+	call	sev_es_req_cpuid	# Call helper
+	testl	%eax, %eax		# Check return code
+	jnz	.Lfail
+	movl	%edx, 0(%esp)		# Store result
+
+	popl	%edx
+	popl	%ecx
+	popl	%ebx
+	popl	%eax
+
+	/* Remove error code */
+	addl	$4, %esp
+
+	/* Jump over CPUID instruction */
+	addl	$2, (%esp)
+
+	iret
+.Lfail:
+	hlt
+	jmp .Lfail
+SYM_CODE_END(startup32_vc_handler)
+
 	.code64
 
 #include "../../kernel/sev_verify_cbit.S"
-
 SYM_FUNC_START(set_sev_encryption_mask)
 #ifdef CONFIG_AMD_MEM_ENCRYPT
 	push	%rbp
-- 
2.30.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

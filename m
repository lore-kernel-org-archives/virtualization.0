Return-Path: <SRS0=2EET=LR=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDB2DC4743C
	for <virtualization@archiver.kernel.org>; Wed, 23 Jun 2021 09:33:12 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5DCFE61185
	for <virtualization@archiver.kernel.org>; Wed, 23 Jun 2021 09:33:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DCFE61185
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 1150D4027C;
	Wed, 23 Jun 2021 09:33:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Vl5kY1CJTZJN; Wed, 23 Jun 2021 09:33:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 8403140003;
	Wed, 23 Jun 2021 09:33:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2DAF1C001A;
	Wed, 23 Jun 2021 09:33:10 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7E9FAC000E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Jun 2021 09:33:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 528F1404A2
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Jun 2021 09:33:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=alien8.de
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id C2V7rDMM_DkC
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Jun 2021 09:33:02 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5429D40253
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Jun 2021 09:33:02 +0000 (UTC)
Received: from zn.tnic (p200300ec2f114b00a4a414805e84bac1.dip0.t-ipconnect.de
 [IPv6:2003:ec:2f11:4b00:a4a4:1480:5e84:bac1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5C0EC1EC04DE;
 Wed, 23 Jun 2021 11:32:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
 t=1624440778;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
 bh=5Dfo3J4t3itaTxlARqlq6y7lR5cwNrkt0PtKQVp6RKA=;
 b=JdGTbEsk9d/Hd8RXQANptDXP5KCvC6M0g+60AxNSox+kKCKFpQ4LjZoL35wSK5KSfd8fW6
 nkXfF+RXg0Zb63m/OKgrJqQpJtPjzzTElNQnp16W167NORjCVdPTJQ5nkbHRMY+u6Fd7UG
 ROgl39XVWIhSOJ/jk6YyfiwwBJONkY8=
Date: Wed, 23 Jun 2021 11:32:50 +0200
From: Borislav Petkov <bp@alien8.de>
To: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH 2/3] x86/sev: Add defines for GHCB version 2 MSR protocol
 requests
Message-ID: <YNL/wpVY1PmGJASW@zn.tnic>
References: <20210622144825.27588-1-joro@8bytes.org>
 <20210622144825.27588-3-joro@8bytes.org>
 <YNLXQIZ5e1wjkshG@8bytes.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YNLXQIZ5e1wjkshG@8bytes.org>
Cc: Brijesh Singh <brijesh.singh@amd.com>, kvm@vger.kernel.org,
 Peter Zijlstra <peterz@infradead.org>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 virtualization@lists.linux-foundation.org,
 Arvind Sankar <nivedita@alum.mit.edu>, hpa@zytor.com,
 Jiri Slaby <jslaby@suse.cz>, x86@kernel.org,
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

On Wed, Jun 23, 2021 at 08:40:00AM +0200, Joerg Roedel wrote:
> From: Brijesh Singh <brijesh.singh@amd.com>
> 
> Add the necessary defines for supporting the GHCB version 2 protocol.
> This includes defines for:
> 
> 	- MSR-based AP hlt request/response
> 	- Hypervisor Feature request/response
> 
> This is the bare minimum of requests that need to be supported by a GHCB
> version 2 implementation. There are more requests in the specification,
> but those depend on Secure Nested Paging support being available.
> 
> These defines are shared between SEV host and guest support, so they are
> submitted as an individual patch without users yet to avoid merge
> conflicts in the future.
> 
> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
> Co-developed-by: Tom Lendacky <thomas.lendacky@amd.com>
> Signed-off-by: Joerg Roedel <jroedel@suse.de>
> ---
>  arch/x86/include/asm/sev-common.h | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/arch/x86/include/asm/sev-common.h b/arch/x86/include/asm/sev-common.h
> index 1cc9e7dd8107..9aa2f29b4c97 100644
> --- a/arch/x86/include/asm/sev-common.h
> +++ b/arch/x86/include/asm/sev-common.h
> @@ -47,6 +47,21 @@
>  		(((unsigned long)reg & GHCB_MSR_CPUID_REG_MASK) << GHCB_MSR_CPUID_REG_POS) | \
>  		(((unsigned long)fn) << GHCB_MSR_CPUID_FUNC_POS))
>  
> +/* AP Reset Hold */
> +#define GHCB_MSR_AP_RESET_HOLD_REQ		0x006
> +#define GHCB_MSR_AP_RESET_HOLD_RESP		0x007
> +#define GHCB_MSR_AP_RESET_HOLD_RESULT_POS	12
> +#define GHCB_MSR_AP_RESET_HOLD_RESULT_MASK	GENMASK_ULL(51, 0)
> +
> +/* GHCB Hypervisor Feature Request/Response */
> +#define GHCB_MSR_HV_FT_REQ			0x080
> +#define GHCB_MSR_HV_FT_RESP			0x081
> +#define GHCB_MSR_HV_FT_POS			12
> +#define GHCB_MSR_HV_FT_MASK			GENMASK_ULL(51, 0)
> +
> +#define GHCB_MSR_HV_FT_RESP_VAL(v)		\
> +	((unsigned long)((v) >> GHCB_MSR_HV_FT_POS) & GHCB_MSR_HV_FT_MASK)
> +

Ok, so I took a critical look at this and it doesn't make sense to have
a differently named define each time you need the [63:12] slice of
GHCBData. So you can simply use GHCB_DATA(msr_value) instead, see below.

Complaints?

---
From: Brijesh Singh <brijesh.singh@amd.com>
Date: Wed, 23 Jun 2021 08:40:00 +0200
Subject: [PATCH] x86/sev: Add defines for GHCB version 2 MSR protocol requests

Add the necessary defines for supporting the GHCB version 2 protocol.
This includes defines for:

	- MSR-based AP hlt request/response
	- Hypervisor Feature request/response

This is the bare minimum of requests that need to be supported by a GHCB
version 2 implementation. There are more requests in the specification,
but those depend on Secure Nested Paging support being available.

These defines are shared between SEV host and guest support.

  [ bp: Fold in https://lkml.kernel.org/r/20210622144825.27588-2-joro@8bytes.org too.
        Simplify the brewing macro maze into readability. ]

Co-developed-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/YNLXQIZ5e1wjkshG@8bytes.org
---
 arch/x86/include/asm/sev-common.h | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/sev-common.h b/arch/x86/include/asm/sev-common.h
index 629c3df243f0..2cef6c5a52c2 100644
--- a/arch/x86/include/asm/sev-common.h
+++ b/arch/x86/include/asm/sev-common.h
@@ -9,8 +9,13 @@
 #define __ASM_X86_SEV_COMMON_H
 
 #define GHCB_MSR_INFO_POS		0
-#define GHCB_MSR_INFO_MASK		(BIT_ULL(12) - 1)
+#define GHCB_DATA_LOW			12
+#define GHCB_MSR_INFO_MASK		(BIT_ULL(GHCB_DATA_LOW) - 1)
 
+#define GHCB_DATA(v)			\
+	(((unsigned long)(v) & ~GHCB_MSR_INFO_MASK) >> GHCB_DATA_LOW)
+
+/* SEV Information Request/Response */
 #define GHCB_MSR_SEV_INFO_RESP		0x001
 #define GHCB_MSR_SEV_INFO_REQ		0x002
 #define GHCB_MSR_VER_MAX_POS		48
@@ -28,6 +33,7 @@
 #define GHCB_MSR_PROTO_MAX(v)		(((v) >> GHCB_MSR_VER_MAX_POS) & GHCB_MSR_VER_MAX_MASK)
 #define GHCB_MSR_PROTO_MIN(v)		(((v) >> GHCB_MSR_VER_MIN_POS) & GHCB_MSR_VER_MIN_MASK)
 
+/* CPUID Request/Response */
 #define GHCB_MSR_CPUID_REQ		0x004
 #define GHCB_MSR_CPUID_RESP		0x005
 #define GHCB_MSR_CPUID_FUNC_POS		32
@@ -45,6 +51,14 @@
 		(((unsigned long)reg & GHCB_MSR_CPUID_REG_MASK) << GHCB_MSR_CPUID_REG_POS) | \
 		(((unsigned long)fn) << GHCB_MSR_CPUID_FUNC_POS))
 
+/* AP Reset Hold */
+#define GHCB_MSR_AP_RESET_HOLD_REQ		0x006
+#define GHCB_MSR_AP_RESET_HOLD_RESP		0x007
+
+/* GHCB Hypervisor Feature Request/Response */
+#define GHCB_MSR_HV_FT_REQ			0x080
+#define GHCB_MSR_HV_FT_RESP			0x081
+
 #define GHCB_MSR_TERM_REQ		0x100
 #define GHCB_MSR_TERM_REASON_SET_POS	12
 #define GHCB_MSR_TERM_REASON_SET_MASK	0xf
-- 
2.29.2

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

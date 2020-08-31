Return-Path: <SRS0=Psgj=CJ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2124BC433E2
	for <virtualization@archiver.kernel.org>; Mon, 31 Aug 2020 17:09:48 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E01562054F
	for <virtualization@archiver.kernel.org>; Mon, 31 Aug 2020 17:09:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="ni5Nt2Pk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E01562054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 94A7286F7A;
	Mon, 31 Aug 2020 17:09:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qx7Hk319KHvo; Mon, 31 Aug 2020 17:09:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id F386D86FE4;
	Mon, 31 Aug 2020 17:09:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E7B57C0052;
	Mon, 31 Aug 2020 17:09:46 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3421EC0051
 for <virtualization@lists.linux-foundation.org>;
 Mon, 31 Aug 2020 17:09:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 22B8586FE4
 for <virtualization@lists.linux-foundation.org>;
 Mon, 31 Aug 2020 17:09:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TSG-JMNeeq5j
 for <virtualization@lists.linux-foundation.org>;
 Mon, 31 Aug 2020 17:09:44 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
 by hemlock.osuosl.org (Postfix) with ESMTPS id E86D186F7A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 31 Aug 2020 17:09:43 +0000 (UTC)
Received: from zn.tnic (p200300ec2f085000329c23fffea6a903.dip0.t-ipconnect.de
 [IPv6:2003:ec:2f08:5000:329c:23ff:fea6:a903])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 143D61EC0428;
 Mon, 31 Aug 2020 19:09:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
 t=1598893781;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
 bh=aMZ5RZS0u1emzQ3FTdi1Dugu3WlGF9pi+6qmkEnK8Rw=;
 b=ni5Nt2PkyGASdLM+wB6eGSOKHks/SlKYXYL7PxLqWA9CEjov0CKErJ+94GqUsJTGbjV6hL
 HQi66OT4bPcjktuYjPQtvsS5QzgszPY4oKoQCYQlOr+cxDUXkCYmTT/Scd30nURTokc54z
 QfGRFJpmgV69Er15hYQJbH7ppI/yx9A=
Date: Mon, 31 Aug 2020 19:09:37 +0200
From: Borislav Petkov <bp@alien8.de>
To: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH v6 69/76] x86/realmode: Setup AP jump table
Message-ID: <20200831170937.GK27517@zn.tnic>
References: <20200824085511.7553-1-joro@8bytes.org>
 <20200824085511.7553-70-joro@8bytes.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200824085511.7553-70-joro@8bytes.org>
Cc: Juergen Gross <jgross@suse.com>, Tom Lendacky <thomas.lendacky@amd.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, Mike Stunes <mstunes@vmware.com>,
 Kees Cook <keescook@chromium.org>, kvm@vger.kernel.org,
 Peter Zijlstra <peterz@infradead.org>, Cfir Cohen <cfir@google.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org,
 Sean Christopherson <sean.j.christopherson@intel.com>,
 virtualization@lists.linux-foundation.org,
 Martin Radev <martin.b.radev@gmail.com>, Joerg Roedel <jroedel@suse.de>,
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

On Mon, Aug 24, 2020 at 10:55:04AM +0200, Joerg Roedel wrote:
> diff --git a/arch/x86/include/uapi/asm/svm.h b/arch/x86/include/uapi/asm/svm.h
> index 8f36ae021a7f..a19ce9681ec2 100644
> --- a/arch/x86/include/uapi/asm/svm.h
> +++ b/arch/x86/include/uapi/asm/svm.h
> @@ -84,6 +84,9 @@
>  /* SEV-ES software-defined VMGEXIT events */
>  #define SVM_VMGEXIT_MMIO_READ			0x80000001
>  #define SVM_VMGEXIT_MMIO_WRITE			0x80000002
> +#define SVM_VMGEXIT_AP_JUMP_TABLE		0x80000005
> +#define		SVM_VMGEXIT_SET_AP_JUMP_TABLE			0
> +#define		SVM_VMGEXIT_GET_AP_JUMP_TABLE			1
	  ^^^^^^^^^^^^

One tab too many here.

>  #define SVM_VMGEXIT_UNSUPPORTED_EVENT		0x8000ffff
>  
>  #define SVM_EXIT_ERR           -1
> diff --git a/arch/x86/kernel/sev-es.c b/arch/x86/kernel/sev-es.c
> index 28fe95ecd508..09a45ccd6c1d 100644
> --- a/arch/x86/kernel/sev-es.c
> +++ b/arch/x86/kernel/sev-es.c
> @@ -21,6 +21,8 @@
>  #include <linux/mm.h>
>  
>  #include <asm/cpu_entry_area.h>
> +#include <asm/stacktrace.h>
> +#include <asm/realmode.h>
>  #include <asm/sev-es.h>
>  #include <asm/insn-eval.h>
>  #include <asm/fpu/internal.h>
> @@ -219,6 +221,9 @@ static __always_inline void sev_es_put_ghcb(struct ghcb_state *state)
>  	}
>  }
>  
> +/* Needed in vc_early_vc_forward_exception */

vc_early_forward_exception()

> +void do_early_exception(struct pt_regs *regs, int trapnr);
> +
>  static inline u64 sev_es_rd_ghcb_msr(void)
>  {
>  	return native_read_msr(MSR_AMD64_SEV_ES_GHCB);
> @@ -407,6 +412,69 @@ static bool vc_slow_virt_to_phys(struct ghcb *ghcb, struct es_em_ctxt *ctxt,
>  /* Include code shared with pre-decompression boot stage */
>  #include "sev-es-shared.c"
>  
> +static u64 sev_es_get_jump_table_addr(void)

Static and used here only once - you can drop the previx "sev_es".

> +{
> +	struct ghcb_state state;
> +	unsigned long flags;
> +	struct ghcb *ghcb;
> +	u64 ret;
> +
> +	local_irq_save(flags);
> +
> +	ghcb = sev_es_get_ghcb(&state);
> +
> +	vc_ghcb_invalidate(ghcb);
> +	ghcb_set_sw_exit_code(ghcb, SVM_VMGEXIT_AP_JUMP_TABLE);
> +	ghcb_set_sw_exit_info_1(ghcb, SVM_VMGEXIT_GET_AP_JUMP_TABLE);
> +	ghcb_set_sw_exit_info_2(ghcb, 0);
> +
> +	sev_es_wr_ghcb_msr(__pa(ghcb));
> +	VMGEXIT();
> +
> +	if (!ghcb_sw_exit_info_1_is_valid(ghcb) ||
> +	    !ghcb_sw_exit_info_2_is_valid(ghcb))
> +		ret = 0;
> +
> +	ret = ghcb->save.sw_exit_info_2;
> +
> +	sev_es_put_ghcb(&state);
> +
> +	local_irq_restore(flags);
> +
> +	return ret;
> +}
> +
> +int sev_es_setup_ap_jump_table(struct real_mode_header *rmh)
> +{
> +	u16 startup_cs, startup_ip;
> +	phys_addr_t jump_table_pa;
> +	u64 jump_table_addr;
> +	u16 __iomem *jump_table;
> +
> +	jump_table_addr = sev_es_get_jump_table_addr();
> +
> +	/* Check if AP Jump Table is non-zero and page-aligned */
> +	if (!jump_table_addr || jump_table_addr & ~PAGE_MASK)
> +		return 0;

I think you need to return !0 here so that the panic() below fires with
a modified message:

	panic("Failed to get/update SEV-ES AP Jump Table");

or are we gonna boot an UP guest still?

If not panic, at least a warning that at least some APs didn't come
up...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

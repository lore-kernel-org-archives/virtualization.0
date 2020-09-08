Return-Path: <SRS0=DDSL=CR=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00DB6C433E2
	for <virtualization@archiver.kernel.org>; Tue,  8 Sep 2020 17:46:23 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27B8D2098B
	for <virtualization@archiver.kernel.org>; Tue,  8 Sep 2020 17:46:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="RM/Zx8iH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27B8D2098B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id BAADA84E34;
	Tue,  8 Sep 2020 17:46:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VyYAGGMjdZZ0; Tue,  8 Sep 2020 17:46:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 1F80884D9A;
	Tue,  8 Sep 2020 17:46:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F14B8C0859;
	Tue,  8 Sep 2020 17:46:20 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CDA32C0051
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Sep 2020 17:46:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id BCBA984D9A
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Sep 2020 17:46:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id n0BYmwgndWll
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Sep 2020 17:46:18 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 024D48085A
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Sep 2020 17:46:18 +0000 (UTC)
Received: from zn.tnic (p200300ec2f10bf0070b09dfd4356f225.dip0.t-ipconnect.de
 [IPv6:2003:ec:2f10:bf00:70b0:9dfd:4356:f225])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 605F51EC0489;
 Tue,  8 Sep 2020 19:46:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
 t=1599587176;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
 bh=nPj3+c2dIwhanvH9Blvxwpvfl2eV/3k/Q9aSuFLclYg=;
 b=RM/Zx8iHBvG5Eti/FNmYaWgJjIMOyQ4VltylfyxY4IdCEIFAfWH60weezPSlACosueFynJ
 DKlNyhaAe9DDi+Up/33riZE7n2E7K1VUYzWs+AuxGZl1Bzei/yP0kIDcV8JJzVPAf4HdRS
 QJYbhpttRw4vRmtimjYS+Qynt7kt/ms=
Date: Tue, 8 Sep 2020 19:46:16 +0200
From: Borislav Petkov <bp@alien8.de>
To: Joerg Roedel <joro@8bytes.org>, Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH v7 71/72] x86/efi: Add GHCB mappings when SEV-ES is active
Message-ID: <20200908174616.GJ25236@zn.tnic>
References: <20200907131613.12703-1-joro@8bytes.org>
 <20200907131613.12703-72-joro@8bytes.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200907131613.12703-72-joro@8bytes.org>
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

+ Ard so that he can ack the efi bits.

On Mon, Sep 07, 2020 at 03:16:12PM +0200, Joerg Roedel wrote:
> From: Tom Lendacky <thomas.lendacky@amd.com>
> 
> Calling down to EFI runtime services can result in the firmware performing
> VMGEXIT calls. The firmware is likely to use the GHCB of the OS (e.g., for
> setting EFI variables), so each GHCB in the system needs to be identity
> mapped in the EFI page tables, as unencrypted, to avoid page faults.
> 
> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
> [ jroedel@suse.de: Moved GHCB mapping loop to sev-es.c ]
> Signed-off-by: Joerg Roedel <jroedel@suse.de>
> ---
>  arch/x86/boot/compressed/sev-es.c |  1 +
>  arch/x86/include/asm/sev-es.h     |  2 ++
>  arch/x86/kernel/sev-es.c          | 30 ++++++++++++++++++++++++++++++
>  arch/x86/platform/efi/efi_64.c    | 10 ++++++++++
>  4 files changed, 43 insertions(+)
> 
> diff --git a/arch/x86/boot/compressed/sev-es.c b/arch/x86/boot/compressed/sev-es.c
> index 45702b866c33..0a9a248ca33d 100644
> --- a/arch/x86/boot/compressed/sev-es.c
> +++ b/arch/x86/boot/compressed/sev-es.c
> @@ -12,6 +12,7 @@
>   */
>  #include "misc.h"
>  
> +#include <asm/pgtable_types.h>
>  #include <asm/sev-es.h>
>  #include <asm/trapnr.h>
>  #include <asm/trap_pf.h>
> diff --git a/arch/x86/include/asm/sev-es.h b/arch/x86/include/asm/sev-es.h
> index e919f09ae33c..cf1d957c7091 100644
> --- a/arch/x86/include/asm/sev-es.h
> +++ b/arch/x86/include/asm/sev-es.h
> @@ -102,11 +102,13 @@ static __always_inline void sev_es_nmi_complete(void)
>  	if (static_branch_unlikely(&sev_es_enable_key))
>  		__sev_es_nmi_complete();
>  }
> +extern int __init sev_es_efi_map_ghcbs(pgd_t *pgd);
>  #else
>  static inline void sev_es_ist_enter(struct pt_regs *regs) { }
>  static inline void sev_es_ist_exit(void) { }
>  static inline int sev_es_setup_ap_jump_table(struct real_mode_header *rmh) { return 0; }
>  static inline void sev_es_nmi_complete(void) { }
> +static inline int sev_es_efi_map_ghcbs(pgd_t *pgd) { return 0; }
>  #endif
>  
>  #endif
> diff --git a/arch/x86/kernel/sev-es.c b/arch/x86/kernel/sev-es.c
> index 9ab3a4dfecd8..4e2b7e4d9b87 100644
> --- a/arch/x86/kernel/sev-es.c
> +++ b/arch/x86/kernel/sev-es.c
> @@ -491,6 +491,36 @@ int sev_es_setup_ap_jump_table(struct real_mode_header *rmh)
>  	return 0;
>  }
>  
> +/*
> + * This is needed by the OVMF UEFI firmware which will use whatever it finds in
> + * the GHCB MSR as its GHCB to talk to the hypervisor. So make sure the per-cpu
> + * runtime GHCBs used by the kernel are also mapped in the EFI page-table.
> + */
> +int __init sev_es_efi_map_ghcbs(pgd_t *pgd)
> +{
> +	struct sev_es_runtime_data *data;
> +	unsigned long address, pflags;
> +	int cpu;
> +	u64 pfn;
> +
> +	if (!sev_es_active())
> +		return 0;
> +
> +	pflags = _PAGE_NX | _PAGE_RW;
> +
> +	for_each_possible_cpu(cpu) {
> +		data = per_cpu(runtime_data, cpu);
> +
> +		address = __pa(&data->ghcb_page);
> +		pfn = address >> PAGE_SHIFT;
> +
> +		if (kernel_map_pages_in_pgd(pgd, pfn, address, 1, pflags))
> +			return 1;
> +	}
> +
> +	return 0;
> +}
> +
>  static enum es_result vc_handle_msr(struct ghcb *ghcb, struct es_em_ctxt *ctxt)
>  {
>  	struct pt_regs *regs = ctxt->regs;
> diff --git a/arch/x86/platform/efi/efi_64.c b/arch/x86/platform/efi/efi_64.c
> index 6af4da1149ba..8f5759df7776 100644
> --- a/arch/x86/platform/efi/efi_64.c
> +++ b/arch/x86/platform/efi/efi_64.c
> @@ -47,6 +47,7 @@
>  #include <asm/realmode.h>
>  #include <asm/time.h>
>  #include <asm/pgalloc.h>
> +#include <asm/sev-es.h>
>  
>  /*
>   * We allocate runtime services regions top-down, starting from -4G, i.e.
> @@ -229,6 +230,15 @@ int __init efi_setup_page_tables(unsigned long pa_memmap, unsigned num_pages)
>  		return 1;
>  	}
>  
> +	/*
> +	 * When SEV-ES is active, the GHCB as set by the kernel will be used
> +	 * by firmware. Create a 1:1 unencrypted mapping for each GHCB.
> +	 */
> +	if (sev_es_efi_map_ghcbs(pgd)) {
> +		pr_err("Failed to create 1:1 mapping for the GHCBs!\n");
> +		return 1;
> +	}
> +
>  	/*
>  	 * When making calls to the firmware everything needs to be 1:1
>  	 * mapped and addressable with 32-bit pointers. Map the kernel
> -- 
> 2.28.0
> 

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

Return-Path: <SRS0=8i8N=ES=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EBA6C61DD8
	for <virtualization@archiver.kernel.org>; Thu, 12 Nov 2020 15:58:02 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 782AB221E9
	for <virtualization@archiver.kernel.org>; Thu, 12 Nov 2020 15:58:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bijei9yg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 782AB221E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id C985A2E210;
	Thu, 12 Nov 2020 15:58:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SBNswdz+6ymp; Thu, 12 Nov 2020 15:57:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 126722E209;
	Thu, 12 Nov 2020 15:57:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0297BC088B;
	Thu, 12 Nov 2020 15:57:57 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B434DC016F
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Nov 2020 15:57:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id ADC4087135
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Nov 2020 15:57:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8aug6e+ZJDSs
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Nov 2020 15:57:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 69A2087132
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Nov 2020 15:57:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1605196673;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eMsslzB60p6fE68DmvMliK7UF+Lv8JTCHb2KCVlluDo=;
 b=Bijei9ygMlwtu7Uxn05uScEtXNf7dXFEPhvSSW+sWFqaJI8ncnb+9/7z4jt1YyNl51+TTx
 bIFbBjiWv4DzKh4hWR8QuzKtpABiacb52Jf0OlBb4Ty4Xy+AF12JkRjAcXGPwXd04Oj1e4
 9AeWy+XVa3ICLinUcIs5qhwaElecdHo=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-386-hLetoI3YPxGteALq59pk-A-1; Thu, 12 Nov 2020 10:57:50 -0500
X-MC-Unique: hLetoI3YPxGteALq59pk-A-1
Received: by mail-wr1-f72.google.com with SMTP id v5so2131782wrr.0
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Nov 2020 07:57:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
 :message-id:mime-version;
 bh=eMsslzB60p6fE68DmvMliK7UF+Lv8JTCHb2KCVlluDo=;
 b=kH87MNwyYlPaLp9pFNfpUO/J6/ULtVjgoLPMYNyHQ807kddvG4lQ5rIevfWm/QLeTI
 9OM1mhZx/HhJ5wnJ9q8DzDFIxoQad2aqyUd1WnrRj/G7FyrPMIjqZiBOoq1Wh6AqF0LE
 DvjhZELk2NFTnmPSsDd77NQrliSnOkKukV9rScObfjXDLDGUeS2nWzle1WVgYHCqdMuw
 a62nLzrwOWu1/RXM4Hhf6Chy36RpIdoDqvy0b9W3gHN8HrPUMyumnjE+GRNcH0xBgLpW
 O5MSWzSGVmTN4a3sB0sgeSZM02mOC1nSmDsfunB5Csab39S1vkUidsVtCYn5jnIXY4jj
 yh4Q==
X-Gm-Message-State: AOAM532pPon+JsVEMFiQ6DMmeSuVGVWWSivERIsfn7b4ICAhyjLDj1bU
 vJ+giVid1f17Nzp95DxNBSlDPtM6/pDlijQIbOKwvxuaWWFjBIO6eYH/Gav7iJMosz7De0D9MjT
 N9W3eLZoFe2C4Zc6eVTpFhcATZU7FYurxutxi4ypDBg==
X-Received: by 2002:a5d:5686:: with SMTP id f6mr164843wrv.329.1605196669178;
 Thu, 12 Nov 2020 07:57:49 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxS8FL/rGWLRebjIj5BO7JLYQfEAyrXlJE2ouC3hPEX/lKUkClC2UxnLRmwJKF6B+Q3NpRgSA==
X-Received: by 2002:a5d:5686:: with SMTP id f6mr164816wrv.329.1605196668951;
 Thu, 12 Nov 2020 07:57:48 -0800 (PST)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
 by smtp.gmail.com with ESMTPSA id x81sm7556334wmg.5.2020.11.12.07.57.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Nov 2020 07:57:48 -0800 (PST)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: Wei Liu <wei.liu@kernel.org>, Linux on Hyper-V List
 <linux-hyperv@vger.kernel.org>
Subject: Re: [PATCH v2 09/17] x86/hyperv: provide a bunch of helper functions
In-Reply-To: <20201105165814.29233-10-wei.liu@kernel.org>
References: <20201105165814.29233-1-wei.liu@kernel.org>
 <20201105165814.29233-10-wei.liu@kernel.org>
Date: Thu, 12 Nov 2020 16:57:46 +0100
Message-ID: <871rgyy3d1.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=vkuznets@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: "open list:GENERIC INCLUDE/ASM HEADER FILES" <linux-arch@vger.kernel.org>,
 Wei Liu <wei.liu@kernel.org>, Stephen Hemminger <sthemmin@microsoft.com>,
 Arnd Bergmann <arnd@arndb.de>, Haiyang Zhang <haiyangz@microsoft.com>,
 "maintainer:X86 ARCHITECTURE \(32-BIT AND 64-BIT\)" <x86@kernel.org>,
 Linux Kernel List <linux-kernel@vger.kernel.org>,
 Michael Kelley <mikelley@microsoft.com>, Ingo Molnar <mingo@redhat.com>,
 Thomas Gleixner <tglx@linutronix.de>, "H.
 Peter Anvin" <hpa@zytor.com>, Nuno Das Neves <nunodasneves@linux.microsoft.com>,
 Borislav Petkov <bp@alien8.de>, Sunil Muthuswamy <sunilmut@microsoft.com>,
 virtualization@lists.linux-foundation.org,
 Vineeth Pillai <viremana@linux.microsoft.com>,
 Lillian Grassin-Drake <ligrassi@microsoft.com>
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

Wei Liu <wei.liu@kernel.org> writes:

> They are used to deposit pages into Microsoft Hypervisor and bring up
> logical and virtual processors.
>
> Signed-off-by: Lillian Grassin-Drake <ligrassi@microsoft.com>
> Signed-off-by: Sunil Muthuswamy <sunilmut@microsoft.com>
> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
> Co-Developed-by: Lillian Grassin-Drake <ligrassi@microsoft.com>
> Co-Developed-by: Sunil Muthuswamy <sunilmut@microsoft.com>
> Co-Developed-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
> Signed-off-by: Wei Liu <wei.liu@kernel.org>
> ---
> v2:
> 1. Adapt to hypervisor side changes
> 2. Address Vitaly's comments
> ---
>  arch/x86/hyperv/Makefile          |   2 +-
>  arch/x86/hyperv/hv_proc.c         | 217 ++++++++++++++++++++++++++++++
>  arch/x86/include/asm/mshyperv.h   |   4 +
>  include/asm-generic/hyperv-tlfs.h |  67 +++++++++
>  4 files changed, 289 insertions(+), 1 deletion(-)
>  create mode 100644 arch/x86/hyperv/hv_proc.c
>
> diff --git a/arch/x86/hyperv/Makefile b/arch/x86/hyperv/Makefile
> index 89b1f74d3225..565358020921 100644
> --- a/arch/x86/hyperv/Makefile
> +++ b/arch/x86/hyperv/Makefile
> @@ -1,6 +1,6 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  obj-y			:= hv_init.o mmu.o nested.o
> -obj-$(CONFIG_X86_64)	+= hv_apic.o
> +obj-$(CONFIG_X86_64)	+= hv_apic.o hv_proc.o
>  
>  ifdef CONFIG_X86_64
>  obj-$(CONFIG_PARAVIRT_SPINLOCKS)	+= hv_spinlock.o
> diff --git a/arch/x86/hyperv/hv_proc.c b/arch/x86/hyperv/hv_proc.c
> new file mode 100644
> index 000000000000..0fd972c9129a
> --- /dev/null
> +++ b/arch/x86/hyperv/hv_proc.c
> @@ -0,0 +1,217 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <linux/types.h>
> +#include <linux/version.h>
> +#include <linux/vmalloc.h>
> +#include <linux/mm.h>
> +#include <linux/clockchips.h>
> +#include <linux/acpi.h>
> +#include <linux/hyperv.h>
> +#include <linux/slab.h>
> +#include <linux/cpuhotplug.h>
> +#include <linux/minmax.h>
> +#include <asm/hypervisor.h>
> +#include <asm/mshyperv.h>
> +#include <asm/apic.h>
> +
> +#include <asm/trace/hyperv.h>
> +
> +#define HV_DEPOSIT_MAX_ORDER (8)
> +#define HV_DEPOSIT_MAX (1 << HV_DEPOSIT_MAX_ORDER)
> +
> +/*
> + * Deposits exact number of pages
> + * Must be called with interrupts enabled
> + * Max 256 pages
> + */
> +int hv_call_deposit_pages(int node, u64 partition_id, u32 num_pages)
> +{
> +	struct page **pages;
> +	int *counts;
> +	int num_allocations;
> +	int i, j, page_count;
> +	int order;
> +	int desired_order;
> +	u16 status;
> +	int ret;
> +	u64 base_pfn;
> +	struct hv_deposit_memory *input_page;
> +	unsigned long flags;
> +
> +	if (num_pages > HV_DEPOSIT_MAX)
> +		return -E2BIG;
> +	if (!num_pages)
> +		return 0;
> +
> +	/* One buffer for page pointers and counts */
> +	pages = page_address(alloc_page(GFP_KERNEL));
> +	if (!pages)
> +		return -ENOMEM;
> +
> +	counts = kcalloc(HV_DEPOSIT_MAX, sizeof(int), GFP_KERNEL);
> +	if (!counts) {
> +		free_page((unsigned long)pages);
> +		return -ENOMEM;
> +	}
> +
> +	/* Allocate all the pages before disabling interrupts */
> +	num_allocations = 0;
> +	i = 0;
> +	order = HV_DEPOSIT_MAX_ORDER;
> +
> +	while (num_pages) {
> +		/* Find highest order we can actually allocate */
> +		desired_order = 31 - __builtin_clz(num_pages);
> +		order = min(desired_order, order);
> +		do {
> +			pages[i] = alloc_pages_node(node, GFP_KERNEL, order);
> +			if (!pages[i]) {
> +				if (!order) {
> +					ret = -ENOMEM;
> +					goto err_free_allocations;
> +				}
> +				--order;
> +			}
> +		} while (!pages[i]);
> +
> +		split_page(pages[i], order);
> +		counts[i] = 1 << order;
> +		num_pages -= counts[i];
> +		i++;
> +		num_allocations++;
> +	}
> +
> +	local_irq_save(flags);
> +
> +	input_page = *this_cpu_ptr(hyperv_pcpu_input_arg);
> +
> +	input_page->partition_id = partition_id;
> +
> +	/* Populate gpa_page_list - these will fit on the input page */
> +	for (i = 0, page_count = 0; i < num_allocations; ++i) {
> +		base_pfn = page_to_pfn(pages[i]);
> +		for (j = 0; j < counts[i]; ++j, ++page_count)
> +			input_page->gpa_page_list[page_count] = base_pfn + j;
> +	}
> +	status = hv_do_rep_hypercall(HVCALL_DEPOSIT_MEMORY,
> +				     page_count, 0, input_page,
> +				     NULL) & HV_HYPERCALL_RESULT_MASK;
> +	local_irq_restore(flags);
> +
> +	if (status != HV_STATUS_SUCCESS) {
> +		pr_err("Failed to deposit pages: %d\n", status);
> +		ret = status;
> +		goto err_free_allocations;
> +	}
> +
> +	ret = 0;
> +	goto free_buf;
> +
> +err_free_allocations:
> +	for (i = 0; i < num_allocations; ++i) {
> +		base_pfn = page_to_pfn(pages[i]);
> +		for (j = 0; j < counts[i]; ++j)
> +			__free_page(pfn_to_page(base_pfn + j));
> +	}
> +
> +free_buf:
> +	free_page((unsigned long)pages);
> +	kfree(counts);
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(hv_call_deposit_pages);
> +
> +int hv_call_add_logical_proc(int node, u32 lp_index, u32 apic_id)
> +{
> +	struct hv_add_logical_processor_in *input;
> +	struct hv_add_logical_processor_out *output;
> +	int status;
> +	unsigned long flags;
> +	int ret = 0;
> +
> +	/*
> +	 * When adding a logical processor, the hypervisor may return
> +	 * HV_STATUS_INSUFFICIENT_MEMORY. When that happens, we deposit more
> +	 * pages and retry.
> +	 */
> +	do {
> +		local_irq_save(flags);
> +
> +		input = *this_cpu_ptr(hyperv_pcpu_input_arg);
> +		/* We don't do anything with the output right now */
> +		output = *this_cpu_ptr(hyperv_pcpu_output_arg);
> +
> +		input->lp_index = lp_index;
> +		input->apic_id = apic_id;
> +		input->flags = 0;
> +		input->proximity_domain_info.domain_id = node_to_pxm(node);
> +		input->proximity_domain_info.flags.reserved = 0;
> +		input->proximity_domain_info.flags.proximity_info_valid = 1;
> +		input->proximity_domain_info.flags.proximity_preferred = 1;
> +		status = hv_do_hypercall(HVCALL_ADD_LOGICAL_PROCESSOR,
> +					 input, output);
> +		local_irq_restore(flags);
> +
> +		if (status != HV_STATUS_INSUFFICIENT_MEMORY) {
> +			if (status != HV_STATUS_SUCCESS) {
> +				pr_err("%s: cpu %u apic ID %u, %d\n", __func__,
> +				       lp_index, apic_id, status);
> +				ret = status;
> +			}
> +			break;
> +		}
> +		ret = hv_call_deposit_pages(node, hv_current_partition_id, 1);
> +	} while (!ret);
> +
> +	return ret;
> +}
> +
> +int hv_call_create_vp(int node, u64 partition_id, u32 vp_index, u32 flags)
> +{
> +	struct hv_create_vp *input;
> +	u16 status;
> +	unsigned long irq_flags;
> +	int ret = 0;
> +
> +	/* Root VPs don't seem to need pages deposited */
> +	if (partition_id != hv_current_partition_id) {
> +		ret = hv_call_deposit_pages(node, partition_id, 90);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	do {
> +		local_irq_save(irq_flags);
> +
> +		input = *this_cpu_ptr(hyperv_pcpu_input_arg);
> +
> +		input->partition_id = partition_id;
> +		input->vp_index = vp_index;
> +		input->flags = flags;
> +		input->subnode_type = HvSubnodeAny;
> +		if (node != NUMA_NO_NODE) {
> +			input->proximity_domain_info.domain_id = node_to_pxm(node);
> +			input->proximity_domain_info.flags.reserved = 0;
> +			input->proximity_domain_info.flags.proximity_info_valid = 1;
> +			input->proximity_domain_info.flags.proximity_preferred = 1;
> +		} else {
> +			input->proximity_domain_info.as_uint64 = 0;
> +		}
> +		status = hv_do_hypercall(HVCALL_CREATE_VP, input, NULL);
> +		local_irq_restore(irq_flags);
> +
> +		if (status != HV_STATUS_INSUFFICIENT_MEMORY) {
> +			if (status != HV_STATUS_SUCCESS) {
> +				pr_err("%s: vcpu %u, lp %u, %d\n", __func__,
> +				       vp_index, flags, status);
> +				ret = status;
> +			}
> +			break;
> +		}
> +		ret = hv_call_deposit_pages(node, partition_id, 1);
> +
> +	} while (!ret);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(hv_call_create_vp);
> +
> diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
> index 67f5d35a73d3..4e590a167160 100644
> --- a/arch/x86/include/asm/mshyperv.h
> +++ b/arch/x86/include/asm/mshyperv.h
> @@ -80,6 +80,10 @@ extern void  __percpu  **hyperv_pcpu_output_arg;
>  
>  extern u64 hv_current_partition_id;
>  
> +int hv_call_deposit_pages(int node, u64 partition_id, u32 num_pages);
> +int hv_call_add_logical_proc(int node, u32 lp_index, u32 acpi_id);
> +int hv_call_create_vp(int node, u64 partition_id, u32 vp_index, u32 flags);

You seem to be only doing EXPORT_SYMBOL_GPL() for
hv_call_deposit_pages() and hv_call_create_vp() but not for
hv_call_add_logical_proc() - is this intended? Also, I don't see
hv_call_create_vp()/hv_call_add_logical_proc() usage outside of
arch/x86/kernel/cpu/mshyperv.c so maybe we don't need to export them at all?

> +
>  static inline u64 hv_do_hypercall(u64 control, void *input, void *output)
>  {
>  	u64 input_address = input ? virt_to_phys(input) : 0;
> diff --git a/include/asm-generic/hyperv-tlfs.h b/include/asm-generic/hyperv-tlfs.h
> index 87b1a79b19eb..b6c74e1a5524 100644
> --- a/include/asm-generic/hyperv-tlfs.h
> +++ b/include/asm-generic/hyperv-tlfs.h
> @@ -142,6 +142,8 @@ struct ms_hyperv_tsc_page {
>  #define HVCALL_FLUSH_VIRTUAL_ADDRESS_LIST_EX	0x0014
>  #define HVCALL_SEND_IPI_EX			0x0015
>  #define HVCALL_GET_PARTITION_ID			0x0046
> +#define HVCALL_DEPOSIT_MEMORY			0x0048
> +#define HVCALL_CREATE_VP			0x004e
>  #define HVCALL_GET_VP_REGISTERS			0x0050
>  #define HVCALL_SET_VP_REGISTERS			0x0051
>  #define HVCALL_POST_MESSAGE			0x005c
> @@ -149,6 +151,7 @@ struct ms_hyperv_tsc_page {
>  #define HVCALL_POST_DEBUG_DATA			0x0069
>  #define HVCALL_RETRIEVE_DEBUG_DATA		0x006a
>  #define HVCALL_RESET_DEBUG_SESSION		0x006b
> +#define HVCALL_ADD_LOGICAL_PROCESSOR		0x0076
>  #define HVCALL_RETARGET_INTERRUPT		0x007e
>  #define HVCALL_FLUSH_GUEST_PHYSICAL_ADDRESS_SPACE 0x00af
>  #define HVCALL_FLUSH_GUEST_PHYSICAL_ADDRESS_LIST 0x00b0
> @@ -413,6 +416,70 @@ struct hv_get_partition_id {
>  	u64 partition_id;
>  } __packed;
>  
> +/* HvDepositMemory hypercall */
> +struct hv_deposit_memory {
> +	u64 partition_id;
> +	u64 gpa_page_list[];
> +} __packed;
> +
> +struct hv_proximity_domain_flags {
> +	u32 proximity_preferred : 1;
> +	u32 reserved : 30;
> +	u32 proximity_info_valid : 1;
> +};
> +
> +/* Not a union in windows but useful for zeroing */
> +union hv_proximity_domain_info {
> +	struct {
> +		u32 domain_id;
> +		struct hv_proximity_domain_flags flags;
> +	};
> +	u64 as_uint64;
> +};
> +
> +struct hv_lp_startup_status {
> +	u64 hv_status;
> +	u64 substatus1;
> +	u64 substatus2;
> +	u64 substatus3;
> +	u64 substatus4;
> +	u64 substatus5;
> +	u64 substatus6;
> +};
> +
> +/* HvAddLogicalProcessor hypercall */
> +struct hv_add_logical_processor_in {
> +	u32 lp_index;
> +	u32 apic_id;
> +	union hv_proximity_domain_info proximity_domain_info;
> +	u64 flags;
> +};
> +
> +struct hv_add_logical_processor_out {
> +	struct hv_lp_startup_status startup_status;
> +};
> +
> +enum HV_SUBNODE_TYPE
> +{
> +    HvSubnodeAny = 0,
> +    HvSubnodeSocket,
> +    HvSubnodeAmdNode,
> +    HvSubnodeL3,
> +    HvSubnodeCount,
> +    HvSubnodeInvalid = -1
> +};
> +
> +/* HvCreateVp hypercall */
> +struct hv_create_vp {
> +	u64 partition_id;
> +	u32 vp_index;
> +	u8 padding[3];
> +	u8 subnode_type;
> +	u64 subnode_id;
> +	union hv_proximity_domain_info proximity_domain_info;
> +	u64 flags;
> +};

You add '__packed' to 'struct hv_deposit_memory' but not to 'struct
hv_create_vp'/'struct hv_add_logical_processor_in', this looks
inconsistent.

> +
>  /* HvRetargetDeviceInterrupt hypercall */
>  union hv_msi_entry {
>  	u64 as_uint64;

-- 
Vitaly

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

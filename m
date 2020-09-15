Return-Path: <SRS0=Zxjt=CY=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FB01C43461
	for <virtualization@archiver.kernel.org>; Tue, 15 Sep 2020 11:01:07 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A67C9218AC
	for <virtualization@archiver.kernel.org>; Tue, 15 Sep 2020 11:01:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R5356SMm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A67C9218AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 2F8B687133;
	Tue, 15 Sep 2020 11:01:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IGxR+iAKI4BV; Tue, 15 Sep 2020 11:01:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id ECD248712E;
	Tue, 15 Sep 2020 11:01:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CFE40C0864;
	Tue, 15 Sep 2020 11:01:03 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7D2BEC0051
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Sep 2020 11:01:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 6460A8712E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Sep 2020 11:01:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rejU5SYbu1AB
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Sep 2020 11:01:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by hemlock.osuosl.org (Postfix) with ESMTPS id E349187129
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Sep 2020 11:01:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600167660;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=guiS9knUyp96zieB7cvAHcyvDidqbqv5BAVHFJQmDkg=;
 b=R5356SMmB4dR88o8EFu8AB1xPTFsAOCpBcFknxRWJn5bo5sQz/RdruvCP0JrCGi9sh3mQb
 uxnm5Pn9rc1sksgsRuULtyP5DOYU4Cjxf1sYQTepWWSdP4CEvl1R7ASupAAz5esw1PBr6Q
 CDZOJCSJFohvBpXRn0+9QBbnUsNVUAw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-443-WIC_k2yRNgmBu51ubNEgJg-1; Tue, 15 Sep 2020 07:00:58 -0400
X-MC-Unique: WIC_k2yRNgmBu51ubNEgJg-1
Received: by mail-wm1-f70.google.com with SMTP id m25so774987wmi.0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Sep 2020 04:00:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
 :message-id:mime-version;
 bh=guiS9knUyp96zieB7cvAHcyvDidqbqv5BAVHFJQmDkg=;
 b=oUDRB/W4gZqQ4wfvX1Bf2UQP3Z2btb5zUNnQUeJ68zfUf8ZcJ5+XKBZqi/woYQzFzJ
 8pjkDcCSYriu44nyPMWkLPSzPC1AK3TDyk2+2Di04V+e+RpFqPppJdA7yjo0F/kLGsUX
 21bb7poMckCy6k5MwBj8KBWf+tPQt0N+G3fRQDM5Xrl5BthLjoHdorcOefgpk+/6FoT+
 0cLGSxeg0xjHVSk0Zi0hN1AdK9xnRormjF+nCZXCbf9lHiS2YdvdKhfZKdBHtvsasg+S
 xaK35VxFOJ83l37ugG8AP2MPKe3Xu6tggcwToRDkLOeX7Pox0VtdVkCvxBGvmP/em60e
 k/Lg==
X-Gm-Message-State: AOAM530rsvIgj2Dxc+VjuozgJVwBplCre9r3qz1Hjvg3GvOEInixhhZt
 hTZkIIlkwNiHDedmwctcJau41WpbZWTGsb6A9jhiHwKaT1Ew/u9VIvzc+gnB8YjDjbbg6sl+wrc
 bFQRNMTuX8S7MTz4LADiAHpd92h8D2ew6w8sPT4WszQ==
X-Received: by 2002:a5d:630a:: with SMTP id i10mr20201582wru.137.1600167657508; 
 Tue, 15 Sep 2020 04:00:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzCkmaofZgQSVXb+OS8Si/lFoB6TPt66RmLSK2FDOqjVL1SWHCcz8BvjMum4MfFHmsxG9nOFQ==
X-Received: by 2002:a5d:630a:: with SMTP id i10mr20201518wru.137.1600167656991; 
 Tue, 15 Sep 2020 04:00:56 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
 by smtp.gmail.com with ESMTPSA id b76sm25426505wme.45.2020.09.15.04.00.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2020 04:00:56 -0700 (PDT)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: Wei Liu <wei.liu@kernel.org>,
 Linux on Hyper-V List <linux-hyperv@vger.kernel.org>
Subject: Re: [PATCH RFC v1 09/18] x86/hyperv: provide a bunch of helper
 functions
In-Reply-To: <20200914115928.83184-1-wei.liu@kernel.org>
References: <20200914112802.80611-1-wei.liu@kernel.org>
 <20200914115928.83184-1-wei.liu@kernel.org>
Date: Tue, 15 Sep 2020 13:00:55 +0200
Message-ID: <87sgbjjod4.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=vkuznets@redhat.com
X-Mimecast-Spam-Score: 0.003
X-Mimecast-Originator: redhat.com
Cc: "open list:GENERIC INCLUDE/ASM HEADER FILES" <linux-arch@vger.kernel.org>,
 Wei Liu <wei.liu@kernel.org>, Stephen Hemminger <sthemmin@microsoft.com>,
 Arnd Bergmann <arnd@arndb.de>, Haiyang Zhang <haiyangz@microsoft.com>,
 "maintainer:X86 ARCHITECTURE \(32-BIT AND 64-BIT\)" <x86@kernel.org>,
 virtualization@lists.linux-foundation.org,
 Linux Kernel List <linux-kernel@vger.kernel.org>,
 Nuno Das Neves <nudasnev@microsoft.com>, Ingo Molnar <mingo@redhat.com>,
 Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>,
 Borislav Petkov <bp@alien8.de>, Sunil Muthuswamy <sunilmut@microsoft.com>,
 Michael Kelley <mikelley@microsoft.com>,
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
> Signed-off-by: Nuno Das Neves <nudasnev@microsoft.com>
> Co-Developed-by: Lillian Grassin-Drake <ligrassi@microsoft.com>
> Co-Developed-by: Sunil Muthuswamy <sunilmut@microsoft.com>
> Co-Developed-by: Nuno Das Neves <nudasnev@microsoft.com>
> Signed-off-by: Wei Liu <wei.liu@kernel.org>
> ---
>  arch/x86/hyperv/Makefile          |   2 +-
>  arch/x86/hyperv/hv_proc.c         | 209 ++++++++++++++++++++++++++++++
>  arch/x86/include/asm/mshyperv.h   |   4 +
>  include/asm-generic/hyperv-tlfs.h |  56 ++++++++
>  4 files changed, 270 insertions(+), 1 deletion(-)
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
> index 000000000000..847c72465d0e
> --- /dev/null
> +++ b/arch/x86/hyperv/hv_proc.c
> @@ -0,0 +1,209 @@
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
> +#include <asm/hypervisor.h>
> +#include <asm/mshyperv.h>
> +#include <asm/apic.h>
> +
> +#include <asm/trace/hyperv.h>
> +
> +#define HV_DEPOSIT_MAX_ORDER (8)
> +#define HV_DEPOSIT_MAX (1 << HV_DEPOSIT_MAX_ORDER)
> +
> +#define MAX(a, b) ((a) > (b) ? (a) : (b))
> +#define MIN(a, b) ((a) < (b) ? (a) : (b))

Nit: include/linux/kernel.h defines min() and max() macros with type
checking.

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
> +	int status;
> +	int ret;
> +	u64 base_pfn;
> +	struct hv_deposit_memory *input_page;
> +	unsigned long flags;
> +
> +	if (num_pages > HV_DEPOSIT_MAX)
> +		return -EINVAL;
> +	if (!num_pages)
> +		return 0;
> +
> +	ret = -ENOMEM;
> +
> +	/* One buffer for page pointers and counts */
> +	pages = page_address(alloc_page(GFP_KERNEL));
> +	if (!pages)
> +		goto free_buf;

There is nothing to free, just do 'return -ENOMEM' here;

> +	counts = (int *)&pages[256];
> +

Oh this is weird. So 'pages' is an array of 512 'struct page *' items
and we use its second half (pages[256]) for an array of signed(!)
integers(!). Can we use a locally defined struct or something better for
that?

> +	/* Allocate all the pages before disabling interrupts */
> +	num_allocations = 0;
> +	i = 0;
> +	order = HV_DEPOSIT_MAX_ORDER;
> +
> +	while (num_pages) {
> +		/* Find highest order we can actually allocate */
> +		desired_order = 31 - __builtin_clz(num_pages);
> +		order = MIN(desired_order, order);
> +		do {
> +			pages[i] = alloc_pages_node(node, GFP_KERNEL, order);
> +			if (!pages[i]) {
> +				if (!order) {
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

So here we believe we will never overrun the 2048 bytes we 'allocated'
for 'counts' above. While 'if (num_pages > HV_DEPOSIT_MAX)' presumably
guarantees that, this is not really obvious.

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

Nit: same like in one ov the previous patches, status can be 'u16'.

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

So if status == HV_STATUS_SUCCESS we break and avoid
hv_call_deposit_pages() below?

> +		}
> +		ret = hv_call_deposit_pages(node, hv_current_partition_id, 1);
> +
> +	} while (!ret);

And if hv_call_deposit_pages() returns '0' we keep doing something? Sorry
but I'm probably missing something important in the 'depositing'
process, could you please add a comment explaining what's going on here?

> +
> +	return ret;
> +}
> +
> +int hv_call_create_vp(int node, u64 partition_id, u32 vp_index, u32 flags)
> +{
> +	struct hv_create_vp *input;
> +	int status;
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
> index 4039302e0ae9..60afc3e417d0 100644
> --- a/arch/x86/include/asm/mshyperv.h
> +++ b/arch/x86/include/asm/mshyperv.h
> @@ -67,6 +67,10 @@ extern void  __percpu  **hyperv_pcpu_output_arg;
>  
>  extern u64 hv_current_partition_id;
>  
> +int hv_call_deposit_pages(int node, u64 partition_id, u32 num_pages);
> +int hv_call_add_logical_proc(int node, u32 lp_index, u32 acpi_id);
> +int hv_call_create_vp(int node, u64 partition_id, u32 vp_index, u32 flags);
> +
>  static inline u64 hv_do_hypercall(u64 control, void *input, void *output)
>  {
>  	u64 input_address = input ? virt_to_phys(input) : 0;
> diff --git a/include/asm-generic/hyperv-tlfs.h b/include/asm-generic/hyperv-tlfs.h
> index 87b1a79b19eb..2b05bed712c0 100644
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
> @@ -413,6 +416,59 @@ struct hv_get_partition_id {
>  	u64 partition_id;
>  } __packed;
>  
> +/* HvDepositMemory hypercall */
> +struct hv_deposit_memory {
> +	u64 partition_id;
> +	u64 gpa_page_list[];
> +};

Other structures above have '__packed' and I remember there were
different opinions if it is needed or not (for properly padded
structures). I'd suggest we stay consitent and keep adding it unless we
decide to get rid of them (but you've added it to the newly introduced
hv_get_partition_id above).
> +
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
> +/* HvAddLogicalProcessor hypercalls */

s/hypercalls/hypercall/

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
> +/* HvCreateVp hypercall */
> +struct hv_create_vp {
> +	u64 partition_id;
> +	u32 vp_index;
> +	u32 padding;
> +	union hv_proximity_domain_info proximity_domain_info;
> +	u64 flags;
> +};
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

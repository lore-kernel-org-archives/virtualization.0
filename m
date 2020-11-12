Return-Path: <SRS0=8i8N=ES=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48D0DC56202
	for <virtualization@archiver.kernel.org>; Thu, 12 Nov 2020 15:44:53 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91C8120A8B
	for <virtualization@archiver.kernel.org>; Thu, 12 Nov 2020 15:44:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DUm2WOpO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91C8120A8B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 9E34B8333E;
	Thu, 12 Nov 2020 15:44:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kON4MU4L9EOZ; Thu, 12 Nov 2020 15:44:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id E961E8716E;
	Thu, 12 Nov 2020 15:44:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C4E86C088B;
	Thu, 12 Nov 2020 15:44:50 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1116BC016F
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Nov 2020 15:44:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id D8CE32040F
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Nov 2020 15:44:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id D9y3MTAg4K9o
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Nov 2020 15:44:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by silver.osuosl.org (Postfix) with ESMTPS id EF97720354
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Nov 2020 15:44:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1605195886;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qxjTdSqsz6xIg1WvznsPF+RZUGZ5GXFMr8Y82HN6228=;
 b=DUm2WOpOp7X6RywUyfLkvDRrvI7XVHiJV+ae8Ug8sxo89OHHshI3ZT6Zk09h0/NsbJqP5A
 XF6j4HYuOFl6eM1HgN2H+kEL19cpT4Jh9l0TaT5KKvw/pk7qHZCUy4Ut5F+KzKwq/vhYbu
 OydJ2AnXyVqZJjjVUbdgSOFA4yF9oJs=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-596-MZQIYk5nPPmfkKJbiKz2CQ-1; Thu, 12 Nov 2020 10:44:43 -0500
X-MC-Unique: MZQIYk5nPPmfkKJbiKz2CQ-1
Received: by mail-wr1-f71.google.com with SMTP id w17so2087901wrp.11
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Nov 2020 07:44:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
 :message-id:mime-version;
 bh=qxjTdSqsz6xIg1WvznsPF+RZUGZ5GXFMr8Y82HN6228=;
 b=IpSvdBQHY+OMpr4EBoQWSg8llEB21r6K80lYkYI6SCn4czQjBnVJHimjmOwq0d0F+U
 YZK363p9CvT4yueTuRHy27eumN9iYR7NcGQ9H9LvHYWOsiPvICUtzNiMUDZ6O+afd0Ag
 MQk9YpG3DiynZaTzwsKJ9xei1+7LQDuk9SJTsKoNVbQNvyexEWQoqT/BOpciRTbZPaOj
 MvJQpfpYH0bbecs6IROFJ5ydDjsfh2YudghjlDoH/X1+/dVENDBxGoYtuE+ESbj3o1JF
 iu7ieDP/M/aOdr878yxWcVtwB/YIS1aO8JuTfg1BL8LAIhhsCAyclIMkCp0bOe275El9
 UZDg==
X-Gm-Message-State: AOAM530EJuaLrRdl9/xBLe58sIhhHA8EHuHnop43MPF9ckaYaTlob8mP
 1MeNx+dFomj4BYCdmtScr/zWtEHYShvJK7pB1HDVIZ8/fIxR4VZNkMs5+HAtujtd6bAM7G5AX9A
 ulSjoyMXCFZR36vXj6PBHIbuhTlOfQb2O3tlSiJdi3w==
X-Received: by 2002:a7b:c309:: with SMTP id k9mr292672wmj.14.1605195881877;
 Thu, 12 Nov 2020 07:44:41 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxcJOmNhQc4LX1KGkibEmhcyJC2zSWy0ZlOScjlyw1KRKeL72zv1sDLur1nMapHOCf6wYE/HQ==
X-Received: by 2002:a7b:c309:: with SMTP id k9mr292640wmj.14.1605195881639;
 Thu, 12 Nov 2020 07:44:41 -0800 (PST)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
 by smtp.gmail.com with ESMTPSA id 34sm7209189wrq.27.2020.11.12.07.44.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Nov 2020 07:44:41 -0800 (PST)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: Wei Liu <wei.liu@kernel.org>, Linux on Hyper-V List
 <linux-hyperv@vger.kernel.org>
Subject: Re: [PATCH v2 07/17] x86/hyperv: extract partition ID from
 Microsoft Hypervisor if necessary
In-Reply-To: <20201105165814.29233-8-wei.liu@kernel.org>
References: <20201105165814.29233-1-wei.liu@kernel.org>
 <20201105165814.29233-8-wei.liu@kernel.org>
Date: Thu, 12 Nov 2020 16:44:39 +0100
Message-ID: <877dqqy3yw.fsf@vitty.brq.redhat.com>
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

> We will need the partition ID for executing some hypercalls later.
>
> Signed-off-by: Lillian Grassin-Drake <ligrassi@microsoft.com>
> Co-Developed-by: Sunil Muthuswamy <sunilmut@microsoft.com>
> Signed-off-by: Wei Liu <wei.liu@kernel.org>
> ---
>  arch/x86/hyperv/hv_init.c         | 26 ++++++++++++++++++++++++++
>  arch/x86/include/asm/mshyperv.h   |  2 ++
>  include/asm-generic/hyperv-tlfs.h |  6 ++++++
>  3 files changed, 34 insertions(+)
>
> diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
> index 7a2e37f025b0..73b0fb851f76 100644
> --- a/arch/x86/hyperv/hv_init.c
> +++ b/arch/x86/hyperv/hv_init.c
> @@ -30,6 +30,9 @@
>  bool hv_root_partition;
>  EXPORT_SYMBOL_GPL(hv_root_partition);
>  
> +u64 hv_current_partition_id;
> +EXPORT_SYMBOL_GPL(hv_current_partition_id);
> +
>  void *hv_hypercall_pg;
>  EXPORT_SYMBOL_GPL(hv_hypercall_pg);
>  
> @@ -335,6 +338,26 @@ static struct syscore_ops hv_syscore_ops = {
>  	.resume		= hv_resume,
>  };
>  
> +void __init hv_get_partition_id(void)
> +{
> +	struct hv_get_partition_id *output_page;
> +	u16 status;
> +	unsigned long flags;
> +
> +	local_irq_save(flags);
> +	output_page = *this_cpu_ptr(hyperv_pcpu_output_arg);
> +	status = hv_do_hypercall(HVCALL_GET_PARTITION_ID, NULL, output_page) &
> +		HV_HYPERCALL_RESULT_MASK;
> +	if (status != HV_STATUS_SUCCESS)
> +		pr_err("Failed to get partition ID: %d\n", status);
> +	else
> +		hv_current_partition_id = output_page->partition_id;

Nit: I'd suggest we simplify this to:

	if (status != HV_STATUS_SUCCESS) {
		pr_err("Failed to get partition ID: %d\n", status);
		BUG();
	}
	hv_current_partition_id = output_page->partition_id;

and drop BUG_ON() below;

> +	local_irq_restore(flags);
> +
> +	/* No point in proceeding if this failed */
> +	BUG_ON(status != HV_STATUS_SUCCESS);
> +}
> +
>  /*
>   * This function is to be invoked early in the boot sequence after the
>   * hypervisor has been detected.
> @@ -430,6 +453,9 @@ void __init hyperv_init(void)
>  
>  	register_syscore_ops(&hv_syscore_ops);
>  
> +	if (hv_root_partition)
> +		hv_get_partition_id();
> +


We don't seem to check that the partition has AccessPartitionId
privilege. While I guess that root partitions always have it, I'd
suggest we write this as:

	if (cpuid_ebx(HYPERV_CPUID_FEATURES) & HV_ACCESS_PARTITION_ID)
		hv_get_partition_id();

	BUG_ON(hv_root_partition && !hv_current_partition_id);

for correctness. Also, we need to make sure '0' is not a valid partition
id and use e.g. -1 otherwise.

>  	return;
>  
>  remove_cpuhp_state:
> diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
> index 62d9390f1ddf..67f5d35a73d3 100644
> --- a/arch/x86/include/asm/mshyperv.h
> +++ b/arch/x86/include/asm/mshyperv.h
> @@ -78,6 +78,8 @@ extern void *hv_hypercall_pg;
>  extern void  __percpu  **hyperv_pcpu_input_arg;
>  extern void  __percpu  **hyperv_pcpu_output_arg;
>  
> +extern u64 hv_current_partition_id;
> +
>  static inline u64 hv_do_hypercall(u64 control, void *input, void *output)
>  {
>  	u64 input_address = input ? virt_to_phys(input) : 0;
> diff --git a/include/asm-generic/hyperv-tlfs.h b/include/asm-generic/hyperv-tlfs.h
> index e6903589a82a..87b1a79b19eb 100644
> --- a/include/asm-generic/hyperv-tlfs.h
> +++ b/include/asm-generic/hyperv-tlfs.h
> @@ -141,6 +141,7 @@ struct ms_hyperv_tsc_page {
>  #define HVCALL_FLUSH_VIRTUAL_ADDRESS_SPACE_EX	0x0013
>  #define HVCALL_FLUSH_VIRTUAL_ADDRESS_LIST_EX	0x0014
>  #define HVCALL_SEND_IPI_EX			0x0015
> +#define HVCALL_GET_PARTITION_ID			0x0046
>  #define HVCALL_GET_VP_REGISTERS			0x0050
>  #define HVCALL_SET_VP_REGISTERS			0x0051
>  #define HVCALL_POST_MESSAGE			0x005c
> @@ -407,6 +408,11 @@ struct hv_tlb_flush_ex {
>  	u64 gva_list[];
>  } __packed;
>  
> +/* HvGetPartitionId hypercall (output only) */
> +struct hv_get_partition_id {
> +	u64 partition_id;
> +} __packed;
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

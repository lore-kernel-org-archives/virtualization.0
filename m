Return-Path: <SRS0=H/CR=HL=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B401C433DB
	for <virtualization@archiver.kernel.org>; Tue,  9 Feb 2021 13:04:40 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8234B64E75
	for <virtualization@archiver.kernel.org>; Tue,  9 Feb 2021 13:04:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8234B64E75
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 2D06E863E0;
	Tue,  9 Feb 2021 13:04:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id z0I0aX3wGJbg; Tue,  9 Feb 2021 13:04:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 7D355848FA;
	Tue,  9 Feb 2021 13:04:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6ACFCC0174;
	Tue,  9 Feb 2021 13:04:38 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7736BC013A
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Feb 2021 13:04:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 66559855C6
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Feb 2021 13:04:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ihTflpanv4C6
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Feb 2021 13:04:33 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 619FA848FA
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Feb 2021 13:04:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1612875872;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YlDBN62QT+LjsTA/QUxGQGe58lH6AMBqtq7gFGvrAJU=;
 b=NMT656npJF8K+cYccJYSzLgrUH5QmACN1deE61dczkyduSPMAcZruEFND1zmfUWWNVdFBr
 N0qDmJXY+ao5eSkiRxYQVlNU6FYsPBHma3flbrpy3dj84307Hj47HLqhkjFxzntWDh8nVz
 V1JqBp1dlW0R0KM6rafh1BwTnzZ82Q4=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-236-pd-1B7gDOE69sUq46q66OA-1; Tue, 09 Feb 2021 08:04:30 -0500
X-MC-Unique: pd-1B7gDOE69sUq46q66OA-1
Received: by mail-ed1-f69.google.com with SMTP id p18so17472284edr.20
 for <virtualization@lists.linux-foundation.org>;
 Tue, 09 Feb 2021 05:04:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
 :message-id:mime-version;
 bh=YlDBN62QT+LjsTA/QUxGQGe58lH6AMBqtq7gFGvrAJU=;
 b=URH0oq1Vum7M/5CkvGrlHi6Ur9wAPE5223fXzZHxp0jLm6b8PjXks/SQ10LQ+1wlqg
 7M2J+uby0+w2rMcECRAaOsVgU7jzMrfAZeKTLN9Y9rjlZk4kxNnpaCQyNUcMPlFHp75L
 h7vcCwgohaRJn7GS+SiYzd3gAY7bWFvVPks8+yaZl3FtxRxjg5bA2vNOHcoQFf/+Fzft
 yR5JSPRpuTqlKTnzJe2GNEWBC9u6h8Pbsnunl1zXsxQajjA0hLV96w0zW08X9Ob4aH9q
 Tav2glEKQlPQN1HpxczNX2rxUf4Hl+0c3MNc8Wl/NxvXFm9PgWxNcUs7yrSD8iaU9Dmp
 YXPg==
X-Gm-Message-State: AOAM531iLhD/hXXlYjaSatoAEdtNa7pnCu3fNTkbbH8YlCcZOA6G9Ckx
 eQj/Dc98saTFzpeVOzByzqIJkVjz79Hr+jEVsla0C02zTYgNnxsgO4xzDv7/pgW6FJv25SX3yxR
 UrkEwTbn8pw06uIPU8zGzDJr3bPk48inzYdki3CWlUw==
X-Received: by 2002:a05:6402:104e:: with SMTP id
 e14mr23107268edu.316.1612875869256; 
 Tue, 09 Feb 2021 05:04:29 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyo4HIuR+0T9rUcQDNRaZ095+7jSeihXr6nVh2iiZp6SzMTP3xc+j9f2+Ss547tuohb9vi9EQ==
X-Received: by 2002:a05:6402:104e:: with SMTP id
 e14mr23107248edu.316.1612875869035; 
 Tue, 09 Feb 2021 05:04:29 -0800 (PST)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
 by smtp.gmail.com with ESMTPSA id a25sm11417578eds.48.2021.02.09.05.04.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Feb 2021 05:04:28 -0800 (PST)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>,
 linux-hyperv@vger.kernel.org
Subject: Re: [RFC PATCH 01/18] x86/hyperv: convert hyperv statuses to linux
 error codes
In-Reply-To: <1605918637-12192-2-git-send-email-nunodasneves@linux.microsoft.com>
References: <1605918637-12192-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1605918637-12192-2-git-send-email-nunodasneves@linux.microsoft.com>
Date: Tue, 09 Feb 2021 14:04:27 +0100
Message-ID: <871rdpo0is.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=vkuznets@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: wei.liu@kernel.org, linux-kernel@vger.kernel.org, mikelley@microsoft.com,
 nunodasneves@linux.microsoft.com, sunilmut@microsoft.com,
 virtualization@lists.linux-foundation.org, viremana@linux.microsoft.com,
 ligrassi@microsoft.com
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

Nuno Das Neves <nunodasneves@linux.microsoft.com> writes:

> Return linux-friendly error codes from hypercall wrapper functions.
> This will be needed in the mshv module.
>
> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
> ---
>  arch/x86/hyperv/hv_proc.c         | 30 ++++++++++++++++++++++++++---
>  arch/x86/include/asm/mshyperv.h   |  1 +
>  include/asm-generic/hyperv-tlfs.h | 32 +++++++++++++++++++++----------
>  3 files changed, 50 insertions(+), 13 deletions(-)
>
> diff --git a/arch/x86/hyperv/hv_proc.c b/arch/x86/hyperv/hv_proc.c
> index 0fd972c9129a..8f86f8e86748 100644
> --- a/arch/x86/hyperv/hv_proc.c
> +++ b/arch/x86/hyperv/hv_proc.c
> @@ -18,6 +18,30 @@
>  #define HV_DEPOSIT_MAX_ORDER (8)
>  #define HV_DEPOSIT_MAX (1 << HV_DEPOSIT_MAX_ORDER)
>  
> +int hv_status_to_errno(int hv_status)
> +{
> +	switch (hv_status) {
> +	case HV_STATUS_SUCCESS:
> +		return 0;
> +	case HV_STATUS_INVALID_PARAMETER:
> +	case HV_STATUS_UNKNOWN_PROPERTY:
> +	case HV_STATUS_PROPERTY_VALUE_OUT_OF_RANGE:
> +	case HV_STATUS_INVALID_VP_INDEX:
> +	case HV_STATUS_INVALID_REGISTER_VALUE:
> +	case HV_STATUS_INVALID_LP_INDEX:
> +		return EINVAL;
> +	case HV_STATUS_ACCESS_DENIED:
> +	case HV_STATUS_OPERATION_DENIED:
> +		return EACCES;
> +	case HV_STATUS_NOT_ACKNOWLEDGED:
> +	case HV_STATUS_INVALID_VP_STATE:
> +	case HV_STATUS_INVALID_PARTITION_STATE:
> +		return EBADFD;
> +	}
> +	return ENOTRECOVERABLE;
> +}
> +EXPORT_SYMBOL_GPL(hv_status_to_errno);
> +
>  /*
>   * Deposits exact number of pages
>   * Must be called with interrupts enabled
> @@ -99,7 +123,7 @@ int hv_call_deposit_pages(int node, u64 partition_id, u32 num_pages)
>  
>  	if (status != HV_STATUS_SUCCESS) {
>  		pr_err("Failed to deposit pages: %d\n", status);
> -		ret = status;
> +		ret = -hv_status_to_errno(status);

"-hv_status_to_errno" looks weird, could we just return
'-EINVAL'/'-EACCES'/... from hv_status_to_errno() instead?

>  		goto err_free_allocations;
>  	}
>  
> @@ -155,7 +179,7 @@ int hv_call_add_logical_proc(int node, u32 lp_index, u32 apic_id)
>  			if (status != HV_STATUS_SUCCESS) {
>  				pr_err("%s: cpu %u apic ID %u, %d\n", __func__,
>  				       lp_index, apic_id, status);
> -				ret = status;
> +				ret = -hv_status_to_errno(status);
>  			}
>  			break;
>  		}
> @@ -203,7 +227,7 @@ int hv_call_create_vp(int node, u64 partition_id, u32 vp_index, u32 flags)
>  			if (status != HV_STATUS_SUCCESS) {
>  				pr_err("%s: vcpu %u, lp %u, %d\n", __func__,
>  				       vp_index, flags, status);
> -				ret = status;
> +				ret = -hv_status_to_errno(status);
>  			}
>  			break;
>  		}
> diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
> index cbee72550a12..eb75faa4d4c5 100644
> --- a/arch/x86/include/asm/mshyperv.h
> +++ b/arch/x86/include/asm/mshyperv.h
> @@ -243,6 +243,7 @@ int hyperv_flush_guest_mapping_range(u64 as,
>  int hyperv_fill_flush_guest_mapping_list(
>  		struct hv_guest_mapping_flush_list *flush,
>  		u64 start_gfn, u64 end_gfn);
> +int hv_status_to_errno(int hv_status);
>  
>  extern bool hv_root_partition;
>  
> diff --git a/include/asm-generic/hyperv-tlfs.h b/include/asm-generic/hyperv-tlfs.h
> index dd385c6a71b5..445244192fa4 100644
> --- a/include/asm-generic/hyperv-tlfs.h
> +++ b/include/asm-generic/hyperv-tlfs.h
> @@ -181,16 +181,28 @@ enum HV_GENERIC_SET_FORMAT {
>  #define HV_HYPERCALL_REP_START_MASK	GENMASK_ULL(59, 48)
>  
>  /* hypercall status code */
> -#define HV_STATUS_SUCCESS			0
> -#define HV_STATUS_INVALID_HYPERCALL_CODE	2
> -#define HV_STATUS_INVALID_HYPERCALL_INPUT	3
> -#define HV_STATUS_INVALID_ALIGNMENT		4
> -#define HV_STATUS_INVALID_PARAMETER		5
> -#define HV_STATUS_OPERATION_DENIED		8
> -#define HV_STATUS_INSUFFICIENT_MEMORY		11
> -#define HV_STATUS_INVALID_PORT_ID		17
> -#define HV_STATUS_INVALID_CONNECTION_ID		18
> -#define HV_STATUS_INSUFFICIENT_BUFFERS		19
> +#define HV_STATUS_SUCCESS			0x0
> +#define HV_STATUS_INVALID_HYPERCALL_CODE	0x2
> +#define HV_STATUS_INVALID_HYPERCALL_INPUT	0x3
> +#define HV_STATUS_INVALID_ALIGNMENT		0x4
> +#define HV_STATUS_INVALID_PARAMETER		0x5
> +#define HV_STATUS_ACCESS_DENIED			0x6
> +#define HV_STATUS_INVALID_PARTITION_STATE	0x7
> +#define HV_STATUS_OPERATION_DENIED		0x8
> +#define HV_STATUS_UNKNOWN_PROPERTY		0x9
> +#define HV_STATUS_PROPERTY_VALUE_OUT_OF_RANGE	0xA
> +#define HV_STATUS_INSUFFICIENT_MEMORY		0xB
> +#define HV_STATUS_INVALID_PARTITION_ID		0xD
> +#define HV_STATUS_INVALID_VP_INDEX		0xE
> +#define HV_STATUS_NOT_FOUND			0x10
> +#define HV_STATUS_INVALID_PORT_ID		0x11
> +#define HV_STATUS_INVALID_CONNECTION_ID		0x12
> +#define HV_STATUS_INSUFFICIENT_BUFFERS		0x13
> +#define HV_STATUS_NOT_ACKNOWLEDGED		0x14
> +#define HV_STATUS_INVALID_VP_STATE		0x15
> +#define HV_STATUS_NO_RESOURCES			0x1D
> +#define HV_STATUS_INVALID_LP_INDEX		0x41
> +#define HV_STATUS_INVALID_REGISTER_VALUE	0x50
>  
>  /*
>   * The Hyper-V TimeRefCount register and the TSC

-- 
Vitaly

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

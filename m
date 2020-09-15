Return-Path: <SRS0=Zxjt=CY=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D960C43461
	for <virtualization@archiver.kernel.org>; Tue, 15 Sep 2020 10:32:39 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BDC8A2076C
	for <virtualization@archiver.kernel.org>; Tue, 15 Sep 2020 10:32:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hVwGfL9d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDC8A2076C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 7C25186689;
	Tue, 15 Sep 2020 10:32:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AGMgZS9XHi0J; Tue, 15 Sep 2020 10:32:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id C4B3985FED;
	Tue, 15 Sep 2020 10:32:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9FFE3C0864;
	Tue, 15 Sep 2020 10:32:37 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 39F4FC0051
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Sep 2020 10:32:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 291F78631C
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Sep 2020 10:32:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dU5wr6QYJXTz
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Sep 2020 10:32:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 5A24486308
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Sep 2020 10:32:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600165954;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QeRQZPobCs6e4P32IINeGIKOUrcjgI68IIdMqZ+JT7M=;
 b=hVwGfL9dnQpX8KIDx8g1sn7cVZOfVSQ9mYeH7vrxPIySeRhg6SvDXs/dgHMMtn3uKQHR2g
 V6P2LVibNuFQzOUGdG+dZ/z5bEfCe8YFrfZm/eCk2aP8ZmpGSXHkj+sMIMGsYE5gvO057a
 RRzE1s4kMJtQYaxCZX18lrUjTqypDok=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-34--oaLloghMZWeOqsQKlWUUw-1; Tue, 15 Sep 2020 06:32:32 -0400
X-MC-Unique: -oaLloghMZWeOqsQKlWUUw-1
Received: by mail-wm1-f70.google.com with SMTP id u5so746223wme.3
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Sep 2020 03:32:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
 :message-id:mime-version;
 bh=QeRQZPobCs6e4P32IINeGIKOUrcjgI68IIdMqZ+JT7M=;
 b=i+v5Zu3ojnfiuT89OjE1ohfqcesAGExlxoOHQMPS/gXaPGP7ck4+iISOKb1zKEiQEI
 KBkjXheg/Ih4ZlA65YCECemX1VgW2qZT62pL5kAqFSXlZyt+dtMssd5C/0WB4r5JyIey
 l2D5C9iOSfRuq8K5KEPSujonQsLvHQW1P1SJHanB2K8DW2ZoVvGS4byhdwcl9gIFWBTA
 z36NFp6Fazj/rm/Wjap9rqJvywjC7ys7BnCHjkMBA+bYu9l0Wr7w6CE8V2SORWdwGIn9
 0CfgZZbnbIAnzX0aj62BKRW7b0Gu48D8JqkW/1Xqu9PSus6Ecj9fHum26Kqi4RFL2M+5
 ZhfQ==
X-Gm-Message-State: AOAM532ZInkJcy0MVKz6nc/GcIdS3BF2kCLCz/y1Opq2davsyH9IaViZ
 ZWVFBh3gWVcLQtJyTQkdyqHLRn4BCG4+xoeLJ10jtQOKxFGwisIZm87GO3fiD+8Xno78he0D0Ds
 KwAj1dyUIgcmXOjIOzRAt0DAeNbrziXOrLYjGQOOD1A==
X-Received: by 2002:adf:c44d:: with SMTP id a13mr20330465wrg.11.1600165951349; 
 Tue, 15 Sep 2020 03:32:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyJkSTvuIy8gFdXXAANcRbGCR0uaovccUxBhrr2j1y4ZvaRu9mnQDPVvKZveLtC18WrUxMMFA==
X-Received: by 2002:adf:c44d:: with SMTP id a13mr20330439wrg.11.1600165951106; 
 Tue, 15 Sep 2020 03:32:31 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
 by smtp.gmail.com with ESMTPSA id q8sm25810346wrx.79.2020.09.15.03.32.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2020 03:32:30 -0700 (PDT)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: Wei Liu <wei.liu@kernel.org>,
 Linux on Hyper-V List <linux-hyperv@vger.kernel.org>
Subject: Re: [PATCH RFC v1 08/18] x86/hyperv: handling hypercall page setup
 for root
In-Reply-To: <20200914112802.80611-9-wei.liu@kernel.org>
References: <20200914112802.80611-1-wei.liu@kernel.org>
 <20200914112802.80611-9-wei.liu@kernel.org>
Date: Tue, 15 Sep 2020 12:32:29 +0200
Message-ID: <87v9gfjpoi.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=vkuznets@redhat.com
X-Mimecast-Spam-Score: 0.004
X-Mimecast-Originator: redhat.com
Cc: Wei Liu <wei.liu@kernel.org>, Stephen Hemminger <sthemmin@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>,
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

> When Linux is running as the root partition, the hypercall page will
> have already been setup by Hyper-V. Copy the content over to the
> allocated page.

And we can't setup a new hypercall page by writing something different
to HV_X64_MSR_HYPERCALL, right?

>
> The suspend, resume and cleanup paths remain untouched because they are
> not supported in this setup yet.
>
> Signed-off-by: Lillian Grassin-Drake <ligrassi@microsoft.com>
> Signed-off-by: Sunil Muthuswamy <sunilmut@microsoft.com>
> Signed-off-by: Nuno Das Neves <nudasnev@microsoft.com>
> Co-Developed-by: Lillian Grassin-Drake <ligrassi@microsoft.com>
> Co-Developed-by: Sunil Muthuswamy <sunilmut@microsoft.com>
> Co-Developed-by: Nuno Das Neves <nudasnev@microsoft.com>
> Signed-off-by: Wei Liu <wei.liu@kernel.org>
> ---
>  arch/x86/hyperv/hv_init.c | 26 ++++++++++++++++++++++++--
>  1 file changed, 24 insertions(+), 2 deletions(-)
>
> diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
> index 0eec1ed32023..26233aebc86c 100644
> --- a/arch/x86/hyperv/hv_init.c
> +++ b/arch/x86/hyperv/hv_init.c
> @@ -25,6 +25,7 @@
>  #include <linux/cpuhotplug.h>
>  #include <linux/syscore_ops.h>
>  #include <clocksource/hyperv_timer.h>
> +#include <linux/highmem.h>
>  
>  /* Is Linux running as the root partition? */
>  bool hv_root_partition;
> @@ -448,8 +449,29 @@ void __init hyperv_init(void)
>  
>  	rdmsrl(HV_X64_MSR_HYPERCALL, hypercall_msr.as_uint64);
>  	hypercall_msr.enable = 1;
> -	hypercall_msr.guest_physical_address = vmalloc_to_pfn(hv_hypercall_pg);
> -	wrmsrl(HV_X64_MSR_HYPERCALL, hypercall_msr.as_uint64);
> +
> +	if (hv_root_partition) {
> +		struct page *pg;
> +		void *src, *dst;
> +
> +		/*
> +		 * Order is important here. We must enable the hypercall page
> +		 * so it is populated with code, then copy the code to an
> +		 * executable page.
> +		 */
> +		wrmsrl(HV_X64_MSR_HYPERCALL, hypercall_msr.as_uint64);
> +
> +		pg = vmalloc_to_page(hv_hypercall_pg);
> +		dst = kmap(pg);
> +		src = memremap(hypercall_msr.guest_physical_address << PAGE_SHIFT, PAGE_SIZE,
> +				MEMREMAP_WB);

memremap() can fail...

> +		memcpy(dst, src, PAGE_SIZE);
> +		memunmap(src);
> +		kunmap(pg);
> +	} else {
> +		hypercall_msr.guest_physical_address = vmalloc_to_pfn(hv_hypercall_pg);
> +		wrmsrl(HV_X64_MSR_HYPERCALL, hypercall_msr.as_uint64);
> +	}

Why can't we do wrmsrl() for both cases here?

>  
>  	/*
>  	 * Ignore any errors in setting up stimer clockevents

-- 
Vitaly

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

Return-Path: <SRS0=Zxjt=CY=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A063FC43461
	for <virtualization@archiver.kernel.org>; Tue, 15 Sep 2020 11:02:22 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1880121D1B
	for <virtualization@archiver.kernel.org>; Tue, 15 Sep 2020 11:02:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RdZFWZW2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1880121D1B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 62333214E6;
	Tue, 15 Sep 2020 11:02:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vUNZ3gqTQVlw; Tue, 15 Sep 2020 11:02:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 5BD3C204A2;
	Tue, 15 Sep 2020 11:02:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 31221C0864;
	Tue, 15 Sep 2020 11:02:18 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 58434C0051
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Sep 2020 11:02:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 17ACB20516
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Sep 2020 11:02:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HLO8yCQ+G5Jp
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Sep 2020 11:02:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-1.mimecast.com
 [205.139.110.61])
 by silver.osuosl.org (Postfix) with ESMTPS id 3BFCF204A2
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Sep 2020 11:02:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600167734;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tiWWA5WPIJE1R4aNQnzFviD2WfhvbCKqrfBZuXGN+7s=;
 b=RdZFWZW2W9opFlxLHwNApNyIezHAUVhi8PbiGPpy62b/O661H9MYzBS9NQxG05K0BBOsce
 piCLMycKrM1IIcQkv1eNu54zllleAdEs8M+1NOa6drJdy7NddPUcI/9ZqfKb8Timt3HIXD
 HV9tGQBO4vanr+QIAFOGn0ztNtZCGmM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-190-aMW27TBvP2eqo0V31294lg-1; Tue, 15 Sep 2020 07:02:12 -0400
X-MC-Unique: aMW27TBvP2eqo0V31294lg-1
Received: by mail-wm1-f72.google.com with SMTP id l15so761424wmh.9
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Sep 2020 04:02:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
 :message-id:mime-version;
 bh=tiWWA5WPIJE1R4aNQnzFviD2WfhvbCKqrfBZuXGN+7s=;
 b=DcIq5G28m2PWFA9iL5wpFAw0rH8In3PmiQTdLasafwNPjXiI55nrTmNJwiyVHgMnUg
 8luYJOLA7A6EENOafTeZqraHBaZd+Df4oBrURLGATEXTe5uAAKI6Fo2qni5RSRnpAeBb
 NeLn/ARip5mWh2GB/t/8nwDBKKxpKQkwVquYF4WM0Vr5lJVLj8EdwLu8vrotdWH81I8b
 jCjY2HDYmordbBuqFIlNybMuIKHYqurE4ccxxWcb+zxfpQWm8jgEEbXSSrr1PqmRRe79
 tGEKMfqOKFZ72qgkb6s3L+3WfC2GN/umEc3gg0AgpYqnORAPtPuoPpSafeE7nFNA/Yde
 NlgQ==
X-Gm-Message-State: AOAM530GmvpPd3uZOQeGUBmHKgGJgCf9C7fkON7ZsaQXT7H1hokeClig
 WNhmyWShkQBt7lcWMY0d0lAOH5h49NRdwZNrffC/lRLMInup3yqA+5aNxeMcP5HlArgHeh/dm8G
 c+rZeDqxtA1/O8243nagNt2drJuY32HyUMy949QwHRg==
X-Received: by 2002:adf:f24d:: with SMTP id b13mr20494608wrp.316.1600167731103; 
 Tue, 15 Sep 2020 04:02:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxlb3plOi5NIG6+FaUC+KmbrIuYLV1hdg3p4P3m7Jsr5kxBr0w1XwcAmImBMjoeZWSiZxGoww==
X-Received: by 2002:adf:f24d:: with SMTP id b13mr20494569wrp.316.1600167730881; 
 Tue, 15 Sep 2020 04:02:10 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
 by smtp.gmail.com with ESMTPSA id m23sm8009179wmi.19.2020.09.15.04.02.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2020 04:02:10 -0700 (PDT)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: Wei Liu <wei.liu@kernel.org>
Subject: Re: [PATCH RFC v1 08/18] x86/hyperv: handling hypercall page setup
 for root
In-Reply-To: <20200915103710.cqmdvzh5lys4wsqo@liuwe-devbox-debian-v2>
References: <20200914112802.80611-1-wei.liu@kernel.org>
 <20200914112802.80611-9-wei.liu@kernel.org>
 <87v9gfjpoi.fsf@vitty.brq.redhat.com>
 <20200915103710.cqmdvzh5lys4wsqo@liuwe-devbox-debian-v2>
Date: Tue, 15 Sep 2020 13:02:08 +0200
Message-ID: <87pn6njob3.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=vkuznets@redhat.com
X-Mimecast-Spam-Score: 0.004
X-Mimecast-Originator: redhat.com
Cc: Wei Liu <wei.liu@kernel.org>, Stephen Hemminger <sthemmin@microsoft.com>,
 Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
 Nuno Das Neves <nudasnev@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>,
 "maintainer:X86 ARCHITECTURE \(32-BIT AND 64-BIT\)" <x86@kernel.org>,
 Linux Kernel List <linux-kernel@vger.kernel.org>,
 Michael Kelley <mikelley@microsoft.com>, Ingo Molnar <mingo@redhat.com>,
 Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>,
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

> On Tue, Sep 15, 2020 at 12:32:29PM +0200, Vitaly Kuznetsov wrote:
>> Wei Liu <wei.liu@kernel.org> writes:
>> 
>> > When Linux is running as the root partition, the hypercall page will
>> > have already been setup by Hyper-V. Copy the content over to the
>> > allocated page.
>> 
>> And we can't setup a new hypercall page by writing something different
>> to HV_X64_MSR_HYPERCALL, right?
>> 
>
> My understanding is that we can't, but Sunil can maybe correct me.
>
>> >
>> > The suspend, resume and cleanup paths remain untouched because they are
>> > not supported in this setup yet.
>> >
>> > Signed-off-by: Lillian Grassin-Drake <ligrassi@microsoft.com>
>> > Signed-off-by: Sunil Muthuswamy <sunilmut@microsoft.com>
>> > Signed-off-by: Nuno Das Neves <nudasnev@microsoft.com>
>> > Co-Developed-by: Lillian Grassin-Drake <ligrassi@microsoft.com>
>> > Co-Developed-by: Sunil Muthuswamy <sunilmut@microsoft.com>
>> > Co-Developed-by: Nuno Das Neves <nudasnev@microsoft.com>
>> > Signed-off-by: Wei Liu <wei.liu@kernel.org>
>> > ---
>> >  arch/x86/hyperv/hv_init.c | 26 ++++++++++++++++++++++++--
>> >  1 file changed, 24 insertions(+), 2 deletions(-)
>> >
>> > diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
>> > index 0eec1ed32023..26233aebc86c 100644
>> > --- a/arch/x86/hyperv/hv_init.c
>> > +++ b/arch/x86/hyperv/hv_init.c
>> > @@ -25,6 +25,7 @@
>> >  #include <linux/cpuhotplug.h>
>> >  #include <linux/syscore_ops.h>
>> >  #include <clocksource/hyperv_timer.h>
>> > +#include <linux/highmem.h>
>> >  
>> >  /* Is Linux running as the root partition? */
>> >  bool hv_root_partition;
>> > @@ -448,8 +449,29 @@ void __init hyperv_init(void)
>> >  
>> >  	rdmsrl(HV_X64_MSR_HYPERCALL, hypercall_msr.as_uint64);
>> >  	hypercall_msr.enable = 1;
>> > -	hypercall_msr.guest_physical_address = vmalloc_to_pfn(hv_hypercall_pg);
>> > -	wrmsrl(HV_X64_MSR_HYPERCALL, hypercall_msr.as_uint64);
>> > +
>> > +	if (hv_root_partition) {
>> > +		struct page *pg;
>> > +		void *src, *dst;
>> > +
>> > +		/*
>> > +		 * Order is important here. We must enable the hypercall page
>> > +		 * so it is populated with code, then copy the code to an
>> > +		 * executable page.
>> > +		 */
>> > +		wrmsrl(HV_X64_MSR_HYPERCALL, hypercall_msr.as_uint64);
>> > +
>> > +		pg = vmalloc_to_page(hv_hypercall_pg);
>> > +		dst = kmap(pg);
>> > +		src = memremap(hypercall_msr.guest_physical_address << PAGE_SHIFT, PAGE_SIZE,
>> > +				MEMREMAP_WB);
>> 
>> memremap() can fail...
>
> And we don't care here, if it fails, we would rather it panic or oops.
>
> I was relying on the fact that copying from / to a NULL pointer will
> cause the kernel to crash. But of course it wouldn't hurt to explicitly
> panic here.
>
>> 
>> > +		memcpy(dst, src, PAGE_SIZE);
>> > +		memunmap(src);
>> > +		kunmap(pg);
>> > +	} else {
>> > +		hypercall_msr.guest_physical_address = vmalloc_to_pfn(hv_hypercall_pg);
>> > +		wrmsrl(HV_X64_MSR_HYPERCALL, hypercall_msr.as_uint64);
>> > +	}
>> 
>> Why can't we do wrmsrl() for both cases here?
>> 
>
> Because the hypercall page has already been set up when Linux is the
> root.

But you already do wrmsrl(HV_X64_MSR_HYPERCALL, hypercall_msr.as_uint64)
in 'if (hv_root_partition)' case above, that's why I asked.

>
> I could've tried writing to the MSR again, but because the behaviour
> here is not documented and subject to change so I didn't bother trying.
>
> Wei.
>
>> >  
>> >  	/*
>> >  	 * Ignore any errors in setting up stimer clockevents
>> 
>> -- 
>> Vitaly
>> 
>

-- 
Vitaly

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

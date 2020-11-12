Return-Path: <SRS0=8i8N=ES=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64643C5519F
	for <virtualization@archiver.kernel.org>; Thu, 12 Nov 2020 15:51:22 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B64C5206B5
	for <virtualization@archiver.kernel.org>; Thu, 12 Nov 2020 15:51:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fmHmROIo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B64C5206B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 130548719A;
	Thu, 12 Nov 2020 15:51:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Py9Xh7PdKN37; Thu, 12 Nov 2020 15:51:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id E65B98718F;
	Thu, 12 Nov 2020 15:51:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CA882C088B;
	Thu, 12 Nov 2020 15:51:19 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0B310C016F
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Nov 2020 15:51:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id ED77187132
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Nov 2020 15:51:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id sBy3Fwp7IRe6
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Nov 2020 15:51:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 48C1586ECD
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Nov 2020 15:51:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1605196277;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QL/CTH82iZSekxz8n80Vq7IhnT/Ojwm8sJF1/GEIh+M=;
 b=fmHmROIoFTv+T3f8goUgUj6SfHl/PITNgHfTCUGtyxgCmmU25+h46R0YXW/2FP+Eo/L53n
 rX30RH5hbJ/fA1A0XnbRuuLw7DF9gh0pgrXppetpn//IOsOaTWZzSmsQ1h3Ia1wI4jtmkM
 pgcx/NUC813E8CdFrsqG1jt9Vn9UZIA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-468-L5pszFRyO5-LtLrIk_Nsjg-1; Thu, 12 Nov 2020 10:51:13 -0500
X-MC-Unique: L5pszFRyO5-LtLrIk_Nsjg-1
Received: by mail-wr1-f69.google.com with SMTP id u1so2115709wri.6
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Nov 2020 07:51:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
 :message-id:mime-version;
 bh=QL/CTH82iZSekxz8n80Vq7IhnT/Ojwm8sJF1/GEIh+M=;
 b=OUFSCfxdjXYVPtnowxBvhkuCc6SWzCC5kGMSSjHcQBhbT6ePYZcvCRiNXvI02LYYaX
 o4jSrcjpN/M4F/jMXaJByBnvWwdAFlFrGgqEL1iUUank/IH1RSwZZ+s+uTsPkG3XPtfi
 sxDy39rG3wOSOmSvQ75Q5doRY9aVRfXXuZOQR71pKJlV8dkX3zBPxoGtHNzTOLKI33EQ
 RbF266HbpcbZZhqfIQ28UMkP8L/Wg+iSH+vJWaD0Z/imJBFQ1zixQx2iISk+4auEzTDy
 Lya0IYrS+CO8EVY8puQFpgM0cadBiNRi2Eo5yEKi+Z+FaKabBqeZftaNzVVBgGTwtaFz
 4MtA==
X-Gm-Message-State: AOAM533styJYkl3zhp3VrBgFLGXiOPxQuC8ZiEsCQdK+6/xMLP3F1c2k
 ksgN3qBoZ/k/7IEX8n3GUmzs5OC+bCzPFZ/mTFtMaYnVjxCXlYo3JeUSzxoLSbox2Vqszxg6tup
 Rrh1m1RwKFPcuRNJ40HaVW+6xgprljLA+uGHBIO3NDg==
X-Received: by 2002:adf:92e7:: with SMTP id 94mr150213wrn.271.1605196272245;
 Thu, 12 Nov 2020 07:51:12 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwIkgCQ/CEFnm6mgolj9Md8yhKfvt/BSxAV3t4aQvN6BbPAwQHEcFa7uwCHjrI24Bq+wVN5dg==
X-Received: by 2002:adf:92e7:: with SMTP id 94mr150145wrn.271.1605196271920;
 Thu, 12 Nov 2020 07:51:11 -0800 (PST)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
 by smtp.gmail.com with ESMTPSA id a15sm7482066wrn.75.2020.11.12.07.51.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Nov 2020 07:51:11 -0800 (PST)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: Wei Liu <wei.liu@kernel.org>, Linux on Hyper-V List
 <linux-hyperv@vger.kernel.org>
Subject: Re: [PATCH v2 08/17] x86/hyperv: handling hypercall page setup for
 root
In-Reply-To: <20201105165814.29233-9-wei.liu@kernel.org>
References: <20201105165814.29233-1-wei.liu@kernel.org>
 <20201105165814.29233-9-wei.liu@kernel.org>
Date: Thu, 12 Nov 2020 16:51:09 +0100
Message-ID: <874kluy3o2.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=vkuznets@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Wei Liu <wei.liu@kernel.org>, Stephen Hemminger <sthemmin@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>,
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

> When Linux is running as the root partition, the hypercall page will
> have already been setup by Hyper-V. Copy the content over to the
> allocated page.
>
> The suspend, resume and cleanup paths remain untouched because they are
> not supported in this setup yet.

What about adding BUG_ONs there then?

>
> Signed-off-by: Lillian Grassin-Drake <ligrassi@microsoft.com>
> Signed-off-by: Sunil Muthuswamy <sunilmut@microsoft.com>
> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
> Co-Developed-by: Lillian Grassin-Drake <ligrassi@microsoft.com>
> Co-Developed-by: Sunil Muthuswamy <sunilmut@microsoft.com>
> Co-Developed-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
> Signed-off-by: Wei Liu <wei.liu@kernel.org>
> ---
>  arch/x86/hyperv/hv_init.c | 32 ++++++++++++++++++++++++++++++--
>  1 file changed, 30 insertions(+), 2 deletions(-)
>
> diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
> index 73b0fb851f76..9fcaf741be99 100644
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
> @@ -438,8 +439,35 @@ void __init hyperv_init(void)
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
> +		 * For the root partition, the hypervisor will set up its
> +		 * hypercall page. The hypervisor guarantees it will not show
> +		 * up in the root's address space. The root can't change the
> +		 * location of the hypercall page.
> +		 *
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
> +		BUG_ON(!(src && dst));
> +		memcpy(dst, src, PAGE_SIZE);

Super-nit: while on x86 PAGE_SIZE always matches HV_HYP_PAGE_SIZE, would
it be more accurate to use the later here?

> +		memunmap(src);
> +		kunmap(pg);
> +	} else {
> +		hypercall_msr.guest_physical_address = vmalloc_to_pfn(hv_hypercall_pg);
> +		wrmsrl(HV_X64_MSR_HYPERCALL, hypercall_msr.as_uint64);
> +	}
>  
>  	/*
>  	 * Ignore any errors in setting up stimer clockevents

-- 
Vitaly

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

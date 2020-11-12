Return-Path: <SRS0=8i8N=ES=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA2A4C5519F
	for <virtualization@archiver.kernel.org>; Thu, 12 Nov 2020 15:24:50 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D5E922240
	for <virtualization@archiver.kernel.org>; Thu, 12 Nov 2020 15:24:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ia7wjUDX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D5E922240
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 8E15320461;
	Thu, 12 Nov 2020 15:24:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lqadhsR-BIdn; Thu, 12 Nov 2020 15:24:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 925C51FEED;
	Thu, 12 Nov 2020 15:24:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 56C23C088B;
	Thu, 12 Nov 2020 15:24:48 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5D01CC016F
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Nov 2020 15:24:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 588F98716B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Nov 2020 15:24:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6y86gHqlTBhA
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Nov 2020 15:24:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 913EA86F51
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Nov 2020 15:24:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1605194685;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=C4WuEqCsb5/AFeS4zkEh2onYBE7lmXmnSMoxFYjN3ig=;
 b=ia7wjUDX/5KCDwHwzFWx0QmplfgWRuiHmCiX3QW26+2Q++jAFhWIhy5JqkkP1bdRFPcnX8
 2wqamMNBLZAV4LarpjaD5UVkFw+KiwdrL7pM89g1I4gd6G+fiW2WKxozsae7QHm/Id7DwG
 Ki1JxE1kMc2wbRjOCkMbLQ4fZ5cg8Qs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-210-XbbVsk95PUGp9KWCCgStMw-1; Thu, 12 Nov 2020 10:24:41 -0500
X-MC-Unique: XbbVsk95PUGp9KWCCgStMw-1
Received: by mail-wm1-f70.google.com with SMTP id o19so2294884wme.2
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Nov 2020 07:24:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
 :message-id:mime-version;
 bh=C4WuEqCsb5/AFeS4zkEh2onYBE7lmXmnSMoxFYjN3ig=;
 b=LAbod7TsV1qH888sUdfCZHHdsB/fjac/C9Lle8WaU6fWAvaqT3T/yDdxP0K0+WHZEp
 MSZ2NF0jc/6qGYa3B1k5nCDMhSdSLDAGcjG7dF+L9UE/V3SzeMtxOL7idTVEzUMQkFeC
 HKes2vokJjhyMLO+ccBZT5dOMvaPAF0xN3cX36fX+jwkjzAwCB4/qKT+ofZPiOQtgTAS
 ZgStK0fpQFaeTjYKd68zng12K0np/Z0+31Sd2JN8JpWqfDQIlX/QMxxACUMUlpjYSNNe
 JrHIxu4x3QIo+q503sxUQvkjP8gOGuT0mpfJeSFQXPNCZfKCdqTXbSWjXIfHBkc/cuAz
 IVug==
X-Gm-Message-State: AOAM531ddJrf+howKCWxpcbRYLDNQzE1M+FOrshDxESApL5oCgubJUng
 kTEfYG+IG5SgMpNlZq8cE2YK/+R9vCHagoZgEmqlgubNgMjxQWoyzne/PvuGCtsYBRM6j7L/kN7
 d2lXoPW+58UcD4kiBqJh/w8Ll+Qvzs4eb+q85J1c50g==
X-Received: by 2002:a1c:c302:: with SMTP id t2mr117238wmf.189.1605194680196;
 Thu, 12 Nov 2020 07:24:40 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxX21sudMRdY26dySOmO/to1hNdt6R88HOOtUfizeNAVKSfSVnCXeomIzbUIzj2x9YbFyGcVQ==
X-Received: by 2002:a1c:c302:: with SMTP id t2mr117208wmf.189.1605194680020;
 Thu, 12 Nov 2020 07:24:40 -0800 (PST)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
 by smtp.gmail.com with ESMTPSA id h62sm7096528wrh.82.2020.11.12.07.24.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Nov 2020 07:24:39 -0800 (PST)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: Wei Liu <wei.liu@kernel.org>, Linux on Hyper-V List
 <linux-hyperv@vger.kernel.org>
Subject: Re: [PATCH v2 03/17] Drivers: hv: vmbus: skip VMBus initialization
 if Linux is root
In-Reply-To: <20201105165814.29233-4-wei.liu@kernel.org>
References: <20201105165814.29233-1-wei.liu@kernel.org>
 <20201105165814.29233-4-wei.liu@kernel.org>
Date: Thu, 12 Nov 2020 16:24:38 +0100
Message-ID: <87imaay4w9.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=vkuznets@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Wei Liu <wei.liu@kernel.org>, Stephen Hemminger <sthemmin@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>,
 Linux Kernel List <linux-kernel@vger.kernel.org>,
 Michael Kelley <mikelley@microsoft.com>,
 Nuno Das Neves <nunodasneves@linux.microsoft.com>,
 Sunil Muthuswamy <sunilmut@microsoft.com>,
 virtualization@lists.linux-foundation.org,
 Vineeth Pillai <viremana@linux.microsoft.com>
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

> There is no VMBus and the other infrastructures initialized in
> hv_acpi_init when Linux is running as the root partition.
>
> Signed-off-by: Wei Liu <wei.liu@kernel.org>
> ---
>  drivers/hv/vmbus_drv.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> index 4fad3e6745e5..37c4d3a28309 100644
> --- a/drivers/hv/vmbus_drv.c
> +++ b/drivers/hv/vmbus_drv.c
> @@ -2612,6 +2612,9 @@ static int __init hv_acpi_init(void)
>  	if (!hv_is_hyperv_initialized())
>  		return -ENODEV;
>  
> +	if (hv_root_partition)
> +		return -ENODEV;
> +

Nit: any particular reason why we need to return an error from here? I'd
suggest we 'return 0;' if it doesn't break anything (we're still running
on Hyper-V, it's just a coincedence that there's nothing to do here,
eventually we may get some devices/handlers I guess. Also, there's going
to be server-side Vmbus eventually, we may as well initialize it here.

>  	init_completion(&probe_event);
>  
>  	/*

-- 
Vitaly

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

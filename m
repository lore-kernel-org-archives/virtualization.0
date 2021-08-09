Return-Path: <SRS0=ROIW=NA=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E188C4338F
	for <virtualization@archiver.kernel.org>; Mon,  9 Aug 2021 09:04:48 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B17B360E52
	for <virtualization@archiver.kernel.org>; Mon,  9 Aug 2021 09:04:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B17B360E52
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6B95E60887;
	Mon,  9 Aug 2021 09:04:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7QgfcjPQGCuH; Mon,  9 Aug 2021 09:04:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 08F4A606CF;
	Mon,  9 Aug 2021 09:04:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C635CC0010;
	Mon,  9 Aug 2021 09:04:45 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 42CADC000E
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 Aug 2021 09:04:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3F01982521
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 Aug 2021 09:04:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wzanm-tWRNQM
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 Aug 2021 09:04:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7C5D68249E
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 Aug 2021 09:04:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1628499882;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ki0M/ROeQnFyAUomdoEV2Uzb2XMJVx3V8RfPhtihxzg=;
 b=iNvGjx9i8Tj2sNjhNKWeU+h1pg6UXzDEL3Gg+fW+aZC7I4JaJot6K7JLwxFt/x9C6KWtKn
 i/vV/m8SR5iRwJMjgmSXXMjYyyNYCGXn1r+Dnth7u5HI2qxAjjIS3rx5t1xuZkt5nRiFTV
 ZdYoTdpunxPwtuDW3E/FAYM+pBxMzc0=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-96-UpmQsZM2OHeqnozv_-bB8A-1; Mon, 09 Aug 2021 05:04:40 -0400
X-MC-Unique: UpmQsZM2OHeqnozv_-bB8A-1
Received: by mail-ed1-f70.google.com with SMTP id
 b16-20020a0564022790b02903be6352006cso1367501ede.15
 for <virtualization@lists.linux-foundation.org>;
 Mon, 09 Aug 2021 02:04:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Ki0M/ROeQnFyAUomdoEV2Uzb2XMJVx3V8RfPhtihxzg=;
 b=OG8A9NWzYw+EDk656rT0bVj5kJArbOo37aJbOka5+e369Sa3e91HCmSMifCcygh5wh
 XiccUhjMNGRyt6YpK2EcG4TRUfb1BjQzixPEUOhCe6UeCQTPluz7CsdUjNvCCADHOnPF
 YQu0nnYM6jVcJaGrIm+5rPxVxcMK8YYca10cMvUohF9lv1wbkSttLOwwRVOw9QnM5PWq
 IawQnr8QoI9oP1bTKRD9SPCIglCr07hQNnJ1rnt5SaP69/puJyQwU7/wNrsFYqBs8cxr
 j+ECUPF/3DOcbo2zooaqb7/VU9jk4MzCxw3fwVZVzC1psxvdItzEFq85pwaubpEXiliO
 qNiQ==
X-Gm-Message-State: AOAM531RKmf/0AbnL9mXrBt8PCii+299rttFuo8/ppUzzsKRRZSzLIRA
 nIKOj57K2jz4xvhWVhZ43Byz/5ymIIgGev3+ZaeB9j4xyJKXnUUlcN4+EU6SBI90/NNAN2nRTiD
 mlp2Y6yw/y7hSpODIqBm7cIS9B82GcpXkRYg85b2mGA==
X-Received: by 2002:a50:fc96:: with SMTP id f22mr6420993edq.367.1628499879136; 
 Mon, 09 Aug 2021 02:04:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzkSN6hz5wCoR1ihaTfQVYU0G5SXcnlIsl04C8vUod+pZfjkrA0xPcoI4EIK+tSlo04UabGMA==
X-Received: by 2002:a50:fc96:: with SMTP id f22mr6420895edq.367.1628499877660; 
 Mon, 09 Aug 2021 02:04:37 -0700 (PDT)
Received: from steredhat (a-nu5-14.tin.it. [212.216.181.13])
 by smtp.gmail.com with ESMTPSA id og35sm5774625ejc.28.2021.08.09.02.04.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Aug 2021 02:04:37 -0700 (PDT)
Date: Mon, 9 Aug 2021 11:04:35 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Xie Yongji <xieyongji@bytedance.com>
Subject: Re: [PATCH] vdpa_sim: Fix incorrect size passed to alloc_iova()
Message-ID: <20210809090435.e5dpn4fw75rjwtw5@steredhat>
References: <20210809060257.99-1-xieyongji@bytedance.com>
MIME-Version: 1.0
In-Reply-To: <20210809060257.99-1-xieyongji@bytedance.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: virtualization@lists.linux-foundation.org, mst@redhat.com
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Mon, Aug 09, 2021 at 02:02:57PM +0800, Xie Yongji wrote:
>The size passed to alloc_iova() should be the size of
>page frames to allocate rather than size in bytes.
>
>Fixes: 4080fc106750 ("vdpa_sim: use iova module to allocate IOVA addresses")
>Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
>---
> drivers/vdpa/vdpa_sim/vdpa_sim.c | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)
>
>diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
>index 14e024de5cbf..1ccf615221fe 100644
>--- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
>+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
>@@ -137,7 +137,8 @@ static dma_addr_t vdpasim_map_range(struct vdpasim *vdpasim, phys_addr_t paddr,
> 	int ret;
>
> 	/* We set the limit_pfn to the maximum (ULONG_MAX - 1) */
>-	iova = alloc_iova(&vdpasim->iova, size, ULONG_MAX - 1, true);
>+	iova = alloc_iova(&vdpasim->iova, size >> iova_shift(&vdpasim->iova),
>+			  ULONG_MAX - 1, true);
> 	if (!iova)
> 		return DMA_MAPPING_ERROR;
>
>-- 
>2.11.0
>

We invoked init_iova_domain() with granularity = 1, so it should be 
correct to use the size in bytes.

However, in order to avoid future bugs if we change granularity, I agree 
that it's better to use iova_shift():

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

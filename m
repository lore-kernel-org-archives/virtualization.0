Return-Path: <SRS0=Do4E=OD=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42308C433F5
	for <virtualization@archiver.kernel.org>; Mon, 13 Sep 2021 07:48:26 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC3CA6109D
	for <virtualization@archiver.kernel.org>; Mon, 13 Sep 2021 07:48:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org DC3CA6109D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 997B780F18;
	Mon, 13 Sep 2021 07:48:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jU7un-zVSMow; Mon, 13 Sep 2021 07:48:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 528DF80F13;
	Mon, 13 Sep 2021 07:48:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 36BFDC000F;
	Mon, 13 Sep 2021 07:48:24 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B55E5C000D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Sep 2021 07:48:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A450E4039E
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Sep 2021 07:48:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wodDMazaAeKc
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Sep 2021 07:48:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C97CF40398
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Sep 2021 07:48:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1631519300;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nrizPStM5aPH6a9Nmw29A6+HoANkslKgHKSEkcGjEPo=;
 b=H6I/ZgH6BumQGhIAWbShXjMaKYmcmjncF8jBcZpHkINXfxd3gJIKr92eqRYOgryHhdCQki
 apu5wm+cGNroRGQMOu72L0gCDIGsDJkw3Azf0+x5dQ2aN57I7pjRMsrpRGhZQozgabrZY2
 5NjXXIjyGg8ni/EN+vL+pU6x1gh3gvg=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-76-oideReY5MT2Nrb7G0pAw0A-1; Mon, 13 Sep 2021 03:48:18 -0400
X-MC-Unique: oideReY5MT2Nrb7G0pAw0A-1
Received: by mail-ed1-f69.google.com with SMTP id
 c7-20020a05640227c700b003d27f41f1d4so195469ede.16
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Sep 2021 00:48:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=nrizPStM5aPH6a9Nmw29A6+HoANkslKgHKSEkcGjEPo=;
 b=ogXFj/H3vFsb86A4So6AueE0xBPjY4s2PVWHstSJuS4o840GbLWkrmwLCgFo0Ezh4Z
 hP2K4U/UhfNbH+w6uv71Eyhd9jEOspHYK+OyvIj1xTe4Q6rIRo3tIB8kn/lr2/7CcZk3
 WdXGCSbSHT6LzGGCkryfL/opqW6HDgETIrFVADGwiXKrKpu7b155Pt0FUyJAN3pgrSjn
 T1fFo8ae6RGkDfI+kWZcG5sUPM2YFee3rotWSaiUNaMlig424msugHoDWJvc/6UblTfg
 sE/EhsKRBzLnBoocxm7zzyqTaJtHsdjKEOfa25SjQ62hNcv2YLU9S2HbHKua9Ct057UG
 99WA==
X-Gm-Message-State: AOAM532BL6GlHgtuKwG+IhMa4B8ayJbGapXctk1Lvu7z34tJ1UwYOoEC
 tO44zRJBfhS0JFmn9+F4uFQskveA//yJWhA3/PP+eq3Ge6AFQ71RwhfN0SAzQ1nGqwTz0ANE6VE
 Z7j6oAEZEFiX8ZDSq/gpjesdmdWSDitbwviycjiK8ag==
X-Received: by 2002:a05:6402:16d9:: with SMTP id
 r25mr11613597edx.80.1631519297317; 
 Mon, 13 Sep 2021 00:48:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzCKZ460Np11G93N0Bxj4RX0YX4bkeIKy3pFhRlRU3HvI91URWCRXpEXfwEj1UrFxr8qNG1Dw==
X-Received: by 2002:a05:6402:16d9:: with SMTP id
 r25mr11613586edx.80.1631519297176; 
 Mon, 13 Sep 2021 00:48:17 -0700 (PDT)
Received: from steredhat (host-79-51-2-59.retail.telecomitalia.it.
 [79.51.2.59])
 by smtp.gmail.com with ESMTPSA id qx18sm3022048ejb.75.2021.09.13.00.48.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Sep 2021 00:48:16 -0700 (PDT)
Date: Mon, 13 Sep 2021 09:48:14 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH 1/9] virtio-blk: validate num_queues during probe
Message-ID: <20210913074814.wcrrisaomlhvtmo5@steredhat>
References: <20210913055353.35219-1-jasowang@redhat.com>
 <20210913055353.35219-2-jasowang@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20210913055353.35219-2-jasowang@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: david.kaplan@amd.com, konrad.wilk@oracle.com, f.hetzelt@tu-berlin.de,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 mst@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
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

On Mon, Sep 13, 2021 at 01:53:45PM +0800, Jason Wang wrote:
>If an untrusted device neogitates BLK_F_MQ but advertises a zero
>num_queues, the driver may end up trying to allocating zero size
>buffers where ZERO_SIZE_PTR is returned which may pass the checking
>against the NULL. This will lead unexpected results.
>
>Fixing this by using single queue if num_queues is zero.
>
>Cc: Paolo Bonzini <pbonzini@redhat.com>
>Cc: Stefan Hajnoczi <stefanha@redhat.com>
>Signed-off-by: Jason Wang <jasowang@redhat.com>
>---
> drivers/block/virtio_blk.c | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)
>
>diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
>index e574fbf5e6df..f130d12df4b9 100644
>--- a/drivers/block/virtio_blk.c
>+++ b/drivers/block/virtio_blk.c
>@@ -498,7 +498,8 @@ static int init_vq(struct virtio_blk *vblk)
> 	err = virtio_cread_feature(vdev, VIRTIO_BLK_F_MQ,
> 				   struct virtio_blk_config, num_queues,
> 				   &num_vqs);
>-	if (err)
>+	/* We need at least on virtqueue */

s/on/one/

The rest LGTM.

Stefano

>+	if (err || !num_vqs)
> 		num_vqs = 1;
>
> 	num_vqs = min_t(unsigned int, nr_cpu_ids, num_vqs);
>-- 
>2.25.1
>
>_______________________________________________
>Virtualization mailing list
>Virtualization@lists.linux-foundation.org
>https://lists.linuxfoundation.org/mailman/listinfo/virtualization
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

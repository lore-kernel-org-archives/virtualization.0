Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37574C433F5
	for <virtualization@archiver.kernel.org>; Mon, 10 Jan 2022 10:00:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C20D260669;
	Mon, 10 Jan 2022 09:59:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xo7cJGanMvJi; Mon, 10 Jan 2022 09:59:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 61B0860C24;
	Mon, 10 Jan 2022 09:59:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 175CDC002F;
	Mon, 10 Jan 2022 09:59:58 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BCDE3C001E
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Jan 2022 09:59:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 96C5060C24
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Jan 2022 09:59:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XuCF5kfqQjV4
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Jan 2022 09:59:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E231060669
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Jan 2022 09:59:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1641808795;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MYwoKFiruwfQG01GvSwMaNXAteGRZLcln5hD63vMlH4=;
 b=ZnY/0tkH5kHIqi3Qti2jHFroYUmJpwl4gKxkDSYPuUxTBYY/oJKJ7Gl1PhCjLdo6iJRGkD
 ANV1sbBnQXK7xsa9Z70FpEJwgSc2LWcko1ERIScIZLFf1Vbr2rLW6XlxsTFiGWkv9W9b6N
 R75QCYWO2dnFA1KDPDEm0nMzxoNVmqs=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-529-bYBmi3vWMC-R7hXCmHFVuw-1; Mon, 10 Jan 2022 04:59:54 -0500
X-MC-Unique: bYBmi3vWMC-R7hXCmHFVuw-1
Received: by mail-ed1-f72.google.com with SMTP id
 h6-20020a056402280600b003f9967993aeso9689824ede.10
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Jan 2022 01:59:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=MYwoKFiruwfQG01GvSwMaNXAteGRZLcln5hD63vMlH4=;
 b=UCQOk5qiYbELVNpP4Ucg02saRlmk4+Hn+euWETJBCWOE7Ucbih7KLC4TQREyMG4vFH
 Tn8wvKGMzJRy38b3llMlPeDqLbZ2PXOyvcyWjeXMOKiSAWZDv2dHaMSGpTs45uXoLQFF
 3t9qIHgcZKncNLKFBgGiOzeBcrO7hVYvR9TWGDTL0TJk/VLdC/52BEmi8x41Yqv3fwpF
 N7TByjc3gqVIXMN5XGCEWmvN7k+yEMV+xz9fjqlLcJ8VKMrz8Axo5kM7Re7wbMWBb2ID
 eP+Impaaa+rWl20P9rS6/GuGZ4JSyJHmk/wqIWiYvzsmjdBvxQmag+JKG8cqCoRgd4zH
 j/Sw==
X-Gm-Message-State: AOAM532vtTQurFp2kQEmntc7AeNtHTcUH17rL8ZrM5tU5XpH4YF3NkaS
 rZeWoX9GzUSOeEGF9bkIdn1g85uViaLMSn5/RqsQWzD/0BsXRvr7aVEYMi+nxzIRBrqh0JqArNS
 9rB1+zxZPU9Ff2XgtcRvCkfYQba+e1gFCkVNEbdC32A==
X-Received: by 2002:a17:906:9f20:: with SMTP id
 fy32mr16563652ejc.439.1641808793386; 
 Mon, 10 Jan 2022 01:59:53 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxwUwPO4/En9jM54gH7GhUZ9MyAFegsu/u9YiAUM2YPekzml5irLTiBjOJ/LkzuqSNMo9VMGA==
X-Received: by 2002:a17:906:9f20:: with SMTP id
 fy32mr16563643ejc.439.1641808793205; 
 Mon, 10 Jan 2022 01:59:53 -0800 (PST)
Received: from redhat.com ([2a03:c5c0:107d:b60c:c297:16fe:7528:e989])
 by smtp.gmail.com with ESMTPSA id kx21sm2232583ejc.155.2022.01.10.01.59.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Jan 2022 01:59:52 -0800 (PST)
Date: Mon, 10 Jan 2022 04:59:49 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH 0/6] virtio: support advance DMA
Message-ID: <20220110045818-mutt-send-email-mst@kernel.org>
References: <20220107063306.23240-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <20220107063306.23240-1-xuanzhuo@linux.alibaba.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: virtualization@lists.linux-foundation.org
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

On Fri, Jan 07, 2022 at 02:33:00PM +0800, Xuan Zhuo wrote:
> virtqueue_add() only supports virtual addresses, dma is completed in
> virtqueue_add().
> 
> In some scenarios (such as the AF_XDP scenario), DMA is completed in advance, so
> it is necessary for us to support passing the DMA address to virtqueue_add().
> 
> This patch set stipulates that if sg->dma_address is not NULL, use this
> address as the DMA address. And record this information in extra->flags,
> which can be skipped when executing dma unmap.
> 
>     extra->flags |= VRING_DESC_F_PREDMA;
> 
> But the indirect desc does not have a corresponding extra, so the second and
> third patches of this patch set are to allocate the corresponding extra while
> allocating the indirect desc. Each desc must have a corresponding extra because
> it is possible in an sgs some are advance DMA, while others are virtual
> addresses. So we must allocate an extra for each indirect desc.


I didn't realize AF_XDP didn't have space to stuff the header into.
Jason, is that expected? It would be best to fix that, performance is
best if header is linear with the data ...
Or maybe we can reduce the use of indirect somewhat, at least while
the ring is mostly empty?

> Xuan Zhuo (6):
>   virtio: rename vring_unmap_state_packed() to
>     vring_unmap_extra_packed()
>   virtio: split: alloc indirect desc with extra
>   virtio: packed: alloc indirect desc with extra
>   virtio: split: virtqueue_add_split() support dma address
>   virtio: packed: virtqueue_add_packed() support dma address
>   virtio: add api virtio_dma_map() for advance dma
> 
>  drivers/virtio/virtio_ring.c | 387 ++++++++++++++++++++---------------
>  include/linux/virtio.h       |   9 +
>  2 files changed, 232 insertions(+), 164 deletions(-)
> 
> --
> 2.31.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

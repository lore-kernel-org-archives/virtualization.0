Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B2D0C6FD18
	for <virtualization@archiver.kernel.org>; Tue, 25 Apr 2023 07:52:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id C04D2404EB;
	Tue, 25 Apr 2023 07:52:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C04D2404EB
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=aZPlKaTI
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id l0OBwbiGXAEb; Tue, 25 Apr 2023 07:52:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 1B3B84019E;
	Tue, 25 Apr 2023 07:52:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1B3B84019E
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E7735C0037;
	Tue, 25 Apr 2023 07:52:01 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4FBA0C002A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Apr 2023 07:52:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 21B8640983
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Apr 2023 07:52:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 21B8640983
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=aZPlKaTI
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7jW6OFNKPUax
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Apr 2023 07:51:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4425640982
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4425640982
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Apr 2023 07:51:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1682409115;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LN+Qupnqrx3nxABl/NIAu7chVBT65o1KteV7K9jKs8k=;
 b=aZPlKaTIGasBRjqnlmwimKZqJsf/0GB/3zCFvSvM9qKCP13Ca8wSWiCym8GdVmrTwkJA4V
 COeYeUWi7ZkNsHekM++fMNifJy4v8v7xf+OjTt0iQUgr9StA9/5AZcf6o6pupeX8MfVmEv
 6MPsofQNMcU4Jf5/GN669MmUvZgCxs4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-271-WHTKTWW3Np22Fe4IvX5X0Q-1; Tue, 25 Apr 2023 03:51:54 -0400
X-MC-Unique: WHTKTWW3Np22Fe4IvX5X0Q-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-3f168827701so20567115e9.0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Apr 2023 00:51:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1682409112; x=1685001112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LN+Qupnqrx3nxABl/NIAu7chVBT65o1KteV7K9jKs8k=;
 b=Q+7VszO/xXAGVBgaPqRCWY64WscAGv/bNSGypySEVABzzEW+5RfExUwX4HvVqlch8f
 eRhLJMrZu6ssbESd49bLtB23QF6cazBUshrRFRQYJkIScawIPGS1YuP2zAK8Ph5V/42P
 grcp9waKXNcNiGCcCZP0wFi1XGt71eVo6UrGZJro/Kd/6EdmHpSsOM6RV2Gqo43pCZDU
 /E7H2FvtDgniIiNivJP2hHglcEb3IAf/Q2SbZhKFdfyfYUfGjnWrTzr4/jMZzKyNB6PN
 57UKbfpSjDUPYc73ksfuFcjKW1LYkqSkLyqJ2UrqRc7l5e/hQH0dLnpO2a+65jvZKDM4
 BgRQ==
X-Gm-Message-State: AAQBX9dDNUKnNCQrxuVsOqJB7otDimv98uR7NXJGnfPFf9wYT8IuADSs
 kgG3NMGoR2UpTXcLMtFBSpdsWLTaHKqYmTScU4t5IuHci2ifFoTGq2G3iXACmbqzdkAI46cHLNc
 rmunXcG35MDQHiWA5zj4lyv5oTXfjj+SGNkTxHi0hGQqQ8fjAUw==
X-Received: by 2002:a05:600c:3649:b0:3f1:e5f2:5e86 with SMTP id
 y9-20020a05600c364900b003f1e5f25e86mr4762897wmq.23.1682409112471; 
 Tue, 25 Apr 2023 00:51:52 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZvYSm0BmOXto3eV5uDy4ezuJbU7lrOsrd6Ji2Rlo2HbihXXA127mPR01nyk9gbKectoF7/Aw==
X-Received: by 2002:a05:600c:3649:b0:3f1:e5f2:5e86 with SMTP id
 y9-20020a05600c364900b003f1e5f25e86mr4762869wmq.23.1682409112085; 
 Tue, 25 Apr 2023 00:51:52 -0700 (PDT)
Received: from redhat.com ([2.55.61.39]) by smtp.gmail.com with ESMTPSA id
 b5-20020a056000054500b002e5ff05765esm12545401wrf.73.2023.04.25.00.51.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Apr 2023 00:51:51 -0700 (PDT)
Date: Tue, 25 Apr 2023 03:51:47 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH vhost v7 00/11] virtio core prepares for AF_XDP
Message-ID: <20230425034700-mutt-send-email-mst@kernel.org>
References: <20230425073613.8839-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <20230425073613.8839-1-xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
 John Fastabend <john.fastabend@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
 virtualization@lists.linux-foundation.org,
 Christoph Hellwig <hch@infradead.org>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Jakub Kicinski <kuba@kernel.org>, bpf@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>
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

On Tue, Apr 25, 2023 at 03:36:02PM +0800, Xuan Zhuo wrote:
> ## About DMA APIs
> 
> Now, virtio may can not work with DMA APIs when virtio features do not have
> VIRTIO_F_ACCESS_PLATFORM.
> 
> 1. I tried to let DMA APIs return phy address by virtio-device. But DMA APIs just
>    work with the "real" devices.
> 2. I tried to let xsk support callballs to get phy address from virtio-net
>    driver as the dma address. But the maintainers of xsk may want to use dma-buf
>    to replace the DMA APIs. I think that may be a larger effort. We will wait
>    too long.
> 
> So rethinking this, firstly, we can support premapped-dma only for devices with
> VIRTIO_F_ACCESS_PLATFORM. In the case of af-xdp, if the users want to use it,
> they have to update the device to support VIRTIO_F_RING_RESET, and they can also
> enable the device's VIRTIO_F_ACCESS_PLATFORM feature by the way.

I don't understand this last sentence. If you think ring
reset can change device features then the answer is no, it can't.

If you are saying device has to set VIRTIO_F_ACCESS_PLATFORM to
benefit from this work, that's fine at least as a first approach.
Note that setting VIRTIO_F_ACCESS_PLATFORM breaks old guests
(it's a secirity boundary), e.g. it is not available for
transitional devices.
So to support transitional devices, we might want to find another way to
address this down the road, but as a first step, I agree just going with
DMA is fine.


> Thanks for the help from Christoph.
> 
> =================
> 
> XDP socket(AF_XDP) is an excellent bypass kernel network framework. The zero
> copy feature of xsk (XDP socket) needs to be supported by the driver. The
> performance of zero copy is very good.
> 
> ENV: Qemu with vhost.
> 
>                    vhost cpu | Guest APP CPU |Guest Softirq CPU | PPS
> -----------------------------|---------------|------------------|------------
> xmit by sockperf:     90%    |   100%        |                  |  318967
> xmit by xsk:          100%   |   30%         |   33%            | 1192064
> recv by sockperf:     100%   |   68%         |   100%           |  692288
> recv by xsk:          100%   |   33%         |   43%            |  771670
> 
> Before achieving the function of Virtio-Net, we also have to let virtio core
> support these features:
> 
> 1. virtio core support premapped
> 2. virtio core support reset per-queue
> 3. introduce DMA APIs to virtio core
> 
> Please review.
> 
> Thanks.
> 
> v7:
>  1. virtqueue_dma_dev() return NULL when virtio is without DMA API.
> 
> v6:
>  1. change the size of the flags to u32.
> 
> v5:
>  1. fix for error handler
>  2. add flags to record internal dma mapping
> 
> v4:
>  1. rename map_inter to dma_map_internal
>  2. fix: Excess function parameter 'vq' description in 'virtqueue_dma_dev'
> 
> v3:
>  1. add map_inter to struct desc state to reocrd whether virtio core do dma map
> 
> v2:
>  1. based on sgs[0]->dma_address to judgment is premapped
>  2. based on extra.addr to judgment to do unmap for no-indirect desc
>  3. based on indir_desc to judgment to do unmap for indirect desc
>  4. rename virtqueue_get_dma_dev to virtqueue_dma_dev
> 
> v1:
>  1. expose dma device. NO introduce the api for dma and sync
>  2. split some commit for review.
> 
> Xuan Zhuo (11):
>   virtio_ring: split: separate dma codes
>   virtio_ring: packed: separate dma codes
>   virtio_ring: packed-indirect: separate dma codes
>   virtio_ring: split: support premapped
>   virtio_ring: packed: support premapped
>   virtio_ring: packed-indirect: support premapped
>   virtio_ring: update document for virtqueue_add_*
>   virtio_ring: introduce virtqueue_dma_dev()
>   virtio_ring: correct the expression of the description of
>     virtqueue_resize()
>   virtio_ring: separate the logic of reset/enable from virtqueue_resize
>   virtio_ring: introduce virtqueue_reset()
> 
>  drivers/virtio/virtio_ring.c | 352 +++++++++++++++++++++++++----------
>  include/linux/virtio.h       |   4 +
>  2 files changed, 259 insertions(+), 97 deletions(-)
> 
> --
> 2.32.0.3.g01195cf9f

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

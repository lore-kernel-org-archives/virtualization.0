Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0768C6FD19
	for <virtualization@archiver.kernel.org>; Fri, 10 Mar 2023 09:06:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A8C6860F58;
	Fri, 10 Mar 2023 09:06:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A8C6860F58
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=VLTH5n8E
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id af77AsStelg5; Fri, 10 Mar 2023 09:06:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 21A1E60F72;
	Fri, 10 Mar 2023 09:06:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 21A1E60F72
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D290AC0071;
	Fri, 10 Mar 2023 09:06:07 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4F241C0032
 for <virtualization@lists.linux-foundation.org>;
 Fri, 10 Mar 2023 09:06:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 378E960F58
 for <virtualization@lists.linux-foundation.org>;
 Fri, 10 Mar 2023 09:06:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 378E960F58
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id a5VWpFxqHgdY
 for <virtualization@lists.linux-foundation.org>;
 Fri, 10 Mar 2023 09:06:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 112E060F74
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 112E060F74
 for <virtualization@lists.linux-foundation.org>;
 Fri, 10 Mar 2023 09:06:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1678439164;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aAWkeksfa5ju7BHJegwUDKyBmOx8VNXyclCOQIjSS/s=;
 b=VLTH5n8ELzOs/0BsZszo2RYZiJtW8Sj5oP4lfm/qNXnEXCl1WHVysE067QbMSEKgNHUfmo
 7y4GWtdv0j03viStyDHHkznArWyxC2BMJoT6MrCUQ8N58I0TifGPI5D2Ai2JMvvUssJmvJ
 LE2fYx1XK+Xr6G9Ns3rALHbY87rUS4I=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-611-hC84H6c3OWapy_3ImfjDMA-1; Fri, 10 Mar 2023 04:06:02 -0500
X-MC-Unique: hC84H6c3OWapy_3ImfjDMA-1
Received: by mail-ed1-f71.google.com with SMTP id
 u10-20020a056402064a00b004c689813557so6764308edx.10
 for <virtualization@lists.linux-foundation.org>;
 Fri, 10 Mar 2023 01:06:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1678439161;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aAWkeksfa5ju7BHJegwUDKyBmOx8VNXyclCOQIjSS/s=;
 b=nCOa24Y4A08i/POCeZPvQviI494GAT2n7p+563WLwHj3BkNFBjBPp8YuDF6bU1eZrg
 vcbJnpTeDI/UFCC1zHG7seeGPwYCaZp6r+UXhbMUI5JD2n3UROqMvibCUf2Ntb7YJdTD
 TZ70E4pift69NZnvLG2sPuG1x6aArQp6yVg+mmffQbj/ehDoTMdT9FfhgAXn4IAKG/MS
 QkiO14hKX6KOw0S3huXOz27Ja7Ih1fyPAiKn0mmtuJ7ldkOUDP+bNY1VM9bH2h6LbHEA
 MKzT2J6ISrv0OvkjI9tCVsGr5QSHnlnjHSshz6yBXGAiJXpSew2wZqmMPw15snYNsccu
 QPyA==
X-Gm-Message-State: AO0yUKWBvQ+btRoj7Agw7DuETyAS0WXqwa/JWOw0bzZwRQnfZVBBZ+tg
 sDC1OfTDNcI4OI2Lc/dP8ixZ86i5bflB4w1vNlA0QK1XnIfWEm5/TtgTXNZ/HF4cnw87Vkzeb8Q
 VR5s62mn2ghyS5/PR/mSNEYWYSD3nAZ4cBL7ALcJW+QIn1CwQYA==
X-Received: by 2002:a05:6402:b10:b0:4ab:4011:ff3d with SMTP id
 bm16-20020a0564020b1000b004ab4011ff3dmr25428518edb.0.1678439161421; 
 Fri, 10 Mar 2023 01:06:01 -0800 (PST)
X-Google-Smtp-Source: AK7set/EfADvH8qVf+Avk/tmPR4Qrr6CeGydDREatsA46yYniLRTPipqJp9G8MANCIIR+bOblQW97A==
X-Received: by 2002:a05:6402:b10:b0:4ab:4011:ff3d with SMTP id
 bm16-20020a0564020b1000b004ab4011ff3dmr25428500edb.0.1678439161133; 
 Fri, 10 Mar 2023 01:06:01 -0800 (PST)
Received: from redhat.com ([2.52.9.88]) by smtp.gmail.com with ESMTPSA id
 p26-20020a170906229a00b008ca37f3eae9sm700704eja.131.2023.03.10.01.05.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Mar 2023 01:06:00 -0800 (PST)
Date: Fri, 10 Mar 2023 04:05:57 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH vhost v2 00/12] virtio core prepares for AF_XDP
Message-ID: <20230310040546-mutt-send-email-mst@kernel.org>
References: <20230308064443.50639-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <20230308064443.50639-1-xuanzhuo@linux.alibaba.com>
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

On Wed, Mar 08, 2023 at 02:44:31PM +0800, Xuan Zhuo wrote:
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


Jason can I get some acks on this?

> Thanks.
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
> Xuan Zhuo (12):
>   virtio_ring: split: separate dma codes
>   virtio_ring: packed: separate dma codes
>   virtio_ring: packed-indirect: separate dma codes
>   virtio_ring: split: support premapped
>   virtio_ring: packed: support premapped
>   virtio_ring: split-indirect: support premapped
>   virtio_ring: packed-indirect: support premapped
>   virtio_ring: update document for virtqueue_add_*
>   virtio_ring: introduce virtqueue_dma_dev()
>   virtio_ring: correct the expression of the description of
>     virtqueue_resize()
>   virtio_ring: separate the logic of reset/enable from virtqueue_resize
>   virtio_ring: introduce virtqueue_reset()
> 
>  drivers/virtio/virtio.c      |   6 +
>  drivers/virtio/virtio_ring.c | 354 +++++++++++++++++++++++++----------
>  include/linux/virtio.h       |   4 +
>  3 files changed, 260 insertions(+), 104 deletions(-)
> 
> --
> 2.32.0.3.g01195cf9f

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

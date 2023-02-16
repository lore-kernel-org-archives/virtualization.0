Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECC2AC636CC
	for <virtualization@archiver.kernel.org>; Thu, 16 Feb 2023 05:27:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8D5EF611A8;
	Thu, 16 Feb 2023 05:27:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8D5EF611A8
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=aDQxxncC
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id v9sEvH-HH2z2; Thu, 16 Feb 2023 05:27:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 1017461181;
	Thu, 16 Feb 2023 05:27:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1017461181
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DA3DFC0032;
	Thu, 16 Feb 2023 05:27:17 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E177EC002B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Feb 2023 05:27:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id ADDC141712
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Feb 2023 05:27:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org ADDC141712
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=aDQxxncC
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bt6bo_5yJN6Y
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Feb 2023 05:27:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9D0B3416F8
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9D0B3416F8
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Feb 2023 05:27:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1676525234;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nW9Ov25yuVTt+7xXhnE3k8K0Pnf2pgVi8F5dx9iqSIo=;
 b=aDQxxncCi4dmdpfcRNpQCnYYcRcV5a9ICte/N+nYz9ixef+z/zy436DZdS85ECh//99cvP
 FI3xekghvMLLKTbokYD0PXrl5tvSsTrmItOmrpc1ZOH5O1NkCubFwwTw5zU3WrgE8nhQ8v
 munovSSj2pavQb/AfE3yxld4tMf6fW8=
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com
 [209.85.160.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-611-LrUt_jcfPbi603hrokHNtg-1; Thu, 16 Feb 2023 00:27:13 -0500
X-MC-Unique: LrUt_jcfPbi603hrokHNtg-1
Received: by mail-oa1-f69.google.com with SMTP id
 586e51a60fabf-16e1a8e5dd9so623294fac.23
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Feb 2023 21:27:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nW9Ov25yuVTt+7xXhnE3k8K0Pnf2pgVi8F5dx9iqSIo=;
 b=6OSsRhW4UfHwcK8WeDqq8G2N36vtx/hy2RaJFZGZGQQwrb1TUWdfvE4TRRUE3Nbw+/
 LyWd9mA+66l21RVHog8C6/YBLkaAbqkM7w5MmvXdAjSGu0OTfxNEneHfKYhCC1ve2CnB
 /vJ3pncwyOqoSOuEAp57o3p5B4wOZ3krYgPIk0bqm4EX3DgqT03y335T5Dhh9ETj6VJt
 uQOZjwTdz2NTfJ1YRBgo+RqtOj629Vwy82KcrJpDYwmuILTWPDGVxh0SBGvZWw1ObFx0
 n7uHuF8dy9R7L4Wua1gSZYI2ZiU/FPr6o+hHWAmmucDNhTqEx3uXnIcFs6FaU20AJMmw
 oCUw==
X-Gm-Message-State: AO0yUKWn2TnbW7aEW9cbaI6i0UcGwxmWeFyCMlypt4ZGOu3vH47t+9S5
 zgdomJ4xZl5OawEPHKBGLJ/m1qhJ45TMihNZFqK2uTwxTpkzjVJ8nczZFpzJjopIcn6RKW3pVny
 O7K9F/7ueYs7MB1VaLeeZfbL40JFP6n/i0XqdKs+rsac68I1w/9dQQ0vlsg==
X-Received: by 2002:a05:6808:3186:b0:37d:5d77:e444 with SMTP id
 cd6-20020a056808318600b0037d5d77e444mr63985oib.35.1676525232536; 
 Wed, 15 Feb 2023 21:27:12 -0800 (PST)
X-Google-Smtp-Source: AK7set8/080km90ExnToH/4dgsMMmOaNs926dTNJz1fyf7KowoR1GXh/+7ZUodF2KVf71nGhGE2WP8WLB8CxxV1VAU0=
X-Received: by 2002:a05:6808:3186:b0:37d:5d77:e444 with SMTP id
 cd6-20020a056808318600b0037d5d77e444mr63983oib.35.1676525231962; Wed, 15 Feb
 2023 21:27:11 -0800 (PST)
MIME-Version: 1.0
References: <20230214072704.126660-1-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20230214072704.126660-1-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 16 Feb 2023 13:27:00 +0800
Message-ID: <CACGkMEsMfBLByXpPrHXDcsDdQmJSQAp-HEanCAn1-d8kFtFYJQ@mail.gmail.com>
Subject: Re: [PATCH vhost 00/10] virtio core prepares for AF_XDP
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 virtualization@lists.linux-foundation.org
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

On Tue, Feb 14, 2023 at 3:27 PM Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
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

What's the setup of this test?

CPU model/frequency, packet size, zerocopy enabled or not.

(I remember I can get better performance with my old laptop through
pktgen (about 2Mpps))

Thanks

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
> Xuan Zhuo (10):
>   virtio_ring: split: refactor virtqueue_add_split() for premapped
>   virtio_ring: packed: separate prepare code from
>     virtuque_add_indirect_packed()
>   virtio_ring: packed: refactor virtqueue_add_packed() for premapped
>   virtio_ring: split: introduce virtqueue_add_split_premapped()
>   virtio_ring: packed: introduce virtqueue_add_packed_premapped()
>   virtio_ring: introduce virtqueue_add_inbuf_premapped()
>   virtio_ring: add api virtio_dma_map() for advance dma
>   virtio_ring: introduce dma sync api for virtio
>   virtio_ring: correct the expression of the description of
>     virtqueue_resize()
>   virtio_ring: introduce virtqueue_reset()
>
>  drivers/virtio/virtio_ring.c | 792 ++++++++++++++++++++++++++++-------
>  include/linux/virtio.h       |  29 ++
>  2 files changed, 659 insertions(+), 162 deletions(-)
>
> --
> 2.32.0.3.g01195cf9f
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

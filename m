Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF46FC433EF
	for <virtualization@archiver.kernel.org>; Tue, 11 Jan 2022 02:55:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 432FC40441;
	Tue, 11 Jan 2022 02:55:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QYdnDje55iUD; Tue, 11 Jan 2022 02:55:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 8699E40298;
	Tue, 11 Jan 2022 02:55:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5C08BC0030;
	Tue, 11 Jan 2022 02:55:03 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E6799C001E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Jan 2022 02:55:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id DC9E1403C2
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Jan 2022 02:55:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NsXnzU8ig2Z5
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Jan 2022 02:55:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id AA48040298
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Jan 2022 02:55:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1641869699;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2S046XOuqM5FpIUAdEbWGxzH0BJ1nRopgX77vdhegw4=;
 b=gfM+WUVurNH59LGbG1jO7F/RA1rH1E5KdUBu5ELLQzyl+5jP/1XyLlPAUWLoZOYUHvHN6l
 +QsD+U8vxVEo6OwuNze/uJnq6sJMid3h+zEUrEsF28tOYfHKRQLmEHGe350HdcCs3J+Bk2
 MfqcasKJ/Osr6SEC/BMjXKA24b6C//0=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-101-PIsBiiESMqiy4eVdhJ4P9A-1; Mon, 10 Jan 2022 21:54:58 -0500
X-MC-Unique: PIsBiiESMqiy4eVdhJ4P9A-1
Received: by mail-lf1-f69.google.com with SMTP id
 m8-20020a0565120a8800b00425edb1a456so7968441lfu.16
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Jan 2022 18:54:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=2S046XOuqM5FpIUAdEbWGxzH0BJ1nRopgX77vdhegw4=;
 b=3XaTJXqgpNnL4k+aPktoiUYuGMWKKcLejYY+Gqg6sj3EUub2WF+tHvzkVcLyRmPrU6
 b+n40QPFfvrC6G1913+A6wVHqsJFM0rbMzsphdXOFAEuPBTvriwWQacTklAP7cwqxO80
 xZdnR3b30cBQi0Li6qtek69G9g+hmQxtkJzT+1hpdsV1Kd2QzHPY5j6OiagvFTS00800
 d7qmPX7mq9rj73ry9JMGN2LHnDcisj8twkPnaBcu+W76JOLcDLQj+knIM9YgLw0XKwLt
 lAWWLD93vhpI2CuKDH0C61KgGKLkfB9WjbExuCQwDgp69oWmUBkLbTwy5cYfjNT2NZeX
 dhgg==
X-Gm-Message-State: AOAM533yk6MLGPnK/v/jIwbgQs3CTVfifBbLCbE0IsBtKTnkoGHvwPjx
 GLwHcP1SNVkHbmlNhhqm2iN+lS83i9mqPf32naYuxY4AzA/S6K/MZZImiVTxuMPAC9widxFD3HS
 NqWcBixDCSup/dBSzKdLF9EBs/YfQ1ld0xiAEz3HcVHMi1pudhC34nnNaHQ==
X-Received: by 2002:a05:6512:68a:: with SMTP id
 t10mr2038953lfe.84.1641869696877; 
 Mon, 10 Jan 2022 18:54:56 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwQSCqMFaej5Xof6Pp7ktAbUE3DgF4LEBdbSBv6b2W+xXlya6519ZnM3uAIpGsjuI3Eesdaz7ZRoyVB91RuhPY=
X-Received: by 2002:a05:6512:68a:: with SMTP id
 t10mr2038943lfe.84.1641869696685; 
 Mon, 10 Jan 2022 18:54:56 -0800 (PST)
MIME-Version: 1.0
References: <20220107063306.23240-1-xuanzhuo@linux.alibaba.com>
 <20220110045818-mutt-send-email-mst@kernel.org>
In-Reply-To: <20220110045818-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 11 Jan 2022 10:54:45 +0800
Message-ID: <CACGkMEshgEO3GBezLVo1t1hQHN00e2rZbsXhDfq4-dANc-CXEA@mail.gmail.com>
Subject: Re: [PATCH 0/6] virtio: support advance DMA
To: "Michael S. Tsirkin" <mst@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: virtualization <virtualization@lists.linux-foundation.org>
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

On Mon, Jan 10, 2022 at 5:59 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Fri, Jan 07, 2022 at 02:33:00PM +0800, Xuan Zhuo wrote:
> > virtqueue_add() only supports virtual addresses, dma is completed in
> > virtqueue_add().
> >
> > In some scenarios (such as the AF_XDP scenario), DMA is completed in advance, so
> > it is necessary for us to support passing the DMA address to virtqueue_add().
> >
> > This patch set stipulates that if sg->dma_address is not NULL, use this
> > address as the DMA address. And record this information in extra->flags,
> > which can be skipped when executing dma unmap.
> >
> >     extra->flags |= VRING_DESC_F_PREDMA;
> >
> > But the indirect desc does not have a corresponding extra, so the second and
> > third patches of this patch set are to allocate the corresponding extra while
> > allocating the indirect desc. Each desc must have a corresponding extra because
> > it is possible in an sgs some are advance DMA, while others are virtual
> > addresses. So we must allocate an extra for each indirect desc.
>
>
> I didn't realize AF_XDP didn't have space to stuff the header into.
> Jason, is that expected?

I might be wrong but it looks to me AF_XDP allows to reserve
sufficient headroom via xdp_umem_reg_v1.

> It would be best to fix that, performance is
> best if header is linear with the data ...

This looks like a must otherwise we may meet trouble in zerocopy receive.

Thanks

> Or maybe we can reduce the use of indirect somewhat, at least while
> the ring is mostly empty?
>
> > Xuan Zhuo (6):
> >   virtio: rename vring_unmap_state_packed() to
> >     vring_unmap_extra_packed()
> >   virtio: split: alloc indirect desc with extra
> >   virtio: packed: alloc indirect desc with extra
> >   virtio: split: virtqueue_add_split() support dma address
> >   virtio: packed: virtqueue_add_packed() support dma address
> >   virtio: add api virtio_dma_map() for advance dma
> >
> >  drivers/virtio/virtio_ring.c | 387 ++++++++++++++++++++---------------
> >  include/linux/virtio.h       |   9 +
> >  2 files changed, 232 insertions(+), 164 deletions(-)
> >
> > --
> > 2.31.0
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

Return-Path: <SRS0=GFjK=P3=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76250C433EF
	for <virtualization@archiver.kernel.org>; Mon,  8 Nov 2021 13:49:42 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B1AD61178
	for <virtualization@archiver.kernel.org>; Mon,  8 Nov 2021 13:49:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2B1AD61178
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id EF4CC80D40;
	Mon,  8 Nov 2021 13:49:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xApNcknQya9I; Mon,  8 Nov 2021 13:49:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 56C8180D0C;
	Mon,  8 Nov 2021 13:49:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2D3E0C0012;
	Mon,  8 Nov 2021 13:49:40 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BF157C000E
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Nov 2021 13:49:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 91A55402AC
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Nov 2021 13:49:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6-jVc_3dajnt
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Nov 2021 13:49:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6F105402A2
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Nov 2021 13:49:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1636379376;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Cfv5/TeagcalCju25Ixtgh7I8siLZLFXg0AEDAFqG/c=;
 b=itGaXJGAa6zgyUUYazlyi4dy1vwv4/68+8sp3oU5GVptmb2tZ+DSjY+UXBfUvSVipULKNn
 3x4b/GtmNE1ihhCqWywnDfZMxv7GMTWEXyPx9KFjb4ILNpfmC8S45RVrKOLPIqRoxjHgkt
 SYBSxV0mYtA/Olv0FLaiX3IZTsb8IRA=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-578-H0yc4heLMN-DnTC_ue4_9g-1; Mon, 08 Nov 2021 08:49:32 -0500
X-MC-Unique: H0yc4heLMN-DnTC_ue4_9g-1
Received: by mail-ed1-f69.google.com with SMTP id
 w13-20020a05640234cd00b003e2fde5ff8aso9211456edc.14
 for <virtualization@lists.linux-foundation.org>;
 Mon, 08 Nov 2021 05:49:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Cfv5/TeagcalCju25Ixtgh7I8siLZLFXg0AEDAFqG/c=;
 b=OvYi7WEAGx51JX1ZwQXstKsjlUOdgahMTKIClStjWQZWrlsu5Hyb2dQzPkO30J6uPz
 ltFP+5Er5rgGEaMgh+HOEFumFpAXy8zyJ1Lxdvjvg66gWXWbQUotyL1gD+DQzT/wHIfv
 LwRXT0fn3HbuYpAs2lRlunPM63QVYnKZ7EIEDVnRp4/bNTRfGpqzO4IiowC6I+nIUUnK
 CLfr2Pplh9r5p/PwglrSqhbIszjJbQb5HvepjyP8Svh6osOwQdSazClcqKZhHfff9FDo
 wvsDC+1lvEGSf4hRBQHMKBDlaQHWKsR6wMAkb6SRWXKEoYfucW0GuZNoyN3juZ5JgtpO
 rsaw==
X-Gm-Message-State: AOAM530WlUtjKfF0dKR9UyS3rmwzQTxsMLXa/6EKSe0WrbgKkUyKUuPJ
 WDNhD2OJ3Z+ZzIfW6NA66F/Jyky7N8iMSx65iywBSMpOuSsj5sPdKDEgN8P0RXK1NDwG5+D29rf
 BK3SweBFRad8v5U9zvuf+LUnZyXGnv7FZUPFINETqgw==
X-Received: by 2002:a17:906:640d:: with SMTP id
 d13mr21430ejm.444.1636379371665; 
 Mon, 08 Nov 2021 05:49:31 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzifYtiqGfrMeXfkQC+E6k2QsEO7bjJ6311JjOpJjTrt5a9Y3WXeaOmHNZQre7IJs2q9baQfQ==
X-Received: by 2002:a17:906:640d:: with SMTP id
 d13mr21400ejm.444.1636379371459; 
 Mon, 08 Nov 2021 05:49:31 -0800 (PST)
Received: from redhat.com ([2.55.155.32])
 by smtp.gmail.com with ESMTPSA id e19sm836980edu.47.2021.11.08.05.49.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Nov 2021 05:49:30 -0800 (PST)
Date: Mon, 8 Nov 2021 08:49:27 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH v4 0/3] virtio support cache indirect desc
Message-ID: <20211108084732-mutt-send-email-mst@kernel.org>
References: <20211108114951.92862-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <20211108114951.92862-1-xuanzhuo@linux.alibaba.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, virtualization@lists.linux-foundation.org
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

On Mon, Nov 08, 2021 at 07:49:48PM +0800, Xuan Zhuo wrote:
> If the VIRTIO_RING_F_INDIRECT_DESC negotiation succeeds, and the number
> of sgs used for sending packets is greater than 1. We must constantly
> call __kmalloc/kfree to allocate/release desc.
> 
> In the case of extremely fast package delivery, the overhead cannot be
> ignored:
> 
>   27.46%  [kernel]  [k] virtqueue_add
>   16.66%  [kernel]  [k] detach_buf_split
>   16.51%  [kernel]  [k] virtnet_xsk_xmit
>   14.04%  [kernel]  [k] virtqueue_add_outbuf
>    5.18%  [kernel]  [k] __kmalloc
>    4.08%  [kernel]  [k] kfree
>    2.80%  [kernel]  [k] virtqueue_get_buf_ctx
>    2.22%  [kernel]  [k] xsk_tx_peek_desc
>    2.08%  [kernel]  [k] memset_erms
>    0.83%  [kernel]  [k] virtqueue_kick_prepare
>    0.76%  [kernel]  [k] virtnet_xsk_run
>    0.62%  [kernel]  [k] __free_old_xmit_ptr
>    0.60%  [kernel]  [k] vring_map_one_sg
>    0.53%  [kernel]  [k] native_apic_mem_write
>    0.46%  [kernel]  [k] sg_next
>    0.43%  [kernel]  [k] sg_init_table
>    0.41%  [kernel]  [k] kmalloc_slab
> 
> This patch adds a cache function to virtio to cache these allocated indirect
> desc instead of constantly allocating and releasing desc.

Hmm a bunch of comments got ignored. See e.g.
https://lore.kernel.org/r/20211027043851-mutt-send-email-mst%40kernel.org
if they aren't relevant add code comments or commit log text explaining the
design choice please.


> v4:
>     1. Only allow desc cache when VIRTIO_RING_F_INDIRECT_DESC negotiation is successful
>     2. The desc cache threshold can be set for each virtqueue
> 
> v3:
>   pre-allocate per buffer indirect descriptors array
> 
> v2:
>   use struct list_head to cache the desc
> 
> Xuan Zhuo (3):
>   virtio: cache indirect desc for split
>   virtio: cache indirect desc for packed
>   virtio-net: enable virtio desc cache
> 
>  drivers/net/virtio_net.c     |  12 ++-
>  drivers/virtio/virtio_ring.c | 152 +++++++++++++++++++++++++++++++----
>  include/linux/virtio.h       |  17 ++++
>  3 files changed, 163 insertions(+), 18 deletions(-)
> 
> --
> 2.31.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

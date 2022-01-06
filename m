Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA309C433EF
	for <virtualization@archiver.kernel.org>; Thu,  6 Jan 2022 12:28:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 305456FBE2;
	Thu,  6 Jan 2022 12:28:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hyJJncURbyJk; Thu,  6 Jan 2022 12:28:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id CC2B86FBDA;
	Thu,  6 Jan 2022 12:28:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A35B1C0030;
	Thu,  6 Jan 2022 12:28:40 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D20F2C001E
 for <virtualization@lists.linux-foundation.org>;
 Thu,  6 Jan 2022 12:28:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B807240A1E
 for <virtualization@lists.linux-foundation.org>;
 Thu,  6 Jan 2022 12:28:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 95rDa2t_dc3M
 for <virtualization@lists.linux-foundation.org>;
 Thu,  6 Jan 2022 12:28:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D546A40A1C
 for <virtualization@lists.linux-foundation.org>;
 Thu,  6 Jan 2022 12:28:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1641472117;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZoahO67h+dDkx8ghrnZtJZ57iC/SipETOINKMx5g1Rk=;
 b=i01l46FXWm7hjIUqM7UAZ6ks1icelS32VW+WeCzaZ8tRtFJ85HzgUQ2vuR6cM2dlkYmM3L
 DKk6BOJHlgKlNwjO2QyDtVxJUVHg5bpQCVghw1XK4hf+ats/vNVmy4ZAmrQ5V/RUsw/UmY
 WVPR0t904peT4PUKfqZUCpe0PznYy80=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-471-ddYv4jyRM8WEvG_WkFCHhg-1; Thu, 06 Jan 2022 07:28:36 -0500
X-MC-Unique: ddYv4jyRM8WEvG_WkFCHhg-1
Received: by mail-wm1-f71.google.com with SMTP id
 k40-20020a05600c1ca800b00345bf554707so1869578wms.4
 for <virtualization@lists.linux-foundation.org>;
 Thu, 06 Jan 2022 04:28:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=ZoahO67h+dDkx8ghrnZtJZ57iC/SipETOINKMx5g1Rk=;
 b=3PKJBMc94v5GJe02W7ADZgLA6j8ttcXKnpi51bQp9vF6Z67cBgDiClsMYaFcohQPFD
 K4FLFrgMz7fRTYkkTVueapAKBz9UHcma038PPc1393vmq7R2XheKqBJ0WRYCrxsGefDm
 xxcb2qjA0MZ7j6I2u0A7lKAC41jdhFT31MOLOmlqqgi7e/aQm/L3wpmVp1I2RBMaTgk3
 sq5mAeg5Qo3K03UxQ7KuStVzo67SQkn/ftBQUJVKc1+BxYCSIXXa3v0+jioCf9uAKLre
 Bu6GzxZTRgMHS06N5yeD8WzaeJq7PZf2yNsqBWwWw1YrNFDsr5IaWZSjGDuAeZaS5tBS
 8bOw==
X-Gm-Message-State: AOAM532iTO/hNcVRirKabkW3N1Sp0OE9yETnfuvO0wjj1v2iVmSFyfkj
 g2hyHWvfCM5agEUy5U/u7nHtaamODmnrJ+n9zLF7sQkKS9KfJ8V0hgWhQSdz1TS6g6LOpxS5F1h
 sFmIx4+PniYrrDyEFvIOAXfZxuCuhlObPO/Kf8QGtpw==
X-Received: by 2002:a05:600c:4998:: with SMTP id
 h24mr6839366wmp.188.1641472115476; 
 Thu, 06 Jan 2022 04:28:35 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxpM0L9YsF3jt+1ZREIQYnIBILYbA0VW3VR0LswXVJPRlFKmniMU7svrLUGNuKg8GJxP/n6/Q==
X-Received: by 2002:a05:600c:4998:: with SMTP id
 h24mr6839351wmp.188.1641472115243; 
 Thu, 06 Jan 2022 04:28:35 -0800 (PST)
Received: from redhat.com ([2a03:c5c0:207e:991b:6857:5652:b903:a63b])
 by smtp.gmail.com with ESMTPSA id y11sm1890725wrp.86.2022.01.06.04.28.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Jan 2022 04:28:34 -0800 (PST)
Date: Thu, 6 Jan 2022 07:28:31 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH v3 0/3] virtio support cache indirect desc
Message-ID: <20220106072615-mutt-send-email-mst@kernel.org>
References: <20211029062814.76594-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <20211029062814.76594-1-xuanzhuo@linux.alibaba.com>
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

On Fri, Oct 29, 2021 at 02:28:11PM +0800, Xuan Zhuo wrote:
> If the VIRTIO_RING_F_INDIRECT_DESC negotiation succeeds, and the number
> of sgs used for sending packets is greater than 1. We must constantly
> call __kmalloc/kfree to allocate/release desc.


So where is this going? I really like the performance boost. My concern
is that if guest spans NUMA nodes and when handler switches from
node to another this will keep reusing the cache from
the old node. A bunch of ways were suggested to address this, but
even just making the cache per numa node would help.


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
> 
> v3:
>   pre-allocate per buffer indirect descriptors array
> 
> v2:
>   use struct list_head to cache the desc
> 
> *** BLURB HERE ***
> 
> Xuan Zhuo (3):
>   virtio: cache indirect desc for split
>   virtio: cache indirect desc for packed
>   virtio-net: enable virtio desc cache
> 
>  drivers/net/virtio_net.c     |  11 +++
>  drivers/virtio/virtio.c      |   6 ++
>  drivers/virtio/virtio_ring.c | 131 ++++++++++++++++++++++++++++++-----
>  include/linux/virtio.h       |  14 ++++
>  4 files changed, 145 insertions(+), 17 deletions(-)
> 
> --
> 2.31.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

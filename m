Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4981FC64EC7
	for <virtualization@archiver.kernel.org>; Thu,  2 Feb 2023 11:08:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DD94241BDE;
	Thu,  2 Feb 2023 11:08:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org DD94241BDE
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XzeXbTmf
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lWNX4TnLrUSm; Thu,  2 Feb 2023 11:08:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id EE9EA41BCE;
	Thu,  2 Feb 2023 11:08:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org EE9EA41BCE
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C5845C0033;
	Thu,  2 Feb 2023 11:08:43 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9C093C002B
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Feb 2023 11:08:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6A2D140C0D
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Feb 2023 11:08:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6A2D140C0D
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=XzeXbTmf
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1p5xfZKf6vQQ
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Feb 2023 11:08:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9510E40250
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9510E40250
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Feb 2023 11:08:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1675336120;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Lz0zTz+Gz36uEjAct9g3W1/HujYGKgEb+bfXh3QBDS8=;
 b=XzeXbTmf2Y9f/ywkwObOVHO20ar3CtQHZKVBAaencVcVQCudzgg0O0KH6y+0NQGnarv/ad
 u7b4fVdHiX70SYckmrMinHKZOHRjcbcfangC5L4qxvmdJfaiq07Zbpsa/C57Rm2HMZLwqr
 ofA0+GXrWk0rZMlAzhLSiKVymtFeu6s=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-281-w0UWvdHyMeu7nxqtVv0JNQ-1; Thu, 02 Feb 2023 06:08:39 -0500
X-MC-Unique: w0UWvdHyMeu7nxqtVv0JNQ-1
Received: by mail-wm1-f72.google.com with SMTP id
 k9-20020a05600c1c8900b003dc5dec2ac6so2646942wms.4
 for <virtualization@lists.linux-foundation.org>;
 Thu, 02 Feb 2023 03:08:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Lz0zTz+Gz36uEjAct9g3W1/HujYGKgEb+bfXh3QBDS8=;
 b=OEAQqAD1Gowg93dLO4/uKxGwuzkQqY35FngqJG7qHpMMTCACPD8Bscx35Pa00DNjQM
 04KsMENKY5x+QFPUM6b0xOUOPGIyuTjhDDvC06uKZbvrIxqmH5GDImkSx8jJMaba59xF
 mwyUk/oJ+OMb0xB5Me1XkcXODLrYz3AbiVQZNGbeg5j/trAADNxQLAJ2SAGwiqjHC4RS
 pGddldFsgVzkdMVVGNkS8d9Cfj67fPdVnpRF1pz85ZOPFpNzeFjqHcu4CVz93CoybD8Q
 oABXg/y0jkwrSucIaEZyM60sYw/pQqMU564EU9DJLHnQZMxThAWggbuZKHcrsV7bhA8e
 3tgQ==
X-Gm-Message-State: AO0yUKVSjXRHDihmoOITQ3DEGpc0OajzDyAyAHWxqTi/0ECRN7CgFBFo
 M3ls7uqU270HihV3uXRLqxSC2Bc/yP68vA5keeIRHXRsKusowcIYQYEC5tqi19ouYKy3KJIkD6q
 V2xQ5VU2zEmPs+g/+LYGCOiOB7gWv5TMdalU/eOSRUg==
X-Received: by 2002:a5d:47cc:0:b0:2c3:be89:7c2a with SMTP id
 o12-20020a5d47cc000000b002c3be897c2amr1585487wrc.13.1675336118302; 
 Thu, 02 Feb 2023 03:08:38 -0800 (PST)
X-Google-Smtp-Source: AK7set8L6ehiCIHTqXDjFaeDmD8e3MDpBSAuqRb/FSnbN4gHDYlbjhPH+AJMGwS/WUDQOGOLlrDz/A==
X-Received: by 2002:a5d:47cc:0:b0:2c3:be89:7c2a with SMTP id
 o12-20020a5d47cc000000b002c3be897c2amr1585462wrc.13.1675336118054; 
 Thu, 02 Feb 2023 03:08:38 -0800 (PST)
Received: from redhat.com ([2a02:14f:1fc:826d:55d8:70a4:3d30:fc2f])
 by smtp.gmail.com with ESMTPSA id
 f12-20020adfdb4c000000b002bfb1de74absm19571527wrj.114.2023.02.02.03.08.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Feb 2023 03:08:37 -0800 (PST)
Date: Thu, 2 Feb 2023 06:08:30 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH 00/33] virtio-net: support AF_XDP zero copy
Message-ID: <20230202060757-mutt-send-email-mst@kernel.org>
References: <20230202110058.130695-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <20230202110058.130695-1-xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Petr Machata <petrm@nvidia.com>, Menglong Dong <imagedong@tencent.com>,
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
 John Fastabend <john.fastabend@gmail.com>,
 =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Kuniyuki Iwashima <kuniyu@amazon.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Jonathan Lemon <jonathan.lemon@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
 bpf@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
 virtualization@lists.linux-foundation.org,
 "David S. Miller" <davem@davemloft.net>,
 Magnus Karlsson <magnus.karlsson@intel.com>
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

On Thu, Feb 02, 2023 at 07:00:25PM +0800, Xuan Zhuo wrote:
> XDP socket(AF_XDP) is an excellent bypass kernel network framework. The zero
> copy feature of xsk (XDP socket) needs to be supported by the driver. The
> performance of zero copy is very good.

Great! Any numbers to share?

> mlx5 and intel ixgbe already support
> this feature, This patch set allows virtio-net to support xsk's zerocopy xmit
> feature.
> 
> Virtio-net did not support per-queue reset, so it was impossible to support XDP
> Socket Zerocopy. At present, we have completed the work of Virtio Spec and
> Kernel in Per-Queue Reset. It is time for Virtio-Net to complete the support for
> the XDP Socket Zerocopy.
> 
> Virtio-net can not increase the queue at will, so xsk shares the queue with
> kernel.
> 
> On the other hand, Virtio-Net does not support generate interrupt manually, so
> when we wakeup tx xmit, we used some tips. If the CPU run by TX NAPI last time
> is other CPUs, use IPI to wake up NAPI on the remote CPU. If it is also the
> local CPU, then we wake up sofrirqd.
> 
> Please review.
> 
> Thanks.
> 
> 
> Xuan Zhuo (33):
>   virtio_ring: virtqueue_add() support premapped
>   virtio_ring: split: virtqueue_add_split() support premapped
>   virtio_ring: packed: virtqueue_add_packed() support premapped
>   virtio_ring: introduce virtqueue_add_outbuf_premapped()
>   virtio_ring: introduce virtqueue_add_inbuf_premapped()
>   virtio_ring: introduce virtqueue_reset()
>   virtio_ring: add api virtio_dma_map() for advance dma
>   virtio_ring: introduce dma sync api for virtio
>   xsk: xsk_buff_pool add callback for dma_sync
>   xsk: support virtio DMA map
>   virtio_net: rename free_old_xmit_skbs to free_old_xmit
>   virtio_net: unify the code for recycling the xmit ptr
>   virtio_net: virtnet_poll_tx support rescheduled
>   virtio_net: independent directory
>   virtio_net: move to virtio_net.h
>   virtio_net: introduce virtnet_xdp_handler() to seprate the logic of
>     run xdp
>   virtio_net: receive_small() use virtnet_xdp_handler()
>   virtio_net: receive_merageable() use virtnet_xdp_handler()
>   virtio_net: introduce virtnet_tx_reset()
>   virtio_net: xsk: introduce virtnet_rq_bind_xsk_pool()
>   virtio_net: xsk: introduce virtnet_xsk_pool_enable()
>   virtio_net: xsk: introduce xsk disable
>   virtio_net: xsk: support xsk setup
>   virtio_net: xsk: stop disable tx napi
>   virtio_net: xsk: __free_old_xmit distinguishes xsk buffer
>   virtio_net: virtnet_sq_free_unused_buf() check xsk buffer
>   virtio_net: virtnet_rq_free_unused_buf() check xsk buffer
>   net: introduce napi_tx_raise()
>   virtio_net: xsk: tx: support tx
>   virtio_net: xsk: tx: support wakeup
>   virtio_net: xsk: tx: auto wakeup when free old xmit
>   virtio_net: xsk: rx: introduce add_recvbuf_xsk()
>   virtio_net: xsk: rx: introduce receive_xsk() to recv xsk buffer
> 
>  MAINTAINERS                                 |   2 +-
>  drivers/net/Kconfig                         |   8 +-
>  drivers/net/Makefile                        |   2 +-
>  drivers/net/virtio/Kconfig                  |  11 +
>  drivers/net/virtio/Makefile                 |   8 +
>  drivers/net/{virtio_net.c => virtio/main.c} | 564 +++++++-------------
>  drivers/net/virtio/virtio_net.h             | 317 +++++++++++
>  drivers/net/virtio/xsk.c                    | 524 ++++++++++++++++++
>  drivers/net/virtio/xsk.h                    |  33 ++
>  drivers/virtio/virtio_ring.c                | 376 +++++++++++--
>  include/linux/netdevice.h                   |   7 +
>  include/linux/virtio.h                      |  29 +
>  include/net/xsk_buff_pool.h                 |   6 +
>  net/core/dev.c                              |  11 +
>  net/xdp/xsk_buff_pool.c                     |  79 ++-
>  15 files changed, 1541 insertions(+), 436 deletions(-)
>  create mode 100644 drivers/net/virtio/Kconfig
>  create mode 100644 drivers/net/virtio/Makefile
>  rename drivers/net/{virtio_net.c => virtio/main.c} (92%)
>  create mode 100644 drivers/net/virtio/virtio_net.h
>  create mode 100644 drivers/net/virtio/xsk.c
>  create mode 100644 drivers/net/virtio/xsk.h
> 
> -- 
> 2.32.0.3.g01195cf9f

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

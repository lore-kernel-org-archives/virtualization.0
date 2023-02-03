Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3E93C636CC
	for <virtualization@archiver.kernel.org>; Fri,  3 Feb 2023 09:08:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3754B429E4;
	Fri,  3 Feb 2023 09:08:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3754B429E4
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=AgBtC94q
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4hFRU5gKNjEf; Fri,  3 Feb 2023 09:08:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 0C40841B36;
	Fri,  3 Feb 2023 09:08:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0C40841B36
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DE301C0032;
	Fri,  3 Feb 2023 09:08:41 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D3C88C002B
 for <virtualization@lists.linux-foundation.org>;
 Fri,  3 Feb 2023 09:08:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B9FCB405B5
 for <virtualization@lists.linux-foundation.org>;
 Fri,  3 Feb 2023 09:08:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B9FCB405B5
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=AgBtC94q
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MeDKX_DSTDdH
 for <virtualization@lists.linux-foundation.org>;
 Fri,  3 Feb 2023 09:08:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C9E7340105
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C9E7340105
 for <virtualization@lists.linux-foundation.org>;
 Fri,  3 Feb 2023 09:08:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1675415318;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sUtd5Ka/hp1Bq87QrTDKK+BVxo/tljWjUJR5C9jZS9o=;
 b=AgBtC94qyUVmWncD4ApCeTu04kdUiS208ofn/39ZI2QGT5c52XKhHZBVUiMSNEGcI051l7
 lItyTXfxPAh7opxwqa+idY91KuUipe6An15+igrsQ3UgMyUA/9qqqKhFWWvvQjh+tl8lUQ
 pbMsJz4G3qbAgtjrEIb3n38bXyX9E5E=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-396-lZXmaWnYPgWtTFShi0KFcQ-1; Fri, 03 Feb 2023 04:08:37 -0500
X-MC-Unique: lZXmaWnYPgWtTFShi0KFcQ-1
Received: by mail-ed1-f70.google.com with SMTP id
 n17-20020a056402061100b004a3f32cc366so3190009edv.20
 for <virtualization@lists.linux-foundation.org>;
 Fri, 03 Feb 2023 01:08:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sUtd5Ka/hp1Bq87QrTDKK+BVxo/tljWjUJR5C9jZS9o=;
 b=r9ardxeAMxWMJTEWSjn5L6NQ+OOpzBI5SJHAAh5ObN/LXvdSHCM2uXAcge9Uh3ywh0
 17UfG0GEd772FbDviZFciHQH8u2yUa4HTHFp8RwBpHMweOCcvrrHd2a2HjImokGJmYS2
 63UhYCt3JNk1ZxPBq1EB5IB42p+fNoRFOUUdBWopOz5Xwi9M2d6g+5Jp+0/3JRS2qw/M
 hnsYff5t2WAoM4sIqZmKNTHhFQsNpkh5v+HJWj6U8xE/UKvwp66WLmdKUOv4vYYWTtug
 Ta8ermf3D8J6M7tcg7exF8LJCI6S0JsCkZGdyt1kYZEBK9CE5Llu7QXmULnprVTXBzsy
 jWeA==
X-Gm-Message-State: AO0yUKWqneR+XgNiKX5Kg2SE7KMS/G5S3x//vPHt2/nI74Wrsrmkwp2z
 bGYrORksxNtwEEN/9UQeQMwwmU+Qr22gLJG0AgE15Go4tjJVn0SHyEmLYQ+xePpB23VAkwGmDYA
 93y6uhRxQWoQwX3frSdXarHF/04zz6t2OonbMxp7J3A==
X-Received: by 2002:a17:907:9917:b0:88d:6de1:96bf with SMTP id
 ka23-20020a170907991700b0088d6de196bfmr10097241ejc.12.1675415316327; 
 Fri, 03 Feb 2023 01:08:36 -0800 (PST)
X-Google-Smtp-Source: AK7set/rLVod5gDwzE+Z06Asw3o+8+gM8I6XaOfEuxYW7oEkMOteoDLr5ZFSr2jTAp3DEer8lZOIIQ==
X-Received: by 2002:a17:907:9917:b0:88d:6de1:96bf with SMTP id
 ka23-20020a170907991700b0088d6de196bfmr10097214ejc.12.1675415316150; 
 Fri, 03 Feb 2023 01:08:36 -0800 (PST)
Received: from redhat.com ([2.52.156.122]) by smtp.gmail.com with ESMTPSA id
 rh25-20020a17090720f900b00887830e535csm1068995ejb.159.2023.02.03.01.08.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Feb 2023 01:08:35 -0800 (PST)
Date: Fri, 3 Feb 2023 04:08:31 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH 00/33] virtio-net: support AF_XDP zero copy
Message-ID: <20230203040739-mutt-send-email-mst@kernel.org>
References: <20230202110058.130695-1-xuanzhuo@linux.alibaba.com>
 <20230202060757-mutt-send-email-mst@kernel.org>
 <1675338247.0108669-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <1675338247.0108669-1-xuanzhuo@linux.alibaba.com>
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

On Thu, Feb 02, 2023 at 07:44:07PM +0800, Xuan Zhuo wrote:
> On Thu, 2 Feb 2023 06:08:30 -0500, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > On Thu, Feb 02, 2023 at 07:00:25PM +0800, Xuan Zhuo wrote:
> > > XDP socket(AF_XDP) is an excellent bypass kernel network framework. The zero
> > > copy feature of xsk (XDP socket) needs to be supported by the driver. The
> > > performance of zero copy is very good.
> >
> > Great! Any numbers to share?
> 
> RESEND. Last mail has some email format error.
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
> Thanks.

Impressive, thanks a lot for this work!
Pls remember to retest and include up to date numbers on
subsequent versions.

> 
> >
> > > mlx5 and intel ixgbe already support
> > > this feature, This patch set allows virtio-net to support xsk's zerocopy xmit
> > > feature.
> > >
> > > Virtio-net did not support per-queue reset, so it was impossible to support XDP
> > > Socket Zerocopy. At present, we have completed the work of Virtio Spec and
> > > Kernel in Per-Queue Reset. It is time for Virtio-Net to complete the support for
> > > the XDP Socket Zerocopy.
> > >
> > > Virtio-net can not increase the queue at will, so xsk shares the queue with
> > > kernel.
> > >
> > > On the other hand, Virtio-Net does not support generate interrupt manually, so
> > > when we wakeup tx xmit, we used some tips. If the CPU run by TX NAPI last time
> > > is other CPUs, use IPI to wake up NAPI on the remote CPU. If it is also the
> > > local CPU, then we wake up sofrirqd.
> > >
> > > Please review.
> > >
> > > Thanks.
> > >
> > >
> > > Xuan Zhuo (33):
> > >   virtio_ring: virtqueue_add() support premapped
> > >   virtio_ring: split: virtqueue_add_split() support premapped
> > >   virtio_ring: packed: virtqueue_add_packed() support premapped
> > >   virtio_ring: introduce virtqueue_add_outbuf_premapped()
> > >   virtio_ring: introduce virtqueue_add_inbuf_premapped()
> > >   virtio_ring: introduce virtqueue_reset()
> > >   virtio_ring: add api virtio_dma_map() for advance dma
> > >   virtio_ring: introduce dma sync api for virtio
> > >   xsk: xsk_buff_pool add callback for dma_sync
> > >   xsk: support virtio DMA map
> > >   virtio_net: rename free_old_xmit_skbs to free_old_xmit
> > >   virtio_net: unify the code for recycling the xmit ptr
> > >   virtio_net: virtnet_poll_tx support rescheduled
> > >   virtio_net: independent directory
> > >   virtio_net: move to virtio_net.h
> > >   virtio_net: introduce virtnet_xdp_handler() to seprate the logic of
> > >     run xdp
> > >   virtio_net: receive_small() use virtnet_xdp_handler()
> > >   virtio_net: receive_merageable() use virtnet_xdp_handler()
> > >   virtio_net: introduce virtnet_tx_reset()
> > >   virtio_net: xsk: introduce virtnet_rq_bind_xsk_pool()
> > >   virtio_net: xsk: introduce virtnet_xsk_pool_enable()
> > >   virtio_net: xsk: introduce xsk disable
> > >   virtio_net: xsk: support xsk setup
> > >   virtio_net: xsk: stop disable tx napi
> > >   virtio_net: xsk: __free_old_xmit distinguishes xsk buffer
> > >   virtio_net: virtnet_sq_free_unused_buf() check xsk buffer
> > >   virtio_net: virtnet_rq_free_unused_buf() check xsk buffer
> > >   net: introduce napi_tx_raise()
> > >   virtio_net: xsk: tx: support tx
> > >   virtio_net: xsk: tx: support wakeup
> > >   virtio_net: xsk: tx: auto wakeup when free old xmit
> > >   virtio_net: xsk: rx: introduce add_recvbuf_xsk()
> > >   virtio_net: xsk: rx: introduce receive_xsk() to recv xsk buffer
> > >
> > >  MAINTAINERS                                 |   2 +-
> > >  drivers/net/Kconfig                         |   8 +-
> > >  drivers/net/Makefile                        |   2 +-
> > >  drivers/net/virtio/Kconfig                  |  11 +
> > >  drivers/net/virtio/Makefile                 |   8 +
> > >  drivers/net/{virtio_net.c => virtio/main.c} | 564 +++++++-------------
> > >  drivers/net/virtio/virtio_net.h             | 317 +++++++++++
> > >  drivers/net/virtio/xsk.c                    | 524 ++++++++++++++++++
> > >  drivers/net/virtio/xsk.h                    |  33 ++
> > >  drivers/virtio/virtio_ring.c                | 376 +++++++++++--
> > >  include/linux/netdevice.h                   |   7 +
> > >  include/linux/virtio.h                      |  29 +
> > >  include/net/xsk_buff_pool.h                 |   6 +
> > >  net/core/dev.c                              |  11 +
> > >  net/xdp/xsk_buff_pool.c                     |  79 ++-
> > >  15 files changed, 1541 insertions(+), 436 deletions(-)
> > >  create mode 100644 drivers/net/virtio/Kconfig
> > >  create mode 100644 drivers/net/virtio/Makefile
> > >  rename drivers/net/{virtio_net.c => virtio/main.c} (92%)
> > >  create mode 100644 drivers/net/virtio/virtio_net.h
> > >  create mode 100644 drivers/net/virtio/xsk.c
> > >  create mode 100644 drivers/net/virtio/xsk.h
> > >
> > > --
> > > 2.32.0.3.g01195cf9f
> >

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

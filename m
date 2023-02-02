Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99DCCC61DA4
	for <virtualization@archiver.kernel.org>; Thu,  2 Feb 2023 11:26:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 30BD940C0D;
	Thu,  2 Feb 2023 11:26:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 30BD940C0D
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7xBh4HSpaArS; Thu,  2 Feb 2023 11:26:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 80BB240C70;
	Thu,  2 Feb 2023 11:26:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 80BB240C70
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 577BAC0033;
	Thu,  2 Feb 2023 11:26:23 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id ADEA3C002B
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Feb 2023 11:26:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 789CA41A3A
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Feb 2023 11:26:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 789CA41A3A
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 68GDXdVVHyn1
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Feb 2023 11:26:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org CE0DF41920
Received: from out30-99.freemail.mail.aliyun.com
 (out30-99.freemail.mail.aliyun.com [115.124.30.99])
 by smtp4.osuosl.org (Postfix) with ESMTPS id CE0DF41920
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Feb 2023 11:26:19 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R101e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018046056;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=21; SR=0;
 TI=SMTPD_---0Vaksi9Q_1675337173; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0Vaksi9Q_1675337173) by smtp.aliyun-inc.com;
 Thu, 02 Feb 2023 19:26:14 +0800
Message-ID: <1675336267.0156906-2-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH 00/33] virtio-net: support AF_XDP zero copy
Date: Thu, 2 Feb 2023 19:11:07 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20230202110058.130695-1-xuanzhuo@linux.alibaba.com>
 <20230202060757-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230202060757-mutt-send-email-mst@kernel.org>
Cc: Petr Machata <petrm@nvidia.com>, Menglong Dong <imagedong@tencent.com>, Maciej Fijalkowski <maciej.fijalkowski@intel.com>, Jesper Dangaard Brouer <hawk@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org, John Fastabend <john.fastabend@gmail.com>, Björn Töpel <bjorn@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Eric Dumazet <edumazet@google.com>, Kuniyuki Iwashima <kuniyu@amazon.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Jonathan Lemon <jonathan.lemon@gmail.com>, Jakub Kicinski <kuba@kernel.org>, bpf@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>, virtualization@lists.linux-foundation.org, "David S. Miller" <davem@davemloft.net>, Magnus Karlsson <magnus.karlsson@intel.com>
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Thu, 2 Feb 2023 06:08:30 -0500, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> On Thu, Feb 02, 2023 at 07:00:25PM +0800, Xuan Zhuo wrote:
> > XDP socket(AF_XDP) is an excellent bypass kernel network framework. The zero
> > copy feature of xsk (XDP socket) needs to be supported by the driver. The
> > performance of zero copy is very good.
>
> Great! Any numbers to share?


ENV: Qemu with vhost.

                   vhost cpu | Guest APP CPU |Guest Softirq CPU | PPS
-----------------------------|---------------|------------------|------------
xmit by sockperf:     90%    |   100%        |                  |  318967
xmit by xsk:          100%   |   30%         |   33%            | 1192064
recv by sockperf:     100%   |   68%         |   100%           |  692288
recv by xsk:          100%   |   33%         |   43%            |  771670


Thanks.
                             |               |                  |
>                                                               |
> > mlx5 and intel ixgbe already support
> > this feature, This patch set allows virtio-net to support xsk's zerocopy xmit
> > feature.
> >
> > Virtio-net did not support per-queue reset, so it was impossible to support XDP
> > Socket Zerocopy. At present, we have completed the work of Virtio Spec and
> > Kernel in Per-Queue Reset. It is time for Virtio-Net to complete the support for
> > the XDP Socket Zerocopy.
> >
> > Virtio-net can not increase the queue at will, so xsk shares the queue with
> > kernel.
> >
> > On the other hand, Virtio-Net does not support generate interrupt manually, so
> > when we wakeup tx xmit, we used some tips. If the CPU run by TX NAPI last time
> > is other CPUs, use IPI to wake up NAPI on the remote CPU. If it is also the
> > local CPU, then we wake up sofrirqd.
> >
> > Please review.
> >
> > Thanks.
> >
> >
> > Xuan Zhuo (33):
> >   virtio_ring: virtqueue_add() support premapped
> >   virtio_ring: split: virtqueue_add_split() support premapped
> >   virtio_ring: packed: virtqueue_add_packed() support premapped
> >   virtio_ring: introduce virtqueue_add_outbuf_premapped()
> >   virtio_ring: introduce virtqueue_add_inbuf_premapped()
> >   virtio_ring: introduce virtqueue_reset()
> >   virtio_ring: add api virtio_dma_map() for advance dma
> >   virtio_ring: introduce dma sync api for virtio
> >   xsk: xsk_buff_pool add callback for dma_sync
> >   xsk: support virtio DMA map
> >   virtio_net: rename free_old_xmit_skbs to free_old_xmit
> >   virtio_net: unify the code for recycling the xmit ptr
> >   virtio_net: virtnet_poll_tx support rescheduled
> >   virtio_net: independent directory
> >   virtio_net: move to virtio_net.h
> >   virtio_net: introduce virtnet_xdp_handler() to seprate the logic of
> >     run xdp
> >   virtio_net: receive_small() use virtnet_xdp_handler()
> >   virtio_net: receive_merageable() use virtnet_xdp_handler()
> >   virtio_net: introduce virtnet_tx_reset()
> >   virtio_net: xsk: introduce virtnet_rq_bind_xsk_pool()
> >   virtio_net: xsk: introduce virtnet_xsk_pool_enable()
> >   virtio_net: xsk: introduce xsk disable
> >   virtio_net: xsk: support xsk setup
> >   virtio_net: xsk: stop disable tx napi
> >   virtio_net: xsk: __free_old_xmit distinguishes xsk buffer
> >   virtio_net: virtnet_sq_free_unused_buf() check xsk buffer
> >   virtio_net: virtnet_rq_free_unused_buf() check xsk buffer
> >   net: introduce napi_tx_raise()
> >   virtio_net: xsk: tx: support tx
> >   virtio_net: xsk: tx: support wakeup
> >   virtio_net: xsk: tx: auto wakeup when free old xmit
> >   virtio_net: xsk: rx: introduce add_recvbuf_xsk()
> >   virtio_net: xsk: rx: introduce receive_xsk() to recv xsk buffer
> >
> >  MAINTAINERS                                 |   2 +-
> >  drivers/net/Kconfig                         |   8 +-
> >  drivers/net/Makefile                        |   2 +-
> >  drivers/net/virtio/Kconfig                  |  11 +
> >  drivers/net/virtio/Makefile                 |   8 +
> >  drivers/net/{virtio_net.c => virtio/main.c} | 564 +++++++-------------
> >  drivers/net/virtio/virtio_net.h             | 317 +++++++++++
> >  drivers/net/virtio/xsk.c                    | 524 ++++++++++++++++++
> >  drivers/net/virtio/xsk.h                    |  33 ++
> >  drivers/virtio/virtio_ring.c                | 376 +++++++++++--
> >  include/linux/netdevice.h                   |   7 +
> >  include/linux/virtio.h                      |  29 +
> >  include/net/xsk_buff_pool.h                 |   6 +
> >  net/core/dev.c                              |  11 +
> >  net/xdp/xsk_buff_pool.c                     |  79 ++-
> >  15 files changed, 1541 insertions(+), 436 deletions(-)
> >  create mode 100644 drivers/net/virtio/Kconfig
> >  create mode 100644 drivers/net/virtio/Makefile
> >  rename drivers/net/{virtio_net.c => virtio/main.c} (92%)
> >  create mode 100644 drivers/net/virtio/virtio_net.h
> >  create mode 100644 drivers/net/virtio/xsk.c
> >  create mode 100644 drivers/net/virtio/xsk.h
> >
> > --
> > 2.32.0.3.g01195cf9f
>
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

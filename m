Return-Path: <SRS0=uiEo=LE=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42F3FC48BD1
	for <virtualization@archiver.kernel.org>; Thu, 10 Jun 2021 08:22:23 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EFF9D61439
	for <virtualization@archiver.kernel.org>; Thu, 10 Jun 2021 08:22:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFF9D61439
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id BBCD582C4D;
	Thu, 10 Jun 2021 08:22:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id y010wJwLXGGu; Thu, 10 Jun 2021 08:22:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 714AA83CA5;
	Thu, 10 Jun 2021 08:22:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 017A1C0023;
	Thu, 10 Jun 2021 08:22:21 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DD156C0022
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Jun 2021 08:22:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id BC4CA405BB
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Jun 2021 08:22:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JARlLumJseZa
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Jun 2021 08:22:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from out30-131.freemail.mail.aliyun.com
 (out30-131.freemail.mail.aliyun.com [115.124.30.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D7C0940539
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Jun 2021 08:22:12 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R111e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=alimailimapcm10staff010182156082;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=21; SR=0;
 TI=SMTPD_---0UbxH88i_1623313329; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0UbxH88i_1623313329) by smtp.aliyun-inc.com(127.0.0.1);
 Thu, 10 Jun 2021 16:22:09 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: netdev@vger.kernel.org
Subject: [PATCH net-next v5 00/15] virtio-net: support xdp socket zero copy
Date: Thu, 10 Jun 2021 16:21:54 +0800
Message-Id: <20210610082209.91487-1-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Cc: Song Liu <songliubraving@fb.com>, Martin KaFai Lau <kafai@fb.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, "Michael S. Tsirkin" <mst@redhat.com>,
 Yonghong Song <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
 "dust . li" <dust.li@linux.alibaba.com>,
 Jonathan Lemon <jonathan.lemon@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, bpf@vger.kernel.org,
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

XDP socket is an excellent by pass kernel network transmission framework. The
zero copy feature of xsk (XDP socket) needs to be supported by the driver. The
performance of zero copy is very good. mlx5 and intel ixgbe already support this
feature, This patch set allows virtio-net to support xsk's zerocopy xmit
feature.

Compared with other drivers, the trouble with virtio-net is that when we bind
the channel to xsk, we cannot directly disable/enable the channel. So we have to
consider the buf that has been placed in the vq after the xsk is released by the
upper layer.

My solution is to add a ctx to each buf placed in vq to record the page used,
and add a reference to the page. So when the upper xsk is released, these pages
are still safe in vq. We will process these bufs when we recycle buf or
receive new data.

In the case of rx, it will be more complicated, because we may encounter the buf
of xsk, or it may be a normal buf. Especially in the case of merge, we may
receive multiple bufs, and these bufs may be xsk buf and normal are
mixed together.

v5:
   support rx

v4:
    1. add priv_flags IFF_NOT_USE_DMA_ADDR
    2. more reasonable patch split

Xuan Zhuo (15):
  netdevice: priv_flags extend to 64bit
  netdevice: add priv_flags IFF_NOT_USE_DMA_ADDR
  virtio-net: add priv_flags IFF_NOT_USE_DMA_ADDR
  xsk: XDP_SETUP_XSK_POOL support option IFF_NOT_USE_DMA_ADDR
  virtio: support virtqueue_detach_unused_buf_ctx
  virtio-net: unify the code for recycling the xmit ptr
  virtio-net: standalone virtnet_aloc_frag function
  virtio-net: split the receive_mergeable function
  virtio-net: virtnet_poll_tx support budget check
  virtio-net: independent directory
  virtio-net: move to virtio_net.h
  virtio-net: support AF_XDP zc tx
  virtio-net: support AF_XDP zc rx
  virtio-net: xsk direct xmit inside xsk wakeup
  virtio-net: xsk zero copy xmit kick by threshold

 MAINTAINERS                           |   2 +-
 drivers/net/Kconfig                   |   8 +-
 drivers/net/Makefile                  |   2 +-
 drivers/net/virtio/Kconfig            |  11 +
 drivers/net/virtio/Makefile           |   7 +
 drivers/net/{ => virtio}/virtio_net.c | 670 +++++++++++-----------
 drivers/net/virtio/virtio_net.h       | 288 ++++++++++
 drivers/net/virtio/xsk.c              | 766 ++++++++++++++++++++++++++
 drivers/net/virtio/xsk.h              | 176 ++++++
 drivers/virtio/virtio_ring.c          |  22 +-
 include/linux/netdevice.h             | 143 ++---
 include/linux/virtio.h                |   2 +
 net/8021q/vlanproc.c                  |   2 +-
 net/xdp/xsk_buff_pool.c               |   2 +-
 14 files changed, 1664 insertions(+), 437 deletions(-)
 create mode 100644 drivers/net/virtio/Kconfig
 create mode 100644 drivers/net/virtio/Makefile
 rename drivers/net/{ => virtio}/virtio_net.c (92%)
 create mode 100644 drivers/net/virtio/virtio_net.h
 create mode 100644 drivers/net/virtio/xsk.c
 create mode 100644 drivers/net/virtio/xsk.h

--
2.31.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

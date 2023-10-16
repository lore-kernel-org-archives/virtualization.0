Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C09ECDB482
	for <virtualization@archiver.kernel.org>; Mon, 16 Oct 2023 12:00:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9025860E1D;
	Mon, 16 Oct 2023 12:00:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9025860E1D
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1vYE7cChNB7r; Mon, 16 Oct 2023 12:00:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id E904060E27;
	Mon, 16 Oct 2023 12:00:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E904060E27
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C2C9EC0DD9;
	Mon, 16 Oct 2023 12:00:45 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 20ED1C0032
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Oct 2023 12:00:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1B01882009
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Oct 2023 12:00:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1B01882009
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id iQbUmfmdb1mo
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Oct 2023 12:00:43 +0000 (UTC)
Received: from out30-99.freemail.mail.aliyun.com
 (out30-99.freemail.mail.aliyun.com [115.124.30.99])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2118681FFC
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Oct 2023 12:00:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2118681FFC
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R131e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018046049;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=14; SR=0;
 TI=SMTPD_---0VuHc.Mz_1697457634; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0VuHc.Mz_1697457634) by smtp.aliyun-inc.com;
 Mon, 16 Oct 2023 20:00:34 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: netdev@vger.kernel.org
Subject: [PATCH net-next v1 00/19] virtio-net: support AF_XDP zero copy
Date: Mon, 16 Oct 2023 20:00:14 +0800
Message-Id: <20231016120033.26933-1-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
MIME-Version: 1.0
X-Git-Hash: 9790cc452aab
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, "Michael S. Tsirkin" <mst@redhat.com>,
 John Fastabend <john.fastabend@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
 virtualization@lists.linux-foundation.org, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, bpf@vger.kernel.org,
 Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>
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

## AF_XDP

XDP socket(AF_XDP) is an excellent bypass kernel network framework. The zero
copy feature of xsk (XDP socket) needs to be supported by the driver. The
performance of zero copy is very good. mlx5 and intel ixgbe already support
this feature, This patch set allows virtio-net to support xsk's zerocopy xmit
feature.

At present, we have completed some preparation:

1. vq-reset (virtio spec and kernel code)
2. virtio-core premapped dma
3. virtio-net xdp refactor

So it is time for Virtio-Net to complete the support for the XDP Socket
Zerocopy.

Virtio-net can not increase the queue num at will, so xsk shares the queue with
kernel.

On the other hand, Virtio-Net does not support generate interrupt from driver
manually, so when we wakeup tx xmit, we used some tips. If the CPU run by TX
NAPI last time is other CPUs, use IPI to wake up NAPI on the remote CPU. If it
is also the local CPU, then we wake up napi directly.

This patch set includes some refactor to the virtio-net to let that to support
AF_XDP.

## performance

ENV: Qemu with vhost-user(polling mode).

Sockperf: https://github.com/Mellanox/sockperf
I use this tool to send udp packet by kernel syscall.

xmit command: sockperf tp -i 10.0.3.1 -t 1000

I write a tool that sends udp packets or recvs udp packets by AF_XDP.

                  | Guest APP CPU |Guest Softirq CPU | UDP PPS
------------------|---------------|------------------|------------
xmit by syscall   |   100%        |                  |   676,915
xmit by xsk       |   59.1%       |   100%           | 5,447,168
recv by syscall   |   60%         |   100%           |   932,288
recv by xsk       |   35.7%       |   100%           | 3,343,168

## maintain

I am currently a reviewer for virtio-net. I commit to maintain AF_XDP support in
virtio-net.

Please review.

Thanks.

v1:
    1. remove two virtio commits. Push this patchset to net-next
    2. squash "virtio_net: virtnet_poll_tx support rescheduled" to xsk: support tx
    3. fix some warnings

Xuan Zhuo (19):
  virtio_net: rename free_old_xmit_skbs to free_old_xmit
  virtio_net: unify the code for recycling the xmit ptr
  virtio_net: independent directory
  virtio_net: move to virtio_net.h
  virtio_net: add prefix virtnet to all struct/api inside virtio_net.h
  virtio_net: separate virtnet_rx_resize()
  virtio_net: separate virtnet_tx_resize()
  virtio_net: sq support premapped mode
  virtio_net: xsk: bind/unbind xsk
  virtio_net: xsk: prevent disable tx napi
  virtio_net: xsk: tx: support tx
  virtio_net: xsk: tx: support wakeup
  virtio_net: xsk: tx: virtnet_free_old_xmit() distinguishes xsk buffer
  virtio_net: xsk: tx: virtnet_sq_free_unused_buf() check xsk buffer
  virtio_net: xsk: rx: introduce add_recvbuf_xsk()
  virtio_net: xsk: rx: introduce receive_xsk() to recv xsk buffer
  virtio_net: xsk: rx: virtnet_rq_free_unused_buf() check xsk buffer
  virtio_net: update tx timeout record
  virtio_net: xdp_features add NETDEV_XDP_ACT_XSK_ZEROCOPY

 MAINTAINERS                                 |   2 +-
 drivers/net/Kconfig                         |   8 +-
 drivers/net/Makefile                        |   2 +-
 drivers/net/virtio/Kconfig                  |  13 +
 drivers/net/virtio/Makefile                 |   8 +
 drivers/net/{virtio_net.c => virtio/main.c} | 652 +++++++++-----------
 drivers/net/virtio/virtio_net.h             | 359 +++++++++++
 drivers/net/virtio/xsk.c                    | 545 ++++++++++++++++
 drivers/net/virtio/xsk.h                    |  32 +
 9 files changed, 1247 insertions(+), 374 deletions(-)
 create mode 100644 drivers/net/virtio/Kconfig
 create mode 100644 drivers/net/virtio/Makefile
 rename drivers/net/{virtio_net.c => virtio/main.c} (91%)
 create mode 100644 drivers/net/virtio/virtio_net.h
 create mode 100644 drivers/net/virtio/xsk.c
 create mode 100644 drivers/net/virtio/xsk.h

--
2.32.0.3.g01195cf9f

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

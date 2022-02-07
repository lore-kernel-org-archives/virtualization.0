Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FD7DC433F5
	for <virtualization@archiver.kernel.org>; Mon,  7 Feb 2022 06:04:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id AF9C4605A7;
	Mon,  7 Feb 2022 06:03:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id t-uQmLwf0-NX; Mon,  7 Feb 2022 06:03:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 66384605A6;
	Mon,  7 Feb 2022 06:03:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 395E2C001A;
	Mon,  7 Feb 2022 06:03:56 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9CE05C000B
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Feb 2022 06:03:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 76CDA605A7
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Feb 2022 06:03:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ixdy9q5LOmzD
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Feb 2022 06:03:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from out30-56.freemail.mail.aliyun.com
 (out30-56.freemail.mail.aliyun.com [115.124.30.56])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A287D605A6
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Feb 2022 06:03:52 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R141e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04400; MF=xuanzhuo@linux.alibaba.com;
 NM=1; PH=DS; RN=11; SR=0; TI=SMTPD_---0V3mOPEj_1644213825; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0V3mOPEj_1644213825) by smtp.aliyun-inc.com(127.0.0.1);
 Mon, 07 Feb 2022 14:03:46 +0800
Message-Id: <1644213739.5846965-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH v3 00/17] virtio pci support VIRTIO_F_RING_RESET
Date: Mon, 07 Feb 2022 14:02:19 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jason Wang <jasowang@redhat.com>
In-Reply-To: <CACGkMEspyHTmcSaq9fgpU88VCZGzu21Khp9H+fqL-pb5GLdEpA@mail.gmail.com>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, "Michael S. Tsirkin" <mst@redhat.com>,
 netdev <netdev@vger.kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Jakub Kicinski <kuba@kernel.org>, bpf@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>
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

On Mon, 7 Feb 2022 11:39:36 +0800, Jason Wang <jasowang@redhat.com> wrote:
> On Wed, Jan 26, 2022 at 3:35 PM Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
> >
> > ================================================================================
> > The virtio spec already supports the virtio queue reset function. This patch set
> > is to add this function to the kernel. The relevant virtio spec information is
> > here:
> >
> >     https://github.com/oasis-tcs/virtio-spec/issues/124
> >
> > Also regarding MMIO support for queue reset, I plan to support it after this
> > patch is passed.
> >
> > #14-#17 is the disable/enable function of rx/tx pair implemented by virtio-net
> > using the new helper.
>
> One thing that came to mind is the steering. E.g if we disable an RX,
> should we stop steering packets to that queue?

Yes, we should reselect a queue.

Thanks.

>
> Thanks
>
> > This function is not currently referenced by other
> > functions. It is more to show the usage of the new helper, I not sure if they
> > are going to be merged together.
> >
> > Please review. Thanks.
> >
> > v3:
> >   1. keep vq, irq unreleased
> >
> > Xuan Zhuo (17):
> >   virtio_pci: struct virtio_pci_common_cfg add queue_notify_data
> >   virtio: queue_reset: add VIRTIO_F_RING_RESET
> >   virtio: queue_reset: struct virtio_config_ops add callbacks for
> >     queue_reset
> >   virtio: queue_reset: add helper
> >   vritio_ring: queue_reset: extract the release function of the vq ring
> >   virtio_ring: queue_reset: split: add __vring_init_virtqueue()
> >   virtio_ring: queue_reset: split: support enable reset queue
> >   virtio_ring: queue_reset: packed: support enable reset queue
> >   virtio_ring: queue_reset: add vring_reset_virtqueue()
> >   virtio_pci: queue_reset: update struct virtio_pci_common_cfg and
> >     option functions
> >   virtio_pci: queue_reset: release vq by vp_dev->vqs
> >   virtio_pci: queue_reset: setup_vq use vring_setup_virtqueue()
> >   virtio_pci: queue_reset: support VIRTIO_F_RING_RESET
> >   virtio_net: virtnet_tx_timeout() fix style
> >   virtio_net: virtnet_tx_timeout() stop ref sq->vq
> >   virtio_net: split free_unused_bufs()
> >   virtio_net: support pair disable/enable
> >
> >  drivers/net/virtio_net.c               | 220 ++++++++++++++++++++++---
> >  drivers/virtio/virtio_pci_common.c     |  62 ++++---
> >  drivers/virtio/virtio_pci_common.h     |  11 +-
> >  drivers/virtio/virtio_pci_legacy.c     |   5 +-
> >  drivers/virtio/virtio_pci_modern.c     | 120 +++++++++++++-
> >  drivers/virtio/virtio_pci_modern_dev.c |  28 ++++
> >  drivers/virtio/virtio_ring.c           | 144 +++++++++++-----
> >  include/linux/virtio.h                 |   1 +
> >  include/linux/virtio_config.h          |  75 ++++++++-
> >  include/linux/virtio_pci_modern.h      |   2 +
> >  include/linux/virtio_ring.h            |  42 +++--
> >  include/uapi/linux/virtio_config.h     |   7 +-
> >  include/uapi/linux/virtio_pci.h        |   2 +
> >  13 files changed, 618 insertions(+), 101 deletions(-)
> >
> > --
> > 2.31.0
> >
>
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

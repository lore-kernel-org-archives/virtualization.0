Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DFD9C433F5
	for <virtualization@archiver.kernel.org>; Fri, 11 Feb 2022 06:34:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0F74D41624;
	Fri, 11 Feb 2022 06:34:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KXn8_WAaLLzj; Fri, 11 Feb 2022 06:34:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 647344025E;
	Fri, 11 Feb 2022 06:34:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 35A98C001A;
	Fri, 11 Feb 2022 06:34:45 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0C9A9C000B
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Feb 2022 06:34:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D361E4089E
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Feb 2022 06:34:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3cyW-84Bmuxg
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Feb 2022 06:34:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from out30-131.freemail.mail.aliyun.com
 (out30-131.freemail.mail.aliyun.com [115.124.30.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A2B1E4025E
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Feb 2022 06:34:41 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R181e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e01424; MF=xuanzhuo@linux.alibaba.com;
 NM=1; PH=DS; RN=4; SR=0; TI=SMTPD_---0V47kJqh_1644561276; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0V47kJqh_1644561276) by smtp.aliyun-inc.com(127.0.0.1);
 Fri, 11 Feb 2022 14:34:37 +0800
Message-ID: <1644560833.8375504-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH v4 00/14] virtio pci support VIRTIO_F_RING_RESET
Date: Fri, 11 Feb 2022 14:27:13 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jason Wang <jasowang@redhat.com>
References: <20220209122901.51790-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEs7jR7Y5QKLeSfwJNqOooqe2Pgcm-GeTqb9rgAyawPSrQ@mail.gmail.com>
In-Reply-To: <CACGkMEs7jR7Y5QKLeSfwJNqOooqe2Pgcm-GeTqb9rgAyawPSrQ@mail.gmail.com>
Cc: virtualization <virtualization@lists.linux-foundation.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
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

On Fri, 11 Feb 2022 13:40:52 +0800, Jason Wang <jasowang@redhat.com> wrote:
> On Wed, Feb 9, 2022 at 8:29 PM Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
> >
> > The virtio spec already supports the virtio queue reset function. This patch set
> > is to add this function to the kernel. The relevant virtio spec information is
> > here:
> >
> >     https://github.com/oasis-tcs/virtio-spec/issues/124
> >
> > Also regarding MMIO support for queue reset, I plan to support it after this
> > patch is passed.
>
> So I had an idea, we can implement ethtool_set_ringparam() in this
> series to get one real users.

I agree, in fact my local test is using this feature.

>
> But this came into another question: it looks to me current virito-net
> just uses the maximum ring size, so it basically means we just can
> decrease the number from startup, so I wonder how much value if we
> don't limit the startup queue size to a dedicated value.

I also have this consideration, so I want to add a virtio-net module parameter
to specify an initial value.

This initial value also has another meaning. In order to achieve high
performance, the backend can provide a large ring size capability, but we also
hope that the ring size can only be increased through ethtool -G when the user
needs it.

To implement this function, we need to add a new parameter to find_vqs().

If there is no problem, I will bring this function in the next version.

Thannks.


>
> Thanks
>
> >
> > Please review. Thanks.
> >
> > v4:
> >   1. just the code of virtio, without virtio-net
> >   2. Performing reset on a queue is divided into these steps:
> >     1. reset_vq: reset one vq
> >     2. recycle the buffer from vq by virtqueue_detach_unused_buf()
> >     3. release the ring of the vq by vring_release_virtqueue()
> >     4. enable_reset_vq: re-enable the reset queue
> >   3. Simplify the parameters of enable_reset_vq()
> >   4. add container structures for virtio_pci_common_cfg
> >
> > v3:
> >   1. keep vq, irq unreleased
> >
> > Xuan Zhuo (14):
> >   virtio_pci: struct virtio_pci_common_cfg add queue_notify_data
> >   virtio: queue_reset: add VIRTIO_F_RING_RESET
> >   virtio_ring: queue_reset: add function vring_setup_virtqueue()
> >   virtio_ring: queue_reset: split: add __vring_init_virtqueue()
> >   virtio_ring: queue_reset: split: support enable reset queue
> >   virtio_ring: queue_reset: packed: support enable reset queue
> >   virtio_ring: queue_reset: extract the release function of the vq ring
> >   virtio_ring: queue_reset: add vring_release_virtqueue()
> >   virtio: queue_reset: struct virtio_config_ops add callbacks for
> >     queue_reset
> >   virtio_pci: queue_reset: update struct virtio_pci_common_cfg and
> >     option functions
> >   virtio_pci: queue_reset: release vq by vp_dev->vqs
> >   virtio_pci: queue_reset: setup_vq() support vring_setup_virtqueue()
> >   virtio_pci: queue_reset: vp_setup_vq() support ring_num
> >   virtio_pci: queue_reset: support VIRTIO_F_RING_RESET
> >
> >  drivers/virtio/virtio_pci_common.c     |  65 +++++++---
> >  drivers/virtio/virtio_pci_common.h     |  11 +-
> >  drivers/virtio/virtio_pci_legacy.c     |   5 +-
> >  drivers/virtio/virtio_pci_modern.c     |  99 ++++++++++++--
> >  drivers/virtio/virtio_pci_modern_dev.c |  36 +++++
> >  drivers/virtio/virtio_ring.c           | 173 ++++++++++++++++++-------
> >  include/linux/virtio.h                 |   6 +
> >  include/linux/virtio_config.h          |  13 ++
> >  include/linux/virtio_pci_modern.h      |   2 +
> >  include/linux/virtio_ring.h            |  37 ++++--
> >  include/uapi/linux/virtio_config.h     |   7 +-
> >  include/uapi/linux/virtio_pci.h        |  14 ++
> >  12 files changed, 375 insertions(+), 93 deletions(-)
> >
> > --
> > 2.31.0
> >
>
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

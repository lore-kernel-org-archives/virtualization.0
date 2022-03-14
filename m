Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66FCEC433F5
	for <virtualization@archiver.kernel.org>; Mon, 14 Mar 2022 11:22:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 0390840159;
	Mon, 14 Mar 2022 11:22:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1bxYN3Ed_FLr; Mon, 14 Mar 2022 11:22:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 6AE274002B;
	Mon, 14 Mar 2022 11:22:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2D3E9C001D;
	Mon, 14 Mar 2022 11:22:07 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id ED0CCC000B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Mar 2022 11:22:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D5B394086A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Mar 2022 11:22:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4_1yYRxMPl0J
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Mar 2022 11:22:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from out30-131.freemail.mail.aliyun.com
 (out30-131.freemail.mail.aliyun.com [115.124.30.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8FFC040867
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Mar 2022 11:22:04 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R701e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e01424; MF=xuanzhuo@linux.alibaba.com;
 NM=1; PH=DS; RN=3; SR=0; TI=SMTPD_---0V78u6S6_1647256921; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0V78u6S6_1647256921) by smtp.aliyun-inc.com(127.0.0.1);
 Mon, 14 Mar 2022 19:22:01 +0800
Message-ID: <1647256878.7874777-2-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH v8 01/16] virtio: add helper virtqueue_get_vring_max_size()
Date: Mon, 14 Mar 2022 19:21:18 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20220314093455.34707-1-xuanzhuo@linux.alibaba.com>
 <20220314093455.34707-2-xuanzhuo@linux.alibaba.com>
 <87cziohnhr.fsf@redhat.com>
 <20220314071819-mutt-send-email-mst@kernel.org>
In-Reply-To: <20220314071819-mutt-send-email-mst@kernel.org>
Cc: Cornelia Huck <cohuck@redhat.com>,
 virtualization@lists.linux-foundation.org
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

On Mon, 14 Mar 2022 07:18:27 -0400, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> On Mon, Mar 14, 2022 at 10:50:08AM +0100, Cornelia Huck wrote:
> > On Mon, Mar 14 2022, Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
> >
> > > Record the maximum queue num supported by the device.
> > >
> > > virtio-net can display the maximum (supported by hardware) ring size in
> > > ethtool -g eth0.
> > >
> > > When the subsequent patch implements vring reset, it can judge whether
> > > the ring size passed by the driver is legal based on this.
> > >
> > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > Acked-by: Jason Wang <jasowang@redhat.com>
> > > ---
> > >  drivers/virtio/virtio_mmio.c       |  2 ++
> > >  drivers/virtio/virtio_pci_legacy.c |  2 ++
> > >  drivers/virtio/virtio_pci_modern.c |  2 ++
> > >  drivers/virtio/virtio_ring.c       | 14 ++++++++++++++
> > >  include/linux/virtio.h             |  2 ++
> > >  5 files changed, 22 insertions(+)
> >
> > Don't you also need to init this for ccw (even though we won't do ring
> > reset there), just for completeness? (Any other transports?)
>
> rpmsg?

There should be these.

 arch/um/drivers/virtio_uml.c             |  1 +
 drivers/platform/mellanox/mlxbf-tmfifo.c |  2 ++
 drivers/remoteproc/remoteproc_virtio.c   |  2 ++
 drivers/s390/virtio/virtio_ccw.c         |  3 +++
 drivers/virtio/virtio_mmio.c             |  2 ++
 drivers/virtio/virtio_pci_legacy.c       |  2 ++
 drivers/virtio/virtio_pci_modern.c       |  2 ++
 drivers/virtio/virtio_vdpa.c             |  2 ++

It will be included in the next version.

Thanks.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

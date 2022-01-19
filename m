Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D70ABC433EF
	for <virtualization@archiver.kernel.org>; Wed, 19 Jan 2022 06:28:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 755D2410AC;
	Wed, 19 Jan 2022 06:28:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bwCS5n1xVbhe; Wed, 19 Jan 2022 06:28:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 130F3410A9;
	Wed, 19 Jan 2022 06:28:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DDC50C0039;
	Wed, 19 Jan 2022 06:28:45 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5BB5DC002F
 for <virtualization@lists.linux-foundation.org>;
 Wed, 19 Jan 2022 06:28:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 49C508272A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 19 Jan 2022 06:28:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PDFcl0InHm4g
 for <virtualization@lists.linux-foundation.org>;
 Wed, 19 Jan 2022 06:28:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from out30-57.freemail.mail.aliyun.com
 (out30-57.freemail.mail.aliyun.com [115.124.30.57])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B19EA82725
 for <virtualization@lists.linux-foundation.org>;
 Wed, 19 Jan 2022 06:28:42 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R811e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04407; MF=xuanzhuo@linux.alibaba.com;
 NM=1; PH=DS; RN=3; SR=0; TI=SMTPD_---0V2FVnUn_1642573718; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0V2FVnUn_1642573718) by smtp.aliyun-inc.com(127.0.0.1);
 Wed, 19 Jan 2022 14:28:39 +0800
MIME-Version: 1.0
message-id: <1642573376.9899275-1-xuanzhuo@linux.alibaba.com>
subject: Re: [PATCH 0/6] virtio pci support VIRTIO_F_RING_RESET
date: Wed, 19 Jan 2022 14:22:56 +0800
from: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
to: Jason Wang <jasowang@redhat.com>
in-reply-to: <CACGkMEsaz+LLBVwg5X7JajYZGAhkTcz4sJLoXhkOOn24fqF5hQ@mail.gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 virtualization <virtualization@lists.linux-foundation.org>
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

On Wed, 19 Jan 2022 14:13:39 +0800, Jason Wang <jasowang@redhat.com> wrote:
> On Wed, Jan 19, 2022 at 10:35 AM Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
> >
> > The virtio spec already supports the virtio queue reset function. This patch set
> > is to add this function to the kernel. The relevant virtio spec information is
> > here:
> >
> >     https://github.com/oasis-tcs/virtio-spec/issues/124
> >
> > virtio-net's queue disable/enable function based on virtio queue reset is here
> >
> >     https://github.com/fengidri/linux/commit/021165b4eda44f87c4b7771ef637bab2512d066f
> >
> > I plan to include this patch in the subsequent virtio-net support AF_XDP
> > patch set.
>
> It's better to send them all to see how the new helpers are actually used.


If this patch is sent together with virtio-net + AF_XDP, I feel that this
patch set will be too big.

I can add the disable/enable function of tx/rx pair to virtio-net. But no one
uses this function for now, so I put it on github.

I'll include these patches for virtio-net using these new helpers in the next patch
set.

Thanks.


>
> Thanks
>
> >
> > Also regarding MMIO support for queue reset, I plan to support it after this
> > patch is passed.
> >
> > Please review. Thanks.
> >
> > Xuan Zhuo (6):
> >   virtio: pci: struct virtio_pci_common_cfg add queue_notify_data
> >   virtio: queue_reset: add VIRTIO_F_RING_RESET
> >   virtio: queue_reset: pci: update struct virtio_pci_common_cfg and
> >     option functions
> >   virtio: queue_reset: pci: extract some functions for subsequent
> >     patches
> >   virtio: queue_reset: pci: support VIRTIO_F_RING_RESET
> >   virtio: queue_reset: add helper
> >
> >  drivers/virtio/virtio_pci_common.c     | 140 +++++++++++++++++++------
> >  drivers/virtio/virtio_pci_common.h     |   5 +
> >  drivers/virtio/virtio_pci_modern.c     |  81 ++++++++++++++
> >  drivers/virtio/virtio_pci_modern_dev.c |  28 +++++
> >  include/linux/virtio_config.h          |  78 ++++++++++++++
> >  include/linux/virtio_pci_modern.h      |   2 +
> >  include/uapi/linux/virtio_config.h     |   7 +-
> >  include/uapi/linux/virtio_pci.h        |   2 +
> >  8 files changed, 310 insertions(+), 33 deletions(-)
> >
> > --
> > 2.31.0
> >
>
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

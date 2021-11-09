Return-Path: <SRS0=KS98=P4=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7945FC433EF
	for <virtualization@archiver.kernel.org>; Tue,  9 Nov 2021 15:16:35 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1AD27611BD
	for <virtualization@archiver.kernel.org>; Tue,  9 Nov 2021 15:16:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1AD27611BD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E10D7402E0;
	Tue,  9 Nov 2021 15:16:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NTqaafWgXTA2; Tue,  9 Nov 2021 15:16:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 8EBAB40398;
	Tue,  9 Nov 2021 15:16:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 58EB1C0019;
	Tue,  9 Nov 2021 15:16:33 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6379CC000E
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Nov 2021 15:16:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5F02980D5E
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Nov 2021 15:16:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id W_0GvDn5HQGq
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Nov 2021 15:16:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from out30-133.freemail.mail.aliyun.com
 (out30-133.freemail.mail.aliyun.com [115.124.30.133])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 453E880C88
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Nov 2021 15:16:27 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R201e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04407; MF=xuanzhuo@linux.alibaba.com;
 NM=1; PH=DS; RN=6; SR=0; TI=SMTPD_---0Uvo7FKL_1636470984; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0Uvo7FKL_1636470984) by smtp.aliyun-inc.com(127.0.0.1);
 Tue, 09 Nov 2021 23:16:24 +0800
MIME-Version: 1.0
message-id: <1636470868.53926-2-xuanzhuo@linux.alibaba.com>
subject: Re: [PATCH v4 0/3] virtio support cache indirect desc
date: Tue, 09 Nov 2021 23:14:28 +0800
from: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
to: Michael S. Tsirkin <mst@redhat.com>
in-reply-to: <20211109080023-mutt-send-email-mst@kernel.org>
x-mailing-list: netdev@vger.kernel.org
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

On Tue, 9 Nov 2021 08:03:18 -0500, Michael S. Tsirkin <mst@redhat.com> wrote:
> On Mon, Nov 08, 2021 at 07:49:48PM +0800, Xuan Zhuo wrote:
> > If the VIRTIO_RING_F_INDIRECT_DESC negotiation succeeds, and the number
> > of sgs used for sending packets is greater than 1. We must constantly
> > call __kmalloc/kfree to allocate/release desc.
> >
> > In the case of extremely fast package delivery, the overhead cannot be
> > ignored:
> >
> >   27.46%  [kernel]  [k] virtqueue_add
> >   16.66%  [kernel]  [k] detach_buf_split
> >   16.51%  [kernel]  [k] virtnet_xsk_xmit
> >   14.04%  [kernel]  [k] virtqueue_add_outbuf
> >    5.18%  [kernel]  [k] __kmalloc
> >    4.08%  [kernel]  [k] kfree
> >    2.80%  [kernel]  [k] virtqueue_get_buf_ctx
> >    2.22%  [kernel]  [k] xsk_tx_peek_desc
> >    2.08%  [kernel]  [k] memset_erms
> >    0.83%  [kernel]  [k] virtqueue_kick_prepare
> >    0.76%  [kernel]  [k] virtnet_xsk_run
> >    0.62%  [kernel]  [k] __free_old_xmit_ptr
> >    0.60%  [kernel]  [k] vring_map_one_sg
> >    0.53%  [kernel]  [k] native_apic_mem_write
> >    0.46%  [kernel]  [k] sg_next
> >    0.43%  [kernel]  [k] sg_init_table
> >    0.41%  [kernel]  [k] kmalloc_slab
> >
> > This patch adds a cache function to virtio to cache these allocated indirect
> > desc instead of constantly allocating and releasing desc.
> >
> > v4:
> >     1. Only allow desc cache when VIRTIO_RING_F_INDIRECT_DESC negotiation is successful
> >     2. The desc cache threshold can be set for each virtqueue
> >
> > v3:
> >   pre-allocate per buffer indirect descriptors array
>
> So I'm not sure why we are doing that. Did it improve anything?

1. Don't call kmalloc in the data path, this is not the point
2. Allocate memory on the cpu of the initialization device to ensure that the
indirect desc cache and vq desc are on the same numa.

Thanks.

>
>
> > v2:
> >   use struct list_head to cache the desc
> >
> > Xuan Zhuo (3):
> >   virtio: cache indirect desc for split
> >   virtio: cache indirect desc for packed
> >   virtio-net: enable virtio desc cache
> >
> >  drivers/net/virtio_net.c     |  12 ++-
> >  drivers/virtio/virtio_ring.c | 152 +++++++++++++++++++++++++++++++----
> >  include/linux/virtio.h       |  17 ++++
> >  3 files changed, 163 insertions(+), 18 deletions(-)
> >
> > --
> > 2.31.0
>
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

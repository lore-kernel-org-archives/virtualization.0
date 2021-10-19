Return-Path: <SRS0=CXPs=PH=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84EA4C433FE
	for <virtualization@archiver.kernel.org>; Tue, 19 Oct 2021 08:16:50 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F30BF61177
	for <virtualization@archiver.kernel.org>; Tue, 19 Oct 2021 08:16:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org F30BF61177
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id B5D594042D;
	Tue, 19 Oct 2021 08:16:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kF_wipv7xmgb; Tue, 19 Oct 2021 08:16:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 3957A401C5;
	Tue, 19 Oct 2021 08:16:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 11329C0011;
	Tue, 19 Oct 2021 08:16:48 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D2C75C000D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Oct 2021 08:16:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B3CD24025D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Oct 2021 08:16:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id u7YllcE5ezZ4
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Oct 2021 08:16:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from out30-42.freemail.mail.aliyun.com
 (out30-42.freemail.mail.aliyun.com [115.124.30.42])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A9E03401C5
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Oct 2021 08:16:45 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R581e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04400; MF=xuanzhuo@linux.alibaba.com;
 NM=1; PH=DS; RN=5; SR=0; TI=SMTPD_---0Ussiapm_1634631401; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0Ussiapm_1634631401) by smtp.aliyun-inc.com(127.0.0.1);
 Tue, 19 Oct 2021 16:16:42 +0800
MIME-Version: 1.0
message-id: <1634631341.208131-2-xuanzhuo@linux.alibaba.com>
subject: Re: [PATCH v2 1/2] virtio_ring: fix style of
 virtqueue_add_indirect_packed
date: Tue, 19 Oct 2021 16:15:41 +0800
from: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
to: Jason Wang <jasowang@redhat.com>
in-reply-to: <CACGkMEvA4GjbFyftndGVAWnPWP6pMy4o35xKtVhrjmmNE-uLvA@mail.gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 "David S. Miller" <davem@davemloft.net>, Tiwei Bie <tiwei.bie@intel.com>,
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

On Tue, 28 Sep 2021 11:14:47 +0800, Jason Wang <jasowang@redhat.com> wrote:
> On Mon, Sep 27, 2021 at 6:54 PM Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
> >
> > Fix the style problem of virtqueue_add_indirect_packed(). The next patch
> > involves the modification of this function.
> >
> > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > ---
> >  drivers/virtio/virtio_ring.c | 12 ++++++------
> >  1 file changed, 6 insertions(+), 6 deletions(-)
>
> Acked-by: Jason Wang <jasowang@redhat.com>

Hi, this patch set seems to have not been merged, is there something wrong with me?

Thanks.

>
> >
> > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > index dd95dfd85e98..91a46c4da87d 100644
> > --- a/drivers/virtio/virtio_ring.c
> > +++ b/drivers/virtio/virtio_ring.c
> > @@ -1050,12 +1050,12 @@ static struct vring_packed_desc *alloc_indirect_packed(unsigned int total_sg,
> >  }
> >
> >  static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
> > -                                      struct scatterlist *sgs[],
> > -                                      unsigned int total_sg,
> > -                                      unsigned int out_sgs,
> > -                                      unsigned int in_sgs,
> > -                                      void *data,
> > -                                      gfp_t gfp)
> > +                                        struct scatterlist *sgs[],
> > +                                        unsigned int total_sg,
> > +                                        unsigned int out_sgs,
> > +                                        unsigned int in_sgs,
> > +                                        void *data,
> > +                                        gfp_t gfp)
> >  {
> >         struct vring_packed_desc *desc;
> >         struct scatterlist *sg;
> > --
> > 2.31.0
> >
>
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

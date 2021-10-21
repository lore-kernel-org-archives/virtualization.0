Return-Path: <SRS0=rBDE=PJ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11FB0C433FE
	for <virtualization@archiver.kernel.org>; Thu, 21 Oct 2021 01:56:30 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52865610A2
	for <virtualization@archiver.kernel.org>; Thu, 21 Oct 2021 01:56:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 52865610A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 0533D4012E;
	Thu, 21 Oct 2021 01:56:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id emLoJjVw6p0A; Thu, 21 Oct 2021 01:56:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 46D284013D;
	Thu, 21 Oct 2021 01:56:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1E060C000F;
	Thu, 21 Oct 2021 01:56:27 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 95BE8C000D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Oct 2021 01:56:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7F59083AAD
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Oct 2021 01:56:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id coDDIvkkPGlA
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Oct 2021 01:56:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from out30-44.freemail.mail.aliyun.com
 (out30-44.freemail.mail.aliyun.com [115.124.30.44])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3052D83AAB
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Oct 2021 01:56:22 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R981e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e01424; MF=xuanzhuo@linux.alibaba.com;
 NM=1; PH=DS; RN=5; SR=0; TI=SMTPD_---0Ut5Vid4_1634781379; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0Ut5Vid4_1634781379) by smtp.aliyun-inc.com(127.0.0.1);
 Thu, 21 Oct 2021 09:56:19 +0800
MIME-Version: 1.0
message-id: <1634781268.9318976-1-xuanzhuo@linux.alibaba.com>
subject: Re: [PATCH v4 2/2] virtio_ring: check desc == NULL when using
 indirect with packed
date: Thu, 21 Oct 2021 09:54:28 +0800
from: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
to: Michael S. Tsirkin <mst@redhat.com>
in-reply-to: <20211020105106-mutt-send-email-mst@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Tiwei Bie <tiwei.bie@intel.com>,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Wed, 20 Oct 2021 10:52:24 -0400, Michael S. Tsirkin <mst@redhat.com> wrote:
> On Wed, Oct 20, 2021 at 07:07:43PM +0800, Xuan Zhuo wrote:
> > On Wed, 20 Oct 2021 04:24:33 -0400, Michael S. Tsirkin <mst@redhat.com> wrote:
> > > On Wed, Oct 20, 2021 at 10:19:46AM +0800, Xuan Zhuo wrote:
> > > > On Tue, 19 Oct 2021 09:21:51 -0400, Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > > On Tue, Oct 19, 2021 at 07:52:35PM +0800, Xuan Zhuo wrote:
> > > > > > When using indirect with packed, we don't check for allocation failures.
> > > > > > This patch checks that and fall back on direct.
> > > > > >
> > > > > > Fixes: 1ce9e6055fa ("virtio_ring: introduce packed ring support")
> > > > > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > > > > ---
> > > > > >  drivers/virtio/virtio_ring.c | 13 ++++++++++---
> > > > > >  1 file changed, 10 insertions(+), 3 deletions(-)
> > > > > >
> > > > > > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > > > > > index 91a46c4da87d..44a03b6e4dc4 100644
> > > > > > --- a/drivers/virtio/virtio_ring.c
> > > > > > +++ b/drivers/virtio/virtio_ring.c
> > > > > > @@ -1065,6 +1065,9 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
> > > > > >
> > > > > >  	head = vq->packed.next_avail_idx;
> > > > > >  	desc = alloc_indirect_packed(total_sg, gfp);
> > > > > > +	if (!desc)
> > > > > > +		/* fall back on direct */
> > > > >
> > > > > this comment belongs in virtqueue_add_packed right after
> > > > > return.
> > > > >
> > > > > > +		return -EAGAIN;
> > > > > >
> > > > >
> > > > > -ENOMEM surely?
> > > >
> > > > virtqueue_add_indirect_packed() will return -ENOMEM when dma mmap fails, so we
> > > > have to choose a different error code.
> > > >
> > > > Thanks.
> > >
> > > That's exactly the point.  Why would we want to recover from allocation
> > > failure but not DMA map failure?
> >
> > >From indirect to direct mode, there is no need to allocate memory, so if we
> > encounter memory allocation failure, we can fall back from indirect to direct
> > mode. Memory allocation failure is a temporary problem.
> >
> > And if you encounter a dma mmap error, this situation should be notified to the
> > upper layer.
> >
> > Thanks.
>
> Why did dma map fail?
> A common reason is precisely that we are running
> out of buffer space. Using direct which does not
> need extra buffer space thus has a chance to work.

It turns out that this is the case, then I have no problem.

Thanks.

>
>
> > >
> > > > >
> > > > > >  	if (unlikely(vq->vq.num_free < 1)) {
> > > > > >  		pr_debug("Can't add buf len 1 - avail = 0\n");
> > > > > > @@ -1176,6 +1179,7 @@ static inline int virtqueue_add_packed(struct virtqueue *_vq,
> > > > > >  	unsigned int i, n, c, descs_used, err_idx;
> > > > > >  	__le16 head_flags, flags;
> > > > > >  	u16 head, id, prev, curr, avail_used_flags;
> > > > > > +	int err;
> > > > > >
> > > > > >  	START_USE(vq);
> > > > > >
> > > > > > @@ -1191,9 +1195,12 @@ static inline int virtqueue_add_packed(struct virtqueue *_vq,
> > > > > >
> > > > > >  	BUG_ON(total_sg == 0);
> > > > > >
> > > > > > -	if (virtqueue_use_indirect(_vq, total_sg))
> > > > > > -		return virtqueue_add_indirect_packed(vq, sgs, total_sg,
> > > > > > -				out_sgs, in_sgs, data, gfp);
> > > > > > +	if (virtqueue_use_indirect(_vq, total_sg)) {
> > > > > > +		err = virtqueue_add_indirect_packed(vq, sgs, total_sg, out_sgs,
> > > > > > +						    in_sgs, data, gfp);
> > > > > > +		if (err != -EAGAIN)
> > > > > > +			return err;
> > > > > > +	}
> > > > > >
> > > > > >  	head = vq->packed.next_avail_idx;
> > > > > >  	avail_used_flags = vq->packed.avail_used_flags;
> > > > > > --
> > > > > > 2.31.0
> > > > >
> > >
>
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

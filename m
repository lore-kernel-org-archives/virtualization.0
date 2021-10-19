Return-Path: <SRS0=CXPs=PH=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B18F4C433F5
	for <virtualization@archiver.kernel.org>; Tue, 19 Oct 2021 11:20:40 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5544A610A1
	for <virtualization@archiver.kernel.org>; Tue, 19 Oct 2021 11:20:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5544A610A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1D7E140701;
	Tue, 19 Oct 2021 11:20:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3QpvD4qTp6Fj; Tue, 19 Oct 2021 11:20:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id A9246406E3;
	Tue, 19 Oct 2021 11:20:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 75E2BC0011;
	Tue, 19 Oct 2021 11:20:38 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3E919C000D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Oct 2021 11:20:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2E7C481A6F
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Oct 2021 11:20:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5maULUUmso1n
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Oct 2021 11:20:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from out30-45.freemail.mail.aliyun.com
 (out30-45.freemail.mail.aliyun.com [115.124.30.45])
 by smtp1.osuosl.org (Postfix) with ESMTPS id F386F819B8
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Oct 2021 11:20:35 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R971e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04357; MF=xuanzhuo@linux.alibaba.com;
 NM=1; PH=DS; RN=5; SR=0; TI=SMTPD_---0Usx6d07_1634642430; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0Usx6d07_1634642430) by smtp.aliyun-inc.com(127.0.0.1);
 Tue, 19 Oct 2021 19:20:30 +0800
MIME-Version: 1.0
message-id: <1634641946.8235457-1-xuanzhuo@linux.alibaba.com>
subject: Re: [PATCH v3 2/2] virtio_ring: check desc == NULL when packed and
 indirect
date: Tue, 19 Oct 2021 19:12:26 +0800
from: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
to: Michael S. Tsirkin <mst@redhat.com>
in-reply-to: <20211019070002-mutt-send-email-mst@kernel.org>
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

On Tue, 19 Oct 2021 07:07:58 -0400, Michael S. Tsirkin <mst@redhat.com> wrote:
> On Tue, Oct 19, 2021 at 06:56:57PM +0800, Xuan Zhuo wrote:
> > In the case of packed, use indirect desc, since desc is allocated by
> > kmalloc_array(), we should check whether its return value is NULL.
> >
> > This patch alloc desc inside virtqueue_add_packe(), if desc == NULL,
>
> Can we manage without typos in commit log please?

I'm sorry. virtqueue_add_packe => virtqueue_add_packed

>
> > fall back to not using indirect.
>
>
> It should say why is the patch created, and how it's fixed,
> as opposed to repating what patch does.
>
> E.g.
>
> when using indirect with packed, we don't check for
> allocation failures. Check and fall back on direct.


It's better.  I know how to do it.


>
>
>
> > Fixes: 1ce9e6055fa ("virtio_ring: introduce packed ring support")
> > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > Acked-by: Jason Wang <jasowang@redhat.com>
> > ---
> >  drivers/virtio/virtio_ring.c | 14 +++++++++-----
> >  1 file changed, 9 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > index 91a46c4da87d..62323c27bfe4 100644
> > --- a/drivers/virtio/virtio_ring.c
> > +++ b/drivers/virtio/virtio_ring.c
> > @@ -1051,20 +1051,19 @@ static struct vring_packed_desc *alloc_indirect_packed(unsigned int total_sg,
> >
> >  static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
> >  					 struct scatterlist *sgs[],
> > +					 struct vring_packed_desc *desc,
> >  					 unsigned int total_sg,
> >  					 unsigned int out_sgs,
> >  					 unsigned int in_sgs,
> >  					 void *data,
> >  					 gfp_t gfp)
>
> So this gets desc and will free it. I don't much like this.

Under normal circumstances, this function will not release desc. It will
actually release "desc" in detach_buf_packed(). Of course, if you encounter
an error in this function, it will also release desc in this function.

If we call alloc_indirect_packed() in virtqueue_add_indirect_packed() it is also
possible, we need to make virtqueue_add_indirect_packed() return a special
return value.

Thanks.

>
>
> >  {
> > -	struct vring_packed_desc *desc;
> >  	struct scatterlist *sg;
> >  	unsigned int i, n, err_idx;
> >  	u16 head, id;
> >  	dma_addr_t addr;
> >
> >  	head = vq->packed.next_avail_idx;
> > -	desc = alloc_indirect_packed(total_sg, gfp);
> >
> >  	if (unlikely(vq->vq.num_free < 1)) {
> >  		pr_debug("Can't add buf len 1 - avail = 0\n");
> > @@ -1191,9 +1190,14 @@ static inline int virtqueue_add_packed(struct virtqueue *_vq,
> >
> >  	BUG_ON(total_sg == 0);
> >
> > -	if (virtqueue_use_indirect(_vq, total_sg))
> > -		return virtqueue_add_indirect_packed(vq, sgs, total_sg,
> > -				out_sgs, in_sgs, data, gfp);
> > +	if (virtqueue_use_indirect(_vq, total_sg)) {
> > +		desc = alloc_indirect_packed(total_sg, gfp);
> > +		if (desc)
> > +			return virtqueue_add_indirect_packed(vq, sgs, desc,
> > +							     total_sg,
> > +							     out_sgs, in_sgs,
> > +							     data, gfp);
> > +	}
> >
> >  	head = vq->packed.next_avail_idx;
> >  	avail_used_flags = vq->packed.avail_used_flags;
> > --
> > 2.31.0
>
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

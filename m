Return-Path: <SRS0=hVMj=PQ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0E6EC433F5
	for <virtualization@archiver.kernel.org>; Thu, 28 Oct 2021 06:28:16 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5DC3F61040
	for <virtualization@archiver.kernel.org>; Thu, 28 Oct 2021 06:28:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5DC3F61040
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 23E4F40135;
	Thu, 28 Oct 2021 06:28:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JfgpmXx9V6PJ; Thu, 28 Oct 2021 06:28:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id B303E40162;
	Thu, 28 Oct 2021 06:28:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7EC75C0019;
	Thu, 28 Oct 2021 06:28:14 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B84CAC000E
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Oct 2021 06:28:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A0E3540162
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Oct 2021 06:28:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rwx4nacQa4YF
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Oct 2021 06:28:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from out30-45.freemail.mail.aliyun.com
 (out30-45.freemail.mail.aliyun.com [115.124.30.45])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0A33640135
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Oct 2021 06:28:10 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R141e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04357; MF=xuanzhuo@linux.alibaba.com;
 NM=1; PH=DS; RN=6; SR=0; TI=SMTPD_---0Utz59Qb_1635402485; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0Utz59Qb_1635402485) by smtp.aliyun-inc.com(127.0.0.1);
 Thu, 28 Oct 2021 14:28:06 +0800
MIME-Version: 1.0
message-id: <1635401763.7680635-3-xuanzhuo@linux.alibaba.com>
subject: Re: [PATCH 1/3] virtio: cache indirect desc for split
date: Thu, 28 Oct 2021 14:16:03 +0800
from: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
to: Jason Wang <jasowang@redhat.com>
in-reply-to: <CACGkMEssaFCNgmRL4b5P5Dpm3WBhpQX37t-_j9Bc6wndTh4UHw@mail.gmail.com>
Cc: netdev <netdev@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
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

On Thu, 28 Oct 2021 10:16:10 +0800, Jason Wang <jasowang@redhat.com> wrote:
> On Thu, Oct 28, 2021 at 1:07 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Wed, Oct 27, 2021 at 02:19:11PM +0800, Xuan Zhuo wrote:
> > > In the case of using indirect, indirect desc must be allocated and
> > > released each time, which increases a lot of cpu overhead.
> > >
> > > Here, a cache is added for indirect. If the number of indirect desc to be
> > > applied for is less than VIRT_QUEUE_CACHE_DESC_NUM, the desc array with
> > > the size of VIRT_QUEUE_CACHE_DESC_NUM is fixed and cached for reuse.
> > >
> > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > ---
> > >  drivers/virtio/virtio.c      |  6 ++++
> > >  drivers/virtio/virtio_ring.c | 63 ++++++++++++++++++++++++++++++------
> > >  include/linux/virtio.h       | 10 ++++++
> > >  3 files changed, 70 insertions(+), 9 deletions(-)
> > >
> > > diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
> > > index 0a5b54034d4b..04bcb74e5b9a 100644
> > > --- a/drivers/virtio/virtio.c
> > > +++ b/drivers/virtio/virtio.c
> > > @@ -431,6 +431,12 @@ bool is_virtio_device(struct device *dev)
> > >  }
> > >  EXPORT_SYMBOL_GPL(is_virtio_device);
> > >
> > > +void virtio_use_desc_cache(struct virtio_device *dev, bool val)
> > > +{
> > > +     dev->desc_cache = val;
> > > +}
> > > +EXPORT_SYMBOL_GPL(virtio_use_desc_cache);
> > > +
> > >  void unregister_virtio_device(struct virtio_device *dev)
> > >  {
> > >       int index = dev->index; /* save for after device release */
> > > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > > index dd95dfd85e98..0b9a8544b0e8 100644
> > > --- a/drivers/virtio/virtio_ring.c
> > > +++ b/drivers/virtio/virtio_ring.c
> > > @@ -117,6 +117,10 @@ struct vring_virtqueue {
> > >       /* Hint for event idx: already triggered no need to disable. */
> > >       bool event_triggered;
> > >
> > > +     /* Is indirect cache used? */
> > > +     bool use_desc_cache;
> > > +     void *desc_cache_chain;
> > > +
> > >       union {
> > >               /* Available for split ring */
> > >               struct {
> > > @@ -423,12 +427,47 @@ static unsigned int vring_unmap_one_split(const struct vring_virtqueue *vq,
> > >       return extra[i].next;
> > >  }
> > >
> > > -static struct vring_desc *alloc_indirect_split(struct virtqueue *_vq,
> > > +#define VIRT_QUEUE_CACHE_DESC_NUM 4
> > > +
> > > +static void desc_cache_chain_free_split(void *chain)
> > > +{
> > > +     struct vring_desc *desc;
> > > +
> > > +     while (chain) {
> > > +             desc = chain;
> > > +             chain = (void *)desc->addr;
> > > +             kfree(desc);
> > > +     }
> > > +}
> > > +
> > > +static void desc_cache_put_split(struct vring_virtqueue *vq,
> > > +                              struct vring_desc *desc, int n)
> > > +{
> > > +     if (vq->use_desc_cache && n <= VIRT_QUEUE_CACHE_DESC_NUM) {
> > > +             desc->addr = (u64)vq->desc_cache_chain;
> > > +             vq->desc_cache_chain = desc;
> > > +     } else {
> > > +             kfree(desc);
> > > +     }
> > > +}
> > > +
> >
> >
> > So I have a question here. What happens if we just do:
> >
> > if (n <= VIRT_QUEUE_CACHE_DESC_NUM) {
> >         return kmem_cache_alloc(VIRT_QUEUE_CACHE_DESC_NUM * sizeof desc, gfp)
> > } else {
> >         return kmalloc_arrat(n, sizeof desc, gfp)
> > }
> >
> > A small change and won't we reap most performance benefits?
>
> Yes, I think we need a benchmark to use private cache to see how much
> it can help.

I did a test, the code is as follows:

+static void desc_cache_put_packed(struct vring_virtqueue *vq,
+                                  struct vring_packed_desc *desc, int n)
+ {
+       if (n <= VIRT_QUEUE_CACHE_DESC_NUM) {
+               kmem_cache_free(vq->desc_cache, desc);
+       } else {
+               kfree(desc);
+       }


@@ -476,11 +452,14 @@ static struct vring_desc *alloc_indirect_split(struct vring_virtqueue *vq,
         */
        gfp &= ~__GFP_HIGHMEM;

-       desc = kmalloc_array(n, sizeof(struct vring_desc), gfp);
+       if (total_sg <= VIRT_QUEUE_CACHE_DESC_NUM)
+               desc = kmem_cache_alloc(vq->desc_cache, gfp);
+       else
+               desc = kmalloc_array(total_sg, sizeof(struct vring_desc), gfp);
+

	.......

+       vq->desc_cache = kmem_cache_create("virio_desc",
+                                          4 * sizeof(struct vring_desc),
+                                          0, 0, NULL);

The effect is not good, basically there is no improvement, using perf top can
see that the overhead of kmem_cache_alloc/kmem_cache_free is also relatively
large:

         26.91%  [kernel]  [k] virtqueue_add
         15.35%  [kernel]  [k] detach_buf_split
         14.15%  [kernel]  [k] virtnet_xsk_xmit
         13.24%  [kernel]  [k] virtqueue_add_outbuf
       >  9.30%  [kernel]  [k] __slab_free
       >  3.91%  [kernel]  [k] kmem_cache_alloc
          2.85%  [kernel]  [k] virtqueue_get_buf_ctx
       >  2.82%  [kernel]  [k] kmem_cache_free
          2.54%  [kernel]  [k] memset_erms
          2.37%  [kernel]  [k] xsk_tx_peek_desc
          1.20%  [kernel]  [k] virtnet_xsk_run
          0.81%  [kernel]  [k] vring_map_one_sg
          0.69%  [kernel]  [k] __free_old_xmit_ptr
          0.69%  [kernel]  [k] virtqueue_kick_prepare
          0.43%  [kernel]  [k] sg_init_table
          0.41%  [kernel]  [k] sg_next
          0.28%  [kernel]  [k] vring_unmap_one_split
          0.25%  [kernel]  [k] vring_map_single.constprop.34
          0.24%  [kernel]  [k] net_rx_action

Thanks.

>
> Thanks
>
> >
> > --
> > MST
> >
>
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

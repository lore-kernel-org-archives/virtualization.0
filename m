Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBB99C76196
	for <virtualization@archiver.kernel.org>; Fri, 31 Mar 2023 03:39:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4262860FC7;
	Fri, 31 Mar 2023 03:39:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4262860FC7
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9rQm3vJXwX1C; Fri, 31 Mar 2023 03:39:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 7F58660EA1;
	Fri, 31 Mar 2023 03:39:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7F58660EA1
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 522DEC007C;
	Fri, 31 Mar 2023 03:39:16 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 06857C002F
 for <virtualization@lists.linux-foundation.org>;
 Fri, 31 Mar 2023 03:39:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id AE755414EA
 for <virtualization@lists.linux-foundation.org>;
 Fri, 31 Mar 2023 03:39:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org AE755414EA
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id awyoOW8-WEVT
 for <virtualization@lists.linux-foundation.org>;
 Fri, 31 Mar 2023 03:39:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 441C2411A6
Received: from out30-113.freemail.mail.aliyun.com
 (out30-113.freemail.mail.aliyun.com [115.124.30.113])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 441C2411A6
 for <virtualization@lists.linux-foundation.org>;
 Fri, 31 Mar 2023 03:39:07 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R871e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018045176;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=8; SR=0;
 TI=SMTPD_---0Vf0WLRw_1680233941; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0Vf0WLRw_1680233941) by smtp.aliyun-inc.com;
 Fri, 31 Mar 2023 11:39:02 +0800
Message-ID: <1680233916.7234168-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH v3 3/4] virtio: fix up virtio_disable_cb
Date: Fri, 31 Mar 2023 11:38:36 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20210526082423.47837-1-mst@redhat.com>
 <20210526082423.47837-4-mst@redhat.com>
 <1680156457.5551112-5-xuanzhuo@linux.alibaba.com>
 <20230330024220-mutt-send-email-mst@kernel.org>
 <1680159261.1588428-1-xuanzhuo@linux.alibaba.com>
 <20230330100219-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230330100219-mutt-send-email-mst@kernel.org>
Cc: Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Jakub Kicinski <kuba@kernel.org>, Wei Wang <weiwan@google.com>,
 David Miller <davem@davemloft.net>
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

On Thu, 30 Mar 2023 10:04:03 -0400, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> On Thu, Mar 30, 2023 at 02:54:21PM +0800, Xuan Zhuo wrote:
> > On Thu, 30 Mar 2023 02:44:44 -0400, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > > On Thu, Mar 30, 2023 at 02:07:37PM +0800, Xuan Zhuo wrote:
> > > > On Wed, 26 May 2021 04:24:40 -0400, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > > > > virtio_disable_cb is currently a nop for split ring with event index.
> > > > > This is because it used to be always called from a callback when we know
> > > > > device won't trigger more events until we update the index.  However,
> > > > > now that we run with interrupts enabled a lot we also poll without a
> > > > > callback so that is different: disabling callbacks will help reduce the
> > > > > number of spurious interrupts.
> > > > > Further, if using event index with a packed ring, and if being called
> > > > > from a callback, we actually do disable interrupts which is unnecessary.
> > > > >
> > > > > Fix both issues by tracking whenever we get a callback. If that is
> > > > > the case disabling interrupts with event index can be a nop.
> > > > > If not the case disable interrupts. Note: with a split ring
> > > > > there's no explicit "no interrupts" value. For now we write
> > > > > a fixed value so our chance of triggering an interupt
> > > > > is 1/ring size. It's probably better to write something
> > > > > related to the last used index there to reduce the chance
> > > > > even further. For now I'm keeping it simple.
> > > >
> > > >
> > > > Don't understand, is this patch necessary? For this patch set, we can do without
> > > > this patch.
> > > >
> > > > So doest this patch optimize virtqueue_disable_cb() by reducing a modification of
> > > > vring_used_event(&vq-> split.vring)?
> > > >
> > > > Or I miss something.
> > > >
> > > > Thanks.
> > >
> > > Before this patch virtqueue_disable_cb did nothing at all
> > > for the common case of event index enabled, so
> > > calling it from virtio net would not help matters.
> >
> > I agree with these codes:
> >
> > -		if (!vq->event)
> > +		if (vq->event)
> > +			/* TODO: this is a hack. Figure out a cleaner value to write. */
> > +			vring_used_event(&vq->split.vring) = 0x0;
> > +		else
> >
> >
> > I just don't understand event_triggered.
>
>
> The comment near it says it all:
>         /* Hint for event idx: already triggered no need to disable. */
> the write into event idx is potentially expensive since it can
> invalidate cache for another processor (depending on the CPU).

Yes, I agree.

Thanks.


>
> > >
> > > But the patch is from 2021, isn't it a bit too late to argue?
> > > If you have a cleanup or an optimization in mind, please
> > > post a patch.
> >
> > Sorry, I just have some problems, I don't oppose it. At least it can reduce the
> > modification of vring_used_event(&vq->split.vring). I think it is also beneficial.
> >
> > Thanks very much.
> >
> >
> > >
> > > > >
> > > > > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > > > > ---
> > > > >  drivers/virtio/virtio_ring.c | 26 +++++++++++++++++++++++++-
> > > > >  1 file changed, 25 insertions(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > > > > index 71e16b53e9c1..88f0b16b11b8 100644
> > > > > --- a/drivers/virtio/virtio_ring.c
> > > > > +++ b/drivers/virtio/virtio_ring.c
> > > > > @@ -113,6 +113,9 @@ struct vring_virtqueue {
> > > > >  	/* Last used index we've seen. */
> > > > >  	u16 last_used_idx;
> > > > >
> > > > > +	/* Hint for event idx: already triggered no need to disable. */
> > > > > +	bool event_triggered;
> > > > > +
> > > > >  	union {
> > > > >  		/* Available for split ring */
> > > > >  		struct {
> > > > > @@ -739,7 +742,10 @@ static void virtqueue_disable_cb_split(struct virtqueue *_vq)
> > > > >
> > > > >  	if (!(vq->split.avail_flags_shadow & VRING_AVAIL_F_NO_INTERRUPT)) {
> > > > >  		vq->split.avail_flags_shadow |= VRING_AVAIL_F_NO_INTERRUPT;
> > > > > -		if (!vq->event)
> > > > > +		if (vq->event)
> > > > > +			/* TODO: this is a hack. Figure out a cleaner value to write. */
> > > > > +			vring_used_event(&vq->split.vring) = 0x0;
> > > > > +		else
> > > > >  			vq->split.vring.avail->flags =
> > > > >  				cpu_to_virtio16(_vq->vdev,
> > > > >  						vq->split.avail_flags_shadow);
> > > > > @@ -1605,6 +1611,7 @@ static struct virtqueue *vring_create_virtqueue_packed(
> > > > >  	vq->weak_barriers = weak_barriers;
> > > > >  	vq->broken = false;
> > > > >  	vq->last_used_idx = 0;
> > > > > +	vq->event_triggered = false;
> > > > >  	vq->num_added = 0;
> > > > >  	vq->packed_ring = true;
> > > > >  	vq->use_dma_api = vring_use_dma_api(vdev);
> > > > > @@ -1919,6 +1926,12 @@ void virtqueue_disable_cb(struct virtqueue *_vq)
> > > > >  {
> > > > >  	struct vring_virtqueue *vq = to_vvq(_vq);
> > > > >
> > > > > +	/* If device triggered an event already it won't trigger one again:
> > > > > +	 * no need to disable.
> > > > > +	 */
> > > > > +	if (vq->event_triggered)
> > > > > +		return;
> > > > > +
> > > > >  	if (vq->packed_ring)
> > > > >  		virtqueue_disable_cb_packed(_vq);
> > > > >  	else
> > > > > @@ -1942,6 +1955,9 @@ unsigned virtqueue_enable_cb_prepare(struct virtqueue *_vq)
> > > > >  {
> > > > >  	struct vring_virtqueue *vq = to_vvq(_vq);
> > > > >
> > > > > +	if (vq->event_triggered)
> > > > > +		vq->event_triggered = false;
> > > > > +
> > > > >  	return vq->packed_ring ? virtqueue_enable_cb_prepare_packed(_vq) :
> > > > >  				 virtqueue_enable_cb_prepare_split(_vq);
> > > > >  }
> > > > > @@ -2005,6 +2021,9 @@ bool virtqueue_enable_cb_delayed(struct virtqueue *_vq)
> > > > >  {
> > > > >  	struct vring_virtqueue *vq = to_vvq(_vq);
> > > > >
> > > > > +	if (vq->event_triggered)
> > > > > +		vq->event_triggered = false;
> > > > > +
> > > > >  	return vq->packed_ring ? virtqueue_enable_cb_delayed_packed(_vq) :
> > > > >  				 virtqueue_enable_cb_delayed_split(_vq);
> > > > >  }
> > > > > @@ -2044,6 +2063,10 @@ irqreturn_t vring_interrupt(int irq, void *_vq)
> > > > >  	if (unlikely(vq->broken))
> > > > >  		return IRQ_HANDLED;
> > > > >
> > > > > +	/* Just a hint for performance: so it's ok that this can be racy! */
> > > > > +	if (vq->event)
> > > > > +		vq->event_triggered = true;
> > > > > +
> > > > >  	pr_debug("virtqueue callback for %p (%p)\n", vq, vq->vq.callback);
> > > > >  	if (vq->vq.callback)
> > > > >  		vq->vq.callback(&vq->vq);
> > > > > @@ -2083,6 +2106,7 @@ struct virtqueue *__vring_new_virtqueue(unsigned int index,
> > > > >  	vq->weak_barriers = weak_barriers;
> > > > >  	vq->broken = false;
> > > > >  	vq->last_used_idx = 0;
> > > > > +	vq->event_triggered = false;
> > > > >  	vq->num_added = 0;
> > > > >  	vq->use_dma_api = vring_use_dma_api(vdev);
> > > > >  #ifdef DEBUG
> > > > > --
> > > > > MST
> > > > >
> > > > > _______________________________________________
> > > > > Virtualization mailing list
> > > > > Virtualization@lists.linux-foundation.org
> > > > > https://lists.linuxfoundation.org/mailman/listinfo/virtualization
> > >
>
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86C12C6FD1D
	for <virtualization@archiver.kernel.org>; Thu, 30 Mar 2023 06:44:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A75AA41DE7;
	Thu, 30 Mar 2023 06:44:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A75AA41DE7
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=gFhtdNNC
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rXDCvEdybCuI; Thu, 30 Mar 2023 06:44:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 9E6844096C;
	Thu, 30 Mar 2023 06:44:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9E6844096C
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7F859C0036;
	Thu, 30 Mar 2023 06:44:56 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CD55EC002F
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Mar 2023 06:44:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A03A641B9B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Mar 2023 06:44:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A03A641B9B
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7wz2GaXA1abF
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Mar 2023 06:44:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2B13D4096C
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2B13D4096C
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Mar 2023 06:44:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1680158691;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uOR4AABgXY6rT1UM0saCrM1Os02S42xCRn/OKU3aRlo=;
 b=gFhtdNNCWBBXc3xbN6ie0tfBga1AfHAEYNfAUQRqEavOrEXJhN3pQ4meTMTiXsNLIUGCvF
 iitwozocJoAFl/O8GsIncSCi5UqSCNWS+KVg57ydkbJTFpRMEvh4t4yRV2fVb2HvliliO/
 c+FIEXjjvT93jwfi66pptR9E4PEmTOs=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-222-3dRXWKeNOMuRnYXJPDCPrg-1; Thu, 30 Mar 2023 02:44:50 -0400
X-MC-Unique: 3dRXWKeNOMuRnYXJPDCPrg-1
Received: by mail-wm1-f72.google.com with SMTP id
 e5-20020a05600c4e4500b003edc5824521so9929574wmq.0
 for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Mar 2023 23:44:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1680158689;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uOR4AABgXY6rT1UM0saCrM1Os02S42xCRn/OKU3aRlo=;
 b=i97xAckhbhdEhpUREwO4EO6G6ArFd+UBNAqcUTdrpZxQ4FjnfDhtQ4taiK8PVxLXlg
 cvLFdz0C9NsVK81fgUq29Y63etF6A6TK8aYtDqI1yccpMkbmjKuW9O1zVt2Sc0g3MesY
 xOK35qAGhtUyoP9ydX5aVd73u3wUzqDmfWFp9fFdIyDCLyaIXji4uZxKpZFqtXWaylWu
 EPzgG3DkGsbknSaMzkSEyUWwF9eSkLSWagrLFm7CAGL9+6Ay7SnvNQRM0kX+WQhik01x
 zkSH5gq7W/dWdgIGzt9znaRC0BXieBraSuwhhr6FTVRb/JMcn6CS+UxCO5JtWjSRQhFM
 H88w==
X-Gm-Message-State: AAQBX9ce7Y6WEZOQAUOSY00dJ2pI6DpIdPdboAU9wbGI5+UOjEq/ca4S
 RItWlTo3LXD5bspQgqR4YneWl7Nq9ziO8P/CATQ5T50Uj310P609hcc0enRgZtp6SfQfvhqwk2N
 6fMOH2Rcb8xA2oQyIUeHxT5doRVGp6pRfd4SrUx1GKw==
X-Received: by 2002:a7b:c045:0:b0:3ef:6fee:8057 with SMTP id
 u5-20020a7bc045000000b003ef6fee8057mr9121729wmc.25.1680158688799; 
 Wed, 29 Mar 2023 23:44:48 -0700 (PDT)
X-Google-Smtp-Source: AKy350b9YXLwf8YQAIK1wJbojYDvpMv6wMNdBsep+spzdVpXknozxcuIotMCTlq+T8/9wIqhpHiyXQ==
X-Received: by 2002:a7b:c045:0:b0:3ef:6fee:8057 with SMTP id
 u5-20020a7bc045000000b003ef6fee8057mr9121710wmc.25.1680158688488; 
 Wed, 29 Mar 2023 23:44:48 -0700 (PDT)
Received: from redhat.com ([2.52.159.107]) by smtp.gmail.com with ESMTPSA id
 f17-20020a05600c4e9100b003ede3f5c81fsm5062688wmq.41.2023.03.29.23.44.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Mar 2023 23:44:47 -0700 (PDT)
Date: Thu, 30 Mar 2023 02:44:44 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH v3 3/4] virtio: fix up virtio_disable_cb
Message-ID: <20230330024220-mutt-send-email-mst@kernel.org>
References: <20210526082423.47837-1-mst@redhat.com>
 <20210526082423.47837-4-mst@redhat.com>
 <1680156457.5551112-5-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <1680156457.5551112-5-xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Thu, Mar 30, 2023 at 02:07:37PM +0800, Xuan Zhuo wrote:
> On Wed, 26 May 2021 04:24:40 -0400, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > virtio_disable_cb is currently a nop for split ring with event index.
> > This is because it used to be always called from a callback when we know
> > device won't trigger more events until we update the index.  However,
> > now that we run with interrupts enabled a lot we also poll without a
> > callback so that is different: disabling callbacks will help reduce the
> > number of spurious interrupts.
> > Further, if using event index with a packed ring, and if being called
> > from a callback, we actually do disable interrupts which is unnecessary.
> >
> > Fix both issues by tracking whenever we get a callback. If that is
> > the case disabling interrupts with event index can be a nop.
> > If not the case disable interrupts. Note: with a split ring
> > there's no explicit "no interrupts" value. For now we write
> > a fixed value so our chance of triggering an interupt
> > is 1/ring size. It's probably better to write something
> > related to the last used index there to reduce the chance
> > even further. For now I'm keeping it simple.
> 
> 
> Don't understand, is this patch necessary? For this patch set, we can do without
> this patch.
> 
> So doest this patch optimize virtqueue_disable_cb() by reducing a modification of
> vring_used_event(&vq-> split.vring)?
> 
> Or I miss something.
> 
> Thanks.

Before this patch virtqueue_disable_cb did nothing at all
for the common case of event index enabled, so
calling it from virtio net would not help matters.

But the patch is from 2021, isn't it a bit too late to argue?
If you have a cleanup or an optimization in mind, please
post a patch.

> >
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> >  drivers/virtio/virtio_ring.c | 26 +++++++++++++++++++++++++-
> >  1 file changed, 25 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > index 71e16b53e9c1..88f0b16b11b8 100644
> > --- a/drivers/virtio/virtio_ring.c
> > +++ b/drivers/virtio/virtio_ring.c
> > @@ -113,6 +113,9 @@ struct vring_virtqueue {
> >  	/* Last used index we've seen. */
> >  	u16 last_used_idx;
> >
> > +	/* Hint for event idx: already triggered no need to disable. */
> > +	bool event_triggered;
> > +
> >  	union {
> >  		/* Available for split ring */
> >  		struct {
> > @@ -739,7 +742,10 @@ static void virtqueue_disable_cb_split(struct virtqueue *_vq)
> >
> >  	if (!(vq->split.avail_flags_shadow & VRING_AVAIL_F_NO_INTERRUPT)) {
> >  		vq->split.avail_flags_shadow |= VRING_AVAIL_F_NO_INTERRUPT;
> > -		if (!vq->event)
> > +		if (vq->event)
> > +			/* TODO: this is a hack. Figure out a cleaner value to write. */
> > +			vring_used_event(&vq->split.vring) = 0x0;
> > +		else
> >  			vq->split.vring.avail->flags =
> >  				cpu_to_virtio16(_vq->vdev,
> >  						vq->split.avail_flags_shadow);
> > @@ -1605,6 +1611,7 @@ static struct virtqueue *vring_create_virtqueue_packed(
> >  	vq->weak_barriers = weak_barriers;
> >  	vq->broken = false;
> >  	vq->last_used_idx = 0;
> > +	vq->event_triggered = false;
> >  	vq->num_added = 0;
> >  	vq->packed_ring = true;
> >  	vq->use_dma_api = vring_use_dma_api(vdev);
> > @@ -1919,6 +1926,12 @@ void virtqueue_disable_cb(struct virtqueue *_vq)
> >  {
> >  	struct vring_virtqueue *vq = to_vvq(_vq);
> >
> > +	/* If device triggered an event already it won't trigger one again:
> > +	 * no need to disable.
> > +	 */
> > +	if (vq->event_triggered)
> > +		return;
> > +
> >  	if (vq->packed_ring)
> >  		virtqueue_disable_cb_packed(_vq);
> >  	else
> > @@ -1942,6 +1955,9 @@ unsigned virtqueue_enable_cb_prepare(struct virtqueue *_vq)
> >  {
> >  	struct vring_virtqueue *vq = to_vvq(_vq);
> >
> > +	if (vq->event_triggered)
> > +		vq->event_triggered = false;
> > +
> >  	return vq->packed_ring ? virtqueue_enable_cb_prepare_packed(_vq) :
> >  				 virtqueue_enable_cb_prepare_split(_vq);
> >  }
> > @@ -2005,6 +2021,9 @@ bool virtqueue_enable_cb_delayed(struct virtqueue *_vq)
> >  {
> >  	struct vring_virtqueue *vq = to_vvq(_vq);
> >
> > +	if (vq->event_triggered)
> > +		vq->event_triggered = false;
> > +
> >  	return vq->packed_ring ? virtqueue_enable_cb_delayed_packed(_vq) :
> >  				 virtqueue_enable_cb_delayed_split(_vq);
> >  }
> > @@ -2044,6 +2063,10 @@ irqreturn_t vring_interrupt(int irq, void *_vq)
> >  	if (unlikely(vq->broken))
> >  		return IRQ_HANDLED;
> >
> > +	/* Just a hint for performance: so it's ok that this can be racy! */
> > +	if (vq->event)
> > +		vq->event_triggered = true;
> > +
> >  	pr_debug("virtqueue callback for %p (%p)\n", vq, vq->vq.callback);
> >  	if (vq->vq.callback)
> >  		vq->vq.callback(&vq->vq);
> > @@ -2083,6 +2106,7 @@ struct virtqueue *__vring_new_virtqueue(unsigned int index,
> >  	vq->weak_barriers = weak_barriers;
> >  	vq->broken = false;
> >  	vq->last_used_idx = 0;
> > +	vq->event_triggered = false;
> >  	vq->num_added = 0;
> >  	vq->use_dma_api = vring_use_dma_api(vdev);
> >  #ifdef DEBUG
> > --
> > MST
> >
> > _______________________________________________
> > Virtualization mailing list
> > Virtualization@lists.linux-foundation.org
> > https://lists.linuxfoundation.org/mailman/listinfo/virtualization

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

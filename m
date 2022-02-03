Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88B83C433EF
	for <virtualization@archiver.kernel.org>; Thu,  3 Feb 2022 11:32:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 27E1460FD8;
	Thu,  3 Feb 2022 11:32:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Q-oyYRypLP_C; Thu,  3 Feb 2022 11:32:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 767C360774;
	Thu,  3 Feb 2022 11:32:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4CD05C001A;
	Thu,  3 Feb 2022 11:32:40 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E85F3C000B
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Feb 2022 11:32:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id CFAB584060
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Feb 2022 11:32:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cEHRCN4RGmxM
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Feb 2022 11:32:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D676E84059
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Feb 2022 11:32:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1643887956;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=itWiruytU2kLGOGapHpMQOUeYdsg6uAbojfcTpmhA2E=;
 b=TbI7e/nlDzsEU3kHhROZ8iXIB2Tf0jx5o8VMrkc8Of31Ihru2HVJWQI6gs8DvnN8ttwi7M
 p9IjKYiX3P/Dc0QqFOmVqXP9HNWBYdF+pclEbYDQ6wN8WyrTKVMbFjoBFq5BQu70rakZpG
 2tzM/J3pkjGCZn1HEg1UQ9YHMLSeSgw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-670-XEc_6PH2OiqlyvRtN-_-cg-1; Thu, 03 Feb 2022 06:32:35 -0500
X-MC-Unique: XEc_6PH2OiqlyvRtN-_-cg-1
Received: by mail-wm1-f69.google.com with SMTP id
 m20-20020a05600c3b1400b003539593ea39so663464wms.0
 for <virtualization@lists.linux-foundation.org>;
 Thu, 03 Feb 2022 03:32:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=itWiruytU2kLGOGapHpMQOUeYdsg6uAbojfcTpmhA2E=;
 b=7jMG68r4QDZDZ97CH6tcfzJIuKcY5M7E4qndnI357gjIGxX2O1n0rSt9urv0F5zlWP
 zARw99OwvScA55+oeDw/I23wSSWdqJFVBG1zP5IPdwFwC0VLHY7LxVga9LHxPaeBnp8T
 zRtQgMeZs7S+uhcnKFMuM6KCCiLzyDU3daagOV7Xr2YRXc2rPs74ftvgRRqaRoZAZZ7B
 3pCywA5ELL9lJ4aw6T7xLh5w1PkhUEPQECfqhJuE9niolSvv4uiQ/I62hnNkNPFMLw8N
 COISlKU+qhUuubk2UqlI0+6PUJkmEdhRf3e2IXJAeDcPnjKQbbKIKV/EIKgyoJzPma4x
 Wvig==
X-Gm-Message-State: AOAM530TD3TFV83bu2jC0g6X2dkWM7mdDfFM8XdAn3cBjlnNgqA+kYez
 h+HlHiuNBZs/Jk/6acsVC3859SPLFwk/E92sugZP9lfE1BYYoDq14ivovoKfiM8Bu7y2tQBiz6M
 ulNoPe1JmHR3vJfZRUfDtb7x4mN6/jhKsGZ9/wmBRAw==
X-Received: by 2002:a5d:588e:: with SMTP id n14mr30777351wrf.45.1643887954390; 
 Thu, 03 Feb 2022 03:32:34 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzdLaO64Cw0scAK+697PXreQjSocOclVGkxGWknz3mN3YgqgeWd6Q25NgJrPtGirlAqR87WZw==
X-Received: by 2002:a5d:588e:: with SMTP id n14mr30777336wrf.45.1643887954184; 
 Thu, 03 Feb 2022 03:32:34 -0800 (PST)
Received: from redhat.com ([2.52.9.182])
 by smtp.gmail.com with ESMTPSA id bg23sm8886500wmb.5.2022.02.03.03.32.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Feb 2022 03:32:33 -0800 (PST)
Date: Thu, 3 Feb 2022 06:32:29 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Cristian Marussi <cristian.marussi@arm.com>
Subject: Re: [PATCH v2 3/9] [RFC] virtio_ring: Embed a wrap counter in opaque
 poll index value
Message-ID: <20220203063115-mutt-send-email-mst@kernel.org>
References: <20220201171601.53316-1-cristian.marussi@arm.com>
 <20220201171601.53316-4-cristian.marussi@arm.com>
 <20220201131434-mutt-send-email-mst@kernel.org>
 <20220203105105.GB2535@e120937-lin>
MIME-Version: 1.0
In-Reply-To: <20220203105105.GB2535@e120937-lin>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: f.fainelli@gmail.com, vincent.guittot@linaro.org,
 igor.skalkin@opensynergy.com, sudeep.holla@arm.com,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 peter.hilber@opensynergy.com, james.quinlan@broadcom.com,
 Jonathan.Cameron@huawei.com, souvik.chakravarty@arm.com,
 etienne.carriere@linaro.org, linux-arm-kernel@lists.infradead.org
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

On Thu, Feb 03, 2022 at 10:51:19AM +0000, Cristian Marussi wrote:
> On Tue, Feb 01, 2022 at 01:27:38PM -0500, Michael S. Tsirkin wrote:
> > Looks correct, thanks. Some minor comments below:
> > 
> 
> Hi Michael,
> 
> thanks for the feedback.
> 
> > On Tue, Feb 01, 2022 at 05:15:55PM +0000, Cristian Marussi wrote:
> > > Exported API virtqueue_poll() can be used to support polling mode operation
> > > on top of virtio layer if needed; currently the parameter last_used_idx is
> > > the opaque value that needs to be passed to the virtqueue_poll() function
> > > to check if there are new pending used buffers in the queue: such opaque
> > > value would have been previously obtained by a call to the API function
> > > virtqueue_enable_cb_prepare().
> > > 
> > > Since such opaque value is indeed containing simply a snapshot in time of
> > > the internal
> > 
> > to add: 16 bit
> > 
> > > last_used_index (roughly), it is possible that,
> > 
> > to add here: 
> > 
> > if another thread calls virtqueue_add_*()
> > at the same time (which existing drivers don't do,
> > but does not seem to be documented as prohibited anywhere), and
> > 
> > > if exactly
> > > 2**16 buffers are marked as used between two successive calls to
> > > virtqueue_poll(), the caller is fooled into thinking that nothing is
> > > pending (ABA problem).
> > > Keep a full fledged internal wraps counter
> > 
> > s/full fledged/a 16 bit/
> > 
> > since I don't see why is a 16 bit counter full but not e.g. a 32 bit one
> > 
> .. :D I wanted to stress the fact that this being a 16bits counter has a
> higher rollover than a 1-bit one wrap_counter already used...but indeed
> all are just counters at the end, it's justthe wrapround that changes...
> 
> I'll fix.
> 
> > > per virtqueue and embed it into
> > > the upper 16bits of the returned opaque value, so that the above scenario
> > > can be detected transparently by virtqueue_poll(): this way each single
> > > possible last_used_idx value is really belonging to a different wrap.
> > 
> > Just to add here: the ABA problem can in theory still happen but
> > now that's after 2^32 requests, which seems sufficient in practice.
> > 
> 
> Sure, I'll fix the commit message as above advised.
> 
> > > Cc: "Michael S. Tsirkin" <mst@redhat.com>
> > > Cc: Igor Skalkin <igor.skalkin@opensynergy.com>
> > > Cc: Peter Hilber <peter.hilber@opensynergy.com>
> > > Cc: virtualization@lists.linux-foundation.org
> > > Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> > > ---
> > > Still no perf data on this, I was wondering what exactly to measure in
> > > term of perf metrics to evaluate the impact of the rolling vq->wraps
> > > counter.
> > > ---
> > >  drivers/virtio/virtio_ring.c | 51 +++++++++++++++++++++++++++++++++---
> > >  1 file changed, 47 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > > index 00f64f2f8b72..613ec0503509 100644
> > > --- a/drivers/virtio/virtio_ring.c
> > > +++ b/drivers/virtio/virtio_ring.c
> > > @@ -12,6 +12,8 @@
> > >  #include <linux/hrtimer.h>
> > >  #include <linux/dma-mapping.h>
> > >  #include <linux/spinlock.h>
> > > +#include <linux/bits.h>
> > > +#include <linux/bitfield.h>
> > >  #include <xen/xen.h>
> > >  
> > >  static bool force_used_validation = false;
> > > @@ -69,6 +71,17 @@ module_param(force_used_validation, bool, 0444);
> > >  #define LAST_ADD_TIME_INVALID(vq)
> > >  #endif
> > >  
> > > +#define VRING_IDX_MASK					GENMASK(15, 0)
> > > +#define VRING_GET_IDX(opaque)				\
> > > +	((u16)FIELD_GET(VRING_IDX_MASK, (opaque)))
> > > +
> > > +#define VRING_WRAPS_MASK				GENMASK(31, 16)
> > > +#define VRING_GET_WRAPS(opaque)				\
> > > +	((u16)FIELD_GET(VRING_WRAPS_MASK, (opaque)))
> > > +
> > > +#define VRING_BUILD_OPAQUE(idx, wraps)			\
> > > +	(FIELD_PREP(VRING_WRAPS_MASK, (wraps)) | ((idx) & VRING_IDX_MASK))
> > > +
> > 
> > Maybe prefix with VRING_POLL_  since that is the only user.
> > 
> 
> I'll do.
> 
> > 
> > >  struct vring_desc_state_split {
> > >  	void *data;			/* Data for callback. */
> > >  	struct vring_desc *indir_desc;	/* Indirect descriptor, if any. */
> > > @@ -117,6 +130,8 @@ struct vring_virtqueue {
> > >  	/* Last used index we've seen. */
> > >  	u16 last_used_idx;
> > >  
> > > +	u16 wraps;
> > > +
> > >  	/* Hint for event idx: already triggered no need to disable. */
> > >  	bool event_triggered;
> > >  
> > > @@ -806,6 +821,8 @@ static void *virtqueue_get_buf_ctx_split(struct virtqueue *_vq,
> > >  	ret = vq->split.desc_state[i].data;
> > >  	detach_buf_split(vq, i, ctx);
> > >  	vq->last_used_idx++;
> > > +	if (unlikely(!vq->last_used_idx))
> > > +		vq->wraps++;
> > >  	/* If we expect an interrupt for the next entry, tell host
> > >  	 * by writing event index and flush out the write before
> > >  	 * the read in the next get_buf call. */
> > 
> > So most drivers don't call virtqueue_poll.
> > Concerned about the overhead here: another option is
> > with a flag that will have to be set whenever a driver
> > wants to use virtqueue_poll.
> 
> Do you mean a compile time flag/Kconfig to just remove the possible
> overhead instructions as a whole when not needed by the driver ?
> 
> Or do you mean at runtime since checking the flag evry time should be
> less costly than checking the wrpas each time AND counting when it
> happens ?

The later.

> > Could you pls do a quick perf test e.g. using tools/virtio/
> > to see what's faster?
> 
> Yes I'll do, thanks for the hint, I have some compilation issues in
> tools/virtio due to my additions (missing mirrored hehaders) or to some
> recently added stuff (missing drv_to_virtio & friends for
> suppressed_used_validation thing)...anyway I fixed those now and I'll
> post related tools/virtio patches with next iteration.
> 
> Anyway, do you mean perf data about vringh_test and virtio_test/vhost
> right ? (ringtest/ excluded 'cause does not use any API is just
> prototyping)

can be either or both, virtio_test/vhost is a bit easier to use.

> > 
> > 
> > 
> > > @@ -1508,6 +1525,7 @@ static void *virtqueue_get_buf_ctx_packed(struct virtqueue *_vq,
> > >  	if (unlikely(vq->last_used_idx >= vq->packed.vring.num)) {
> > >  		vq->last_used_idx -= vq->packed.vring.num;
> > >  		vq->packed.used_wrap_counter ^= 1;
> > > +		vq->wraps++;
> > >  	}
> > >  
> > >  	/*
> > > @@ -1744,6 +1762,7 @@ static struct virtqueue *vring_create_virtqueue_packed(
> > >  	vq->weak_barriers = weak_barriers;
> > >  	vq->broken = false;
> > >  	vq->last_used_idx = 0;
> > > +	vq->wraps = 0;
> > >  	vq->event_triggered = false;
> > >  	vq->num_added = 0;
> > >  	vq->packed_ring = true;
> > > @@ -2092,13 +2111,17 @@ EXPORT_SYMBOL_GPL(virtqueue_disable_cb);
> > >   */
> > >  unsigned virtqueue_enable_cb_prepare(struct virtqueue *_vq)
> > >  {
> > > +	unsigned int last_used_idx;
> > >  	struct vring_virtqueue *vq = to_vvq(_vq);
> > >  
> > >  	if (vq->event_triggered)
> > >  		vq->event_triggered = false;
> > >  
> > > -	return vq->packed_ring ? virtqueue_enable_cb_prepare_packed(_vq) :
> > > -				 virtqueue_enable_cb_prepare_split(_vq);
> > > +	last_used_idx = vq->packed_ring ?
> > > +			virtqueue_enable_cb_prepare_packed(_vq) :
> > > +			virtqueue_enable_cb_prepare_split(_vq);
> > > +
> > > +	return VRING_BUILD_OPAQUE(last_used_idx, vq->wraps);
> > >  }
> > >  EXPORT_SYMBOL_GPL(virtqueue_enable_cb_prepare);
> > >  
> > > @@ -2107,6 +2130,21 @@ EXPORT_SYMBOL_GPL(virtqueue_enable_cb_prepare);
> > >   * @_vq: the struct virtqueue we're talking about.
> > >   * @last_used_idx: virtqueue state (from call to virtqueue_enable_cb_prepare).
> > >   *
> > > + * The provided last_used_idx, as returned by virtqueue_enable_cb_prepare(),
> > > + * is an opaque value representing the queue state and it is built as follows:
> > > + *
> > > + *	---------------------------------------------------------
> > > + *	|	vq->wraps	|	vq->last_used_idx	|
> > > + *	31------------------------------------------------------0
> > > + *
> > > + * The MSB 16bits embedding the wraps counter for the underlying virtqueue
> > > + * is stripped out here before reaching into the lower layer helpers.
> > > + *
> > > + * This structure of the opaque value mitigates the scenario in which, when
> > > + * exactly 2**16 messages are marked as used between two successive calls to
> > > + * virtqueue_poll(), the caller is fooled into thinking nothing new has arrived
> > > + * since the pure last_used_idx is exactly the same.
> > > + *
> > 
> > Do you want to move this comment to where the macros implementing it
> > are?
> > 
> 
> Sure, I'll do.
> 
> Thanks,
> Cristian

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

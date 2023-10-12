Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1300DCDB46E
	for <virtualization@archiver.kernel.org>; Thu, 12 Oct 2023 09:40:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B2462607D6;
	Thu, 12 Oct 2023 09:40:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B2462607D6
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=NN69pMtw
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BhZUurcUSfvH; Thu, 12 Oct 2023 09:40:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id C732160B45;
	Thu, 12 Oct 2023 09:40:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C732160B45
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A8302C0071;
	Thu, 12 Oct 2023 09:40:48 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3D285C0032
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Oct 2023 09:40:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 15EF740370
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Oct 2023 09:40:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 15EF740370
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=NN69pMtw
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qxqSi2Oc3ydf
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Oct 2023 09:40:46 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3A0C04026E
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Oct 2023 09:40:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3A0C04026E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697103645;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=00tS3vVt56YLB6HCDNOpijtr1BRbbD0u9qHtCnGMKDk=;
 b=NN69pMtwSQAJsyHZEhjmeVjwK857IiuTyPHzP23Ioum/cTHvWyPL371hqB0JlWOw+KoKcm
 R6Yn/WoCi9P4oN+Q+QfKhQnuqDu1H6ZZ8CwueL7prCCPDmyPRL3CvNYGxAticlkgSTV6nT
 SgtYX6SEzyf+ea8GefBM53xgSLpAghk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-614-lyombV4mMYmW2ZZhAkQAXg-1; Thu, 12 Oct 2023 05:40:43 -0400
X-MC-Unique: lyombV4mMYmW2ZZhAkQAXg-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-40652e8cb57so6727095e9.0
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Oct 2023 02:40:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697103642; x=1697708442;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=00tS3vVt56YLB6HCDNOpijtr1BRbbD0u9qHtCnGMKDk=;
 b=eIR1syyleO2hXP3uVykUzFrnxvQUb4bACaavNFahoiKAQU9oAJnVVsse5jdp8Dst2v
 MEFcAJPMrn2dMWNN2hl1eI1SdihYNHu12Fn5Qh2MqWhD8Wwr8dhechPvKbfD01yVr46U
 VPJOTuehuyAid+9BN8Fng7exqMnTdnBowUKHQZiqQJEyrgywa+f0RegfmRtK+vWo8dei
 YTHGkxf2Cits7+JwG76XnnC6czIIXvTHM0fWAAcOAO9E0nyUv6o8vg4XrD8KMuEcMuFi
 n73CI1qQbxHKcfwAQ6gH7GxltixSXbUgBya+6cHG9MfgruoWUBQt/NGNC0Ducn5BGkxi
 fLLw==
X-Gm-Message-State: AOJu0YyHaGLHUM5sd/OM2/doEm0mzTgTHVybtQOOK743YJaEgWuI6LI9
 r9EQJ/mzkjw1Qy8Xj1ud4+a92qCTF3ms0i7KIBAQhqabkjUvWgYMJP1BHRTGYWmf0F4xCMqH2RZ
 fVXnDM9iasTJ3e4gXSzGE+qYZWbMq8wYWggYg0g1xBA==
X-Received: by 2002:a05:6000:81b:b0:329:6b5b:57b8 with SMTP id
 bt27-20020a056000081b00b003296b5b57b8mr17336959wrb.25.1697103642333; 
 Thu, 12 Oct 2023 02:40:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHl7KzQPIMAq5kHVaTLlIETFIobOXBWJ/kPIl5UMZdZb+nC75A7URLvftxFpanZ8usGUXKKfg==
X-Received: by 2002:a05:6000:81b:b0:329:6b5b:57b8 with SMTP id
 bt27-20020a056000081b00b003296b5b57b8mr17336944wrb.25.1697103641913; 
 Thu, 12 Oct 2023 02:40:41 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73d2:bf00:e379:826:5137:6b23])
 by smtp.gmail.com with ESMTPSA id
 t4-20020a5d6904000000b0032710f5584fsm17786997wru.25.2023.10.12.02.40.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Oct 2023 02:40:41 -0700 (PDT)
Date: Thu, 12 Oct 2023 05:40:38 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH vhost 01/22] virtio_ring: virtqueue_set_dma_premapped
 support disable
Message-ID: <20231012053812-mutt-send-email-mst@kernel.org>
References: <20231011092728.105904-1-xuanzhuo@linux.alibaba.com>
 <20231011092728.105904-2-xuanzhuo@linux.alibaba.com>
 <20231012051416-mutt-send-email-mst@kernel.org>
 <1697102334.7060938-2-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <1697102334.7060938-2-xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
 John Fastabend <john.fastabend@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
 virtualization@lists.linux-foundation.org, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, bpf@vger.kernel.org,
 Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>
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

On Thu, Oct 12, 2023 at 05:18:54PM +0800, Xuan Zhuo wrote:
> On Thu, 12 Oct 2023 05:15:52 -0400, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > On Wed, Oct 11, 2023 at 05:27:07PM +0800, Xuan Zhuo wrote:
> > > virtqueue_set_dma_premapped() adds a new parameter to disable the
> > > virtqueue premapped mode.
> > >
> > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > ---
> > >  drivers/net/virtio_net.c     |  2 +-
> > >  drivers/virtio/virtio_ring.c | 11 ++++++++---
> > >  include/linux/virtio.h       |  2 +-
> > >  3 files changed, 10 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > index fe7f314d65c9..6b5f47ebf9b2 100644
> > > --- a/drivers/net/virtio_net.c
> > > +++ b/drivers/net/virtio_net.c
> > > @@ -737,7 +737,7 @@ static void virtnet_rq_set_premapped(struct virtnet_info *vi)
> > >  		return;
> > >
> > >  	for (i = 0; i < vi->max_queue_pairs; i++) {
> > > -		if (virtqueue_set_dma_premapped(vi->rq[i].vq))
> > > +		if (virtqueue_set_dma_premapped(vi->rq[i].vq, true))
> > >  			continue;
> > >
> > >  		vi->rq[i].do_dma = true;
> > > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > > index 51d8f3299c10..b3ded56722f4 100644
> > > --- a/drivers/virtio/virtio_ring.c
> > > +++ b/drivers/virtio/virtio_ring.c
> > > @@ -2784,7 +2784,7 @@ EXPORT_SYMBOL_GPL(virtqueue_resize);
> > >   * 0: success.
> > >   * -EINVAL: vring does not use the dma api, so we can not enable premapped mode.
> > >   */
> > > -int virtqueue_set_dma_premapped(struct virtqueue *_vq)
> > > +int virtqueue_set_dma_premapped(struct virtqueue *_vq, bool mode)
> > >  {
> > >  	struct vring_virtqueue *vq = to_vvq(_vq);
> > >  	u32 num;
> > > @@ -2803,8 +2803,13 @@ int virtqueue_set_dma_premapped(struct virtqueue *_vq)
> > >  		return -EINVAL;
> > >  	}
> > >
> > > -	vq->premapped = true;
> > > -	vq->do_unmap = false;
> > > +	if (mode) {
> > > +		vq->premapped = true;
> > > +		vq->do_unmap = false;
> > > +	} else {
> > > +		vq->premapped = false;
> > > +		vq->do_unmap = vq->use_dma_api;
> > > +	}
> > >
> > >  	END_USE(vq);
> > >
> > > diff --git a/include/linux/virtio.h b/include/linux/virtio.h
> > > index 4cc614a38376..1cf7b004348b 100644
> > > --- a/include/linux/virtio.h
> > > +++ b/include/linux/virtio.h
> > > @@ -81,7 +81,7 @@ bool virtqueue_enable_cb(struct virtqueue *vq);
> > >
> > >  unsigned virtqueue_enable_cb_prepare(struct virtqueue *vq);
> > >
> > > -int virtqueue_set_dma_premapped(struct virtqueue *_vq);
> > > +int virtqueue_set_dma_premapped(struct virtqueue *_vq, bool mode);
> > >
> > >  bool virtqueue_poll(struct virtqueue *vq, unsigned);
> >
> > Wait a sec I thought we never change premapped. If you make this
> > dynamic don't you need a bunch of locking?
> > Or maybe queue is empty when you change this?
> > If yes pls add a bunch of BUG_ON checks to make sure this is not misused.
> 
> 
> Actually, this api is called immediately after the vq init or vq reset.
> 
> We already have such a check.
> 
> Thanks.
> 
> /**
>  * virtqueue_set_dma_premapped - set the vring premapped mode
>  * @_vq: the struct virtqueue we're talking about.
>  *
>  * Enable the premapped mode of the vq.
>  *
>  * The vring in premapped mode does not do dma internally, so the driver must
>  * do dma mapping in advance. The driver must pass the dma_address through
>  * dma_address of scatterlist. When the driver got a used buffer from
>  * the vring, it has to unmap the dma address.
>  *
>  * This function must be called immediately after creating the vq, or after vq
>  * reset, and before adding any buffers to it.
>  *
>  * Caller must ensure we don't call this with other virtqueue operations
>  * at the same time (except where noted).
>  *
>  * Returns zero or a negative error.
>  * 0: success.
>  * -EINVAL: vring does not use the dma api, so we can not enable premapped mode.
>  */
> int virtqueue_set_dma_premapped(struct virtqueue *_vq, bool mode)
> {
> 	struct vring_virtqueue *vq = to_vvq(_vq);
> 	u32 num;
> 
> 	START_USE(vq);
> 
> 	num = vq->packed_ring ? vq->packed.vring.num : vq->split.vring.num;
> 
> -->	if (num != vq->vq.num_free) {
> 		END_USE(vq);
> 		return -EINVAL;
> 	}

But it turns out virtnet_rq_set_premapped actually just ignores errors.
So returning EINVAL here does nothing caller just proceeds?
And checking num_free without locks is never safe anyway.
I think the point is that this never triggers then just BUG_ON.


> 
> 	if (!vq->use_dma_api) {
> 		END_USE(vq);
> 		return -EINVAL;
> 	}
> 
> 	if (mode) {
> 		vq->premapped = true;
> 		vq->do_unmap = false;
> 	} else {
> 		vq->premapped = false;
> 		vq->do_unmap = vq->use_dma_api;
> 	}
> 
> 	END_USE(vq);
> 
> 	return 0;
> }
> EXPORT_SYMBOL_GPL(virtqueue_set_dma_premapped);
> 
> 
> >
> >
> > > --
> > > 2.32.0.3.g01195cf9f
> >

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BAE1C433EF
	for <virtualization@archiver.kernel.org>; Thu, 10 Mar 2022 12:17:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E55E684721;
	Thu, 10 Mar 2022 12:17:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SjMRCY_DyjIe; Thu, 10 Mar 2022 12:17:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 6513A84722;
	Thu, 10 Mar 2022 12:17:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 240EBC0012;
	Thu, 10 Mar 2022 12:17:24 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7AB25C000B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Mar 2022 12:17:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 61B1B40B45
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Mar 2022 12:17:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nsfxuPMjrmfP
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Mar 2022 12:17:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 27BBF4015D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Mar 2022 12:17:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1646914640;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iCa3Iap6wQ5Zl4P5Ktca1OOk+bdgfEmL5P8D9QaSpF8=;
 b=TOGvMCpusCH/a9umzGsnLBkQwGZD9iw2KSoR7prO4fd3H07Vqz4cGOQ+TnE4GiGT/JhdbO
 k2mvJvznV1EkyhfnZQ+0222NAsd6xf0NIOx5+xUpLJm4l3lsakARaPqEelDiloUzvwoPg2
 ytC6e3HZ6+AwoPXfeIj7dixrZn0AsgE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-391-tokjuTOnPNmvpzljz5Q07w-1; Thu, 10 Mar 2022 07:17:17 -0500
X-MC-Unique: tokjuTOnPNmvpzljz5Q07w-1
Received: by mail-wr1-f70.google.com with SMTP id
 z16-20020adff1d0000000b001ef7dc78b23so1620238wro.12
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Mar 2022 04:17:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=iCa3Iap6wQ5Zl4P5Ktca1OOk+bdgfEmL5P8D9QaSpF8=;
 b=ofD6Wf17sB8GTcfbor+w3tQVXdV9GPqrmiJ+tPSI0oMJz546iSznPijgtx21HQSQtd
 DChrzBWfoGbQXoS1Z43R8lXoWeD7gcapV+r4QK9nB/Wb600a1F4YoTaypP0/J7LFFLmD
 c2iys8Y+DiLWlYKfbIwHs+sqsCAs+MgO/715efJ2ALb3N287GYh6qmSoNecLbw8fu9wp
 04hcKWRC9OJCjP/nVmg3n7IaMHduQMhcrfIuorW9noYa0ZntmftGQrtpBjiqphBLyAET
 KPh2E5b+MFHqmS2rB4GP5SrFbIY2spC9mhruqzrB5Iau1jFvybouhy66rWjFPiAEg+Os
 kTcw==
X-Gm-Message-State: AOAM532dnZxoAhBlaYqstEgQZrFdnjeVD24Hlx4l7OKS67XI9ts6ZQvs
 tMyChJM3qClshdM/RRLVTV3HJagHVgxlKqD7kXn4L2VWdEaRrKlRF/fPKeGbFE4S2GoQbIXee7k
 Ztkl7y0QBA9DjqKFFl4SqyGXzzL9sEk/+RiO2ptetVQ==
X-Received: by 2002:a5d:52c5:0:b0:1f2:1a3:465a with SMTP id
 r5-20020a5d52c5000000b001f201a3465amr3386181wrv.206.1646914635705; 
 Thu, 10 Mar 2022 04:17:15 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyJ8kxEUsaqBt/nb6dCuHcfgNxBZpEdY850Aa5dvWPrkmgIy1r3xCyWoo8uhz2jX3jr6T1QKQ==
X-Received: by 2002:a5d:52c5:0:b0:1f2:1a3:465a with SMTP id
 r5-20020a5d52c5000000b001f201a3465amr3386152wrv.206.1646914635366; 
 Thu, 10 Mar 2022 04:17:15 -0800 (PST)
Received: from redhat.com ([2.53.27.107]) by smtp.gmail.com with ESMTPSA id
 z2-20020a056000110200b001e7140ddb44sm4045484wrw.49.2022.03.10.04.17.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Mar 2022 04:17:14 -0800 (PST)
Date: Thu, 10 Mar 2022 07:17:09 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH v7 09/26] virtio_ring: split: implement
 virtqueue_reset_vring_split()
Message-ID: <20220310071335-mutt-send-email-mst@kernel.org>
References: <20220308123518.33800-1-xuanzhuo@linux.alibaba.com>
 <20220308123518.33800-10-xuanzhuo@linux.alibaba.com>
 <20220310015418-mutt-send-email-mst@kernel.org>
 <1646896623.3794115-2-xuanzhuo@linux.alibaba.com>
 <20220310025930-mutt-send-email-mst@kernel.org>
 <1646900056.7775025-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <1646900056.7775025-1-xuanzhuo@linux.alibaba.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Vadim Pasternak <vadimp@nvidia.com>, linux-remoteproc@vger.kernel.org,
 Alexei Starovoitov <ast@kernel.org>, virtualization@lists.linux-foundation.org,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>, linux-s390@vger.kernel.org,
 Johannes Berg <johannes.berg@intel.com>,
 Daniel Borkmann <daniel@iogearbox.net>, Richard Weinberger <richard@nod.at>,
 Vincent Whitchurch <vincent.whitchurch@axis.com>,
 John Fastabend <john.fastabend@gmail.com>, Halil Pasic <pasic@linux.ibm.com>,
 Jakub Kicinski <kuba@kernel.org>, Heiko Carstens <hca@linux.ibm.com>,
 platform-driver-x86@vger.kernel.org, Jesper Dangaard Brouer <hawk@kernel.org>,
 Vasily Gorbik <gor@linux.ibm.com>, Jeff Dike <jdike@addtoit.com>,
 linux-um@lists.infradead.org, Mark Gross <markgross@kernel.org>,
 Hans de Goede <hdegoede@redhat.com>, kvm@vger.kernel.org,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 Mathieu Poirier <mathieu.poirier@linaro.org>, netdev@vger.kernel.org,
 Cornelia Huck <cohuck@redhat.com>, Sven Schnelle <svens@linux.ibm.com>,
 bpf@vger.kernel.org, "David S. Miller" <davem@davemloft.net>
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

On Thu, Mar 10, 2022 at 04:14:16PM +0800, Xuan Zhuo wrote:
> On Thu, 10 Mar 2022 03:07:22 -0500, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > On Thu, Mar 10, 2022 at 03:17:03PM +0800, Xuan Zhuo wrote:
> > > On Thu, 10 Mar 2022 02:00:39 -0500, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > > > On Tue, Mar 08, 2022 at 08:35:01PM +0800, Xuan Zhuo wrote:
> > > > > virtio ring supports reset.
> > > > >
> > > > > Queue reset is divided into several stages.
> > > > >
> > > > > 1. notify device queue reset
> > > > > 2. vring release
> > > > > 3. attach new vring
> > > > > 4. notify device queue re-enable
> > > > >
> > > > > After the first step is completed, the vring reset operation can be
> > > > > performed. If the newly set vring num does not change, then just reset
> > > > > the vq related value.
> > > > >
> > > > > Otherwise, the vring will be released and the vring will be reallocated.
> > > > > And the vring will be attached to the vq. If this process fails, the
> > > > > function will exit, and the state of the vq will be the vring release
> > > > > state. You can call this function again to reallocate the vring.
> > > > >
> > > > > In addition, vring_align, may_reduce_num are necessary for reallocating
> > > > > vring, so they are retained when creating vq.
> > > > >
> > > > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > > > ---
> > > > >  drivers/virtio/virtio_ring.c | 69 ++++++++++++++++++++++++++++++++++++
> > > > >  1 file changed, 69 insertions(+)
> > > > >
> > > > > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > > > > index e0422c04c903..148fb1fd3d5a 100644
> > > > > --- a/drivers/virtio/virtio_ring.c
> > > > > +++ b/drivers/virtio/virtio_ring.c
> > > > > @@ -158,6 +158,12 @@ struct vring_virtqueue {
> > > > >  			/* DMA address and size information */
> > > > >  			dma_addr_t queue_dma_addr;
> > > > >  			size_t queue_size_in_bytes;
> > > > > +
> > > > > +			/* The parameters for creating vrings are reserved for
> > > > > +			 * creating new vrings when enabling reset queue.
> > > > > +			 */
> > > > > +			u32 vring_align;
> > > > > +			bool may_reduce_num;
> > > > >  		} split;
> > > > >
> > > > >  		/* Available for packed ring */
> > > > > @@ -217,6 +223,12 @@ struct vring_virtqueue {
> > > > >  #endif
> > > > >  };
> > > > >
> > > > > +static void vring_free(struct virtqueue *vq);
> > > > > +static void __vring_virtqueue_init_split(struct vring_virtqueue *vq,
> > > > > +					 struct virtio_device *vdev);
> > > > > +static int __vring_virtqueue_attach_split(struct vring_virtqueue *vq,
> > > > > +					  struct virtio_device *vdev,
> > > > > +					  struct vring vring);
> > > > >
> > > > >  /*
> > > > >   * Helpers.
> > > > > @@ -1012,6 +1024,8 @@ static struct virtqueue *vring_create_virtqueue_split(
> > > > >  		return NULL;
> > > > >  	}
> > > > >
> > > > > +	to_vvq(vq)->split.vring_align = vring_align;
> > > > > +	to_vvq(vq)->split.may_reduce_num = may_reduce_num;
> > > > >  	to_vvq(vq)->split.queue_dma_addr = vring.dma_addr;
> > > > >  	to_vvq(vq)->split.queue_size_in_bytes = vring.queue_size_in_bytes;
> > > > >  	to_vvq(vq)->we_own_ring = true;
> > > > > @@ -1019,6 +1033,59 @@ static struct virtqueue *vring_create_virtqueue_split(
> > > > >  	return vq;
> > > > >  }
> > > > >
> > > > > +static int virtqueue_reset_vring_split(struct virtqueue *_vq, u32 num)
> > > > > +{
> > > > > +	struct vring_virtqueue *vq = to_vvq(_vq);
> > > > > +	struct virtio_device *vdev = _vq->vdev;
> > > > > +	struct vring_split vring;
> > > > > +	int err;
> > > > > +
> > > > > +	if (num > _vq->num_max)
> > > > > +		return -E2BIG;
> > > > > +
> > > > > +	switch (vq->vq.reset) {
> > > > > +	case VIRTIO_VQ_RESET_STEP_NONE:
> > > > > +		return -ENOENT;
> > > > > +
> > > > > +	case VIRTIO_VQ_RESET_STEP_VRING_ATTACH:
> > > > > +	case VIRTIO_VQ_RESET_STEP_DEVICE:
> > > > > +		if (vq->split.vring.num == num || !num)
> > > > > +			break;
> > > > > +
> > > > > +		vring_free(_vq);
> > > > > +
> > > > > +		fallthrough;
> > > > > +
> > > > > +	case VIRTIO_VQ_RESET_STEP_VRING_RELEASE:
> > > > > +		if (!num)
> > > > > +			num = vq->split.vring.num;
> > > > > +
> > > > > +		err = vring_create_vring_split(&vring, vdev,
> > > > > +					       vq->split.vring_align,
> > > > > +					       vq->weak_barriers,
> > > > > +					       vq->split.may_reduce_num, num);
> > > > > +		if (err)
> > > > > +			return -ENOMEM;
> > > > > +
> > > > > +		err = __vring_virtqueue_attach_split(vq, vdev, vring.vring);
> > > > > +		if (err) {
> > > > > +			vring_free_queue(vdev, vring.queue_size_in_bytes,
> > > > > +					 vring.queue,
> > > > > +					 vring.dma_addr);
> > > > > +			return -ENOMEM;
> > > > > +		}
> > > > > +
> > > > > +		vq->split.queue_dma_addr = vring.dma_addr;
> > > > > +		vq->split.queue_size_in_bytes = vring.queue_size_in_bytes;
> > > > > +	}
> > > > > +
> > > > > +	__vring_virtqueue_init_split(vq, vdev);
> > > > > +	vq->we_own_ring = true;
> > > > > +	vq->vq.reset = VIRTIO_VQ_RESET_STEP_VRING_ATTACH;
> > > > > +
> > > > > +	return 0;
> > > > > +}
> > > > > +
> > > >
> > > > I kind of dislike this state machine.
> > > >
> > > > Hacks like special-casing num = 0 to mean "reset" are especially
> > > > confusing.
> > >
> > > I'm removing it. I'll say in the function description that this function is
> > > currently only called when vq has been reset. I'm no longer checking it based on
> > > state.
> > >
> > > >
> > > > And as Jason points out, when we want a resize then yes this currently
> > > > implies reset but that is an implementation detail.
> > > >
> > > > There should be a way to just make these cases separate functions
> > > > and then use them to compose consistent external APIs.
> > >
> > > Yes, virtqueue_resize_split() is fine for ethtool -G.
> > >
> > > But in the case of AF_XDP, just execute reset to free the buffer. The name
> > > virtqueue_reset_vring_split() I think can cover both cases. Or we use two apis
> > > to handle both scenarios?
> > >
> > > Or can anyone think of a better name. ^_^
> > >
> > > Thanks.
> >
> >
> > I'd say resize should be called resize and reset should be called reset.
> 
> 
> OK, I'll change it to resize here.
> 
> But I want to know that when I implement virtio-net to support AF_XDP, its
> requirement is to release all submitted buffers. Then should I add a new api
> such as virtqueue_reset_vring()?

Sounds like a reasonable name.

> >
> > The big issue is a sane API for resize. Ideally it would resubmit
> > buffers which did not get used. Question is what to do
> > about buffers which don't fit (if ring has been downsized)?
> > Maybe a callback that will handle them?
> > And then what? Queue them up and readd later? Drop?
> > If we drop we should drop from the head not the tail ...
> 
> It's a good idea, let's implement it later.
> 
> Thanks.

Well ... not sure how you are going to support resize
if you don't know what to do with buffers that were
in the ring.

> >
> >
> > > >
> > > > If we additionally want to track state for debugging then bool flags
> > > > seem more appropriate for this, though from experience that is
> > > > not always worth the extra code.
> > > >
> > > >
> > > >
> > > > >  /*
> > > > >   * Packed ring specific functions - *_packed().
> > > > > @@ -2317,6 +2384,8 @@ static int __vring_virtqueue_attach_split(struct vring_virtqueue *vq,
> > > > >  static void __vring_virtqueue_init_split(struct vring_virtqueue *vq,
> > > > >  					 struct virtio_device *vdev)
> > > > >  {
> > > > > +	vq->vq.reset = VIRTIO_VQ_RESET_STEP_NONE;
> > > > > +
> > > > >  	vq->packed_ring = false;
> > > > >  	vq->we_own_ring = false;
> > > > >  	vq->broken = false;
> > > > > --
> > > > > 2.31.0
> > > >
> >

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

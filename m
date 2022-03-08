Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC3DFC433FE
	for <virtualization@archiver.kernel.org>; Tue,  8 Mar 2022 07:05:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7BE2B60BB1;
	Tue,  8 Mar 2022 07:05:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id x3FoEVqxjZ22; Tue,  8 Mar 2022 07:05:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id D028460C08;
	Tue,  8 Mar 2022 07:05:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AE320C0012;
	Tue,  8 Mar 2022 07:05:47 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 61A3BC000B
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Mar 2022 07:05:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 494E84170E
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Mar 2022 07:05:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xtve9a3eNsom
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Mar 2022 07:05:44 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from out30-43.freemail.mail.aliyun.com
 (out30-43.freemail.mail.aliyun.com [115.124.30.43])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A91E841635
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Mar 2022 07:05:43 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R491e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e01424; MF=xuanzhuo@linux.alibaba.com;
 NM=1; PH=DS; RN=33; SR=0; TI=SMTPD_---0V6cqqVc_1646723135; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0V6cqqVc_1646723135) by smtp.aliyun-inc.com(127.0.0.1);
 Tue, 08 Mar 2022 15:05:36 +0800
Message-ID: <1646722885.3801584-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH v6 06/26] virtio_ring: packed: extrace the logic of
 creating vring
Date: Tue, 8 Mar 2022 15:01:25 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20220224081102.80224-1-xuanzhuo@linux.alibaba.com>
 <20220224081102.80224-7-xuanzhuo@linux.alibaba.com>
 <20220307171629-mutt-send-email-mst@kernel.org>
In-Reply-To: <20220307171629-mutt-send-email-mst@kernel.org>
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Mon, 7 Mar 2022 17:17:51 -0500, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> On Thu, Feb 24, 2022 at 04:10:42PM +0800, Xuan Zhuo wrote:
> > Separate the logic of packed to create vring queue.
> >
> > For the convenience of passing parameters, add a structure
> > vring_packed.
> >
> > This feature is required for subsequent virtuqueue reset vring.
> >
> > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
>
> Subject has a typo.

I will fix it.

> Besides:
>
> > ---
> >  drivers/virtio/virtio_ring.c | 121 ++++++++++++++++++++++++++---------
> >  1 file changed, 92 insertions(+), 29 deletions(-)
> >
> > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > index dc6313b79305..41864c5e665f 100644
> > --- a/drivers/virtio/virtio_ring.c
> > +++ b/drivers/virtio/virtio_ring.c
> > @@ -92,6 +92,18 @@ struct vring_split {
> >  	struct vring vring;
> >  };
> >
> > +struct vring_packed {
> > +	u32 num;
> > +	struct vring_packed_desc *ring;
> > +	struct vring_packed_desc_event *driver;
> > +	struct vring_packed_desc_event *device;
> > +	dma_addr_t ring_dma_addr;
> > +	dma_addr_t driver_event_dma_addr;
> > +	dma_addr_t device_event_dma_addr;
> > +	size_t ring_size_in_bytes;
> > +	size_t event_size_in_bytes;
> > +};
> > +
> >  struct vring_virtqueue {
> >  	struct virtqueue vq;
> >
> > @@ -1683,45 +1695,101 @@ static struct vring_desc_extra *vring_alloc_desc_extra(struct vring_virtqueue *v
> >  	return desc_extra;
> >  }
> >
> > -static struct virtqueue *vring_create_virtqueue_packed(
> > -	unsigned int index,
> > -	unsigned int num,
> > -	unsigned int vring_align,
> > -	struct virtio_device *vdev,
> > -	bool weak_barriers,
> > -	bool may_reduce_num,
> > -	bool context,
> > -	bool (*notify)(struct virtqueue *),
> > -	void (*callback)(struct virtqueue *),
> > -	const char *name)
> > +static void vring_free_vring_packed(struct vring_packed *vring,
> > +				    struct virtio_device *vdev)
> > +{
> > +	dma_addr_t ring_dma_addr, driver_event_dma_addr, device_event_dma_addr;
> > +	struct vring_packed_desc_event *driver, *device;
> > +	size_t ring_size_in_bytes, event_size_in_bytes;
> > +	struct vring_packed_desc *ring;
> > +
> > +	ring                  = vring->ring;
> > +	driver                = vring->driver;
> > +	device                = vring->device;
> > +	ring_dma_addr         = vring->ring_size_in_bytes;
> > +	event_size_in_bytes   = vring->event_size_in_bytes;
> > +	ring_dma_addr         = vring->ring_dma_addr;
> > +	driver_event_dma_addr = vring->driver_event_dma_addr;
> > +	device_event_dma_addr = vring->device_event_dma_addr;
> > +
> > +	if (device)
> > +		vring_free_queue(vdev, event_size_in_bytes, device, device_event_dma_addr);
> > +
> > +	if (driver)
> > +		vring_free_queue(vdev, event_size_in_bytes, driver, driver_event_dma_addr);
> > +
> > +	if (ring)
> > +		vring_free_queue(vdev, ring_size_in_bytes, ring, ring_dma_addr);
>
> ring_size_in_bytes is uninitialized here.
>
> Which begs the question how was this tested patchset generally and
> this patch in particular.
> Please add note on tested configurations and tests run to the patchset.

Sorry, my environment is running in split mode. I did not retest the packed mode
before sending patches. Because my dpdk vhost-user is not easy to use, I
need to change the kernel of the host.

I would like to ask if there are other lightweight environments that can be used
to test packed mode.


Thanks.


>
> > +}
> > +
> > +static int vring_create_vring_packed(struct vring_packed *vring,
> > +				    struct virtio_device *vdev,
> > +				    u32 num)
> >  {
> > -	struct vring_virtqueue *vq;
> >  	struct vring_packed_desc *ring;
> >  	struct vring_packed_desc_event *driver, *device;
> >  	dma_addr_t ring_dma_addr, driver_event_dma_addr, device_event_dma_addr;
> >  	size_t ring_size_in_bytes, event_size_in_bytes;
> >
> > +	memset(vring, 0, sizeof(*vring));
> > +
> >  	ring_size_in_bytes = num * sizeof(struct vring_packed_desc);
> >
> >  	ring = vring_alloc_queue(vdev, ring_size_in_bytes,
> >  				 &ring_dma_addr,
> >  				 GFP_KERNEL|__GFP_NOWARN|__GFP_ZERO);
> >  	if (!ring)
> > -		goto err_ring;
> > +		goto err;
> > +
> > +	vring->num = num;
> > +	vring->ring = ring;
> > +	vring->ring_size_in_bytes = ring_size_in_bytes;
> > +	vring->ring_dma_addr = ring_dma_addr;
> >
> >  	event_size_in_bytes = sizeof(struct vring_packed_desc_event);
> > +	vring->event_size_in_bytes = event_size_in_bytes;
> >
> >  	driver = vring_alloc_queue(vdev, event_size_in_bytes,
> >  				   &driver_event_dma_addr,
> >  				   GFP_KERNEL|__GFP_NOWARN|__GFP_ZERO);
> >  	if (!driver)
> > -		goto err_driver;
> > +		goto err;
> > +
> > +	vring->driver = driver;
> > +	vring->driver_event_dma_addr = driver_event_dma_addr;
> >
> >  	device = vring_alloc_queue(vdev, event_size_in_bytes,
> >  				   &device_event_dma_addr,
> >  				   GFP_KERNEL|__GFP_NOWARN|__GFP_ZERO);
> >  	if (!device)
> > -		goto err_device;
> > +		goto err;
> > +
> > +	vring->device = device;
> > +	vring->device_event_dma_addr = device_event_dma_addr;
> > +	return 0;
> > +
> > +err:
> > +	vring_free_vring_packed(vring, vdev);
> > +	return -ENOMEM;
> > +}
> > +
> > +static struct virtqueue *vring_create_virtqueue_packed(
> > +	unsigned int index,
> > +	unsigned int num,
> > +	unsigned int vring_align,
> > +	struct virtio_device *vdev,
> > +	bool weak_barriers,
> > +	bool may_reduce_num,
> > +	bool context,
> > +	bool (*notify)(struct virtqueue *),
> > +	void (*callback)(struct virtqueue *),
> > +	const char *name)
> > +{
> > +	struct vring_virtqueue *vq;
> > +	struct vring_packed vring;
> > +
> > +	if (vring_create_vring_packed(&vring, vdev, num))
> > +		goto err_vq;
> >
> >  	vq = kmalloc(sizeof(*vq), GFP_KERNEL);
> >  	if (!vq)
> > @@ -1753,17 +1821,17 @@ static struct virtqueue *vring_create_virtqueue_packed(
> >  	if (virtio_has_feature(vdev, VIRTIO_F_ORDER_PLATFORM))
> >  		vq->weak_barriers = false;
> >
> > -	vq->packed.ring_dma_addr = ring_dma_addr;
> > -	vq->packed.driver_event_dma_addr = driver_event_dma_addr;
> > -	vq->packed.device_event_dma_addr = device_event_dma_addr;
> > +	vq->packed.ring_dma_addr = vring.ring_dma_addr;
> > +	vq->packed.driver_event_dma_addr = vring.driver_event_dma_addr;
> > +	vq->packed.device_event_dma_addr = vring.device_event_dma_addr;
> >
> > -	vq->packed.ring_size_in_bytes = ring_size_in_bytes;
> > -	vq->packed.event_size_in_bytes = event_size_in_bytes;
> > +	vq->packed.ring_size_in_bytes = vring.ring_size_in_bytes;
> > +	vq->packed.event_size_in_bytes = vring.event_size_in_bytes;
> >
> >  	vq->packed.vring.num = num;
> > -	vq->packed.vring.desc = ring;
> > -	vq->packed.vring.driver = driver;
> > -	vq->packed.vring.device = device;
> > +	vq->packed.vring.desc = vring.ring;
> > +	vq->packed.vring.driver = vring.driver;
> > +	vq->packed.vring.device = vring.device;
> >
> >  	vq->packed.next_avail_idx = 0;
> >  	vq->packed.avail_wrap_counter = 1;
> > @@ -1804,12 +1872,7 @@ static struct virtqueue *vring_create_virtqueue_packed(
> >  err_desc_state:
> >  	kfree(vq);
> >  err_vq:
> > -	vring_free_queue(vdev, event_size_in_bytes, device, device_event_dma_addr);
> > -err_device:
> > -	vring_free_queue(vdev, event_size_in_bytes, driver, driver_event_dma_addr);
> > -err_driver:
> > -	vring_free_queue(vdev, ring_size_in_bytes, ring, ring_dma_addr);
> > -err_ring:
> > +	vring_free_vring_packed(&vring, vdev);
> >  	return NULL;
> >  }
> >
> > --
> > 2.31.0
>
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

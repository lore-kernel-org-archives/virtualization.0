Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B9C4C46467
	for <virtualization@archiver.kernel.org>; Wed, 11 Jan 2023 13:52:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1063381F91;
	Wed, 11 Jan 2023 13:52:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1063381F91
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=D7fLHohY
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id W4g98X3nohEU; Wed, 11 Jan 2023 13:52:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 4ED8781F92;
	Wed, 11 Jan 2023 13:52:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4ED8781F92
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1FDE0C0032;
	Wed, 11 Jan 2023 13:52:51 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2437FC002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Jan 2023 13:52:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E77E260E13
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Jan 2023 13:52:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E77E260E13
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=D7fLHohY
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id otRyE3EE9bj7
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Jan 2023 13:52:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 18A3E60701
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 18A3E60701
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Jan 2023 13:52:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1673445168;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EVXd0+tTmNanAqtPTUXnzWMvK7HgkczZRyk87Gekezw=;
 b=D7fLHohYZuwQ6JxiMW/xWRiNtfXRIGPspIYWBYgthzvJtEd5NnB9kqvy8KtCq73trTUzu3
 KJFOzBLVUhC1g7EjVI0ujuqzY+6gXtQ4WHYKeclG8yV4rGxRRlgBYOxo8qkhWGL0Gr6lHo
 +YwPCrhUPgv4F8Vfc6hfjJbudd/fi9I=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-437-vb4IHA4SOHO8ecwZjqAVDg-1; Wed, 11 Jan 2023 08:52:39 -0500
X-MC-Unique: vb4IHA4SOHO8ecwZjqAVDg-1
Received: by mail-wr1-f69.google.com with SMTP id
 i28-20020adfa51c000000b002ba26dfcd08so2709294wrb.18
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Jan 2023 05:52:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EVXd0+tTmNanAqtPTUXnzWMvK7HgkczZRyk87Gekezw=;
 b=thNNMVJ9v7aBeQmNVZ4lxxUHs/Uu7wlIQxfI5ZzHCsiOx8f4XOVgdB8I+opBuOGse3
 kXueyN+zhI0OXqHGgh0zf5LLmQ1iBzZDNGaAHWkB05eLEZqj1bFM3MYP51LZMfQY9sIq
 3tD56r6EiJVpqm8ieRv/qpKwRYsN/We3b68P9L/CCOWn/f16XdfUpGopGPe8xl+uaefH
 vtqLKwOXYHKI4oT1KHnwWgJT67DWtO+X49OS4y2g+R0iALWt3YERlKxwMDz1PjET8OlC
 TOLnEoqAwzL0Wf4GzjIFtsmsk7fYcVq9ojXRTBMmqEUle9QnAKL6OcZiB1+BGHU95rac
 30YA==
X-Gm-Message-State: AFqh2ko96rRCB5KhjjxLN/EBlNMLmOnrIkSIshu3C5zCbq3rwv+2nLXZ
 QmnYNWCWG1pTH9xXj6D9WYm5393Aue7bS1bi6SMqX5hmG/RWI5oNUtu2BIItJbWi9xR6YgTlMQN
 bzzsJ5ciUtW62+3lFA5FLossrO4hfuMC0zuryyv9stg==
X-Received: by 2002:a05:6000:910:b0:242:733b:af28 with SMTP id
 bz16-20020a056000091000b00242733baf28mr61561355wrb.5.1673445158338; 
 Wed, 11 Jan 2023 05:52:38 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvZsLF5O5by/jN4b7/Dxocy8fV9SSbKWgBeKVV6PBIXB42ZP1FOxfklK2qKs3KZ6zIt+ghfMw==
X-Received: by 2002:a05:6000:910:b0:242:733b:af28 with SMTP id
 bz16-20020a056000091000b00242733baf28mr61561341wrb.5.1673445158119; 
 Wed, 11 Jan 2023 05:52:38 -0800 (PST)
Received: from redhat.com ([2.52.157.155]) by smtp.gmail.com with ESMTPSA id
 m10-20020adff38a000000b002bc83b85180sm5361050wro.114.2023.01.11.05.52.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Jan 2023 05:52:37 -0800 (PST)
Date: Wed, 11 Jan 2023 08:52:34 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eli Cohen <elic@nvidia.com>
Subject: Re: [PATCH 1/5] virtio_ring: per virtqueue dma device
Message-ID: <20230111085210-mutt-send-email-mst@kernel.org>
References: <20230111062809.25020-1-jasowang@redhat.com>
 <20230111062809.25020-2-jasowang@redhat.com>
 <DM8PR12MB5400E61C7E968AC7604556EBABFC9@DM8PR12MB5400.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <DM8PR12MB5400E61C7E968AC7604556EBABFC9@DM8PR12MB5400.namprd12.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: "gdawar@amd.com" <gdawar@amd.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "tanuj.kamde@amd.com" <tanuj.kamde@amd.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>
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

On Wed, Jan 11, 2023 at 01:32:20PM +0000, Eli Cohen wrote:
> > From: Jason Wang <jasowang@redhat.com>
> > Sent: Wednesday, 11 January 2023 8:28
> > To: mst@redhat.com; jasowang@redhat.com
> > Cc: Eli Cohen <elic@nvidia.com>; gdawar@amd.com;
> > virtualization@lists.linux-foundation.org; linux-kernel@vger.kernel.org;
> > tanuj.kamde@amd.com
> > Subject: [PATCH 1/5] virtio_ring: per virtqueue dma device
> > 
> > This patch introduces a per virtqueue dma device. This will be used
> > for virtio devices whose virtqueue are backed by different underlayer
> > devices.
> > 
> > One example is the vDPA that where the control virtqueue could be
> > implemented through software mediation.
> > 
> > Some of the work are actually done before since the helper like
> > vring_dma_device(). This work left are:
> > 
> > - Let vring_dma_device() return the per virtqueue dma device instead
> >   of the vdev's parent.
> > - Allow passing a dma_device when creating the virtqueue through a new
> >   helper, old vring creation helper will keep using vdev's parent.
> > 
> > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > ---
> >  drivers/virtio/virtio_ring.c | 133 ++++++++++++++++++++++++-----------
> >  include/linux/virtio_ring.h  |  16 +++++
> >  2 files changed, 109 insertions(+), 40 deletions(-)
> > 
> > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > index 723c4e29e1d3..41144b5246a8 100644
> > --- a/drivers/virtio/virtio_ring.c
> > +++ b/drivers/virtio/virtio_ring.c
> > @@ -202,6 +202,9 @@ struct vring_virtqueue {
> >  	/* DMA, allocation, and size information */
> >  	bool we_own_ring;
> > 
> > +	/* Device used for doing DMA */
> > +	struct device *dma_dev;
> > +
> >  #ifdef DEBUG
> >  	/* They're supposed to lock for us. */
> >  	unsigned int in_use;
> > @@ -219,7 +222,8 @@ static struct virtqueue
> > *__vring_new_virtqueue(unsigned int index,
> >  					       bool context,
> >  					       bool (*notify)(struct virtqueue *),
> >  					       void (*callback)(struct virtqueue
> > *),
> > -					       const char *name);
> > +					       const char *name,
> > +					       struct device *dma_dev);
> >  static struct vring_desc_extra *vring_alloc_desc_extra(unsigned int num);
> >  static void vring_free(struct virtqueue *_vq);
> > 
> > @@ -297,10 +301,11 @@ size_t virtio_max_dma_size(struct virtio_device
> > *vdev)
> >  EXPORT_SYMBOL_GPL(virtio_max_dma_size);
> > 
> >  static void *vring_alloc_queue(struct virtio_device *vdev, size_t size,
> > -			      dma_addr_t *dma_handle, gfp_t flag)
> > +			       dma_addr_t *dma_handle, gfp_t flag,
> > +			       struct device *dma_dev)
> >  {
> >  	if (vring_use_dma_api(vdev)) {
> > -		return dma_alloc_coherent(vdev->dev.parent, size,
> > +		return dma_alloc_coherent(dma_dev, size,
> >  					  dma_handle, flag);
> >  	} else {
> >  		void *queue = alloc_pages_exact(PAGE_ALIGN(size), flag);
> > @@ -330,10 +335,11 @@ static void *vring_alloc_queue(struct virtio_device
> > *vdev, size_t size,
> >  }
> > 
> >  static void vring_free_queue(struct virtio_device *vdev, size_t size,
> > -			     void *queue, dma_addr_t dma_handle)
> > +			     void *queue, dma_addr_t dma_handle,
> > +			     struct device *dma_dev)
> >  {
> >  	if (vring_use_dma_api(vdev))
> > -		dma_free_coherent(vdev->dev.parent, size, queue,
> > dma_handle);
> > +		dma_free_coherent(dma_dev, size, queue, dma_handle);
> >  	else
> >  		free_pages_exact(queue, PAGE_ALIGN(size));
> >  }
> > @@ -341,11 +347,11 @@ static void vring_free_queue(struct virtio_device
> > *vdev, size_t size,
> >  /*
> >   * The DMA ops on various arches are rather gnarly right now, and
> >   * making all of the arch DMA ops work on the vring device itself
> > - * is a mess.  For now, we use the parent device for DMA ops.
> > + * is a mess.
> >   */
> >  static inline struct device *vring_dma_dev(const struct vring_virtqueue *vq)
> >  {
> > -	return vq->vq.vdev->dev.parent;
> > +	return vq->dma_dev;
> >  }
> 
> How about getting rid of this function and just use vq->dma_dev?

Will make the patch even bigger than it is.
If you do patch on top pls.

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

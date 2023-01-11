Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EB36C5479D
	for <virtualization@archiver.kernel.org>; Wed, 11 Jan 2023 16:26:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5CE68418E8;
	Wed, 11 Jan 2023 16:26:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5CE68418E8
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=dNWvmtDX
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5CZYAZh8lzFD; Wed, 11 Jan 2023 16:26:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 3B1E2418DC;
	Wed, 11 Jan 2023 16:26:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3B1E2418DC
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0D143C0033;
	Wed, 11 Jan 2023 16:26:15 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4D615C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Jan 2023 16:26:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1A2EC820DE
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Jan 2023 16:26:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1A2EC820DE
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=dNWvmtDX
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zUf0kd5B247Y
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Jan 2023 16:26:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 23633820DA
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 23633820DA
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Jan 2023 16:26:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1673454371;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wtEIkYjmLZsEiOQrIC2X2XBPeBjTa7fz4qIHCcwmF9c=;
 b=dNWvmtDXjpRldEnMYU5Jwt6iEPO/y3obt8iYkcnSSjjFOUVNzSvP3Xn8koWZb5WUXuLApX
 paOlzVn3oVhST3dgZ3rLwkSVA1vkYuoGq+ptYH68y5s7vbbEJk0CMwW3pz+xmr1sjPqn8G
 e6Z8KDRxQxbPg7WemoUDVZsvIlx6J/I=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-47-fktW_9iHNoW4rMPs6f-FEA-1; Wed, 11 Jan 2023 11:26:10 -0500
X-MC-Unique: fktW_9iHNoW4rMPs6f-FEA-1
Received: by mail-ed1-f69.google.com with SMTP id
 b15-20020a056402350f00b0048477a5114bso10193222edd.2
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Jan 2023 08:26:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wtEIkYjmLZsEiOQrIC2X2XBPeBjTa7fz4qIHCcwmF9c=;
 b=De/L5Fn1bGHUlgv+ClhkleqfTLGbSrfC0BzMOzlpxuiJWJzZI5JyvNTWg+zy3rpOCl
 gaw2dhSgkv/y97jdXWJxbKZ0nIiURTHvPoYmnKANkK+iQaOtiWXTOYWdIIfgwocGDDso
 lR26bpr8TWQw2EbPEMkMWs8cNksby/ctZYtkdPSRMIdOpo5oEY0MUmsNuN80UwRjBY0a
 Lglltlmf6bggeTwcrxozHFcpuye/BD0C+tf5IXxd1GIM4nie4FphpYMKjyPEYL6TRpGx
 19rzJo6wH7ITwuu/KifXfwfY0xzrqbzyqLzJuWDjMbpsZE0MnHdOfXVyZQqjoMou3wmq
 o9qQ==
X-Gm-Message-State: AFqh2ko1X26KA4L2IELODPaYUnxq2qiYlL5MCnHjgPB36ighp1KVkN/z
 slXjerOy9PYwBukRGq14RxtFoctOWZxRWhZ6qGKuGMEc8gYhqmN2dC9sZNK/CzBOC6g5Z41ABK4
 ggf0xcESKtRBl7zNr3hY7K/lvgV1qx9+xwg38NND/zw==
X-Received: by 2002:aa7:d0c9:0:b0:498:d121:6e00 with SMTP id
 u9-20020aa7d0c9000000b00498d1216e00mr13325453edo.35.1673454368397; 
 Wed, 11 Jan 2023 08:26:08 -0800 (PST)
X-Google-Smtp-Source: AMrXdXtxM349cHuByHfYfwlhKliS60TqAwJqWGnKs7P1TQQQjs1c9z9H5hekBTG2DcqcKN3DEIbLDg==
X-Received: by 2002:aa7:d0c9:0:b0:498:d121:6e00 with SMTP id
 u9-20020aa7d0c9000000b00498d1216e00mr13325446edo.35.1673454368201; 
 Wed, 11 Jan 2023 08:26:08 -0800 (PST)
Received: from redhat.com ([109.253.181.221]) by smtp.gmail.com with ESMTPSA id
 ec11-20020a0564020d4b00b004948dc3d150sm6203670edb.88.2023.01.11.08.26.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Jan 2023 08:26:07 -0800 (PST)
Date: Wed, 11 Jan 2023 11:26:02 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eli Cohen <elic@nvidia.com>
Subject: Re: [PATCH 1/5] virtio_ring: per virtqueue dma device
Message-ID: <20230111112541-mutt-send-email-mst@kernel.org>
References: <20230111062809.25020-1-jasowang@redhat.com>
 <20230111062809.25020-2-jasowang@redhat.com>
 <DM8PR12MB5400E61C7E968AC7604556EBABFC9@DM8PR12MB5400.namprd12.prod.outlook.com>
 <20230111085210-mutt-send-email-mst@kernel.org>
 <DM8PR12MB54008B92885A8971C4CFED0EABFC9@DM8PR12MB5400.namprd12.prod.outlook.com>
 <20230111095358-mutt-send-email-mst@kernel.org>
 <DM8PR12MB54005A89EB05BF46AD7D2DFEABFC9@DM8PR12MB5400.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <DM8PR12MB54005A89EB05BF46AD7D2DFEABFC9@DM8PR12MB5400.namprd12.prod.outlook.com>
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

On Wed, Jan 11, 2023 at 02:58:21PM +0000, Eli Cohen wrote:
> > -----Original Message-----
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Wednesday, 11 January 2023 16:54
> > To: Eli Cohen <elic@nvidia.com>
> > Cc: Jason Wang <jasowang@redhat.com>; gdawar@amd.com;
> > virtualization@lists.linux-foundation.org; linux-kernel@vger.kernel.org;
> > tanuj.kamde@amd.com
> > Subject: Re: [PATCH 1/5] virtio_ring: per virtqueue dma device
> > 
> > On Wed, Jan 11, 2023 at 02:46:20PM +0000, Eli Cohen wrote:
> > > > From: Michael S. Tsirkin <mst@redhat.com>
> > > > Sent: Wednesday, 11 January 2023 15:53
> > > > To: Eli Cohen <elic@nvidia.com>
> > > > Cc: Jason Wang <jasowang@redhat.com>; gdawar@amd.com;
> > > > virtualization@lists.linux-foundation.org; linux-kernel@vger.kernel.org;
> > > > tanuj.kamde@amd.com
> > > > Subject: Re: [PATCH 1/5] virtio_ring: per virtqueue dma device
> > > >
> > > > On Wed, Jan 11, 2023 at 01:32:20PM +0000, Eli Cohen wrote:
> > > > > > From: Jason Wang <jasowang@redhat.com>
> > > > > > Sent: Wednesday, 11 January 2023 8:28
> > > > > > To: mst@redhat.com; jasowang@redhat.com
> > > > > > Cc: Eli Cohen <elic@nvidia.com>; gdawar@amd.com;
> > > > > > virtualization@lists.linux-foundation.org; linux-kernel@vger.kernel.org;
> > > > > > tanuj.kamde@amd.com
> > > > > > Subject: [PATCH 1/5] virtio_ring: per virtqueue dma device
> > > > > >
> > > > > > This patch introduces a per virtqueue dma device. This will be used
> > > > > > for virtio devices whose virtqueue are backed by different underlayer
> > > > > > devices.
> > > > > >
> > > > > > One example is the vDPA that where the control virtqueue could be
> > > > > > implemented through software mediation.
> > > > > >
> > > > > > Some of the work are actually done before since the helper like
> > > > > > vring_dma_device(). This work left are:
> > > > > >
> > > > > > - Let vring_dma_device() return the per virtqueue dma device instead
> > > > > >   of the vdev's parent.
> > > > > > - Allow passing a dma_device when creating the virtqueue through a
> > new
> > > > > >   helper, old vring creation helper will keep using vdev's parent.
> > > > > >
> > > > > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > > > > > ---
> > > > > >  drivers/virtio/virtio_ring.c | 133 ++++++++++++++++++++++++-----------
> > > > > >  include/linux/virtio_ring.h  |  16 +++++
> > > > > >  2 files changed, 109 insertions(+), 40 deletions(-)
> > > > > >
> > > > > > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > > > > > index 723c4e29e1d3..41144b5246a8 100644
> > > > > > --- a/drivers/virtio/virtio_ring.c
> > > > > > +++ b/drivers/virtio/virtio_ring.c
> > > > > > @@ -202,6 +202,9 @@ struct vring_virtqueue {
> > > > > >  	/* DMA, allocation, and size information */
> > > > > >  	bool we_own_ring;
> > > > > >
> > > > > > +	/* Device used for doing DMA */
> > > > > > +	struct device *dma_dev;
> > > > > > +
> > > > > >  #ifdef DEBUG
> > > > > >  	/* They're supposed to lock for us. */
> > > > > >  	unsigned int in_use;
> > > > > > @@ -219,7 +222,8 @@ static struct virtqueue
> > > > > > *__vring_new_virtqueue(unsigned int index,
> > > > > >  					       bool context,
> > > > > >  					       bool (*notify)(struct virtqueue *),
> > > > > >  					       void (*callback)(struct virtqueue
> > > > > > *),
> > > > > > -					       const char *name);
> > > > > > +					       const char *name,
> > > > > > +					       struct device *dma_dev);
> > > > > >  static struct vring_desc_extra *vring_alloc_desc_extra(unsigned int
> > num);
> > > > > >  static void vring_free(struct virtqueue *_vq);
> > > > > >
> > > > > > @@ -297,10 +301,11 @@ size_t virtio_max_dma_size(struct
> > virtio_device
> > > > > > *vdev)
> > > > > >  EXPORT_SYMBOL_GPL(virtio_max_dma_size);
> > > > > >
> > > > > >  static void *vring_alloc_queue(struct virtio_device *vdev, size_t size,
> > > > > > -			      dma_addr_t *dma_handle, gfp_t flag)
> > > > > > +			       dma_addr_t *dma_handle, gfp_t flag,
> > > > > > +			       struct device *dma_dev)
> > > > > >  {
> > > > > >  	if (vring_use_dma_api(vdev)) {
> > > > > > -		return dma_alloc_coherent(vdev->dev.parent, size,
> > > > > > +		return dma_alloc_coherent(dma_dev, size,
> > > > > >  					  dma_handle, flag);
> > > > > >  	} else {
> > > > > >  		void *queue = alloc_pages_exact(PAGE_ALIGN(size), flag);
> > > > > > @@ -330,10 +335,11 @@ static void *vring_alloc_queue(struct
> > > > virtio_device
> > > > > > *vdev, size_t size,
> > > > > >  }
> > > > > >
> > > > > >  static void vring_free_queue(struct virtio_device *vdev, size_t size,
> > > > > > -			     void *queue, dma_addr_t dma_handle)
> > > > > > +			     void *queue, dma_addr_t dma_handle,
> > > > > > +			     struct device *dma_dev)
> > > > > >  {
> > > > > >  	if (vring_use_dma_api(vdev))
> > > > > > -		dma_free_coherent(vdev->dev.parent, size, queue,
> > > > > > dma_handle);
> > > > > > +		dma_free_coherent(dma_dev, size, queue,
> > dma_handle);
> > > > > >  	else
> > > > > >  		free_pages_exact(queue, PAGE_ALIGN(size));
> > > > > >  }
> > > > > > @@ -341,11 +347,11 @@ static void vring_free_queue(struct
> > > > virtio_device
> > > > > > *vdev, size_t size,
> > > > > >  /*
> > > > > >   * The DMA ops on various arches are rather gnarly right now, and
> > > > > >   * making all of the arch DMA ops work on the vring device itself
> > > > > > - * is a mess.  For now, we use the parent device for DMA ops.
> > > > > > + * is a mess.
> > > > > >   */
> > > > > >  static inline struct device *vring_dma_dev(const struct
> > vring_virtqueue
> > > > *vq)
> > > > > >  {
> > > > > > -	return vq->vq.vdev->dev.parent;
> > > > > > +	return vq->dma_dev;
> > > > > >  }
> > > > >
> > > > > How about getting rid of this function and just use vq->dma_dev?
> > > >
> > > > Will make the patch even bigger than it is.
> > >
> > > I can't see how this can happen. You get rid of the function and you lose
> > overall 10 lines. What am I missing?
> > 
> > This is an existing function, if you drop it you need to refactor
> > more of the existing code. No?
> It's static function in the file that is used whenever you need the dma device.

my point is if we remove it we need to change all it's callers.

> > > > If you do patch on top pls.
> > >
> 

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

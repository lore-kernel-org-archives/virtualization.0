Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 782CEC433EF
	for <virtualization@archiver.kernel.org>; Thu,  7 Jul 2022 05:59:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 23B1883E2F;
	Thu,  7 Jul 2022 05:59:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 23B1883E2F
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=CWXzXyR4
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id swkKHTR4ToHl; Thu,  7 Jul 2022 05:59:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 8CF8883E11;
	Thu,  7 Jul 2022 05:59:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8CF8883E11
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5FB81C0035;
	Thu,  7 Jul 2022 05:59:27 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DF4BCC002D
 for <virtualization@lists.linux-foundation.org>;
 Thu,  7 Jul 2022 05:59:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id ACB4E83E11
 for <virtualization@lists.linux-foundation.org>;
 Thu,  7 Jul 2022 05:59:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org ACB4E83E11
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id txiHV-tP-quj
 for <virtualization@lists.linux-foundation.org>;
 Thu,  7 Jul 2022 05:59:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B349183E00
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B349183E00
 for <virtualization@lists.linux-foundation.org>;
 Thu,  7 Jul 2022 05:59:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1657173563;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2q7+TPvdFuP3InqW/d0k42xLZ4iHApQghMEZG4X8Q3Y=;
 b=CWXzXyR4IDvti3hon4k1qlXK8bsIwbZr+jUtbLRsmbvigGRAufeLxIF3GYOd82t8HMweLJ
 cLo2MShKHQE0ZjS9BnlTBV7F5v1JU89LHdvt48omsihiG6rz5gqHyX3BLq53fXDCxF1YIf
 EZ7pJYaJWU041doHjfl6Fr5v3Vkf4XE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-557-k2IVkuCGN4CGe5NG7buWtA-1; Thu, 07 Jul 2022 01:59:21 -0400
X-MC-Unique: k2IVkuCGN4CGe5NG7buWtA-1
Received: by mail-wr1-f70.google.com with SMTP id
 g9-20020adfa489000000b0021d6e786099so1665180wrb.7
 for <virtualization@lists.linux-foundation.org>;
 Wed, 06 Jul 2022 22:59:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=2q7+TPvdFuP3InqW/d0k42xLZ4iHApQghMEZG4X8Q3Y=;
 b=rfYClrDTntlYz3HJyq6lwN33oQbQpmRSvzwyiki1pyAGeEmSxHZw/5g/qaPXb/GrbH
 FDU1MN6z/B67NTAMndTbAZHaQzLNclaleVOqqSnTrpchKtyeOMhb5K8RRTEKrcVX/swe
 wTbj6DP/KKs2Dv1cbGDurQOh5wM9AfYW1A6gsiGLmgPRGZEE3Xy/m5YUz/dw6ge7erhJ
 uDxwkAwRpYwo4SlFb+FgXqhKgVZ81rgQXdZeDcgI/L+LIWB6qNJp4Ojg7BwuPO3bSP4m
 TyNVRksKt9/4QtfSIEpThoxIfYcgYLCoXu3D1/ebc2FhxgUHAUMxHF0pN/zXnsp4BGXd
 mBQg==
X-Gm-Message-State: AJIora+bUpQUwDdV4JU0RAeESRQ0l2DTsRfRPCXsBY4BwaU3Ufz1uMFk
 9dhWuu9uLyImuzdogexBzYxWR6oNFCp747CIc+I6OJtwxXlZipPZ8S/DvC0N+QeiNxivtIyILmV
 68KxRtu81E6Zhy/bnhPJIkmWIwHt+30Li8LVHVFSSdw==
X-Received: by 2002:a7b:cb10:0:b0:3a0:312c:fd3c with SMTP id
 u16-20020a7bcb10000000b003a0312cfd3cmr2423650wmj.52.1657173560283; 
 Wed, 06 Jul 2022 22:59:20 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vIV5TJdz/TGeZjg5Dll5Qb5msBn9er9oFFwlVrFx/xpgmeUCNvQRiviHdKEM7T4da2csThTQ==
X-Received: by 2002:a7b:cb10:0:b0:3a0:312c:fd3c with SMTP id
 u16-20020a7bcb10000000b003a0312cfd3cmr2423633wmj.52.1657173560015; 
 Wed, 06 Jul 2022 22:59:20 -0700 (PDT)
Received: from redhat.com ([2.52.154.68]) by smtp.gmail.com with ESMTPSA id
 o4-20020a05600c378400b003a2b708c26dsm7219527wmr.40.2022.07.06.22.59.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Jul 2022 22:59:19 -0700 (PDT)
Date: Thu, 7 Jul 2022 01:59:15 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Guo Zhi <qtxuning1999@sjtu.edu.cn>
Subject: Re: [PATCH v2 4/4] virtio_test: enable indirection feature
Message-ID: <20220707015717-mutt-send-email-mst@kernel.org>
References: <20220707024409.1869-1-qtxuning1999@sjtu.edu.cn>
 <20220707024409.1869-5-qtxuning1999@sjtu.edu.cn>
 <20220707005311-mutt-send-email-mst@kernel.org>
 <2ff418ad-0ab8-1474-4308-2d163c1e6652@sjtu.edu.cn>
MIME-Version: 1.0
In-Reply-To: <2ff418ad-0ab8-1474-4308-2d163c1e6652@sjtu.edu.cn>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: eperezma@redhat.com, linux-kernel@vger.kernel.org,
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

On Thu, Jul 07, 2022 at 01:56:37PM +0800, Guo Zhi wrote:
> On 2022/7/7 12:59, Michael S. Tsirkin wrote:
> > On Thu, Jul 07, 2022 at 10:44:09AM +0800, Guo Zhi wrote:
> > > Prior implementation don't use indirection feature because there is only
> > > one descriptor for every io event, actually prior implementation don't
> > > support indirection because vhost can't translate and find the indirect
> > > descriptors. This commit enable virtio_test malloc indirect descriptors
> > > in a indirect buffer and map this buffer to vhost, thus resolve this
> > > problem.
> > > 
> > > Signed-off-by: Guo Zhi <qtxuning1999@sjtu.edu.cn>
> > > ---
> > >   tools/virtio/virtio_test.c | 50 ++++++++++++++++++++++++++++++++------
> > >   1 file changed, 42 insertions(+), 8 deletions(-)
> > > 
> > > diff --git a/tools/virtio/virtio_test.c b/tools/virtio/virtio_test.c
> > > index 363695b33..dca408a5c 100644
> > > --- a/tools/virtio/virtio_test.c
> > > +++ b/tools/virtio/virtio_test.c
> > > @@ -25,7 +25,7 @@
> > >   #define RINGSIZE   256
> > >   #define TEST_BUF_NUM 0x100000
> > >   #define BUF_SIZE   1024
> > > -/* Unused */
> > > +#define INDIRECTS_SIZE   (RINGSIZE * sizeof(struct vring_desc) * 8)
> > >   void *__kmalloc_fake, *__kfree_ignore_start, *__kfree_ignore_end;
> > >   struct vq_info {
> > > @@ -47,6 +47,8 @@ struct vdev_info {
> > >   	int nvqs;
> > >   	void *buf;
> > >   	size_t buf_size;
> > > +	void *indirects;
> > > +	size_t indirects_size;
> > What are these exactly?
> The buffer is used to put indirect descriptors, and the buffer will be added
> in the vhost iotlb through VHOST_SET_MEM_TABLE, so that vhost can translate
> the descriptors in user mode correctly.

Pls come up with a better name. indirect_buf and indirect_buf_size?
And add a comment.

> > 
> > >   	struct vhost_memory *mem;
> > >   };
> > > @@ -131,6 +133,8 @@ static void vq_info_add(struct vdev_info *dev, int num)
> > >   static void vdev_info_init(struct vdev_info* dev, unsigned long long features)
> > >   {
> > >   	int r;
> > > +	int nregions = 2;
> > > +
> > >   	memset(dev, 0, sizeof *dev);
> > >   	dev->vdev.features = features;
> > >   	INIT_LIST_HEAD(&dev->vdev.vqs);
> > > @@ -138,19 +142,25 @@ static void vdev_info_init(struct vdev_info* dev, unsigned long long features)
> > >   	dev->buf_size = BUF_SIZE;
> > >   	dev->buf = malloc(dev->buf_size);
> > >   	assert(dev->buf);
> > > -        dev->control = open("/dev/vhost-test", O_RDWR);
> > > +	dev->indirects_size = INDIRECTS_SIZE;
> > > +	dev->indirects = malloc(dev->indirects_size);
> > > +	assert(dev->indirects);
> > > +	dev->control = open("/dev/vhost-test", O_RDWR);
> > >   	assert(dev->control >= 0);
> > >   	r = ioctl(dev->control, VHOST_SET_OWNER, NULL);
> > >   	assert(r >= 0);
> > >   	dev->mem = malloc(offsetof(struct vhost_memory, regions) +
> > > -			  sizeof dev->mem->regions[0]);
> > > +			(sizeof(dev->mem->regions[0])) * nregions);
> > >   	assert(dev->mem);
> > >   	memset(dev->mem, 0, offsetof(struct vhost_memory, regions) +
> > > -                          sizeof dev->mem->regions[0]);
> > > -	dev->mem->nregions = 1;
> > > +			(sizeof(dev->mem->regions[0])) * nregions);
> > > +	dev->mem->nregions = nregions;
> > >   	dev->mem->regions[0].guest_phys_addr = (long)dev->buf;
> > >   	dev->mem->regions[0].userspace_addr = (long)dev->buf;
> > >   	dev->mem->regions[0].memory_size = dev->buf_size;
> > > +	dev->mem->regions[1].guest_phys_addr = (long)dev->indirects;
> > > +	dev->mem->regions[1].userspace_addr = (long)dev->indirects;
> > > +	dev->mem->regions[1].memory_size = dev->indirects_size;
> > >   	r = ioctl(dev->control, VHOST_SET_MEM_TABLE, dev->mem);
> > >   	assert(r >= 0);
> > >   }
> > > @@ -170,6 +180,19 @@ static void wait_for_interrupt(struct vdev_info *dev)
> > >   		}
> > >   }
> > > +static int test_virtqueue_add_outbuf(struct virtqueue *vq,
> > > +				     struct scatterlist *sg, unsigned int num,
> > > +				     void *data, void *indirects)
> > > +{
> > > +	int r;
> > > +
> > > +	__kmalloc_fake = indirects;
> > > +	r = virtqueue_add_outbuf(vq, sg, num, data,
> > > +				 GFP_ATOMIC);
> > > +	__kmalloc_fake = NULL;
> > > +	return r;
> > > +}
> > > +
> > Quite a hack. Please add comments with documentation. Also - no way to
> > avoid hacks?
> 
> The __kmalloc_fake is refered from vringh_test.
> 
> If not using __kmalloc_fake here, the vhost doesn't know how to translate
> the indirects descriptors(user address).
> 
> We may could register a single region as large as the whole virtual space in
> the vhost iotlb using 1:1 mapping.
> 
> But since they are tests, IMHO, better here to use VHOST_SET_MEM_TABLE with
> more regions.

But why do we need to do this on each buffer add?

> > 
> > >   static void run_test(struct vdev_info *dev, struct vq_info *vq,
> > >   		     bool delayed, int batch, int reset_n, int bufs)
> > >   {
> > > @@ -181,6 +204,7 @@ static void run_test(struct vdev_info *dev, struct vq_info *vq,
> > >   	unsigned len;
> > >   	long long spurious = 0;
> > >   	const bool random_batch = batch == RANDOM_BATCH;
> > > +	void *indirects;
> > >   	r = ioctl(dev->control, VHOST_TEST_RUN, &test);
> > >   	assert(r >= 0);
> > > @@ -188,10 +212,15 @@ static void run_test(struct vdev_info *dev, struct vq_info *vq,
> > >   		next_reset = INT_MAX;
> > >   	}
> > > +	/* Don't kfree indirects. */
> > > +	__kfree_ignore_start = dev->indirects;
> > > +	__kfree_ignore_end = dev->indirects + dev->indirects_size;
> > > +
> > >   	for (;;) {
> > >   		virtqueue_disable_cb(vq->vq);
> > >   		completed_before = completed;
> > >   		started_before = started;
> > > +		indirects = dev->indirects;
> > >   		do {
> > >   			const bool reset = completed > next_reset;
> > >   			if (random_batch)
> > > @@ -203,9 +232,13 @@ static void run_test(struct vdev_info *dev, struct vq_info *vq,
> > >   				sg_init_table(sg, sg_size);
> > >   				for (int i = 0; i < sg_size; ++i)
> > >   					sg_set_buf(&sg[i], dev->buf + i, 0x1);
> > > -				r = virtqueue_add_outbuf(vq->vq, sg, sg_size,
> > > -							 dev->buf + started,
> > > -							 GFP_ATOMIC);
> > > +
> > > +				// use indirects buffer repeatedly
> > 
> > C style comments please.
> It will be modified.
> > 
> > > +				if (indirects + sg_size * sizeof(struct vring_desc) >
> > > +						dev->indirects + dev->indirects_size)
> > > +					indirects = dev->indirects;
> > > +				r = test_virtqueue_add_outbuf(vq->vq, sg, sg_size,
> > > +							      dev->buf + started, indirects);
> > >   				if (unlikely(r != 0)) {
> > >   					if (r == -ENOSPC &&
> > >   					    started > started_before)
> > > @@ -216,6 +249,7 @@ static void run_test(struct vdev_info *dev, struct vq_info *vq,
> > >   				}
> > >   				++started;
> > > +				indirects += sg_size * sizeof(struct vring_desc);
> > >   			}
> > >   			if (unlikely(!virtqueue_kick(vq->vq))) {
> > >   				r = -1;
> > > -- 
> > > 2.17.1
> 

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

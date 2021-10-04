Return-Path: <SRS0=QelU=OY=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66BBCC433EF
	for <virtualization@archiver.kernel.org>; Mon,  4 Oct 2021 15:39:45 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A30561357
	for <virtualization@archiver.kernel.org>; Mon,  4 Oct 2021 15:39:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1A30561357
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D75AC8440A;
	Mon,  4 Oct 2021 15:39:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 57_Apq_F80Dc; Mon,  4 Oct 2021 15:39:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 528D984244;
	Mon,  4 Oct 2021 15:39:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 24EE4C0011;
	Mon,  4 Oct 2021 15:39:43 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 94324C000D
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Oct 2021 15:39:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 90E56404F4
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Oct 2021 15:39:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yuYyX2ZP_k0z
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Oct 2021 15:39:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 772BC40184
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Oct 2021 15:39:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1633361979;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qU1FtB2Eld4jQppv2Kg9J4SKZoBotXi+g3+/KDP2nB0=;
 b=V4RtETxcvXDGWwaymAdFj+cVMsx0CwWQ+8SGt65LBzk/72qgDMANeDR8xUegslY8ca7ugF
 EL2DDlIWVBeGfhOY628IAzt14tmcNVobhnu3A4/vFJWebZ6k7LxYkH/w6qpIXVFoJtDvQr
 kTvGZvVjDtj1v5cTi+Jc9/KJPz4KcJY=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-8-J70mJlwHNwWfmOEzDHUdEg-1; Mon, 04 Oct 2021 11:39:38 -0400
X-MC-Unique: J70mJlwHNwWfmOEzDHUdEg-1
Received: by mail-ed1-f70.google.com with SMTP id
 t28-20020a508d5c000000b003dad7fc5caeso7674338edt.11
 for <virtualization@lists.linux-foundation.org>;
 Mon, 04 Oct 2021 08:39:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=qU1FtB2Eld4jQppv2Kg9J4SKZoBotXi+g3+/KDP2nB0=;
 b=1bcUqU5IWxEukWY7/ZhbLYhyNnj5XuiLY3OtFZRK/+dttbvPtIqhZV7Q4Qp0aO1Bx0
 up0WZC+nTsFjbXGvqzxYcjOjC116laroUv+WA7egmhmZyt9piFwNB8AelHjTBpdJr0lj
 ptgZlMmgPnCWERdptnBXM33kAVLcSrzvbNLWVRjJQECEB1yVPMpkhv+CmcMX3mkHTq9z
 VdNku+9vQGcwn270HnkcGIBKtmCgxe2K//O0m+0nXtMRmr6/sHLsn1FyfsFKUyUdNeYe
 usjEkt4qe+xj8FK4hXke+NX2BaXOF7nzY5stHMSai+PZM8lMGahHv33FQ9Q1MV2c7CuY
 68Wg==
X-Gm-Message-State: AOAM533W4XfJhSk/PskTyWLdjLH4G/AafFTyMj2QX4sYO+8KUEY1GM92
 g0e75h5P0NKz53H1ewIuCKxzPvnnCz4OhbAMu7JX0b3FASBcj+Y0BRJk2pm0i/Zo/mh1I/sdIlB
 xKlpaKiZCtBsLUdI3GYFuD9aw2W86cu1aIEN9ouM1MQ==
X-Received: by 2002:a17:906:a2c9:: with SMTP id
 by9mr13462726ejb.305.1633361977035; 
 Mon, 04 Oct 2021 08:39:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJymXaxS/ytfZ06+7jKPOhRySBzCqaPSUjBwPFfvyPHjd3iZN7oI5pN28PgDrC2yAGlapCwmMA==
X-Received: by 2002:a17:906:a2c9:: with SMTP id
 by9mr13462700ejb.305.1633361976806; 
 Mon, 04 Oct 2021 08:39:36 -0700 (PDT)
Received: from redhat.com (93-172-224-64.bb.netvision.net.il. [93.172.224.64])
 by smtp.gmail.com with ESMTPSA id
 o5sm7374753eds.26.2021.10.04.08.39.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Oct 2021 08:39:36 -0700 (PDT)
Date: Mon, 4 Oct 2021 11:39:33 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xie Yongji <xieyongji@bytedance.com>
Subject: Re: [PATCH v5] virtio-blk: Add validation for block size in config
 space
Message-ID: <20211004113722-mutt-send-email-mst@kernel.org>
References: <20210809101609.148-1-xieyongji@bytedance.com>
 <20211004112623-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20211004112623-mutt-send-email-mst@kernel.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 stefanha@redhat.com, virtualization@lists.linux-foundation.org
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

On Mon, Oct 04, 2021 at 11:27:29AM -0400, Michael S. Tsirkin wrote:
> On Mon, Aug 09, 2021 at 06:16:09PM +0800, Xie Yongji wrote:
> > An untrusted device might presents an invalid block size
> > in configuration space. This tries to add validation for it
> > in the validate callback and clear the VIRTIO_BLK_F_BLK_SIZE
> > feature bit if the value is out of the supported range.
> > 
> > And we also double check the value in virtblk_probe() in
> > case that it's changed after the validation.
> > 
> > Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
> 
> So I had to revert this due basically bugs in QEMU.
> 
> My suggestion at this point is to try and update
> blk_queue_logical_block_size to BUG_ON when the size
> is out of a reasonable range.
> 
> This has the advantage of fixing more hardware, not just virtio.
> 
> 
> 
> > ---
> >  drivers/block/virtio_blk.c | 39 +++++++++++++++++++++++++++++++++------
> >  1 file changed, 33 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> > index 4b49df2dfd23..afb37aac09e8 100644
> > --- a/drivers/block/virtio_blk.c
> > +++ b/drivers/block/virtio_blk.c
> > @@ -692,6 +692,28 @@ static const struct blk_mq_ops virtio_mq_ops = {
> >  static unsigned int virtblk_queue_depth;
> >  module_param_named(queue_depth, virtblk_queue_depth, uint, 0444);
> >  
> > +static int virtblk_validate(struct virtio_device *vdev)
> > +{
> > +	u32 blk_size;
> > +
> > +	if (!vdev->config->get) {
> > +		dev_err(&vdev->dev, "%s failure: config access disabled\n",
> > +			__func__);
> > +		return -EINVAL;
> > +	}
> > +
> > +	if (!virtio_has_feature(vdev, VIRTIO_BLK_F_BLK_SIZE))
> > +		return 0;
> > +
> > +	blk_size = virtio_cread32(vdev,
> > +			offsetof(struct virtio_blk_config, blk_size));
> > +
> > +	if (blk_size < SECTOR_SIZE || blk_size > PAGE_SIZE)
> > +		__virtio_clear_bit(vdev, VIRTIO_BLK_F_BLK_SIZE);
> > +
> > +	return 0;
> > +}
> > +
> >  static int virtblk_probe(struct virtio_device *vdev)
> >  {
> >  	struct virtio_blk *vblk;

I started wondering about this. So let's assume is
PAGE_SIZE < blk_size (after all it's up to guest at many platforms).

Will using the device even work given blk size is less than what
is can support?

And what exactly happens today if blk_size is out of this range?





> > @@ -703,12 +725,6 @@ static int virtblk_probe(struct virtio_device *vdev)
> >  	u8 physical_block_exp, alignment_offset;
> >  	unsigned int queue_depth;
> >  
> > -	if (!vdev->config->get) {
> > -		dev_err(&vdev->dev, "%s failure: config access disabled\n",
> > -			__func__);
> > -		return -EINVAL;
> > -	}
> > -
> >  	err = ida_simple_get(&vd_index_ida, 0, minor_to_index(1 << MINORBITS),
> >  			     GFP_KERNEL);
> >  	if (err < 0)
> > @@ -823,6 +839,14 @@ static int virtblk_probe(struct virtio_device *vdev)
> >  	else
> >  		blk_size = queue_logical_block_size(q);
> >  
> > +	if (unlikely(blk_size < SECTOR_SIZE || blk_size > PAGE_SIZE)) {
> > +		dev_err(&vdev->dev,
> > +			"block size is changed unexpectedly, now is %u\n",
> > +			blk_size);
> > +		err = -EINVAL;
> > +		goto err_cleanup_disk;
> > +	}
> > +
> >  	/* Use topology information if available */
> >  	err = virtio_cread_feature(vdev, VIRTIO_BLK_F_TOPOLOGY,
> >  				   struct virtio_blk_config, physical_block_exp,
> > @@ -881,6 +905,8 @@ static int virtblk_probe(struct virtio_device *vdev)
> >  	device_add_disk(&vdev->dev, vblk->disk, virtblk_attr_groups);
> >  	return 0;
> >  
> > +err_cleanup_disk:
> > +	blk_cleanup_disk(vblk->disk);
> >  out_free_tags:
> >  	blk_mq_free_tag_set(&vblk->tag_set);
> >  out_free_vq:
> > @@ -983,6 +1009,7 @@ static struct virtio_driver virtio_blk = {
> >  	.driver.name			= KBUILD_MODNAME,
> >  	.driver.owner			= THIS_MODULE,
> >  	.id_table			= id_table,
> > +	.validate			= virtblk_validate,
> >  	.probe				= virtblk_probe,
> >  	.remove				= virtblk_remove,
> >  	.config_changed			= virtblk_config_changed,
> > -- 
> > 2.11.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

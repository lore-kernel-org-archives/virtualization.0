Return-Path: <SRS0=LBOH=OZ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1492C433EF
	for <virtualization@archiver.kernel.org>; Tue,  5 Oct 2021 10:42:59 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 743C761409
	for <virtualization@archiver.kernel.org>; Tue,  5 Oct 2021 10:42:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 743C761409
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 364C060736;
	Tue,  5 Oct 2021 10:42:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YrkSVjYj-7jP; Tue,  5 Oct 2021 10:42:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 643A0606CF;
	Tue,  5 Oct 2021 10:42:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3BE75C0011;
	Tue,  5 Oct 2021 10:42:57 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7DD90C000D
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Oct 2021 10:42:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5D9C4400DF
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Oct 2021 10:42:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id sZRtInmdsl86
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Oct 2021 10:42:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5DA91400DD
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Oct 2021 10:42:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1633430573;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bnN0iAzDh/S8fsii9MloUrds9D80Vyvt+Eh8JOcls+c=;
 b=jAAGSj/1A9pe5/4ev1aSj2zdS6zPNf/13cTpMXeDaPa/wMUOiiIqVobXYAAEzfjh54W0Nb
 PUT/OEzxTFkYyyvY924F3A4W6uj0CVAGxMdFdWU+GGJVSwdQm6zRxaGFSOcMOJ/FCvz7aN
 UOE7/X39LkN4xlfs3B8G2gxA2MQiGcM=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-33-5JCyjPy7PxSil4PM_gIy9w-1; Tue, 05 Oct 2021 06:42:51 -0400
X-MC-Unique: 5JCyjPy7PxSil4PM_gIy9w-1
Received: by mail-ed1-f69.google.com with SMTP id
 n19-20020a509353000000b003dad185759bso12288880eda.6
 for <virtualization@lists.linux-foundation.org>;
 Tue, 05 Oct 2021 03:42:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=bnN0iAzDh/S8fsii9MloUrds9D80Vyvt+Eh8JOcls+c=;
 b=VZ3xN9kGUPhy8HszTMVrPR/Ra3pBNjwdiCzGFLlTLFyTur/cCAM+pNduM9jG85eCEP
 OSQAbFL9glSos5xCT+ubAyShJS1XYlbmZU2IlHI8gEVed+GtFqZWIR4AjBWVcQteIHnp
 eWp0xDWxYzQwPxIBdPUJCrEB5b1q3HwWns7/ed45fN2WKK62KYPHB9EjyJtHjCopZuGX
 OBlxxNoMReVWnGsmLU33OkrpC39HC0UqlrUN3Tw03FXBAqmIrUNkyLa+SR1Ym+tQYGoQ
 M1gVhdjbiEOEkKPk6R/aL3yvi1JdYSLPUtkmHeZCxrlteVLVVsxUs5vqIAPnvdlEm58g
 DrHw==
X-Gm-Message-State: AOAM5315ApUlozCyDg4YwiwBpzzdjdtCUo+IWz5Y2enDkESQUdS7tI8Z
 JcRy2JtvGO1BXbQDNGjQKVWzyyGiGihYZ2sWUEyHUkKY1lqWsnitwXk1rf5fTthVcRONQRpYeCo
 YdyMWDwKtGxXfUtYA0XYkKDttOW/9APQwTR33tnEMLg==
X-Received: by 2002:a17:906:608e:: with SMTP id
 t14mr23510385ejj.441.1633430570491; 
 Tue, 05 Oct 2021 03:42:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwACM112IUCa3fOx7O5XRyDrZ+g5wNyCBCOWtDMMiRFBtNmFLZZKgE9j8Wc70F7xxIuqg+/cw==
X-Received: by 2002:a17:906:608e:: with SMTP id
 t14mr23510362ejj.441.1633430570315; 
 Tue, 05 Oct 2021 03:42:50 -0700 (PDT)
Received: from redhat.com ([2.55.147.134])
 by smtp.gmail.com with ESMTPSA id a1sm8000402edu.43.2021.10.05.03.42.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Oct 2021 03:42:49 -0700 (PDT)
Date: Tue, 5 Oct 2021 06:42:43 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xie Yongji <xieyongji@bytedance.com>
Subject: Re: [PATCH v5] virtio-blk: Add validation for block size in config
 space
Message-ID: <20211005062359-mutt-send-email-mst@kernel.org>
References: <20210809101609.148-1-xieyongji@bytedance.com>
 <20211004112623-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20211004112623-mutt-send-email-mst@kernel.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, linux-block@vger.kernel.org,
 stefanha@redhat.com, Christoph Hellwig <hch@lst.de>
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

Stefan also pointed out this duplicates the logic from 

        if (blksize < 512 || blksize > PAGE_SIZE || !is_power_of_2(blksize))
                return -EINVAL;


and a bunch of other places.


Would it be acceptable for blk layer to validate the input
instead of having each driver do it's own thing?
Maybe inside blk_queue_logical_block_size?



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

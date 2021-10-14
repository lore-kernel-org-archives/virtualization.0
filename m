Return-Path: <SRS0=Buhk=PC=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95DABC433F5
	for <virtualization@archiver.kernel.org>; Thu, 14 Oct 2021 05:55:52 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B9FF61152
	for <virtualization@archiver.kernel.org>; Thu, 14 Oct 2021 05:55:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3B9FF61152
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 064B8406A7;
	Thu, 14 Oct 2021 05:55:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0E97Hx3tLQGo; Thu, 14 Oct 2021 05:55:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 86E32406B9;
	Thu, 14 Oct 2021 05:55:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 610C0C0011;
	Thu, 14 Oct 2021 05:55:50 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A1FE3C000D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 14 Oct 2021 05:55:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9D816401D8
 for <virtualization@lists.linux-foundation.org>;
 Thu, 14 Oct 2021 05:55:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NqJJicUS_TUX
 for <virtualization@lists.linux-foundation.org>;
 Thu, 14 Oct 2021 05:55:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9554840004
 for <virtualization@lists.linux-foundation.org>;
 Thu, 14 Oct 2021 05:55:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1634190947;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BAJQlUnpJGNYVVkjFBgbYcXUFXkFAM867FKrPwKtnBU=;
 b=NNDQZ+bdSYTRHFAsQEbP6mmTdTKpQq7mcneILI+pWw6nmZ6YtuUZXrMe4PZxiRaxviOtNv
 IPZ/Dt2PDRSR5dRVznFitR6qgtcSviqDTUTgHPBgozuvacAVkd/FSxAh/4R//cU/sTCga+
 NFzJ/7klAQGMVOCU7K3vC2oVPG5FrCM=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-561-dOKMMcHVP-Oxv6pAevKkiQ-1; Thu, 14 Oct 2021 01:55:45 -0400
X-MC-Unique: dOKMMcHVP-Oxv6pAevKkiQ-1
Received: by mail-ed1-f70.google.com with SMTP id
 i7-20020a50d747000000b003db0225d219so4302823edj.0
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Oct 2021 22:55:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=BAJQlUnpJGNYVVkjFBgbYcXUFXkFAM867FKrPwKtnBU=;
 b=0+FTjb8Y28FiYB8X62zEr4HDBeDNco5NZiY9NMyWDCyRPhynEmlzM0I8v8n7WNkHCU
 xziyo4tb2H7WVoNVtOV045ouIBMUAY8yDhBRt4MpKWGtdsQAx6ONoqd+OKEy31cx+/AD
 /3nOF+zn55K+EFxvMFz8wMIl6cUpa9gbn5r1ztk0lTbZBVarI0wqUx1+jIuFAL8rGd1l
 hW9qbIB8lMCZLga7sKixY5+nGZPqosazT8tSEgMv52R1TqHo0Pc4cej0Lq5upiTBTqmO
 oyiylYxHkiDhdNfzLYY9SDo2jMG12UnWswM2COaT+aDCCN4QtjPeTpda0co2BelBX3Yq
 ykIw==
X-Gm-Message-State: AOAM531mnyaPHql10JfUZGQ4psrr5sozbL6QkTTeKpVCXSOvI2JgOZ5X
 juqnYZVojH7cakne5vKASpS+VhzODZSjXF5SUVcEQv7V4We/2Xfh1equAo0OMHNyGF2pB8H545A
 J8zn+Xl8IsQpZ/n/12jjUEtxB+huhevzOebFY8LVPHQ==
X-Received: by 2002:a17:906:fb19:: with SMTP id
 lz25mr1476004ejb.406.1634190944463; 
 Wed, 13 Oct 2021 22:55:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzkfgQIXxK3a8hnf8Yk/1EOBU93PwQ/K7bp1CzcCdKlz/OHkGbWKA2JjGysHrbIwPi9cJl4zA==
X-Received: by 2002:a17:906:fb19:: with SMTP id
 lz25mr1475987ejb.406.1634190944256; 
 Wed, 13 Oct 2021 22:55:44 -0700 (PDT)
Received: from redhat.com ([2.55.16.227])
 by smtp.gmail.com with ESMTPSA id oz11sm1030711ejc.72.2021.10.13.22.55.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Oct 2021 22:55:43 -0700 (PDT)
Date: Thu, 14 Oct 2021 01:55:39 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH] Revert "virtio-blk: Add validation for block size in
 config space"
Message-ID: <20211014015029-mutt-send-email-mst@kernel.org>
References: <20211013124553.23803-1-mst@redhat.com>
 <CACGkMEvoE8+FxvX_vJEqEuqHptHu1-0TyM4j1P=cnRiBD6-1vA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEvoE8+FxvX_vJEqEuqHptHu1-0TyM4j1P=cnRiBD6-1vA@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Jens Axboe <axboe@kernel.dk>, linux-kernel <linux-kernel@vger.kernel.org>,
 stable@vger.kernel.org,
 virtualization <virtualization@lists.linux-foundation.org>,
 linux-block@vger.kernel.org, Xie Yongji <xieyongji@bytedance.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
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

On Thu, Oct 14, 2021 at 10:45:25AM +0800, Jason Wang wrote:
> On Wed, Oct 13, 2021 at 8:46 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > It turns out that access to config space before completing the feature
> > negotiation is broken for big endian guests at least with QEMU hosts up
> > to 6.1 inclusive.  This affects any device that accesses config space in
> > the validate callback: at the moment that is virtio-net with
> > VIRTIO_NET_F_MTU but since 82e89ea077b9 ("virtio-blk: Add validation for
> > block size in config space") that also started affecting virtio-blk with
> > VIRTIO_BLK_F_BLK_SIZE.
> 
> Ok, so it looks like I need to do something similar in my series to
> validate max_nr_ports in probe() instead of validate()? (multi port is
> not enabled by default).

I think what we should do is fix upstream QEMU first. With that, plus
Halil's work-around writing out the version 1 feature, we should be
good reading config in validate.

> 
> I wonder if we need to document this and rename the validate to
> validate_features() (since we can do very little thing if we can't
> read config in .validate()).

That's not a bad idea anyway - any validation that does not
need to clear features can be done in probe in any case.


> > Further, unlike VIRTIO_NET_F_MTU which is off by
> > default on QEMU, VIRTIO_BLK_F_BLK_SIZE is on by default, which resulted
> > in lots of people not being able to boot VMs on BE.
> >
> > The spec is very clear that what we are doing is legal so QEMU needs to
> > be fixed, but given it's been broken for so many years and no one
> > noticed, we need to give QEMU a bit more time before applying this.
> >
> > Further, this patch is incomplete (does not check blk size is a power
> > of two) and it duplicates the logic from nbd.
> >
> > Revert for now, and we'll reapply a cleaner logic in the next release.
> >
> > Cc: stable@vger.kernel.org
> > Fixes: 82e89ea077b9 ("virtio-blk: Add validation for block size in config space")
> > Cc: Xie Yongji <xieyongji@bytedance.com>
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> 
> Acked-by: jason Wang <jasowang@redhat.com>
> 
> > ---
> >  drivers/block/virtio_blk.c | 37 ++++++-------------------------------
> >  1 file changed, 6 insertions(+), 31 deletions(-)
> >
> > diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> > index 9b3bd083b411..303caf2d17d0 100644
> > --- a/drivers/block/virtio_blk.c
> > +++ b/drivers/block/virtio_blk.c
> > @@ -689,28 +689,6 @@ static const struct blk_mq_ops virtio_mq_ops = {
> >  static unsigned int virtblk_queue_depth;
> >  module_param_named(queue_depth, virtblk_queue_depth, uint, 0444);
> >
> > -static int virtblk_validate(struct virtio_device *vdev)
> > -{
> > -       u32 blk_size;
> > -
> > -       if (!vdev->config->get) {
> > -               dev_err(&vdev->dev, "%s failure: config access disabled\n",
> > -                       __func__);
> > -               return -EINVAL;
> > -       }
> > -
> > -       if (!virtio_has_feature(vdev, VIRTIO_BLK_F_BLK_SIZE))
> > -               return 0;
> > -
> > -       blk_size = virtio_cread32(vdev,
> > -                       offsetof(struct virtio_blk_config, blk_size));
> > -
> > -       if (blk_size < SECTOR_SIZE || blk_size > PAGE_SIZE)
> > -               __virtio_clear_bit(vdev, VIRTIO_BLK_F_BLK_SIZE);
> > -
> > -       return 0;
> > -}
> > -
> >  static int virtblk_probe(struct virtio_device *vdev)
> >  {
> >         struct virtio_blk *vblk;
> > @@ -722,6 +700,12 @@ static int virtblk_probe(struct virtio_device *vdev)
> >         u8 physical_block_exp, alignment_offset;
> >         unsigned int queue_depth;
> >
> > +       if (!vdev->config->get) {
> > +               dev_err(&vdev->dev, "%s failure: config access disabled\n",
> > +                       __func__);
> > +               return -EINVAL;
> > +       }
> > +
> >         err = ida_simple_get(&vd_index_ida, 0, minor_to_index(1 << MINORBITS),
> >                              GFP_KERNEL);
> >         if (err < 0)
> > @@ -836,14 +820,6 @@ static int virtblk_probe(struct virtio_device *vdev)
> >         else
> >                 blk_size = queue_logical_block_size(q);
> >
> > -       if (blk_size < SECTOR_SIZE || blk_size > PAGE_SIZE) {
> > -               dev_err(&vdev->dev,
> > -                       "block size is changed unexpectedly, now is %u\n",
> > -                       blk_size);
> > -               err = -EINVAL;
> > -               goto out_cleanup_disk;
> > -       }
> > -
> >         /* Use topology information if available */
> >         err = virtio_cread_feature(vdev, VIRTIO_BLK_F_TOPOLOGY,
> >                                    struct virtio_blk_config, physical_block_exp,
> > @@ -1009,7 +985,6 @@ static struct virtio_driver virtio_blk = {
> >         .driver.name                    = KBUILD_MODNAME,
> >         .driver.owner                   = THIS_MODULE,
> >         .id_table                       = id_table,
> > -       .validate                       = virtblk_validate,
> >         .probe                          = virtblk_probe,
> >         .remove                         = virtblk_remove,
> >         .config_changed                 = virtblk_config_changed,
> > --
> > MST
> >

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

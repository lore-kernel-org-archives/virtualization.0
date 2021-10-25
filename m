Return-Path: <SRS0=ZIIO=PN=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 136D9C433FE
	for <virtualization@archiver.kernel.org>; Mon, 25 Oct 2021 17:21:23 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B51FF60C49
	for <virtualization@archiver.kernel.org>; Mon, 25 Oct 2021 17:21:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B51FF60C49
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 6C77A403A0;
	Mon, 25 Oct 2021 17:21:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nOL2Xl-qdRIp; Mon, 25 Oct 2021 17:21:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id C868140192;
	Mon, 25 Oct 2021 17:21:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 76A3AC0012;
	Mon, 25 Oct 2021 17:21:20 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 06227C000E
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Oct 2021 17:21:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id DAF1F40192
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Oct 2021 17:21:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3cABmvqqU92C
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Oct 2021 17:21:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E984C40388
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Oct 2021 17:21:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1635182476;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=951N6fckZ5XpWCmhYbFd+TMi4ClcrotPVi9JGI1/vNA=;
 b=DhzGmvKMVREjuIBUG4tD4XkaziDrflu3L/sVRqdiVgVcBiVNvXC0d+9MtiZXbwR13LBygO
 lS3kEycpemD1AOsQJXi7K9cGG7Xeef/tsnry7oBxx5iZmkMocI/GXuObk/n4FqFDsryDSx
 Zvw34Ok/zRG4JQy3sp9CAfTq/uoFKhU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-562-zVCI4qWhPXWr9hAt7vgaLQ-1; Mon, 25 Oct 2021 13:21:15 -0400
X-MC-Unique: zVCI4qWhPXWr9hAt7vgaLQ-1
Received: by mail-wr1-f72.google.com with SMTP id
 i3-20020a5d5223000000b00167f0515e90so2878585wra.4
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Oct 2021 10:21:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=951N6fckZ5XpWCmhYbFd+TMi4ClcrotPVi9JGI1/vNA=;
 b=kWktn4WDl9QkOX4wOT6lRV25ExabecknkXBQMLWCX3hvvAJ1PCOfX1jn1dr7AoApjP
 WD699NaMZEL00I+xGhW4XlH+Wo510iwFzxwPOG1kSoTJNyBkVpd6uzKwlkaaKfjMS9ni
 7wV70t7gWZVckGy5cLQS18CsvIwYJJjFIWZQsWKq9Ty06JAbWE0GSMVhW6va4jqqbd/X
 ZFsmMeGy1bxyajM4nifMc0YZ6mK6RX+U2BOwtMNtCo7W1fGd71Zyti/GtdsIzXMU7+G/
 i13i4LwTgqI4VI9rQNhPj0w+p78Z2XOjCfzdhZctiMW2bwk53hEzaYcrGTzPXWBIR6IZ
 BZ4g==
X-Gm-Message-State: AOAM533A5PtD5+3nVXSdN92vzoaTDFQnyq6daKzGbN7zOV3D/s3xArg6
 JBO6PqbE7EWw0FTbUDT7eagJdMAL3bfdy74EEY7gdpnzdiK4MQeN6KchOGNoUFppbWwJG6xgMtU
 EcuqWK4c5LX0NL14yxE2wdB3x/8pPM0vCWqTVqAG01g==
X-Received: by 2002:adf:d1e6:: with SMTP id g6mr445654wrd.33.1635182474396;
 Mon, 25 Oct 2021 10:21:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzj1fTiGxIx6iukFpJuix4SvN3qiXy7bRCzCzSU/tCsoyaecfFSByMrrXTKu1tKjLZVO4MIag==
X-Received: by 2002:adf:d1e6:: with SMTP id g6mr445610wrd.33.1635182474064;
 Mon, 25 Oct 2021 10:21:14 -0700 (PDT)
Received: from redhat.com ([2.55.12.86])
 by smtp.gmail.com with ESMTPSA id f1sm12819845wrc.74.2021.10.25.10.21.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Oct 2021 10:21:13 -0700 (PDT)
Date: Mon, 25 Oct 2021 13:21:09 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Yongji Xie <xieyongji@bytedance.com>
Subject: Re: [PATCH 4/4] virtio-blk: Use blk_validate_block_size() to
 validate block size
Message-ID: <20211025131446-mutt-send-email-mst@kernel.org>
References: <20211025094306.97-1-xieyongji@bytedance.com>
 <20211025094306.97-5-xieyongji@bytedance.com>
 <20211025091911-mutt-send-email-mst@kernel.org>
 <CACycT3smA7sSdp-8BKUtN4OW7nkUX+NaW_x9JzfvVgUvM9Yh7A@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACycT3smA7sSdp-8BKUtN4OW7nkUX+NaW_x9JzfvVgUvM9Yh7A@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Jens Axboe <axboe@kernel.dk>, Josef Bacik <josef@toxicpanda.com>,
 nbd@other.debian.org, linux-block@vger.kernel.org,
 Stefan Hajnoczi <stefanha@redhat.com>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Christoph Hellwig <hch@lst.de>
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

On Mon, Oct 25, 2021 at 09:47:34PM +0800, Yongji Xie wrote:
> On Mon, Oct 25, 2021 at 9:20 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Mon, Oct 25, 2021 at 05:43:06PM +0800, Xie Yongji wrote:
> > > The block layer can't support the block size larger than
> > > page size yet. If an untrusted device presents an invalid
> > > block size in configuration space, it will result in the
> > > kernel crash something like below:
> > >
> > > [  506.154324] BUG: kernel NULL pointer dereference, address: 0000000000000008
> > > [  506.160416] RIP: 0010:create_empty_buffers+0x24/0x100
> > > [  506.174302] Call Trace:
> > > [  506.174651]  create_page_buffers+0x4d/0x60
> > > [  506.175207]  block_read_full_page+0x50/0x380
> > > [  506.175798]  ? __mod_lruvec_page_state+0x60/0xa0
> > > [  506.176412]  ? __add_to_page_cache_locked+0x1b2/0x390
> > > [  506.177085]  ? blkdev_direct_IO+0x4a0/0x4a0
> > > [  506.177644]  ? scan_shadow_nodes+0x30/0x30
> > > [  506.178206]  ? lru_cache_add+0x42/0x60
> > > [  506.178716]  do_read_cache_page+0x695/0x740
> > > [  506.179278]  ? read_part_sector+0xe0/0xe0
> > > [  506.179821]  read_part_sector+0x36/0xe0
> > > [  506.180337]  adfspart_check_ICS+0x32/0x320
> > > [  506.180890]  ? snprintf+0x45/0x70
> > > [  506.181350]  ? read_part_sector+0xe0/0xe0
> > > [  506.181906]  bdev_disk_changed+0x229/0x5c0
> > > [  506.182483]  blkdev_get_whole+0x6d/0x90
> > > [  506.183013]  blkdev_get_by_dev+0x122/0x2d0
> > > [  506.183562]  device_add_disk+0x39e/0x3c0
> > > [  506.184472]  virtblk_probe+0x3f8/0x79b [virtio_blk]
> > > [  506.185461]  virtio_dev_probe+0x15e/0x1d0 [virtio]
> > >
> > > So this patch tries to use the block layer helper to
> > > validate the block size.
> > >
> > > Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
> > > ---
> > >  drivers/block/virtio_blk.c | 7 +++++--
> > >  1 file changed, 5 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> > > index 303caf2d17d0..5bcacefe969e 100644
> > > --- a/drivers/block/virtio_blk.c
> > > +++ b/drivers/block/virtio_blk.c
> > > @@ -815,9 +815,12 @@ static int virtblk_probe(struct virtio_device *vdev)
> > >       err = virtio_cread_feature(vdev, VIRTIO_BLK_F_BLK_SIZE,
> > >                                  struct virtio_blk_config, blk_size,
> > >                                  &blk_size);
> > > -     if (!err)
> > > +     if (!err) {
> > > +             if (blk_validate_block_size(blk_size))
> > > +                     goto out_cleanup_disk;
> > > +
> >
> >
> > Did you test this with an invalid blk size? It seems unlikely that it
> > fails properly the way you'd expect.
> >
> 
> Oops... Sorry, I just checked whether the block device is created with
> invalid block size.
> 
> Will send v2 soon!
> 
> Thanks,
> Yongji

Please avoid doing that in the future. Posting untested patches is only
acceptable if you make it abundantly clear that they are untested.

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

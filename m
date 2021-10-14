Return-Path: <SRS0=Buhk=PC=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4B92C433F5
	for <virtualization@archiver.kernel.org>; Thu, 14 Oct 2021 05:45:14 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A8C9610E8
	for <virtualization@archiver.kernel.org>; Thu, 14 Oct 2021 05:45:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7A8C9610E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 35D7F40004;
	Thu, 14 Oct 2021 05:45:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id b0M5mrOCUzFH; Thu, 14 Oct 2021 05:45:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id A97A740162;
	Thu, 14 Oct 2021 05:45:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 61674C0011;
	Thu, 14 Oct 2021 05:45:12 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C087AC000D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 14 Oct 2021 05:45:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A1DC7606F5
 for <virtualization@lists.linux-foundation.org>;
 Thu, 14 Oct 2021 05:45:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id opWFQ2WeUsn6
 for <virtualization@lists.linux-foundation.org>;
 Thu, 14 Oct 2021 05:45:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8FC7A606B8
 for <virtualization@lists.linux-foundation.org>;
 Thu, 14 Oct 2021 05:45:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1634190308;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=95mUAaVAy4SDw5WDEVKHbawoK+B6f/qisstbgq6pucQ=;
 b=KiHC4vsUJboBOXUHql/TBeRMOHjOYaN8CV3FwN5ClFY/I0Edmk2g9V+EusCwwi0ICgCG6x
 xS1FSEFITz5c4e216D+MJugesOYR9YP/ljuc/uij9E5R9FeO7zw6jlNS+bhB4KZNI7KxUr
 HrXS0OWT8oczVvN/4tY6yNi5+w9nBUE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-473-beMWo6kBNPiWpmwG2It14w-1; Thu, 14 Oct 2021 01:45:06 -0400
X-MC-Unique: beMWo6kBNPiWpmwG2It14w-1
Received: by mail-wr1-f69.google.com with SMTP id
 h99-20020adf906c000000b001644add8925so495741wrh.0
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Oct 2021 22:45:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=95mUAaVAy4SDw5WDEVKHbawoK+B6f/qisstbgq6pucQ=;
 b=hdg3Zb65xitMzgILKziEERehTHcO1SJLAVZs8Y5v+9wBe9W0ec0Qd4769ZlliHS5dq
 Dy8oSaQbRQcrYsO4RivLL5zAz2cBsIHI1YbQoU/tlYWwmngMKuNOwRv4NQSUG3CzKvEh
 8b3KfEUUuCXqY5Htnh7MjSuYLo+Ch3fGqGvkzpMkDV3qY2/GfJ4jYKSCrv9Kp07HBvog
 Qrd0qnxMkcRFu+1Q4k8fZuPKmbpba1/MjBrXzWlaBIEt/Eu49R4VBKQrtdGsaaFYbW69
 71wjv8fvNobjnZCQk7umv44qBB+Mc7DXY44el22mIIuMia9a6Y9mpfG/MfDJTddte87O
 J9xg==
X-Gm-Message-State: AOAM531ZjaYe/IvKGAaOjtsohZj4G5EX3eLom2c3ivqLqPmPh1uXWVBu
 QMak3Q5wdzUr1nFvBPh+z2pX9L+8JFUdK9D2LJVhfgnkyj6DN2lfcNbbY30VQ7rWjHEaI12Xw2z
 fJM8MPIIDYZGAXfUZwzzCi2bWI0vlvsRS/zsWI2X3gA==
X-Received: by 2002:adf:fa8b:: with SMTP id h11mr4437430wrr.74.1634190305886; 
 Wed, 13 Oct 2021 22:45:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzlqBA7dxAcsi2M6NyYDFy65R1jTgZxOyb7b9adWL5LIoEn0+/hh2W82aFZr55WpHCWHZTlOQ==
X-Received: by 2002:adf:fa8b:: with SMTP id h11mr4437406wrr.74.1634190305701; 
 Wed, 13 Oct 2021 22:45:05 -0700 (PDT)
Received: from redhat.com ([2.55.16.227])
 by smtp.gmail.com with ESMTPSA id m4sm7074703wml.28.2021.10.13.22.45.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Oct 2021 22:45:05 -0700 (PDT)
Date: Thu, 14 Oct 2021 01:45:01 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH V2 01/12] virtio-blk: validate num_queues during probe
Message-ID: <20211014014210-mutt-send-email-mst@kernel.org>
References: <20211012065227.9953-1-jasowang@redhat.com>
 <20211012065227.9953-2-jasowang@redhat.com>
 <20211013060341-mutt-send-email-mst@kernel.org>
 <CACGkMEvJ76EBtx847HodDmoLDkz7QjFoJMBdgGTEeEoZ8W-9Sw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEvJ76EBtx847HodDmoLDkz7QjFoJMBdgGTEeEoZ8W-9Sw@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: "kaplan, david" <david.kaplan@amd.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, "Hetzelt,
 Felicitas" <f.hetzelt@tu-berlin.de>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
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

On Thu, Oct 14, 2021 at 10:32:32AM +0800, Jason Wang wrote:
> On Wed, Oct 13, 2021 at 6:04 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Tue, Oct 12, 2021 at 02:52:16PM +0800, Jason Wang wrote:
> > > If an untrusted device neogitates BLK_F_MQ but advertises a zero
> > > num_queues, the driver may end up trying to allocating zero size
> > > buffers where ZERO_SIZE_PTR is returned which may pass the checking
> > > against the NULL. This will lead unexpected results.
> > >
> > > Fixing this by using single queue if num_queues is zero.
> > >
> > > Cc: Paolo Bonzini <pbonzini@redhat.com>
> > > Cc: Stefan Hajnoczi <stefanha@redhat.com>
> > > Cc: Stefano Garzarella <sgarzare@redhat.com>
> > > Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> >
> > I'd rather fail probe so we don't need to support that.
> 
> I think we should be consistent among all virtio drivers.

Well we started being permissive. We can't change that
since that might break on some hosts. But given focus on
security being restrictive sounds better now.

> E.g without this patch, we stick to 1 if virtio_create_feature() fail.
> Do we need to fix that?

We can't easily, some hosts might be broken.

> And we do something similar at least for the virtio-net and a lot of
> other places.
> 
>         /* We need at least 2 queue's */
>         if (err || max_queue_pairs < VIRTIO_NET_CTRL_MQ_VQ_PAIRS_MIN ||
>             max_queue_pairs > VIRTIO_NET_CTRL_MQ_VQ_PAIRS_MAX ||
>             !virtio_has_feature(vdev, VIRTIO_NET_F_CTRL_VQ))
>                 max_queue_pairs = 1;
> 
> Thanks
> 
> >
> > > ---
> > >  drivers/block/virtio_blk.c | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> > > index 9b3bd083b411..9deff01a38cb 100644
> > > --- a/drivers/block/virtio_blk.c
> > > +++ b/drivers/block/virtio_blk.c
> > > @@ -495,7 +495,8 @@ static int init_vq(struct virtio_blk *vblk)
> > >       err = virtio_cread_feature(vdev, VIRTIO_BLK_F_MQ,
> > >                                  struct virtio_blk_config, num_queues,
> > >                                  &num_vqs);
> > > -     if (err)
> > > +     /* We need at least one virtqueue */
> > > +     if (err || !num_vqs)
> > >               num_vqs = 1;
> > >
> > >       num_vqs = min_t(unsigned int, nr_cpu_ids, num_vqs);
> > > --
> > > 2.25.1
> >

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

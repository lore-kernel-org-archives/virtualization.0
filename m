Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23EC8C77B7D
	for <virtualization@archiver.kernel.org>; Thu, 18 May 2023 14:01:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 892DD42B30;
	Thu, 18 May 2023 14:01:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 892DD42B30
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=gv2C+v/Y
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zmK8Bvfrw1vc; Thu, 18 May 2023 14:01:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id BC11E42B1B;
	Thu, 18 May 2023 14:01:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org BC11E42B1B
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 98D4FC0035;
	Thu, 18 May 2023 14:01:07 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 95423C002A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 May 2023 14:01:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 62714608A5
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 May 2023 14:01:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 62714608A5
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=gv2C+v/Y
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KeWl5qIsXuQL
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 May 2023 14:01:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E651160783
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E651160783
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 May 2023 14:01:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684418460;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OqoT1ooiwuLnfzzgibH0FBhUwM4Y+miV1PDEA23wRik=;
 b=gv2C+v/Y2FdFKAqTjjVV+9eOpOsVZ88cbjd3IUZg8Bd0Mx1DGIFDvirU3BoFSV6RNZFL1z
 BEN+MclBx8XINczXR/J2mw90B/VFVIvskPllkkysJlPOg1ogpx85FD017tq7TX7ppikltB
 FKClb63AOY0k0Qshl/OZx3ZzYj45v6U=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-383-oEEj5LJQNuqPQ1QkNr1EKw-1; Thu, 18 May 2023 10:00:59 -0400
X-MC-Unique: oEEj5LJQNuqPQ1QkNr1EKw-1
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-4f37c82f185so1374101e87.0
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 May 2023 07:00:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684418457; x=1687010457;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OqoT1ooiwuLnfzzgibH0FBhUwM4Y+miV1PDEA23wRik=;
 b=epDxeE7e7Bht9GnRXzD6MQ8ZQ4W02IMRl6SrroOH+DK/bC9+BEqvCs3IGgScF5yPlq
 g4x6DFFTjBtu97WfITLwhmjelhcOm3cOh1r7ZZ/IPdXazvwXQDXj3hWIQOncGpNQ0+SQ
 7P9IEVpz4EdqqEEgCFO3BCxRAkhvOWauc8FQIABlBUVrJY2U6FyLG/S+jkTl3fAAH8hS
 0E8GpJ7BaXmiq7VjJhNNHIWHpmoZEnXwL2uQrbi3h1n7pw/guxgcCkVulOpy5k05QpZu
 6bwwDwSx6FWqARBofkOKAvjRsOSHpMPtrOqIOb2I/KlT2dqo0OZ9p+vH8X/lvlcOG8a3
 KOAQ==
X-Gm-Message-State: AC+VfDx6fibkvKQKc18Ics/JiDBo/6znJ2jZKGUteO0JqmyWiy941lxZ
 7J2pGKhCgAo33rIY77ktLqcZYF5fxvhEYcXsL3pxSwMhJXgnlEWPjLkjDlTPmPTJ5la4YjUi/zd
 C8+0CkP6zF0DNm9/szYkLm2UBrWBp7Jt2n/7HBVE7/w==
X-Received: by 2002:a05:6512:38d1:b0:4f3:7a8c:d46c with SMTP id
 p17-20020a05651238d100b004f37a8cd46cmr1173631lft.66.1684418457678; 
 Thu, 18 May 2023 07:00:57 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7Abdv0LZtEhZjOfwdOw5QMtS6LhlvQJIsG6dCBq1tcpgeX/m9kQrOnS4xHur6uGOTsP5Li/Q==
X-Received: by 2002:a05:6512:38d1:b0:4f3:7a8c:d46c with SMTP id
 p17-20020a05651238d100b004f37a8cd46cmr1173625lft.66.1684418457238; 
 Thu, 18 May 2023 07:00:57 -0700 (PDT)
Received: from redhat.com ([2a02:14f:175:3e4d:6703:27b9:6f74:5282])
 by smtp.gmail.com with ESMTPSA id
 a29-20020a056512021d00b004f3940f21dasm252843lfo.301.2023.05.18.07.00.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 May 2023 07:00:56 -0700 (PDT)
Date: Thu, 18 May 2023 10:00:46 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH vhost v9 10/12] virtio_ring: correct the expression of
 the description of virtqueue_resize()
Message-ID: <20230518082612-mutt-send-email-mst@kernel.org>
References: <20230517022249.20790-1-xuanzhuo@linux.alibaba.com>
 <20230517022249.20790-11-xuanzhuo@linux.alibaba.com>
 <1684411970.7875407-2-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <1684411970.7875407-2-xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Christoph Hellwig <hch@infradead.org>,
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

On Thu, May 18, 2023 at 08:12:50PM +0800, Xuan Zhuo wrote:
> On Wed, 17 May 2023 10:22:47 +0800, Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
> > Modify the "useless" to a more accurate "unused".
> >
> > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > Acked-by: Jason Wang <jasowang@redhat.com>
> 
> 
> Hi Michael,
> 
> Currently, we have to discuss a few cases regarding dma-premapped. Can you
> merge the three patches behind this (including this one)? These have nothing to
> do with dma-premapped.
> 
> Should I post a new patch set separately?
> 
> Thanks.


Please do.

> 
> 
> 
> > ---
> >  drivers/virtio/virtio_ring.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > index 42730c4ecdc5..c90160d2d280 100644
> > --- a/drivers/virtio/virtio_ring.c
> > +++ b/drivers/virtio/virtio_ring.c
> > @@ -2734,7 +2734,7 @@ EXPORT_SYMBOL_GPL(vring_create_virtqueue_dma);
> >   * virtqueue_resize - resize the vring of vq
> >   * @_vq: the struct virtqueue we're talking about.
> >   * @num: new ring num
> > - * @recycle: callback for recycle the useless buffer
> > + * @recycle: callback to recycle unused buffers
> >   *
> >   * When it is really necessary to create a new vring, it will set the current vq
> >   * into the reset state. Then call the passed callback to recycle the buffer
> > --
> > 2.32.0.3.g01195cf9f
> >

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

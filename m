Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4BA0C433EF
	for <virtualization@archiver.kernel.org>; Tue, 19 Jul 2022 21:31:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5AF9F82EDB;
	Tue, 19 Jul 2022 21:31:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5AF9F82EDB
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=YLKquV8K
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RWApdvFBssFm; Tue, 19 Jul 2022 21:31:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id CA66A80A9A;
	Tue, 19 Jul 2022 21:31:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org CA66A80A9A
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A8E3AC0033;
	Tue, 19 Jul 2022 21:31:56 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5F27AC002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Jul 2022 21:31:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2EDBB82E95
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Jul 2022 21:31:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2EDBB82E95
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DamugC31XbRu
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Jul 2022 21:31:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org DDD5080A9A
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id DDD5080A9A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Jul 2022 21:31:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1658266312;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BZUhztkXgylP7x29mvXh1lO6FSwsyErGTF/6AoFUmjY=;
 b=YLKquV8KBofeS8w1CioxdJl5SlWfqHQgPEp5r/OkKDtfN3mIUE+nORfVGCOI245YvxAEay
 oCX5SmIBN4ERTxkk9ebvDilUftaq90JWTS34CsCZ3B8ifOC92MqZeTG0bjKIYObjaO7TBO
 ruEeSeeHScrnx9eJP7d7nqJv/Uce2CY=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-634-vtIBt4bUPEexkKCjX1z8SQ-1; Tue, 19 Jul 2022 17:31:51 -0400
X-MC-Unique: vtIBt4bUPEexkKCjX1z8SQ-1
Received: by mail-ed1-f72.google.com with SMTP id
 b15-20020a056402278f00b0043acaf76f8dso10834202ede.21
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Jul 2022 14:31:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=BZUhztkXgylP7x29mvXh1lO6FSwsyErGTF/6AoFUmjY=;
 b=SS23W1aDV5jAMdSI6Z2eLaS3zrKWB4jXk9HxmE4GGqnNfgTYXEeMPg3ugIvDj8KA30
 LlCgjDBTWUN0O1tgPRKZADrowTq2M3PlMaU1V84s8CNHvbNSUZ5Ry/+G5WmBhNADQk61
 Y1KsbyjXICkM2NyjUSRyjrUzRz4zskruiGtgX9SLHuBW4qCj9mM2Uobc9bAUK17EO4Fz
 u1eoHKvThwKOfKLuyuUwpYh/krZfJ5mQO+Ovhad5OmWHgDSxmBL9Mgnfh/TGVMxWHwG3
 0wHlICpl6yspFETdZu69wODxN6j2YK/Wp13/gbziTskYdMmy3FRs8ufsLHjG0tWE9GCl
 bJeQ==
X-Gm-Message-State: AJIora/fL9Qv2VTAXego8KbOcOg+o69KqEPjxlPPrydNhIyO0Rmhh8QU
 EyhrJKYc6SLPY9f4nKRn4l6FkoNcsoWAM9/v8u6ukAQ7bOqlvNnmMvIo6bNUkPhb/9rO8ufq7mL
 w8+EhNNJj3yS9Oc4nWsQEoRWZ04/aFxJnCM4kv6tT6w==
X-Received: by 2002:a17:907:6d26:b0:72b:3a72:a117 with SMTP id
 sa38-20020a1709076d2600b0072b3a72a117mr31945706ejc.280.1658266310153; 
 Tue, 19 Jul 2022 14:31:50 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1s5iAzLyUDTj2fQ0Ll1zvPxL/U2luYNZUH/ySNV2VfBHAvovv/mA383vCir7H2KGbK6FCcfdQ==
X-Received: by 2002:a17:907:6d26:b0:72b:3a72:a117 with SMTP id
 sa38-20020a1709076d2600b0072b3a72a117mr31945691ejc.280.1658266309866; 
 Tue, 19 Jul 2022 14:31:49 -0700 (PDT)
Received: from redhat.com ([2a03:c5c0:207e:f101:7ade:a844:162d:171a])
 by smtp.gmail.com with ESMTPSA id
 o18-20020a170906769200b00726abf9a32bsm7166887ejm.138.2022.07.19.14.31.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Jul 2022 14:31:49 -0700 (PDT)
Date: Tue, 19 Jul 2022 17:31:45 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Keir Fraser <keirf@google.com>
Subject: Re: [PATCH] virtio: Force DMA restricted devices through DMA API
Message-ID: <20220719172607-mutt-send-email-mst@kernel.org>
References: <20220719100256.419780-1-keirf@google.com>
 <20220719074941-mutt-send-email-mst@kernel.org>
 <Yta6RowkzVbXaSt2@google.com>
MIME-Version: 1.0
In-Reply-To: <Yta6RowkzVbXaSt2@google.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: kernel-team@android.com, linux-kernel@vger.kernel.org,
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

On Tue, Jul 19, 2022 at 02:05:58PM +0000, Keir Fraser wrote:
> On Tue, Jul 19, 2022 at 07:56:09AM -0400, Michael S. Tsirkin wrote:
> > On Tue, Jul 19, 2022 at 10:02:56AM +0000, Keir Fraser wrote:
> > > If virtio devices are tagged for "restricted-dma-pool", then that
> > > pool should be used for virtio ring setup, via the DMA API.
> > > 
> > > In particular, this fixes virtio_balloon for ARM PKVM, where the usual
> > > workaround of setting VIRTIO_F_ACCESS_PLATFORM in the virtio device
> > > doesn't work because the virtio_balloon driver clears the flag. This
> > > seems a more robust fix than fiddling the flag again.
> > > 
> > > Signed-off-by: Keir Fraser <keirf@google.com>
> > 
> > 
> > So the reason balloon disables ACCESS_PLATFORM is simply
> > because it passes physical addresses to device and
> > expects device to be able to poke at them.
> > 
> > I worry about modifying DMA semantics yet again - it has as much of a
> > chance to break some legacy configs as it has to fix some.
> > 
> > 
> > And I don't really know much about restricted-dma-pool but
> > I'd like to understand why does it make sense to set it for
> > the balloon since it pokes at all and any system memory.
> 
> So this is set in the device tree by the host, telling it to bounce all DMA
> through a restricted memory window (basically swiotlb). The original reason
> is simply to isolate DMA, to the extent possible, on IOMMU-less systems.
> 
> However it is also useful for PKVM because the host is not trusted to access
> ordinary protected VM memory.

I'll have to read up on pKVM. Will get back to you.

> To allow I/O via the host, restricted-dma-pool
> is used to cause a bounce aperture to be allocated during VM boot, which is
> then explicitly shared with the host. For correct PKVM virtio operation, all
> data *and metadata* (virtio rings and descriptors) must be allocated in or
> bounced through this aperture.
>
> Insofar as virtio device accesses to virtio rings in guest memory essentially
> *are* DMA (from the pov of the guest), I think it makes sense to respect the
> bounce buffer for those rings, if so configured by the device tree.
>
> > > ---
> > >  drivers/virtio/virtio_ring.c | 8 ++++++++
> > >  1 file changed, 8 insertions(+)
> > > 
> > > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > > index a5ec724c01d8..12be2607c648 100644
> > > --- a/drivers/virtio/virtio_ring.c
> > > +++ b/drivers/virtio/virtio_ring.c
> > > @@ -12,6 +12,7 @@
> > >  #include <linux/hrtimer.h>
> > >  #include <linux/dma-mapping.h>
> > >  #include <linux/spinlock.h>
> > > +#include <linux/swiotlb.h>
> > >  #include <xen/xen.h>
> > >  
> > >  #ifdef DEBUG
> > > @@ -248,6 +249,13 @@ static bool vring_use_dma_api(struct virtio_device *vdev)
> > >  	if (!virtio_has_dma_quirk(vdev))
> > >  		return true;
> > >  
> > > +	/* If the device is configured to use a DMA restricted pool,
> > > +	 * we had better use it.
> > > +	 */
> > > +	if (IS_ENABLED(CONFIG_DMA_RESTRICTED_POOL) &&
> > > +	    is_swiotlb_for_alloc(vdev->dev.parent))
> > > +		return true;
> > > +
> > >  	/* Otherwise, we are left to guess. */
> > >  	/*
> > >  	 * In theory, it's possible to have a buggy QEMU-supposed
> > > -- 
> > > 2.37.0.170.g444d1eabd0-goog
> > 
> > 

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

Return-Path: <SRS0=hez8=DG=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34714C4727D
	for <virtualization@archiver.kernel.org>; Tue, 29 Sep 2020 05:55:27 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B991020BED
	for <virtualization@archiver.kernel.org>; Tue, 29 Sep 2020 05:55:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EoKpJqC0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B991020BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 6284786688;
	Tue, 29 Sep 2020 05:55:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id U75i3Y3SqQq0; Tue, 29 Sep 2020 05:55:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id A8E27860BE;
	Tue, 29 Sep 2020 05:55:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8AAD0C016F;
	Tue, 29 Sep 2020 05:55:25 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 74C1AC0051
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Sep 2020 05:55:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 5D0F186F8F
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Sep 2020 05:55:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZLiZGYEtDtZF
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Sep 2020 05:55:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 4AB8B86F74
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Sep 2020 05:55:23 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601358922;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CU6DE2cx0I1FLYs8fHE6zj6vjwpo9LDCmZqFve4flUg=;
 b=EoKpJqC0nzClsUNxNS9oqV4foiJbYij+YK60wRR+YLTFvakKv/OzJ9aI9b6Yx5tivN0S39
 rl3uLCoUvHgk3P1SDvxlf11zF2cNEA6xXMcZbwYEiSdhzrLfs5hVk1ZhUg76hy/REIzNtY
 t7km5YjyydssV9Z2oc6ACcwwYzK0K7o=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-392-6y7oEAjJMDShPxClneaLLA-1; Tue, 29 Sep 2020 01:55:19 -0400
X-MC-Unique: 6y7oEAjJMDShPxClneaLLA-1
Received: by mail-wr1-f70.google.com with SMTP id v5so1296591wrr.0
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Sep 2020 22:55:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=CU6DE2cx0I1FLYs8fHE6zj6vjwpo9LDCmZqFve4flUg=;
 b=Wiig5xcRAhmjN5qnNhiqQGCbvE7COHJ/rkiyaIoI45NfW6nrT2VwX/0FfFycBcZ1lp
 3/quKYfzODjHxas/h5uI/79ShrifCVwAzHr9wXQ+mPEgjNARQHiCHdWy3g0tX1bFKbS8
 GlfHAC9v1qbDK/06zDm0cX4APbKszAl6En+ftvdvgigAxEWnoTNL1AEEbVT6MGF/bTSS
 mGGjFxvCtuP0PRgQ6ZWVXQwtoXoAxS61aeEnPV9wsE6Wo56p1bQrF0m34VS2uP0ETJ8D
 kjHCJv5AZukhw3j1sI9S1AY4sq7qMpE2O3yUhC25IGd8RDSJEYhlaSUqvngiaFEWFiDI
 JmxQ==
X-Gm-Message-State: AOAM532ytbrhPODNdmGeZB3kGzb5KxpoKb9mO2op7792uM2yclo72oUI
 p5o6XdSeaEkHKyENbylzLdZl90luRLllDkRu9p61ub8ETjYnjLMHkrMl9s4h00S0moJokycKlIq
 7DrZWHv+eoPMRA4hyQ7IdW02S0/6aHpYDg3Nl5MDn+Q==
X-Received: by 2002:a1c:b103:: with SMTP id a3mr2656566wmf.68.1601358918055;
 Mon, 28 Sep 2020 22:55:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzxsOwwngwmhGeReV8HiZ7hkWkrIf0RVPILaTaEu1hmMo4H1fr7U3ZGwgZqxZtONPMxJ+qfaw==
X-Received: by 2002:a1c:b103:: with SMTP id a3mr2656544wmf.68.1601358917787;
 Mon, 28 Sep 2020 22:55:17 -0700 (PDT)
Received: from redhat.com (bzq-79-179-71-128.red.bezeqint.net. [79.179.71.128])
 by smtp.gmail.com with ESMTPSA id w14sm4153307wrk.95.2020.09.28.22.55.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2020 22:55:16 -0700 (PDT)
Date: Tue, 29 Sep 2020 01:55:13 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Tonghao Zhang <xiangxia.m.yue@gmail.com>
Subject: Re: [PATCH 2/2] virtio-net: ethtool configurable RXCSUM
Message-ID: <20200929015427-mutt-send-email-mst@kernel.org>
References: <20200928033915.82810-1-xiangxia.m.yue@gmail.com>
 <20200928033915.82810-2-xiangxia.m.yue@gmail.com>
 <20200928152142-mutt-send-email-mst@kernel.org>
 <CAMDZJNVUVm9y2NV5ZGHzrPoEaDF4PZEGWVFEx9g6sF3U-1Rm0Q@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAMDZJNVUVm9y2NV5ZGHzrPoEaDF4PZEGWVFEx9g6sF3U-1Rm0Q@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Linux Kernel Network Developers <netdev@vger.kernel.org>,
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

On Tue, Sep 29, 2020 at 09:45:24AM +0800, Tonghao Zhang wrote:
> On Tue, Sep 29, 2020 at 3:25 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Mon, Sep 28, 2020 at 11:39:15AM +0800, xiangxia.m.yue@gmail.com wrote:
> > > From: Tonghao Zhang <xiangxia.m.yue@gmail.com>
> > >
> > > Allow user configuring RXCSUM separately with ethtool -K,
> > > reusing the existing virtnet_set_guest_offloads helper
> > > that configures RXCSUM for XDP. This is conditional on
> > > VIRTIO_NET_F_CTRL_GUEST_OFFLOADS.
> > >
> > > Cc: Michael S. Tsirkin <mst@redhat.com>
> > > Cc: Jason Wang <jasowang@redhat.com>
> > > Signed-off-by: Tonghao Zhang <xiangxia.m.yue@gmail.com>
> > > ---
> > >  drivers/net/virtio_net.c | 40 ++++++++++++++++++++++++++++------------
> > >  1 file changed, 28 insertions(+), 12 deletions(-)
> > >
> > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > index 21b71148c532..2e3af0b2c281 100644
> > > --- a/drivers/net/virtio_net.c
> > > +++ b/drivers/net/virtio_net.c
> > > @@ -68,6 +68,8 @@ static const unsigned long guest_offloads[] = {
> > >                               (1ULL << VIRTIO_NET_F_GUEST_ECN)  | \
> > >                               (1ULL << VIRTIO_NET_F_GUEST_UFO))
> > >
> > > +#define GUEST_OFFLOAD_CSUM_MASK (1ULL << VIRTIO_NET_F_GUEST_CSUM)
> > > +
> > >  struct virtnet_stat_desc {
> > >       char desc[ETH_GSTRING_LEN];
> > >       size_t offset;
> > > @@ -2526,25 +2528,37 @@ static int virtnet_set_features(struct net_device *dev,
> > >                               netdev_features_t features)
> > >  {
> > >       struct virtnet_info *vi = netdev_priv(dev);
> > > -     u64 offloads;
> > > +     u64 offloads = vi->guest_offloads &
> > > +                    vi->guest_offloads_capable;
> > >       int err;
> > >
> > > -     if ((dev->features ^ features) & NETIF_F_LRO) {
> > > -             if (vi->xdp_queue_pairs)
> > > -                     return -EBUSY;
> > > +     /* Don't allow configuration while XDP is active. */
> > > +     if (vi->xdp_queue_pairs)
> > > +             return -EBUSY;
> > >
> > > +     if ((dev->features ^ features) & NETIF_F_LRO) {
> > >               if (features & NETIF_F_LRO)
> > > -                     offloads = vi->guest_offloads_capable;
> > > +                     offloads |= GUEST_OFFLOAD_LRO_MASK;
> > >               else
> > > -                     offloads = vi->guest_offloads_capable &
> > > -                                ~GUEST_OFFLOAD_LRO_MASK;
> > > +                     offloads &= ~GUEST_OFFLOAD_LRO_MASK;
> > > +     }
> > >
> > > -             err = virtnet_set_guest_offloads(vi, offloads);
> > > -             if (err)
> > > -                     return err;
> > > -             vi->guest_offloads = offloads;
> > > +     if ((dev->features ^ features) & NETIF_F_RXCSUM) {
> > > +             if (features & NETIF_F_RXCSUM)
> > > +                     offloads |= GUEST_OFFLOAD_CSUM_MASK;
> > > +             else
> > > +                     offloads &= ~GUEST_OFFLOAD_CSUM_MASK;
> > >       }
> > >
> > > +     if (offloads == (vi->guest_offloads &
> > > +                      vi->guest_offloads_capable))
> > > +             return 0;
> >
> > Hmm, what exactly does this do?
> If the features(lro, rxcsum) we supported, are not changed, it is not
> necessary to invoke virtnet_set_guest_offloads.

okay, could you describe the cases where this triggers in a bit more
detail pls?

> > > +
> > > +     err = virtnet_set_guest_offloads(vi, offloads);
> > > +     if (err)
> > > +             return err;
> > > +
> > > +     vi->guest_offloads = offloads;
> > >       return 0;
> > >  }
> > >
> > > @@ -3013,8 +3027,10 @@ static int virtnet_probe(struct virtio_device *vdev)
> > >       if (virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_TSO4) ||
> > >           virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_TSO6))
> > >               dev->features |= NETIF_F_LRO;
> > > -     if (virtio_has_feature(vdev, VIRTIO_NET_F_CTRL_GUEST_OFFLOADS))
> > > +     if (virtio_has_feature(vdev, VIRTIO_NET_F_CTRL_GUEST_OFFLOADS)) {
> > > +             dev->hw_features |= NETIF_F_RXCSUM;
> > >               dev->hw_features |= NETIF_F_LRO;
> > > +     }
> > >
> > >       dev->vlan_features = dev->features;
> > >
> > > --
> > > 2.23.0
> >
> 
> 
> -- 
> Best regards, Tonghao

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

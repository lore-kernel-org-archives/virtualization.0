Return-Path: <SRS0=hez8=DG=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 664C8C4727F
	for <virtualization@archiver.kernel.org>; Tue, 29 Sep 2020 07:25:21 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7C36207F7
	for <virtualization@archiver.kernel.org>; Tue, 29 Sep 2020 07:25:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EMYygneE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7C36207F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 88E4F865C7;
	Tue, 29 Sep 2020 07:25:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id X+Qp4YTaeZxn; Tue, 29 Sep 2020 07:25:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id E4B23865C1;
	Tue, 29 Sep 2020 07:25:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BAFACC0890;
	Tue, 29 Sep 2020 07:25:17 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D50DCC016F
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Sep 2020 07:25:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id D065886FCD
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Sep 2020 07:25:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id c3DCvFn7ucwr
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Sep 2020 07:25:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 1319C86FC7
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Sep 2020 07:25:15 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601364315;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YZ8E1/B0IgHE6g3riQOXVTHOwxNzr+Lp4c04gi89x5U=;
 b=EMYygneE+S1ypolXl/2IpdbQVJzUC1BXOOlPOmq3syvajoKnHmQZCK7x6cvKLPTfSgFZ18
 0ICzyXxc2pXtC4b4TLDkPPfD/i6PxH+TDvcSUugChYV7ZDF3fkHCL1kuVoURPxCs2lQmfC
 bfGI1bBk/aAvM5NEEoYd+PNmUnDQNEA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-579-uGqa4MniMqCoT6ZUNKAApQ-1; Tue, 29 Sep 2020 03:25:13 -0400
X-MC-Unique: uGqa4MniMqCoT6ZUNKAApQ-1
Received: by mail-wr1-f71.google.com with SMTP id v12so1372996wrm.9
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Sep 2020 00:25:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=YZ8E1/B0IgHE6g3riQOXVTHOwxNzr+Lp4c04gi89x5U=;
 b=Zw6SLEPEeWXw+P9/nf+7Vm1JSWZtes7Sksl/n/FVKiPKYx9dnNib3FsxcCaXO0pcEg
 ZBXBOZ+QbNQifcDxNKhFsxzcI2g3x5cQz5ENoL/PU5tKWwckuEldqFMEG6X/xfyGWaa0
 h8fu2U7N5AhFoTR4E8GFnq4RxoZK4cX1CP/Bxzf2inMEkvvUO2XkNikRT3Ln/vMEkNhF
 UmQfOybXOr59W+nfmYPXArpd8rNhxu7ccLyJtrxfv6SEbQ80bgfCnEnVi+4wwQseT6bt
 MvOGhXl15Cp3hFhzby7oC8JRWxUJ+oVRAyJWnsCFZG8gLEWtdA82FBg9ixmmg/2IMNTT
 iLcw==
X-Gm-Message-State: AOAM5329gFvd1hBfbZ61gOMn6JbeIGPtslMeMS9E1icWKyc9T4xmHTYN
 jhVi3HCN/ZTldnZMT4xedCp55AXrgrrSpZoIAGbMPA0IqihHLvvn70k6i0y7NM5V+CviOtULbjJ
 ZohJ7hOUhiprsV4Hw4jz+ceFj+TjUxpBNWAVzKOc0KQ==
X-Received: by 2002:a5d:4811:: with SMTP id l17mr2644467wrq.252.1601364312098; 
 Tue, 29 Sep 2020 00:25:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyEpK/MPBU1pyxP4vRA1kwGMHn0cJZ1Ea78w0zQPAat249q7ZwGjLz3eOdqfBs022VCrrzdPg==
X-Received: by 2002:a5d:4811:: with SMTP id l17mr2644445wrq.252.1601364311876; 
 Tue, 29 Sep 2020 00:25:11 -0700 (PDT)
Received: from redhat.com (bzq-79-179-71-128.red.bezeqint.net. [79.179.71.128])
 by smtp.gmail.com with ESMTPSA id c4sm4652560wme.27.2020.09.29.00.25.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2020 00:25:11 -0700 (PDT)
Date: Tue, 29 Sep 2020 03:25:08 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Tonghao Zhang <xiangxia.m.yue@gmail.com>
Subject: Re: [PATCH 2/2] virtio-net: ethtool configurable RXCSUM
Message-ID: <20200929032314-mutt-send-email-mst@kernel.org>
References: <20200928033915.82810-1-xiangxia.m.yue@gmail.com>
 <20200928033915.82810-2-xiangxia.m.yue@gmail.com>
 <20200928152142-mutt-send-email-mst@kernel.org>
 <CAMDZJNVUVm9y2NV5ZGHzrPoEaDF4PZEGWVFEx9g6sF3U-1Rm0Q@mail.gmail.com>
 <20200929015427-mutt-send-email-mst@kernel.org>
 <CAMDZJNX94out3B_puYy+zbdotDwU=qZKG2=sMfyoj9o5nnewmA@mail.gmail.com>
 <20200929022138-mutt-send-email-mst@kernel.org>
 <CAMDZJNVzKc-Wb13Z5ocz_4DHqP_ZMzM1sO1GWmmKhNUKMuP9PQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAMDZJNVzKc-Wb13Z5ocz_4DHqP_ZMzM1sO1GWmmKhNUKMuP9PQ@mail.gmail.com>
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

On Tue, Sep 29, 2020 at 03:17:50PM +0800, Tonghao Zhang wrote:
> On Tue, Sep 29, 2020 at 2:22 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Tue, Sep 29, 2020 at 02:10:56PM +0800, Tonghao Zhang wrote:
> > > On Tue, Sep 29, 2020 at 1:55 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > >
> > > > On Tue, Sep 29, 2020 at 09:45:24AM +0800, Tonghao Zhang wrote:
> > > > > On Tue, Sep 29, 2020 at 3:25 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > > >
> > > > > > On Mon, Sep 28, 2020 at 11:39:15AM +0800, xiangxia.m.yue@gmail.com wrote:
> > > > > > > From: Tonghao Zhang <xiangxia.m.yue@gmail.com>
> > > > > > >
> > > > > > > Allow user configuring RXCSUM separately with ethtool -K,
> > > > > > > reusing the existing virtnet_set_guest_offloads helper
> > > > > > > that configures RXCSUM for XDP. This is conditional on
> > > > > > > VIRTIO_NET_F_CTRL_GUEST_OFFLOADS.
> > > > > > >
> > > > > > > Cc: Michael S. Tsirkin <mst@redhat.com>
> > > > > > > Cc: Jason Wang <jasowang@redhat.com>
> > > > > > > Signed-off-by: Tonghao Zhang <xiangxia.m.yue@gmail.com>
> > > > > > > ---
> > > > > > >  drivers/net/virtio_net.c | 40 ++++++++++++++++++++++++++++------------
> > > > > > >  1 file changed, 28 insertions(+), 12 deletions(-)
> > > > > > >
> > > > > > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > > > > > index 21b71148c532..2e3af0b2c281 100644
> > > > > > > --- a/drivers/net/virtio_net.c
> > > > > > > +++ b/drivers/net/virtio_net.c
> > > > > > > @@ -68,6 +68,8 @@ static const unsigned long guest_offloads[] = {
> > > > > > >                               (1ULL << VIRTIO_NET_F_GUEST_ECN)  | \
> > > > > > >                               (1ULL << VIRTIO_NET_F_GUEST_UFO))
> > > > > > >
> > > > > > > +#define GUEST_OFFLOAD_CSUM_MASK (1ULL << VIRTIO_NET_F_GUEST_CSUM)
> > > > > > > +
> > > > > > >  struct virtnet_stat_desc {
> > > > > > >       char desc[ETH_GSTRING_LEN];
> > > > > > >       size_t offset;
> > > > > > > @@ -2526,25 +2528,37 @@ static int virtnet_set_features(struct net_device *dev,
> > > > > > >                               netdev_features_t features)
> > > > > > >  {
> > > > > > >       struct virtnet_info *vi = netdev_priv(dev);
> > > > > > > -     u64 offloads;
> > > > > > > +     u64 offloads = vi->guest_offloads &
> > > > > > > +                    vi->guest_offloads_capable;
> > > > > > >       int err;
> > > > > > >
> > > > > > > -     if ((dev->features ^ features) & NETIF_F_LRO) {
> > > > > > > -             if (vi->xdp_queue_pairs)
> > > > > > > -                     return -EBUSY;
> > > > > > > +     /* Don't allow configuration while XDP is active. */
> > > > > > > +     if (vi->xdp_queue_pairs)
> > > > > > > +             return -EBUSY;
> > > > > > >
> > > > > > > +     if ((dev->features ^ features) & NETIF_F_LRO) {
> > > > > > >               if (features & NETIF_F_LRO)
> > > > > > > -                     offloads = vi->guest_offloads_capable;
> > > > > > > +                     offloads |= GUEST_OFFLOAD_LRO_MASK;
> > > > > > >               else
> > > > > > > -                     offloads = vi->guest_offloads_capable &
> > > > > > > -                                ~GUEST_OFFLOAD_LRO_MASK;
> > > > > > > +                     offloads &= ~GUEST_OFFLOAD_LRO_MASK;
> > > > > > > +     }
> > > > > > >
> > > > > > > -             err = virtnet_set_guest_offloads(vi, offloads);
> > > > > > > -             if (err)
> > > > > > > -                     return err;
> > > > > > > -             vi->guest_offloads = offloads;
> > > > > > > +     if ((dev->features ^ features) & NETIF_F_RXCSUM) {
> > > > > > > +             if (features & NETIF_F_RXCSUM)
> > > > > > > +                     offloads |= GUEST_OFFLOAD_CSUM_MASK;
> > > > > > > +             else
> > > > > > > +                     offloads &= ~GUEST_OFFLOAD_CSUM_MASK;
> > > > > > >       }
> > > > > > >
> > > > > > > +     if (offloads == (vi->guest_offloads &
> > > > > > > +                      vi->guest_offloads_capable))
> > > > > > > +             return 0;
> > > > > >
> > > > > > Hmm, what exactly does this do?
> > > > > If the features(lro, rxcsum) we supported, are not changed, it is not
> > > > > necessary to invoke virtnet_set_guest_offloads.
> > > >
> > > > okay, could you describe the cases where this triggers in a bit more
> > > > detail pls?
> > > Hi
> > > As I known,  when we run che commands show as below:
> > > ethtool -K eth1 sg off
> > > ethtool -K eth1 tso off
> > >
> > > In that case, we will not invoke virtnet_set_guest_offloads.
> >
> > How about initialization though? E.g. it looks like guest_offloads
> > is 0-initialized, won't this skip the first command to disable
> > offloads?
> I guest you mean that: if guest_offloads == 0, and run the command
> "ethtool -K eth1 sg off", that will disable offload ?
> In that patch
> u64 offloads = vi->guest_offloads & vi->guest_offloads_capable; // offload = 0
> .....
>  if (offloads == (vi->guest_offloads & vi->guest_offloads_capable)) //
> if offload not changed, offload == 0, and (vi->guest_offloads &
> vi->guest_offloads_capable) == 0.
>         return 0;
> 
> virtnet_set_guest_offloads // that will not be invoked, so will not
> disable offload


Sorry don't understand the question here.
At device init offloads are enabled, I am asking won't this skip
disabling them the first time this function is invoked.
Why are we bothering with this check? Is this called lots of
times where offloads are unchanged to make skipping the
command worthwhile?

> > > > > > > +
> > > > > > > +     err = virtnet_set_guest_offloads(vi, offloads);
> > > > > > > +     if (err)
> > > > > > > +             return err;
> > > > > > > +
> > > > > > > +     vi->guest_offloads = offloads;
> > > > > > >       return 0;
> > > > > > >  }
> > > > > > >
> > > > > > > @@ -3013,8 +3027,10 @@ static int virtnet_probe(struct virtio_device *vdev)
> > > > > > >       if (virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_TSO4) ||
> > > > > > >           virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_TSO6))
> > > > > > >               dev->features |= NETIF_F_LRO;
> > > > > > > -     if (virtio_has_feature(vdev, VIRTIO_NET_F_CTRL_GUEST_OFFLOADS))
> > > > > > > +     if (virtio_has_feature(vdev, VIRTIO_NET_F_CTRL_GUEST_OFFLOADS)) {
> > > > > > > +             dev->hw_features |= NETIF_F_RXCSUM;
> > > > > > >               dev->hw_features |= NETIF_F_LRO;
> > > > > > > +     }
> > > > > > >
> > > > > > >       dev->vlan_features = dev->features;
> > > > > > >
> > > > > > > --
> > > > > > > 2.23.0
> > > > > >
> > > > >
> > > > >
> > > > > --
> > > > > Best regards, Tonghao
> > > >
> > >
> > >
> > > --
> > > Best regards, Tonghao
> >
> 
> 
> -- 
> Best regards, Tonghao

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

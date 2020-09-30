Return-Path: <SRS0=Q6Zn=DH=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 565E6C4727D
	for <virtualization@archiver.kernel.org>; Wed, 30 Sep 2020 02:11:52 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B13AB20773
	for <virtualization@archiver.kernel.org>; Wed, 30 Sep 2020 02:11:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HBThixVJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B13AB20773
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 469E086E48;
	Wed, 30 Sep 2020 02:11:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rexCZyeZF5zd; Wed, 30 Sep 2020 02:11:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 8533F86D63;
	Wed, 30 Sep 2020 02:11:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 68C94C0889;
	Wed, 30 Sep 2020 02:11:50 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B1841C0051
 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Sep 2020 02:11:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 83D9E2046B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Sep 2020 02:11:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ev4eTzqSbCez
 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Sep 2020 02:11:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ed1-f66.google.com (mail-ed1-f66.google.com
 [209.85.208.66])
 by silver.osuosl.org (Postfix) with ESMTPS id 3CDE420009
 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Sep 2020 02:11:48 +0000 (UTC)
Received: by mail-ed1-f66.google.com with SMTP id w1so157089edr.3
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Sep 2020 19:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=7hZ1tmJDKYbFj1JAR2kOqXmJ14cEBCBL/omVit1tt0s=;
 b=HBThixVJFPy2i/wXeINssCE+v7YQyICrCJcnIXctSDPZcNDXhfa2QpdfTAttjX+6VD
 nPLVueF6rZ6Q8WIhAHIMytXxlKKA0SR914CAFk+JB5Fn4IIY8W9cIWRWPrVKVxygY2Ya
 HIRiVe/DvXPPqLeXo7WKxVJUieoOYGffMxB6zWbm6INFKA9dN09xyAR52VwtQLz31d5a
 Y2hlia8qk63vCgHY7ZgIJ00wPM1y+79DzpPKomCMR7EKU76FwBzZfEew7FU+mL+AskEv
 1tLakI8d9J2ccH3gV5M9t63QMxALY5fzhA4Db99/Qd/dqBbtA2pMJ5dbQrNNrMIf9R+Y
 aCVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=7hZ1tmJDKYbFj1JAR2kOqXmJ14cEBCBL/omVit1tt0s=;
 b=Gi7IpU/bOvD71MPHHxYLa5aBebVsvfi7yE+7Hd3SyGAKaDrjpcb4dD+spFJZnisLTB
 uUaLZCeXdjA/UKhlTUkmZeedi3WJXZN2ORWyMbYkMQ0xT7dkpfkG5rotrnlOv7sVB/wK
 3j1JbWKHUXHA/tRS+r9lmG1ysT9HvOh56TwVMS7YLj4kjUsRur+CRC+R6Sq8wc8BbI7Q
 IDE5wPpXhZLr3QfFY2NZyeowZN48WSMRj8qK5iUpRVZh4rgH5B/9g7T1z9hsB9mXUS2l
 3XIVk/SIZJya4KP4YQm2ZV+neBiNZZh0ZsAfVjCGAmVILpgWi/EWBsfkOjHDsM+hd00N
 6M0Q==
X-Gm-Message-State: AOAM5335Xes+qaFNWolOzp2uvU4np3eQmbgiU6WTCh63q9mM+6esfqjK
 l/PVbyGvbV3P0LE6WhdK+K8Myi62NbJi/5zVIMs=
X-Google-Smtp-Source: ABdhPJyX+Z741IY7X4VfM2bYUi7FQKJY4JmN9c+eeMmAv0Ix/UWTYfkiM6MPYX8iiH4X3y8ZifbFiJd4No6QJ2CCVTE=
X-Received: by 2002:a50:eb0a:: with SMTP id y10mr387086edp.89.1601431906593;
 Tue, 29 Sep 2020 19:11:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200928033915.82810-1-xiangxia.m.yue@gmail.com>
 <20200928033915.82810-2-xiangxia.m.yue@gmail.com>
 <20200928152142-mutt-send-email-mst@kernel.org>
 <CAMDZJNVUVm9y2NV5ZGHzrPoEaDF4PZEGWVFEx9g6sF3U-1Rm0Q@mail.gmail.com>
 <20200929015427-mutt-send-email-mst@kernel.org>
 <CAMDZJNX94out3B_puYy+zbdotDwU=qZKG2=sMfyoj9o5nnewmA@mail.gmail.com>
 <20200929022138-mutt-send-email-mst@kernel.org>
 <CAMDZJNVzKc-Wb13Z5ocz_4DHqP_ZMzM1sO1GWmmKhNUKMuP9PQ@mail.gmail.com>
 <20200929032314-mutt-send-email-mst@kernel.org>
In-Reply-To: <20200929032314-mutt-send-email-mst@kernel.org>
From: Tonghao Zhang <xiangxia.m.yue@gmail.com>
Date: Wed, 30 Sep 2020 10:09:07 +0800
Message-ID: <CAMDZJNXvWEB5-D0gFVsLfqEHwHTTe0K+4ro3EzyExFmhiFxKUg@mail.gmail.com>
Subject: Re: [PATCH 2/2] virtio-net: ethtool configurable RXCSUM
To: "Michael S. Tsirkin" <mst@redhat.com>
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

On Tue, Sep 29, 2020 at 3:25 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Tue, Sep 29, 2020 at 03:17:50PM +0800, Tonghao Zhang wrote:
> > On Tue, Sep 29, 2020 at 2:22 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > >
> > > On Tue, Sep 29, 2020 at 02:10:56PM +0800, Tonghao Zhang wrote:
> > > > On Tue, Sep 29, 2020 at 1:55 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > >
> > > > > On Tue, Sep 29, 2020 at 09:45:24AM +0800, Tonghao Zhang wrote:
> > > > > > On Tue, Sep 29, 2020 at 3:25 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > > > >
> > > > > > > On Mon, Sep 28, 2020 at 11:39:15AM +0800, xiangxia.m.yue@gmail.com wrote:
> > > > > > > > From: Tonghao Zhang <xiangxia.m.yue@gmail.com>
> > > > > > > >
> > > > > > > > Allow user configuring RXCSUM separately with ethtool -K,
> > > > > > > > reusing the existing virtnet_set_guest_offloads helper
> > > > > > > > that configures RXCSUM for XDP. This is conditional on
> > > > > > > > VIRTIO_NET_F_CTRL_GUEST_OFFLOADS.
> > > > > > > >
> > > > > > > > Cc: Michael S. Tsirkin <mst@redhat.com>
> > > > > > > > Cc: Jason Wang <jasowang@redhat.com>
> > > > > > > > Signed-off-by: Tonghao Zhang <xiangxia.m.yue@gmail.com>
> > > > > > > > ---
> > > > > > > >  drivers/net/virtio_net.c | 40 ++++++++++++++++++++++++++++------------
> > > > > > > >  1 file changed, 28 insertions(+), 12 deletions(-)
> > > > > > > >
> > > > > > > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > > > > > > index 21b71148c532..2e3af0b2c281 100644
> > > > > > > > --- a/drivers/net/virtio_net.c
> > > > > > > > +++ b/drivers/net/virtio_net.c
> > > > > > > > @@ -68,6 +68,8 @@ static const unsigned long guest_offloads[] = {
> > > > > > > >                               (1ULL << VIRTIO_NET_F_GUEST_ECN)  | \
> > > > > > > >                               (1ULL << VIRTIO_NET_F_GUEST_UFO))
> > > > > > > >
> > > > > > > > +#define GUEST_OFFLOAD_CSUM_MASK (1ULL << VIRTIO_NET_F_GUEST_CSUM)
> > > > > > > > +
> > > > > > > >  struct virtnet_stat_desc {
> > > > > > > >       char desc[ETH_GSTRING_LEN];
> > > > > > > >       size_t offset;
> > > > > > > > @@ -2526,25 +2528,37 @@ static int virtnet_set_features(struct net_device *dev,
> > > > > > > >                               netdev_features_t features)
> > > > > > > >  {
> > > > > > > >       struct virtnet_info *vi = netdev_priv(dev);
> > > > > > > > -     u64 offloads;
> > > > > > > > +     u64 offloads = vi->guest_offloads &
> > > > > > > > +                    vi->guest_offloads_capable;
> > > > > > > >       int err;
> > > > > > > >
> > > > > > > > -     if ((dev->features ^ features) & NETIF_F_LRO) {
> > > > > > > > -             if (vi->xdp_queue_pairs)
> > > > > > > > -                     return -EBUSY;
> > > > > > > > +     /* Don't allow configuration while XDP is active. */
> > > > > > > > +     if (vi->xdp_queue_pairs)
> > > > > > > > +             return -EBUSY;
> > > > > > > >
> > > > > > > > +     if ((dev->features ^ features) & NETIF_F_LRO) {
> > > > > > > >               if (features & NETIF_F_LRO)
> > > > > > > > -                     offloads = vi->guest_offloads_capable;
> > > > > > > > +                     offloads |= GUEST_OFFLOAD_LRO_MASK;
> > > > > > > >               else
> > > > > > > > -                     offloads = vi->guest_offloads_capable &
> > > > > > > > -                                ~GUEST_OFFLOAD_LRO_MASK;
> > > > > > > > +                     offloads &= ~GUEST_OFFLOAD_LRO_MASK;
> > > > > > > > +     }
> > > > > > > >
> > > > > > > > -             err = virtnet_set_guest_offloads(vi, offloads);
> > > > > > > > -             if (err)
> > > > > > > > -                     return err;
> > > > > > > > -             vi->guest_offloads = offloads;
> > > > > > > > +     if ((dev->features ^ features) & NETIF_F_RXCSUM) {
> > > > > > > > +             if (features & NETIF_F_RXCSUM)
> > > > > > > > +                     offloads |= GUEST_OFFLOAD_CSUM_MASK;
> > > > > > > > +             else
> > > > > > > > +                     offloads &= ~GUEST_OFFLOAD_CSUM_MASK;
> > > > > > > >       }
> > > > > > > >
> > > > > > > > +     if (offloads == (vi->guest_offloads &
> > > > > > > > +                      vi->guest_offloads_capable))
> > > > > > > > +             return 0;
> > > > > > >
> > > > > > > Hmm, what exactly does this do?
> > > > > > If the features(lro, rxcsum) we supported, are not changed, it is not
> > > > > > necessary to invoke virtnet_set_guest_offloads.
> > > > >
> > > > > okay, could you describe the cases where this triggers in a bit more
> > > > > detail pls?
> > > > Hi
> > > > As I known,  when we run che commands show as below:
> > > > ethtool -K eth1 sg off
> > > > ethtool -K eth1 tso off
> > > >
> > > > In that case, we will not invoke virtnet_set_guest_offloads.
> > >
> > > How about initialization though? E.g. it looks like guest_offloads
> > > is 0-initialized, won't this skip the first command to disable
> > > offloads?
> > I guest you mean that: if guest_offloads == 0, and run the command
> > "ethtool -K eth1 sg off", that will disable offload ?
> > In that patch
> > u64 offloads = vi->guest_offloads & vi->guest_offloads_capable; // offload = 0
> > .....
> >  if (offloads == (vi->guest_offloads & vi->guest_offloads_capable)) //
> > if offload not changed, offload == 0, and (vi->guest_offloads &
> > vi->guest_offloads_capable) == 0.
> >         return 0;
> >
> > virtnet_set_guest_offloads // that will not be invoked, so will not
> > disable offload
>
>
> Sorry don't understand the question here.
> At device init offloads are enabled, I am asking won't this skip
> disabling them the first time this function is invoked.
> Why are we bothering with this check? Is this called lots of
> times where offloads are unchanged to make skipping the
> command worthwhile?
Hi Michael
I remove the check and when rxcum is disabled, LRO also is disabled
(suggested by Willem de Bruijn)
please review, thanks.

http://patchwork.ozlabs.org/project/netdev/patch/20200930020300.62245-1-xiangxia.m.yue@gmail.com/

> > > > > > > > +
> > > > > > > > +     err = virtnet_set_guest_offloads(vi, offloads);
> > > > > > > > +     if (err)
> > > > > > > > +             return err;
> > > > > > > > +
> > > > > > > > +     vi->guest_offloads = offloads;
> > > > > > > >       return 0;
> > > > > > > >  }
> > > > > > > >
> > > > > > > > @@ -3013,8 +3027,10 @@ static int virtnet_probe(struct virtio_device *vdev)
> > > > > > > >       if (virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_TSO4) ||
> > > > > > > >           virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_TSO6))
> > > > > > > >               dev->features |= NETIF_F_LRO;
> > > > > > > > -     if (virtio_has_feature(vdev, VIRTIO_NET_F_CTRL_GUEST_OFFLOADS))
> > > > > > > > +     if (virtio_has_feature(vdev, VIRTIO_NET_F_CTRL_GUEST_OFFLOADS)) {
> > > > > > > > +             dev->hw_features |= NETIF_F_RXCSUM;
> > > > > > > >               dev->hw_features |= NETIF_F_LRO;
> > > > > > > > +     }
> > > > > > > >
> > > > > > > >       dev->vlan_features = dev->features;
> > > > > > > >
> > > > > > > > --
> > > > > > > > 2.23.0
> > > > > > >
> > > > > >
> > > > > >
> > > > > > --
> > > > > > Best regards, Tonghao
> > > > >
> > > >
> > > >
> > > > --
> > > > Best regards, Tonghao
> > >
> >
> >
> > --
> > Best regards, Tonghao
>


-- 
Best regards, Tonghao
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

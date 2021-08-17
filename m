Return-Path: <SRS0=dYih=NI=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 417DCC4338F
	for <virtualization@archiver.kernel.org>; Tue, 17 Aug 2021 08:16:51 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6CD060FBF
	for <virtualization@archiver.kernel.org>; Tue, 17 Aug 2021 08:16:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E6CD060FBF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B0CF783753;
	Tue, 17 Aug 2021 08:16:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LolNpIeiU5Ca; Tue, 17 Aug 2021 08:16:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 4152B80FFD;
	Tue, 17 Aug 2021 08:16:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 17F78C0010;
	Tue, 17 Aug 2021 08:16:46 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 51577C000E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Aug 2021 08:16:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 302BA8105B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Aug 2021 08:16:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yHMkf2zuQeDf
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Aug 2021 08:16:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6306080FFD
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Aug 2021 08:16:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1629188202;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=e3ctewUOTsKGZENQJgUMk7UI3Zq20LDKQ2q7neygSyw=;
 b=TFDi51CEM+0/QMwplCGuDd9szLtvBK/3xQm/wgQfI5xzjtiw8Rg3Yxj7rxVrv6nNP4vGtN
 BUHxWuGfGtqjuOR3z6TRMo5I3KzsXrYtawlhsGtwdMYzwEWG8WhdZHc76xJ2VNVIMs5F9y
 P5JEQPnpzMIbtKpVZKwR6V+9PwFwBJ4=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-394-L87W0yoyM3Gn1xa6Pe0h-g-1; Tue, 17 Aug 2021 04:16:39 -0400
X-MC-Unique: L87W0yoyM3Gn1xa6Pe0h-g-1
Received: by mail-lf1-f69.google.com with SMTP id
 z26-20020a0565120c1a00b003cf39d5ed62so1259340lfu.16
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Aug 2021 01:16:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=e3ctewUOTsKGZENQJgUMk7UI3Zq20LDKQ2q7neygSyw=;
 b=TDudbqDyvVqyiRWygPABj1YcxsyVXAfpDRBGTKXPutHIvs0i9N0hLOpjIFoERrhzMO
 Tin+NXT2M6vKtmfWHBP7J1fJ/JAsSRPSgVn8RLozU/Qry/44HDAHtvil0YuT28LFyFW+
 xS/xgjL7rYRTiQL9U5S2qq+tNhm1wPBdWVeokRuKchsb4qsYe4ql01/L251IJZqFdAsS
 n+75G2SKMf0ct1bI7PX68FMCUs6l8bIfUlW3lqASpQijyp29zCMLBWIHk5k7jgKu0xHW
 fDRx2XhtZFZWchI24Y60Crz/q1LZ7EHlNy1jPTBaGrTaWqi92UkuYhLtsSvUGDifAXOr
 eSew==
X-Gm-Message-State: AOAM533apvbwv4FiU+uKm49XUSguNz2wp7TjdOtg4N6XnNs1CKt44G4q
 BkUOdCksQgBnmf8NiISsPXsnHFwBSLw65/0XGzx2nWEhooYjcWdG07vrHaYRyD+9ma/7zSeaQjr
 khvMRd3VbYTUHatmTVY9E0faAc98cBKIdSgC0z85ViEDPP0Zz+VV7i2udcQ==
X-Received: by 2002:a19:e00b:: with SMTP id x11mr1599239lfg.436.1629188197717; 
 Tue, 17 Aug 2021 01:16:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxOoc1hi6Z/mta4euyFcXISlA832eI1bKIDzEItOgJ0WuAxvbQdlmufrdPWFKHfL9QeQ+mYV8bZ9lcjd41KHJA=
X-Received: by 2002:a19:e00b:: with SMTP id x11mr1599225lfg.436.1629188197483; 
 Tue, 17 Aug 2021 01:16:37 -0700 (PDT)
MIME-Version: 1.0
References: <20210817020338.6400-1-jasowang@redhat.com>
 <20210817023118-mutt-send-email-mst@kernel.org>
In-Reply-To: <20210817023118-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 17 Aug 2021 16:16:26 +0800
Message-ID: <CACGkMEuYMMBqgmpo25zc1uT2qCB09pjThDWJoWKLCz9GehccFQ@mail.gmail.com>
Subject: Re: [PATCH net] virtio-net: use NETIF_F_GRO_HW instead of NETIF_F_LRO
To: "Michael S. Tsirkin" <mst@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Willem de Bruijn <willemb@google.com>, netdev <netdev@vger.kernel.org>,
 Ivan <ivan@prestigetransportation.com>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Jakub Kicinski <kuba@kernel.org>, davem <davem@davemloft.net>
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

On Tue, Aug 17, 2021 at 2:46 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> Patch is good. Suggest some tweaks to the commit log.
>
> On Tue, Aug 17, 2021 at 10:03:38AM +0800, Jason Wang wrote:
> > Commit a02e8964eaf92 ("virtio-net: ethtool configurable LRO") tries to
> > advertise LRO on behalf of the guest offloading features and allow the
>
> tries to advertise -> advertises
>
> that part actually works.
>
> allow -> allows
>
> on behalf of features is really weird. maybe "maps"?
>
> > administrator to enable and disable those features via ethtool.
> >
> > This may lead several issues:
>
> may lead->lead to
>
> >
> > - For the device that doesn't support control guest offloads, the
> >   "LRO" can't be disabled so we will get a warn in the
>
> warn -> warning
>
> >   dev_disable_lro()
>
> .. when turning off LRO or when enabling forwarding bridging etc.
>
> > - For the device that have the control guest offloads, the guest
>
> have the -> supports
>
> >   offloads were disabled in the case of bridge etc
>
> etc -> forwarding etc
>
> > which may slow down
>
> were -> are
>
> may slow -> slows
>
> >   the traffic.
> >
> > Fixing this by using NETIF_F_GRO_HW instead. Though the spec does not
> > guaranteed to be re-segmented as original explicitly now, we can add
>
> guaranteed -> guarantee
>
> > that to the spec
>
> I would add:
>
> Further, we never advertised LRO historically before a02e8964eaf92
> ("virtio-net: ethtool configurable LRO") and so bridged/forwarded
> configs effectively relied on virtio receive offloads being GRO.
>
>
>
>
> > and then we can catch the bad configuration and
> > setup.
>
> Don't know what does this part mean. How would we catch it?
> With a new flag? Let's say so.
>
> >
> > Fixes: a02e8964eaf92 ("virtio-net: ethtool configurable LRO")
> > Signed-off-by: Jason Wang <jasowang@redhat.com>
>
>
>
> Proposed rewritten commit log:

Agree.

Post a new version.

Thanks

>
> ===
> [PATCH net] virtio-net: use NETIF_F_GRO_HW instead of NETIF_F_LRO
>
> Commit a02e8964eaf92 ("virtio-net: ethtool configurable LRO")
> maps LRO to virtio guest offloading features and allows the
> administrator to enable and disable those features via ethtool.
>
> This leads to several issues:
>
>
> - For a device that doesn't support control guest offloads, the "LRO"
>   can't be disabled triggering WARN in dev_disable_lro() when turning
>   off LRO or when enabling forwarding bridging etc.
>
> - For a device that supports control guest offloads, the guest
>   offloads are disabled in cases of bridging, forwarding etc
>   slowing down the traffic.
>
> Fix this by using NETIF_F_GRO_HW instead. Though the spec does not
> guarantee packets to be re-segmented as the original ones,
> we can add that to the spec, possibly with a flag for devices to
> differentiate between GRO and LRO.
>
> Further, we never advertised LRO historically before a02e8964eaf92
> ("virtio-net: ethtool configurable LRO") and so bridged/forwarded
> configs effectively always relied on virtio receive offloads behaving
> like GRO - thus even if this breaks any configs it is at least not
> a regression.
>
> Fixes: a02e8964eaf92 ("virtio-net: ethtool configurable LRO")
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> Reported-by: Ivan <ivan@prestigetransportation.com>
> Tested-by: Ivan <ivan@prestigetransportation.com>
> Signed-off-by: Jason Wang <jasowang@redhat.com>
>
> ===
>
>
> > ---
> >  drivers/net/virtio_net.c | 14 +++++++-------
> >  1 file changed, 7 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index 0416a7e00914..10c382b08bce 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -63,7 +63,7 @@ static const unsigned long guest_offloads[] = {
> >       VIRTIO_NET_F_GUEST_CSUM
> >  };
> >
> > -#define GUEST_OFFLOAD_LRO_MASK ((1ULL << VIRTIO_NET_F_GUEST_TSO4) | \
> > +#define GUEST_OFFLOAD_GRO_HW_MASK ((1ULL << VIRTIO_NET_F_GUEST_TSO4) | \
> >                               (1ULL << VIRTIO_NET_F_GUEST_TSO6) | \
> >                               (1ULL << VIRTIO_NET_F_GUEST_ECN)  | \
> >                               (1ULL << VIRTIO_NET_F_GUEST_UFO))
> > @@ -2481,7 +2481,7 @@ static int virtnet_xdp_set(struct net_device *dev, struct bpf_prog *prog,
> >               virtio_has_feature(vi->vdev, VIRTIO_NET_F_GUEST_ECN) ||
> >               virtio_has_feature(vi->vdev, VIRTIO_NET_F_GUEST_UFO) ||
> >               virtio_has_feature(vi->vdev, VIRTIO_NET_F_GUEST_CSUM))) {
> > -             NL_SET_ERR_MSG_MOD(extack, "Can't set XDP while host is implementing LRO/CSUM, disable LRO/CSUM first");
> > +             NL_SET_ERR_MSG_MOD(extack, "Can't set XDP while host is implementing GRO_HW/CSUM, disable GRO_HW/CSUM first");
> >               return -EOPNOTSUPP;
> >       }
> >
> > @@ -2612,15 +2612,15 @@ static int virtnet_set_features(struct net_device *dev,
> >       u64 offloads;
> >       int err;
> >
> > -     if ((dev->features ^ features) & NETIF_F_LRO) {
> > +     if ((dev->features ^ features) & NETIF_F_GRO_HW) {
> >               if (vi->xdp_enabled)
> >                       return -EBUSY;
> >
> > -             if (features & NETIF_F_LRO)
> > +             if (features & NETIF_F_GRO_HW)
> >                       offloads = vi->guest_offloads_capable;
> >               else
> >                       offloads = vi->guest_offloads_capable &
> > -                                ~GUEST_OFFLOAD_LRO_MASK;
> > +                                ~GUEST_OFFLOAD_GRO_HW_MASK;
> >
> >               err = virtnet_set_guest_offloads(vi, offloads);
> >               if (err)
> > @@ -3100,9 +3100,9 @@ static int virtnet_probe(struct virtio_device *vdev)
> >               dev->features |= NETIF_F_RXCSUM;
> >       if (virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_TSO4) ||
> >           virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_TSO6))
> > -             dev->features |= NETIF_F_LRO;
> > +             dev->features |= NETIF_F_GRO_HW;
> >       if (virtio_has_feature(vdev, VIRTIO_NET_F_CTRL_GUEST_OFFLOADS))
> > -             dev->hw_features |= NETIF_F_LRO;
> > +             dev->hw_features |= NETIF_F_GRO_HW;
> >
> >       dev->vlan_features = dev->features;
> >
> > --
> > 2.25.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

Return-Path: <SRS0=F+q/=ND=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CCB6C4320A
	for <virtualization@archiver.kernel.org>; Thu, 12 Aug 2021 05:00:19 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF2A460F57
	for <virtualization@archiver.kernel.org>; Thu, 12 Aug 2021 05:00:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org CF2A460F57
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 890E0826BB;
	Thu, 12 Aug 2021 05:00:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CRv69APEG_Ev; Thu, 12 Aug 2021 05:00:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 03BA08266D;
	Thu, 12 Aug 2021 05:00:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C7950C001A;
	Thu, 12 Aug 2021 05:00:12 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 76656C000E
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Aug 2021 05:00:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 55E55405D1
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Aug 2021 05:00:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EKlKTogPgc7b
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Aug 2021 05:00:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9DFC9404BF
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Aug 2021 05:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1628744406;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DQUQgpLOH7EvoFZyVb3gOKPst+Hz5mvO2rmYb4CAJ/s=;
 b=MlKzVbCjrwGEZvP08PDwvuvDNhenTYiH3Hopn6silgXktBYb9nHj+N+PJurYz62Fuk7AGT
 yrjQGK5ei8ndH8Nc80eqjHADbIo/m8CmY/QwqIiBUPIkY8NutQ6RkO2B0gYZKZwdlHPIPv
 CT7nWR1qod5angdw/FhYbhTbCbcVuTQ=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-574-ps42E7tYMTOBeu1_r7pmZw-1; Thu, 12 Aug 2021 01:00:05 -0400
X-MC-Unique: ps42E7tYMTOBeu1_r7pmZw-1
Received: by mail-ed1-f71.google.com with SMTP id
 j15-20020aa7c40f0000b02903be5fbe68a9so2430158edq.2
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Aug 2021 22:00:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=DQUQgpLOH7EvoFZyVb3gOKPst+Hz5mvO2rmYb4CAJ/s=;
 b=aCVqGZPxPNrTwN9tLx8r9XB5NpeebCDqSXNkcTiibOgeqzQD7kXhDye56jIsHaiK9D
 6Ro6Njq9A7d1IhOBTBKJQES4FWc6X1+5Fp08+9LuoBSZBWhBqvZ/2jq0yuztQ5Ie88Sw
 uYXdxUzhvDLneIKw2yeIt4fFFQUQqtDXEv9rMC2yJhrQptD7PTDzUic96kQ1TL2AyBqT
 tFnjEJ4H2W1luTQz2HhzTgA8OqrBHqke/TvtqQEyi0K4XeR4DXhRK08ENUWB0yArIKNK
 jDettGqCBC9KFpu/Pv3NlK9Husxl+EriX9YGQismpXmnOD++IgEpGU5Q/91KimpdOXpm
 Grbg==
X-Gm-Message-State: AOAM5337S30dEJPiZEx1VLpEdkBlGZdUV60IH5r7BJb/npbZYHV+WhlE
 OrEAeNJfGHu4iaivAWAqVliHlnAGmXAjw8d/qcNrHieSM+RTkI134aTleMhCM9xjM4FVkxojueP
 Hwf7ouVwl7clOV3aH8D6EKBE1aAH5gxtYfkWsPjr02w==
X-Received: by 2002:a17:906:580c:: with SMTP id
 m12mr1960729ejq.32.1628744404131; 
 Wed, 11 Aug 2021 22:00:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzKLVMf+qTdMY912mSDNmu9+IlM2KUZDsBbWXlCpC6KUa/Fgm9wWtlkt1XeENnU8hLWpfURvQ==
X-Received: by 2002:a17:906:580c:: with SMTP id
 m12mr1960711ejq.32.1628744403856; 
 Wed, 11 Aug 2021 22:00:03 -0700 (PDT)
Received: from redhat.com ([2.55.129.96])
 by smtp.gmail.com with ESMTPSA id ck17sm90912edb.88.2021.08.11.22.00.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Aug 2021 22:00:03 -0700 (PDT)
Date: Thu, 12 Aug 2021 00:59:59 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: ivan <ivan@prestigetransportation.com>
Subject: Re: [RFC PATCH] virtio-net: use NETIF_F_GRO_HW instead of NETIF_F_LRO
Message-ID: <20210812005246-mutt-send-email-mst@kernel.org>
References: <20210811081623.9832-1-jasowang@redhat.com>
 <CACFia2dOarWzZ-FfOgA-n3Puxhw4zacdEPtabzbbveyeuV3YBA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACFia2dOarWzZ-FfOgA-n3Puxhw4zacdEPtabzbbveyeuV3YBA@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 "David S. Miller" <davem@davemloft.net>
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

On Wed, Aug 11, 2021 at 08:20:03PM -0500, ivan wrote:
> On Wed, Aug 11, 2021 at 3:16 AM Jason Wang <jasowang@redhat.com> wrote:
> >
> > Commit a02e8964eaf92 ("virtio-net: ethtool configurable LRO") tries to
> > advertise LRO on behalf of the guest offloading features and allow the
> > administrator to enable and disable those features via ethtool.
> >
> > This may lead several issues:
> >
> > - For the device that doesn't support control guest offloads, the
> >   "LRO" can't be disabled so we will get a warn in the
> >   dev_disable_lro()
> > - For the device that have the control guest offloads, the guest
> >   offloads were disabled in the case of bridge etc which may slow down
> >   the traffic.
> >
> > Try to fix this by using NETIF_F_GRO_HW instead so we're not
> > guaranteed to be re-segmented as original. Or we may want a new netdev
> > feature like RX_GSO since the guest offloads for virtio-net is
> > actually to receive GSO packet.
> >
> > Or we can try not advertise LRO is control guest offloads is not
> > enabled. This solves the warning but will still slow down the traffic.
> >
> > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > ---
> >  drivers/net/virtio_net.c | 14 +++++++-------
> >  1 file changed, 7 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index 0416a7e00914..10c382b08bce 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -63,7 +63,7 @@ static const unsigned long guest_offloads[] = {
> >         VIRTIO_NET_F_GUEST_CSUM
> >  };
> >
> > -#define GUEST_OFFLOAD_LRO_MASK ((1ULL << VIRTIO_NET_F_GUEST_TSO4) | \
> > +#define GUEST_OFFLOAD_GRO_HW_MASK ((1ULL << VIRTIO_NET_F_GUEST_TSO4) | \
> >                                 (1ULL << VIRTIO_NET_F_GUEST_TSO6) | \
> >                                 (1ULL << VIRTIO_NET_F_GUEST_ECN)  | \
> >                                 (1ULL << VIRTIO_NET_F_GUEST_UFO))
> > @@ -2481,7 +2481,7 @@ static int virtnet_xdp_set(struct net_device *dev, struct bpf_prog *prog,
> >                 virtio_has_feature(vi->vdev, VIRTIO_NET_F_GUEST_ECN) ||
> >                 virtio_has_feature(vi->vdev, VIRTIO_NET_F_GUEST_UFO) ||
> >                 virtio_has_feature(vi->vdev, VIRTIO_NET_F_GUEST_CSUM))) {
> > -               NL_SET_ERR_MSG_MOD(extack, "Can't set XDP while host is implementing LRO/CSUM, disable LRO/CSUM first");
> > +               NL_SET_ERR_MSG_MOD(extack, "Can't set XDP while host is implementing GRO_HW/CSUM, disable GRO_HW/CSUM first");
> >                 return -EOPNOTSUPP;
> >         }
> >
> > @@ -2612,15 +2612,15 @@ static int virtnet_set_features(struct net_device *dev,
> >         u64 offloads;
> >         int err;
> >
> > -       if ((dev->features ^ features) & NETIF_F_LRO) {
> > +       if ((dev->features ^ features) & NETIF_F_GRO_HW) {
> >                 if (vi->xdp_enabled)
> >                         return -EBUSY;
> >
> > -               if (features & NETIF_F_LRO)
> > +               if (features & NETIF_F_GRO_HW)
> >                         offloads = vi->guest_offloads_capable;
> >                 else
> >                         offloads = vi->guest_offloads_capable &
> > -                                  ~GUEST_OFFLOAD_LRO_MASK;
> > +                                  ~GUEST_OFFLOAD_GRO_HW_MASK;
> >
> >                 err = virtnet_set_guest_offloads(vi, offloads);
> >                 if (err)
> > @@ -3100,9 +3100,9 @@ static int virtnet_probe(struct virtio_device *vdev)
> >                 dev->features |= NETIF_F_RXCSUM;
> >         if (virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_TSO4) ||
> >             virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_TSO6))
> > -               dev->features |= NETIF_F_LRO;
> > +               dev->features |= NETIF_F_GRO_HW;
> >         if (virtio_has_feature(vdev, VIRTIO_NET_F_CTRL_GUEST_OFFLOADS))
> > -               dev->hw_features |= NETIF_F_LRO;
> > +               dev->hw_features |= NETIF_F_GRO_HW;
> >
> >         dev->vlan_features = dev->features;
> >
> > --
> 
> I applied this patch, recompiled the kernel, and tested it.
> The warning messages are gone. Network speed is normal.
> I can now enable forwarding, and nothing bad happens.
> So far, so good.
> 
> Thank you.

OK so that's

Tested-by: ivan <ivan@prestigetransportation.com>

It is still weird that without the patch networking dies.

What happens if you apply the patch then try to disable GRO
using ethtool?

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

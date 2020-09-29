Return-Path: <SRS0=hez8=DG=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76F83C2D0A8
	for <virtualization@archiver.kernel.org>; Tue, 29 Sep 2020 01:47:55 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8EDC206F4
	for <virtualization@archiver.kernel.org>; Tue, 29 Sep 2020 01:47:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PSDamLIB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8EDC206F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 4F774866AE;
	Tue, 29 Sep 2020 01:47:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eL2Wp6TJE7SX; Tue, 29 Sep 2020 01:47:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id DA1F28669D;
	Tue, 29 Sep 2020 01:47:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AAD80C0891;
	Tue, 29 Sep 2020 01:47:52 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 36347C016F
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Sep 2020 01:47:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 1E9F586FAB
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Sep 2020 01:47:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 35Osz7DGXM8M
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Sep 2020 01:47:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ej1-f67.google.com (mail-ej1-f67.google.com
 [209.85.218.67])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 2720D86F6F
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Sep 2020 01:47:50 +0000 (UTC)
Received: by mail-ej1-f67.google.com with SMTP id r7so12548057ejs.11
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Sep 2020 18:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=MkBPqBhHfLDw/+PRNqDaEfF8oeqozUeo1kOlUOG88QU=;
 b=PSDamLIB9h0D9VqOfh0Em81onTFLfaclu1WQ9M+xWbr2+B4Y6fp7tFSyR1cqfaMthp
 ID2KARr9QaufbqRqcjSP4CWunJNb2hpnyS81ugqOu+qhG3c/m4JVjvA7uwiiNWlXOosR
 CQEgqY1nzWU1IuSiHN4XBf2pZFxUczj6upyR/JQI/5LTB8+yFaeUdGeeth6fSCK6SYBs
 2kOVpRobMBYeGbO3jiHzjd4pcSgpbv13CG+QzsFTbvpkyFtt7PCGFGyMqcwb0F58+cco
 3r4YrmKOyGDS0PLqslvwbRVnhI/cME9ZWxrzDaZhvcIC010R4s1YCUZowQbnpFdH+571
 NMPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=MkBPqBhHfLDw/+PRNqDaEfF8oeqozUeo1kOlUOG88QU=;
 b=ntI67wjIy8Ogo6HdJ36pKlrXqZFH1GZ66+xx/I9U5xVsnWofeZryBk6yCWwNr2n1jv
 DVHkj2hNn7IvX3Q7me7RsYHRlt5/TQg2ft5G0j1K5yPkB7HU4JlKTQMmuAEm463fikcG
 fCPSD4PJNtdcP5FV+3BTbUocM/9b2gx1+76bv3B3tpZ1E1zrYXR9mRJifdCpNP82WAm0
 ejfIgBuQI8ZZFJJcEvdrlaXMJPbk57pZD5IGKYp3vBTe4geFJss7+xWUIArNB4fNPl9r
 zIhpfoBWPl1GgsHBsBWBRBTrbA28/osugJ1+7ZcH3WmYNpFaUicFII+3Qk0UgSP4+tfl
 cF2A==
X-Gm-Message-State: AOAM530cdpVsRCxIzYj5v7gcwExz/6yr09uI0FDee/RW/6vHv9FEJ7uB
 Pxf9GUPLOAS3NPBj6Fx2+s0xNaxsB+3cp7ivvv8=
X-Google-Smtp-Source: ABdhPJwLhDDOLskOrdw3djY+kSSWJ0zk8ymGNb5sA+GernTPHpXjdOQ3WxytSLv0e44NxQdtmdv857KoIaazyTe5EDE=
X-Received: by 2002:a17:907:374:: with SMTP id
 rs20mr1580498ejb.135.1601344068474; 
 Mon, 28 Sep 2020 18:47:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200928033915.82810-1-xiangxia.m.yue@gmail.com>
 <20200928033915.82810-2-xiangxia.m.yue@gmail.com>
 <20200928152142-mutt-send-email-mst@kernel.org>
In-Reply-To: <20200928152142-mutt-send-email-mst@kernel.org>
From: Tonghao Zhang <xiangxia.m.yue@gmail.com>
Date: Tue, 29 Sep 2020 09:45:24 +0800
Message-ID: <CAMDZJNVUVm9y2NV5ZGHzrPoEaDF4PZEGWVFEx9g6sF3U-1Rm0Q@mail.gmail.com>
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

On Tue, Sep 29, 2020 at 3:25 AM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Mon, Sep 28, 2020 at 11:39:15AM +0800, xiangxia.m.yue@gmail.com wrote:
> > From: Tonghao Zhang <xiangxia.m.yue@gmail.com>
> >
> > Allow user configuring RXCSUM separately with ethtool -K,
> > reusing the existing virtnet_set_guest_offloads helper
> > that configures RXCSUM for XDP. This is conditional on
> > VIRTIO_NET_F_CTRL_GUEST_OFFLOADS.
> >
> > Cc: Michael S. Tsirkin <mst@redhat.com>
> > Cc: Jason Wang <jasowang@redhat.com>
> > Signed-off-by: Tonghao Zhang <xiangxia.m.yue@gmail.com>
> > ---
> >  drivers/net/virtio_net.c | 40 ++++++++++++++++++++++++++++------------
> >  1 file changed, 28 insertions(+), 12 deletions(-)
> >
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index 21b71148c532..2e3af0b2c281 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -68,6 +68,8 @@ static const unsigned long guest_offloads[] = {
> >                               (1ULL << VIRTIO_NET_F_GUEST_ECN)  | \
> >                               (1ULL << VIRTIO_NET_F_GUEST_UFO))
> >
> > +#define GUEST_OFFLOAD_CSUM_MASK (1ULL << VIRTIO_NET_F_GUEST_CSUM)
> > +
> >  struct virtnet_stat_desc {
> >       char desc[ETH_GSTRING_LEN];
> >       size_t offset;
> > @@ -2526,25 +2528,37 @@ static int virtnet_set_features(struct net_device *dev,
> >                               netdev_features_t features)
> >  {
> >       struct virtnet_info *vi = netdev_priv(dev);
> > -     u64 offloads;
> > +     u64 offloads = vi->guest_offloads &
> > +                    vi->guest_offloads_capable;
> >       int err;
> >
> > -     if ((dev->features ^ features) & NETIF_F_LRO) {
> > -             if (vi->xdp_queue_pairs)
> > -                     return -EBUSY;
> > +     /* Don't allow configuration while XDP is active. */
> > +     if (vi->xdp_queue_pairs)
> > +             return -EBUSY;
> >
> > +     if ((dev->features ^ features) & NETIF_F_LRO) {
> >               if (features & NETIF_F_LRO)
> > -                     offloads = vi->guest_offloads_capable;
> > +                     offloads |= GUEST_OFFLOAD_LRO_MASK;
> >               else
> > -                     offloads = vi->guest_offloads_capable &
> > -                                ~GUEST_OFFLOAD_LRO_MASK;
> > +                     offloads &= ~GUEST_OFFLOAD_LRO_MASK;
> > +     }
> >
> > -             err = virtnet_set_guest_offloads(vi, offloads);
> > -             if (err)
> > -                     return err;
> > -             vi->guest_offloads = offloads;
> > +     if ((dev->features ^ features) & NETIF_F_RXCSUM) {
> > +             if (features & NETIF_F_RXCSUM)
> > +                     offloads |= GUEST_OFFLOAD_CSUM_MASK;
> > +             else
> > +                     offloads &= ~GUEST_OFFLOAD_CSUM_MASK;
> >       }
> >
> > +     if (offloads == (vi->guest_offloads &
> > +                      vi->guest_offloads_capable))
> > +             return 0;
>
> Hmm, what exactly does this do?
If the features(lro, rxcsum) we supported, are not changed, it is not
necessary to invoke virtnet_set_guest_offloads.
> > +
> > +     err = virtnet_set_guest_offloads(vi, offloads);
> > +     if (err)
> > +             return err;
> > +
> > +     vi->guest_offloads = offloads;
> >       return 0;
> >  }
> >
> > @@ -3013,8 +3027,10 @@ static int virtnet_probe(struct virtio_device *vdev)
> >       if (virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_TSO4) ||
> >           virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_TSO6))
> >               dev->features |= NETIF_F_LRO;
> > -     if (virtio_has_feature(vdev, VIRTIO_NET_F_CTRL_GUEST_OFFLOADS))
> > +     if (virtio_has_feature(vdev, VIRTIO_NET_F_CTRL_GUEST_OFFLOADS)) {
> > +             dev->hw_features |= NETIF_F_RXCSUM;
> >               dev->hw_features |= NETIF_F_LRO;
> > +     }
> >
> >       dev->vlan_features = dev->features;
> >
> > --
> > 2.23.0
>


-- 
Best regards, Tonghao
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

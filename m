Return-Path: <SRS0=bpJj=DR=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 677ABC433DF
	for <virtualization@archiver.kernel.org>; Sat, 10 Oct 2020 01:57:43 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DAE872225B
	for <virtualization@archiver.kernel.org>; Sat, 10 Oct 2020 01:57:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AGxCOJHz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAE872225B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 84C1220434;
	Sat, 10 Oct 2020 01:57:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id B0gQq3NTnA-I; Sat, 10 Oct 2020 01:57:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 3ED1E2042B;
	Sat, 10 Oct 2020 01:57:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1DCF9C07FF;
	Sat, 10 Oct 2020 01:57:41 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7C02FC0051
 for <virtualization@lists.linux-foundation.org>;
 Sat, 10 Oct 2020 01:57:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 62D45878AC
 for <virtualization@lists.linux-foundation.org>;
 Sat, 10 Oct 2020 01:57:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WmHtABeN9fSS
 for <virtualization@lists.linux-foundation.org>;
 Sat, 10 Oct 2020 01:57:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ed1-f68.google.com (mail-ed1-f68.google.com
 [209.85.208.68])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 450BC878A5
 for <virtualization@lists.linux-foundation.org>;
 Sat, 10 Oct 2020 01:57:39 +0000 (UTC)
Received: by mail-ed1-f68.google.com with SMTP id g4so11355333edk.0
 for <virtualization@lists.linux-foundation.org>;
 Fri, 09 Oct 2020 18:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Ej9W/wdGVHkJe37GtEVPFUNkVAYebVIX+ppZawU5yrs=;
 b=AGxCOJHzE8qt9ydl/IFHP1pag6Xl2y0SE6klNIOxFzIPPOL9B1XBGnoEnNg+MdCh0G
 MHvMO+8NydjJjzZLvD1Sh+rjlc9BPaP8mJ2rdRUtBObCS89ZtnqW4zHe4prcYfHWfmGa
 3e9j+lVcc+InthdxpylwAj5yHUEyGStkdSwYSYnXyzTNuMl6RZeXFB5orzWCvGGL/qmo
 3B7gfcEoeP9R0MKPU1pZqtCneKTBbUifr8fKnkGWtkZq4QbBtDeudVSh5tgHIcPVygZa
 yPHQzFeiGbyg0LcYWG+E6dKX/CfjmK/meXzQXjiT1OIKIT5MVere9406dlZ5Irpq+w+w
 +4cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Ej9W/wdGVHkJe37GtEVPFUNkVAYebVIX+ppZawU5yrs=;
 b=Di66WDf79U2K9HIBfTZ6WTj7PwF5XpjqCQduE/BPk0jt2gNubK0oewVxNw2iOjV6+R
 RUSk580XBvo5GZHau/hl0clFyAAvSM22VfzTjxXLITmgJJ8zgvWMI4/JKrtA5NdWCdzE
 F+XcdhOBdQ6S/oXToRf9yYPMt8O/9F/0SkZRkMdGpVgmJVQkSDSqmN+rugi1ykfQSNYN
 P+7ikAEGV5ezTMXcZhA3fkt9pMOtqL6qI/Ev4fs9n2ljGlkcy2QqN93k7kfAVr81Mybq
 NEerlA5gfEDen5yB7PKv5FJrS90N1XRgTWKsFjACjqjJ2eE4NhxjHlBPT2rHfW5jKfDe
 sLGQ==
X-Gm-Message-State: AOAM530KX6YbXHNuSJAKnaVKiv++PAtGr6Vq8cmrScymOtKwfNcRX8YK
 4KvSxX0OfTP+ZfvM5n9CA+KQJ5rjPUFGOD1MjdE=
X-Google-Smtp-Source: ABdhPJyJJ+UkVEE2d2vb9hs4seDQAQq4hn36I76NEv8nbeEGM+0qf7M+SunlzivmvT00lYbk0s/isHHe1DNP0bwbmf4=
X-Received: by 2002:a05:6402:7c8:: with SMTP id
 u8mr2267491edy.153.1602295057527; 
 Fri, 09 Oct 2020 18:57:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200930020300.62245-1-xiangxia.m.yue@gmail.com>
 <CA+FuTSed1GsGp8a=GnHqV-HUcsOSZ0tb0NCe8360S8Md3MbS3g@mail.gmail.com>
 <CAMDZJNWX=3ikS5f0H+xD-dByW2=JHXjvk1=R=CkDLt0TW-orTg@mail.gmail.com>
 <CA+FuTSeVRhM+q_WuWvBDMk+Ao61y+iJWTukpoLzNCHGfYG9=UA@mail.gmail.com>
In-Reply-To: <CA+FuTSeVRhM+q_WuWvBDMk+Ao61y+iJWTukpoLzNCHGfYG9=UA@mail.gmail.com>
From: Tonghao Zhang <xiangxia.m.yue@gmail.com>
Date: Sat, 10 Oct 2020 09:53:45 +0800
Message-ID: <CAMDZJNUY-F47m0aQ0wqG_O-ttauS0_dciBTrL=DU=Z_h-w+-Kw@mail.gmail.com>
Subject: Re: [PATCH net-next v2] virtio-net: ethtool configurable RXCSUM
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Network Development <netdev@vger.kernel.org>,
 virtualization@lists.linux-foundation.org,
 "Michael S. Tsirkin" <mst@redhat.com>
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

On Fri, Oct 9, 2020 at 9:49 PM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> On Thu, Oct 8, 2020 at 9:19 PM Tonghao Zhang <xiangxia.m.yue@gmail.com> wrote:
> >
> > On Wed, Sep 30, 2020 at 6:05 PM Willem de Bruijn
> > <willemdebruijn.kernel@gmail.com> wrote:
> > >
> > > On Wed, Sep 30, 2020 at 4:05 AM <xiangxia.m.yue@gmail.com> wrote:
> > > >
> > > > From: Tonghao Zhang <xiangxia.m.yue@gmail.com>
> > > >
> > > > Allow user configuring RXCSUM separately with ethtool -K,
> > > > reusing the existing virtnet_set_guest_offloads helper
> > > > that configures RXCSUM for XDP. This is conditional on
> > > > VIRTIO_NET_F_CTRL_GUEST_OFFLOADS.
> > > >
> > > > If Rx checksum is disabled, LRO should also be disabled.
> > > >
> > > > Cc: Michael S. Tsirkin <mst@redhat.com>
> > > > Cc: Jason Wang <jasowang@redhat.com>
> > > > Signed-off-by: Tonghao Zhang <xiangxia.m.yue@gmail.com>
> > >
> > > The first patch was merged into net.
> > >
> > > Please wait until that is merged into net-next, as this depends on the
> > > other patch.
> > >
> > > > ---
> > > > v2:
> > > > * LRO depends the rx csum
> > > > * remove the unnecessary check
> > > > ---
> > > >  drivers/net/virtio_net.c | 49 ++++++++++++++++++++++++++++++----------
> > > >  1 file changed, 37 insertions(+), 12 deletions(-)
> > > >
> > > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > > index 21b71148c532..5407a0106771 100644
> > > > --- a/drivers/net/virtio_net.c
> > > > +++ b/drivers/net/virtio_net.c
> > > > @@ -68,6 +68,8 @@ static const unsigned long guest_offloads[] = {
> > > >                                 (1ULL << VIRTIO_NET_F_GUEST_ECN)  | \
> > > >                                 (1ULL << VIRTIO_NET_F_GUEST_UFO))
> > > >
> > > > +#define GUEST_OFFLOAD_CSUM_MASK (1ULL << VIRTIO_NET_F_GUEST_CSUM)
> > > > +
> > > >  struct virtnet_stat_desc {
> > > >         char desc[ETH_GSTRING_LEN];
> > > >         size_t offset;
> > > > @@ -2522,29 +2524,49 @@ static int virtnet_get_phys_port_name(struct net_device *dev, char *buf,
> > > >         return 0;
> > > >  }
> > > >
> > > > +static netdev_features_t virtnet_fix_features(struct net_device *netdev,
> > > > +                                             netdev_features_t features)
> > > > +{
> > > > +       /* If Rx checksum is disabled, LRO should also be disabled.
> > > > +        * That is life. :)
> > >
> > > Please remove this second line.
> > OK
> > > > +        */
> > > > +       if (!(features & NETIF_F_RXCSUM))
> > > > +               features &= ~NETIF_F_LRO;
> > > > +
> > > > +       return features;
> > > > +}
> > > > +
> > > >  static int virtnet_set_features(struct net_device *dev,
> > > >                                 netdev_features_t features)
> > > >  {
> > > >         struct virtnet_info *vi = netdev_priv(dev);
> > > > -       u64 offloads;
> > > > +       u64 offloads = vi->guest_offloads &
> > > > +                      vi->guest_offloads_capable;
> > >
> > > When can vi->guest_offloads have bits set outside the mask of
> > > vi->guest_offloads_capable?
> > In this case, we can use only vi->guest_offloads. and
> > guest_offloads_capable will not be used any more.
> > so should we remove guest_offloads_capable ?
>
> That bitmap stores the capabilities of the device as learned at
> initial device probe. I don't see how it can be removed.
Hi Willem
guest_offloads_capable was introduced by
a02e8964eaf9 ("virtio-net: ethtool configurable LRO")
and used only for LRO. Now we don't use it anymore, right ?
because this patch (virtio-net: ethtool configurable RXCSUM)
doesn't use it.


-- 
Best regards, Tonghao
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

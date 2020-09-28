Return-Path: <SRS0=0GV8=DF=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB542C4727F
	for <virtualization@archiver.kernel.org>; Mon, 28 Sep 2020 09:25:10 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F35921D95
	for <virtualization@archiver.kernel.org>; Mon, 28 Sep 2020 09:25:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LKeWaMM2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F35921D95
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id D6EDF85683;
	Mon, 28 Sep 2020 09:25:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id W2lCFQKnlr39; Mon, 28 Sep 2020 09:25:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 589518562A;
	Mon, 28 Sep 2020 09:25:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 502D7C016F;
	Mon, 28 Sep 2020 09:25:09 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8513DC0051
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Sep 2020 09:25:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 742BD8567A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Sep 2020 09:25:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fbkp_XT6UApq
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Sep 2020 09:25:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ed1-f67.google.com (mail-ed1-f67.google.com
 [209.85.208.67])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id A89C18562A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Sep 2020 09:25:06 +0000 (UTC)
Received: by mail-ed1-f67.google.com with SMTP id t16so514685edw.7
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Sep 2020 02:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=D54y3w+nC4nVWs7Kc//fHorCLSEx8nCQ+X16e2eDf14=;
 b=LKeWaMM23bFWnothf8UNYy+IVMcB9xCJ9DPOEjaISvkbMppRy8WT5dOTlyUwCKw7TT
 hjIhKrBSTxj7UoJtIqrqf/xo/gcz7xYlDRm8uM8eO3ihYlb5MPb11ryzqXYHRxKAwnMm
 kIuA07d1ZI6eS7CU1kH/Af+2buP/jrKy6cio98vuZ973gF4Nc48ZxiPgOqyT8nX/j7zz
 SQKHGTw5Od9Fru8pUddZhrqsHew5iAkEMnfsi3ZEx60fDc0CSQRUsPmelklPDix0/Evv
 WxsgY6LBVONJDiZo38OFbACx5eIpOtmu6MrFOAMlVW5VPsmp4PySYMPBQvh6rEsV4X5Q
 7Clw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=D54y3w+nC4nVWs7Kc//fHorCLSEx8nCQ+X16e2eDf14=;
 b=cJ5xalg6Zw9Aok7weF72a0VNKgPZ11BKtQRmW7IRrwNsinCNdFFXeqWGqwCkRF5dwF
 ShAx1QAO92f0oZhxOMOpiwnj/6czfKrbvkDzTo0Q7m6OkvKbQWi3s+Xfz8P3wzcZpD2h
 ImRqUK/CY20F0jSTJaqgURY0WdH93Jz6hMuOAHcQa5iAKrcItW2HokZ81Ktgd/veVCFh
 9dMICkxA4giJ745IITjCndeSNenMmXtJze7BLkZHrflwoPaama2DEppgnaY9JPWb+TS6
 k4R3HffnTIrIuwBbPvGqrnMD2wZNdk99N2zhZYi8OBA4l10tyNj8XOdRrbRbDLc5YiBn
 8wSw==
X-Gm-Message-State: AOAM532LCaPUbfgrPGdz+7/YYkV/XiNYcQ3RsID4I/GCgZEBCB9jfbtc
 MuuEVcQpN7yYEHaSFvAkWjp4i7QriwFzBW1AQUA=
X-Google-Smtp-Source: ABdhPJxR6b3+1zzRBUVLqpxSSiAWiCWb5Sh5292b3+AcD6At3PjbCLi8ucjBdo9k7H+vplPCduJl41tAx1bXHOKIDZI=
X-Received: by 2002:a05:6402:304f:: with SMTP id
 bu15mr661152edb.201.1601285105029; 
 Mon, 28 Sep 2020 02:25:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200928033915.82810-1-xiangxia.m.yue@gmail.com>
 <20200928033915.82810-2-xiangxia.m.yue@gmail.com>
 <CA+FuTSeOzCAVShBa1VTXtkqzc9YFdng_Dk1wVbjVeniTRREM=A@mail.gmail.com>
In-Reply-To: <CA+FuTSeOzCAVShBa1VTXtkqzc9YFdng_Dk1wVbjVeniTRREM=A@mail.gmail.com>
From: Tonghao Zhang <xiangxia.m.yue@gmail.com>
Date: Mon, 28 Sep 2020 17:22:53 +0800
Message-ID: <CAMDZJNWBtbB07czxpgmGXEazFSKuaToaWPAGxt4ts2AeV8BJnw@mail.gmail.com>
Subject: Re: [PATCH 2/2] virtio-net: ethtool configurable RXCSUM
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

On Mon, Sep 28, 2020 at 4:39 PM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> On Mon, Sep 28, 2020 at 5:42 AM <xiangxia.m.yue@gmail.com> wrote:
> >
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
> >                                 (1ULL << VIRTIO_NET_F_GUEST_ECN)  | \
> >                                 (1ULL << VIRTIO_NET_F_GUEST_UFO))
> >
> > +#define GUEST_OFFLOAD_CSUM_MASK (1ULL << VIRTIO_NET_F_GUEST_CSUM)
> > +
> >  struct virtnet_stat_desc {
> >         char desc[ETH_GSTRING_LEN];
> >         size_t offset;
> > @@ -2526,25 +2528,37 @@ static int virtnet_set_features(struct net_device *dev,
> >                                 netdev_features_t features)
> >  {
> >         struct virtnet_info *vi = netdev_priv(dev);
> > -       u64 offloads;
> > +       u64 offloads = vi->guest_offloads &
> > +                      vi->guest_offloads_capable;
> >         int err;
> >
> > -       if ((dev->features ^ features) & NETIF_F_LRO) {
> > -               if (vi->xdp_queue_pairs)
> > -                       return -EBUSY;
> > +       /* Don't allow configuration while XDP is active. */
> > +       if (vi->xdp_queue_pairs)
> > +               return -EBUSY;
> >
> > +       if ((dev->features ^ features) & NETIF_F_LRO) {
> >                 if (features & NETIF_F_LRO)
> > -                       offloads = vi->guest_offloads_capable;
> > +                       offloads |= GUEST_OFFLOAD_LRO_MASK;
> >                 else
> > -                       offloads = vi->guest_offloads_capable &
> > -                                  ~GUEST_OFFLOAD_LRO_MASK;
> > +                       offloads &= ~GUEST_OFFLOAD_LRO_MASK;
> > +       }
> >
> > -               err = virtnet_set_guest_offloads(vi, offloads);
> > -               if (err)
> > -                       return err;
> > -               vi->guest_offloads = offloads;
> > +       if ((dev->features ^ features) & NETIF_F_RXCSUM) {
> > +               if (features & NETIF_F_RXCSUM)
> > +                       offloads |= GUEST_OFFLOAD_CSUM_MASK;
> > +               else
> > +                       offloads &= ~GUEST_OFFLOAD_CSUM_MASK;
> >         }
>
> LRO requires receive checksum offload: packets must have their
> checksum verified prior to coalescing.
Oh, sorry for that, I will change that patch. thanks!
> The two features can thus not be configured fully independently.



-- 
Best regards, Tonghao
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

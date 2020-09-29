Return-Path: <SRS0=hez8=DG=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 653D3C4346E
	for <virtualization@archiver.kernel.org>; Tue, 29 Sep 2020 06:04:04 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F23220BED
	for <virtualization@archiver.kernel.org>; Tue, 29 Sep 2020 06:04:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NxNiZNJ+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F23220BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id E047C86FF8;
	Tue, 29 Sep 2020 06:04:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PAyQXR6ppBNw; Tue, 29 Sep 2020 06:04:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 55C0B86FCF;
	Tue, 29 Sep 2020 06:04:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3FEAFC016F;
	Tue, 29 Sep 2020 06:04:03 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4857EC0051
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Sep 2020 06:04:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 427FB8527F
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Sep 2020 06:04:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kT3kryuO7U5e
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Sep 2020 06:03:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ej1-f66.google.com (mail-ej1-f66.google.com
 [209.85.218.66])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 2824C80614
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Sep 2020 06:03:58 +0000 (UTC)
Received: by mail-ej1-f66.google.com with SMTP id z23so13216741ejr.13
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Sep 2020 23:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=cbzGI2E63rvacCgT4IMKli2vxVX3CttMz/Tx1YiiZz4=;
 b=NxNiZNJ+OG8oxMmSK7C6prgulO6SqIcircN1UxT/zdOGR92Uemo+KDnwi9gT0syDgZ
 /nEIFdDUiHPieQZrs5fA5lGMztANsWA41JiobgsR/bSJVTABbJD4Vc/BtrGBXsUepY1F
 5Nk/m+D46iZ8n5qs56ejH60OiZN4zjU392fNgEQTUtWNNZHWytx0r/ZTvBRcvuybUqad
 XkKz/qBEEeMc1x44VTnwc8bc/TITwSu2UbsZz+4WjbfvaHc+UDVdGegNcrPwroG18wAW
 JQALySM+3lHTMbiMVH+ODU2to/AvBeeM5u/wd2bhoatGd6GCTcyFz4zWkTmQUD0VSiEf
 fxyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=cbzGI2E63rvacCgT4IMKli2vxVX3CttMz/Tx1YiiZz4=;
 b=XjflpwYn/B3u5mBLTdFw8R0DtJQRVdtUuZ84aMi/LQRBPZSC2UFrPQmveBrU5TbWGb
 HsX6jQ9ZYU9KOz8GiT8PZxxdFnNMirBIa2DgLNqGCrRrFkR6gpz/NSTOpl17WL14YQBR
 KmFYG2ReGmjPY2YIgIlHQob8sSsZ09Ivr9Lv4eZTIaFvjdO+lvEhFFrLgZG1m9xWaGbh
 9Ma3Mu2WY6O6DWNNq1nJiioUtemRhwyNYDzsZYlt3PS7kpXC2QHfAbSAFwwnvmngIgUj
 6msvSK7UBCfrcSz8nQXQByXUrKSq70EBHU5nmugDzjs2lyqpRmRMtzttMwG4HXjatXyx
 LxCA==
X-Gm-Message-State: AOAM532Bmf+sgxImmWQ5wSbijfCK8xjbjm4vojiR8Haz/NjLhAMZnkcy
 MgfqJi4/+NIIhjIG5/WRDvyBHxPPGK4LNgoQzSM=
X-Google-Smtp-Source: ABdhPJx4NzKw/Sv5M31LactrcvvEGd5J1cmI3BJLFWADl29QUTQ+on8SInzw2zCQ0mO4/8iDIsy3zhNZ2eCoIisHQX8=
X-Received: by 2002:a17:906:178d:: with SMTP id
 t13mr2350935eje.410.1601359436511; 
 Mon, 28 Sep 2020 23:03:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200928033915.82810-1-xiangxia.m.yue@gmail.com>
 <20200928151531-mutt-send-email-mst@kernel.org>
 <CAMDZJNV_A+EuqFGEhB_-g_5unUJ9TyyDZu1krtxBS22EnW1mAw@mail.gmail.com>
 <20200929015624-mutt-send-email-mst@kernel.org>
In-Reply-To: <20200929015624-mutt-send-email-mst@kernel.org>
From: Tonghao Zhang <xiangxia.m.yue@gmail.com>
Date: Tue, 29 Sep 2020 14:01:32 +0800
Message-ID: <CAMDZJNWtGBoiOsyzpPg8MK-YL=E+a4+fiV_cThrDpW-GY+fMMg@mail.gmail.com>
Subject: Re: [PATCH 1/2] virtio-net: don't disable guest csum when disable LRO
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Linux Kernel Network Developers <netdev@vger.kernel.org>,
 Willem de Bruijn <willemb@google.com>,
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

On Tue, Sep 29, 2020 at 1:57 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Tue, Sep 29, 2020 at 09:40:22AM +0800, Tonghao Zhang wrote:
> > On Tue, Sep 29, 2020 at 3:21 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> > >
> > > On Mon, Sep 28, 2020 at 11:39:14AM +0800, xiangxia.m.yue@gmail.com wrote:
> > > > From: Tonghao Zhang <xiangxia.m.yue@gmail.com>
> > > >
> > > > Open vSwitch and Linux bridge will disable LRO of the interface
> > > > when this interface added to them. Now when disable the LRO, the
> > > > virtio-net csum is disable too. That drops the forwarding performance.
> > > >
> > > > Fixes: e59ff2c49ae1 ("virtio-net: disable guest csum during XDP set")
> > >
> > > I am a bit confused by this tag. Did this change bring about
> > > disabling checksum when LRO is disabled? I am not sure
> > > I follow how ...
> > Hi Michael
> > It's not right fix tag.
> > The commit a02e8964eaf9 ("virtio-net: ethtool configurable LRO"),
> > disable the csum, when we disable the LRO
>
> OK then, pls send a correct Fixes tag when you repost this ...
Hi Michael
I repost this patch, please review. thanks.
http://patchwork.ozlabs.org/project/netdev/patch/20200929015806.19171-1-xiangxia.m.yue@gmail.com/
> > > > Cc: Michael S. Tsirkin <mst@redhat.com>
> > > > Cc: Jason Wang <jasowang@redhat.com>
> > > > Cc: Willem de Bruijn <willemb@google.com>
> > > > Signed-off-by: Tonghao Zhang <xiangxia.m.yue@gmail.com>
> > > > ---
> > > >  drivers/net/virtio_net.c | 8 +++++++-
> > > >  1 file changed, 7 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > > index 7145c83c6c8c..21b71148c532 100644
> > > > --- a/drivers/net/virtio_net.c
> > > > +++ b/drivers/net/virtio_net.c
> > > > @@ -63,6 +63,11 @@ static const unsigned long guest_offloads[] = {
> > > >       VIRTIO_NET_F_GUEST_CSUM
> > > >  };
> > > >
> > > > +#define GUEST_OFFLOAD_LRO_MASK ((1ULL << VIRTIO_NET_F_GUEST_TSO4) | \
> > > > +                             (1ULL << VIRTIO_NET_F_GUEST_TSO6) | \
> > > > +                             (1ULL << VIRTIO_NET_F_GUEST_ECN)  | \
> > > > +                             (1ULL << VIRTIO_NET_F_GUEST_UFO))
> > > > +
> > > >  struct virtnet_stat_desc {
> > > >       char desc[ETH_GSTRING_LEN];
> > > >       size_t offset;
> > > > @@ -2531,7 +2536,8 @@ static int virtnet_set_features(struct net_device *dev,
> > > >               if (features & NETIF_F_LRO)
> > > >                       offloads = vi->guest_offloads_capable;
> > > >               else
> > > > -                     offloads = 0;
> > > > +                     offloads = vi->guest_offloads_capable &
> > > > +                                ~GUEST_OFFLOAD_LRO_MASK;
> > > >
> > > >               err = virtnet_set_guest_offloads(vi, offloads);
> > > >               if (err)
> > > > --
> > > > 2.23.0
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

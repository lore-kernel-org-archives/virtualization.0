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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F94FC433DF
	for <virtualization@archiver.kernel.org>; Sat, 10 Oct 2020 19:04:24 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 930FC206BE
	for <virtualization@archiver.kernel.org>; Sat, 10 Oct 2020 19:04:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UI3mYte4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 930FC206BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 319D6877CB;
	Sat, 10 Oct 2020 19:04:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PRg1S7GSzFOB; Sat, 10 Oct 2020 19:04:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id DE3AD876C1;
	Sat, 10 Oct 2020 19:04:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BE811C07FF;
	Sat, 10 Oct 2020 19:04:21 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0EA4BC0051
 for <virtualization@lists.linux-foundation.org>;
 Sat, 10 Oct 2020 19:04:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id E615B87722
 for <virtualization@lists.linux-foundation.org>;
 Sat, 10 Oct 2020 19:04:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dp9JEjq6XEE2
 for <virtualization@lists.linux-foundation.org>;
 Sat, 10 Oct 2020 19:04:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com
 [209.85.210.193])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 29287872D2
 for <virtualization@lists.linux-foundation.org>;
 Sat, 10 Oct 2020 19:04:20 +0000 (UTC)
Received: by mail-pf1-f193.google.com with SMTP id d1so1408452pfc.0
 for <virtualization@lists.linux-foundation.org>;
 Sat, 10 Oct 2020 12:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=GvvHnnSbHJ2XDnxeZeyrA7lUthNy++4jLaKqWSsbUWg=;
 b=UI3mYte48TBb7t5UoUAlrw8I1mebFnXRYY0E4e+Xwm3vyju2+1MmUZL/KsVSGejObH
 2sNlqaeBB6/8OGFGpxILOyMyFX5cTCd8DX928wIN78HWmoeGmeI2inhnW7chCIMeLFvS
 H58EERauO+uS02O2GmXWUxs7YGz0xducr5JyMQHzXKqFgolaJG37RQenIzwb5F7+Oriw
 jgisMb9W7i0UAKD3YuP7J38Zc5dcJRqu6Hbi+5gTwunWBW2N3EoYPqYQWAWVRGiwiBsV
 N1wgKDacLLXXrADZX0WYXmfwIjL0BLh76O37N9Wov+aTYnu8RjmKBfwYV61HWvzYDKQi
 9qUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=GvvHnnSbHJ2XDnxeZeyrA7lUthNy++4jLaKqWSsbUWg=;
 b=dHfmHX8TEbWgMrRjQ5UnuJNNF7b9hfmTJ3cs4rsYXK5WcNJY7PjnVaNxInN2TT8WK9
 U3cgt3H1uvxo3yUNIIPG+4w2UyL+OceokJ3rR3ftmk/bNfA2XG+MmZurzvzgxp/NvWqq
 uwZ9fuT2VBV9qdYVkxnQmmpDEhngMwHfocBEYhArl7yKtKe0ffVGWI94D8xgBXiu1+MK
 PvYaaR4k7Ja7Z4sVt9ZeP5DeUyhZVb7A/BkMLd7OsgexUYz37XCQo5QzSCgRBKAW7rOU
 mP0GIuNLQtUOpTVDWjfYV3+UBiZbToZ/UbypEtlhEA1xXtLuhimAolrn7lb0JaiqvXq9
 WhsQ==
X-Gm-Message-State: AOAM5329hYftdjM7JtJHPYglkJRmxmiTFKZnTcPURbZk+8071rSjsued
 d+n57rLjY9S8PfkyF4EdyAIYLs9gOxk=
X-Google-Smtp-Source: ABdhPJxkv3rH20gU+0pxm0liMZEHKUboK4WydO7Kkh/LQap1xkmJmqHZJKn57wCv4QWsUV0V/eifqg==
X-Received: by 2002:a05:6102:3013:: with SMTP id
 s19mr11369240vsa.2.1602356320413; 
 Sat, 10 Oct 2020 11:58:40 -0700 (PDT)
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com.
 [209.85.221.182])
 by smtp.gmail.com with ESMTPSA id b197sm1620405vkb.52.2020.10.10.11.58.38
 for <virtualization@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 10 Oct 2020 11:58:39 -0700 (PDT)
Received: by mail-vk1-f182.google.com with SMTP id c63so2904472vkb.7
 for <virtualization@lists.linux-foundation.org>;
 Sat, 10 Oct 2020 11:58:38 -0700 (PDT)
X-Received: by 2002:a1f:5341:: with SMTP id h62mr10099366vkb.24.1602356317922; 
 Sat, 10 Oct 2020 11:58:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200930020300.62245-1-xiangxia.m.yue@gmail.com>
 <CA+FuTSed1GsGp8a=GnHqV-HUcsOSZ0tb0NCe8360S8Md3MbS3g@mail.gmail.com>
 <CAMDZJNWX=3ikS5f0H+xD-dByW2=JHXjvk1=R=CkDLt0TW-orTg@mail.gmail.com>
 <CA+FuTSeVRhM+q_WuWvBDMk+Ao61y+iJWTukpoLzNCHGfYG9=UA@mail.gmail.com>
 <CAMDZJNUY-F47m0aQ0wqG_O-ttauS0_dciBTrL=DU=Z_h-w+-Kw@mail.gmail.com>
In-Reply-To: <CAMDZJNUY-F47m0aQ0wqG_O-ttauS0_dciBTrL=DU=Z_h-w+-Kw@mail.gmail.com>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Sat, 10 Oct 2020 14:58:01 -0400
X-Gmail-Original-Message-ID: <CA+FuTSeOa1Xh4XtrKd2F2hJa5cn-+UA3-E3BKxe66oTJbxH3Vw@mail.gmail.com>
Message-ID: <CA+FuTSeOa1Xh4XtrKd2F2hJa5cn-+UA3-E3BKxe66oTJbxH3Vw@mail.gmail.com>
Subject: Re: [PATCH net-next v2] virtio-net: ethtool configurable RXCSUM
To: Tonghao Zhang <xiangxia.m.yue@gmail.com>
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

On Fri, Oct 9, 2020 at 10:10 PM Tonghao Zhang <xiangxia.m.yue@gmail.com> wrote:
>
> On Fri, Oct 9, 2020 at 9:49 PM Willem de Bruijn
> <willemdebruijn.kernel@gmail.com> wrote:
> >
> > On Thu, Oct 8, 2020 at 9:19 PM Tonghao Zhang <xiangxia.m.yue@gmail.com> wrote:
> > >
> > > On Wed, Sep 30, 2020 at 6:05 PM Willem de Bruijn
> > > <willemdebruijn.kernel@gmail.com> wrote:
> > > >
> > > > On Wed, Sep 30, 2020 at 4:05 AM <xiangxia.m.yue@gmail.com> wrote:
> > > > >
> > > > > From: Tonghao Zhang <xiangxia.m.yue@gmail.com>
> > > > >
> > > > > Allow user configuring RXCSUM separately with ethtool -K,
> > > > > reusing the existing virtnet_set_guest_offloads helper
> > > > > that configures RXCSUM for XDP. This is conditional on
> > > > > VIRTIO_NET_F_CTRL_GUEST_OFFLOADS.
> > > > >
> > > > > If Rx checksum is disabled, LRO should also be disabled.
> > > > >
> > > > > Cc: Michael S. Tsirkin <mst@redhat.com>
> > > > > Cc: Jason Wang <jasowang@redhat.com>
> > > > > Signed-off-by: Tonghao Zhang <xiangxia.m.yue@gmail.com>
> > > >
> > > > The first patch was merged into net.
> > > >
> > > > Please wait until that is merged into net-next, as this depends on the
> > > > other patch.
> > > >
> > > > > ---
> > > > > v2:
> > > > > * LRO depends the rx csum
> > > > > * remove the unnecessary check
> > > > > ---
> > > > >  drivers/net/virtio_net.c | 49 ++++++++++++++++++++++++++++++----------
> > > > >  1 file changed, 37 insertions(+), 12 deletions(-)
> > > > >
> > > > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > > > index 21b71148c532..5407a0106771 100644
> > > > > --- a/drivers/net/virtio_net.c
> > > > > +++ b/drivers/net/virtio_net.c
> > > > > @@ -68,6 +68,8 @@ static const unsigned long guest_offloads[] = {
> > > > >                                 (1ULL << VIRTIO_NET_F_GUEST_ECN)  | \
> > > > >                                 (1ULL << VIRTIO_NET_F_GUEST_UFO))
> > > > >
> > > > > +#define GUEST_OFFLOAD_CSUM_MASK (1ULL << VIRTIO_NET_F_GUEST_CSUM)
> > > > > +
> > > > >  struct virtnet_stat_desc {
> > > > >         char desc[ETH_GSTRING_LEN];
> > > > >         size_t offset;
> > > > > @@ -2522,29 +2524,49 @@ static int virtnet_get_phys_port_name(struct net_device *dev, char *buf,
> > > > >         return 0;
> > > > >  }
> > > > >
> > > > > +static netdev_features_t virtnet_fix_features(struct net_device *netdev,
> > > > > +                                             netdev_features_t features)
> > > > > +{
> > > > > +       /* If Rx checksum is disabled, LRO should also be disabled.
> > > > > +        * That is life. :)
> > > >
> > > > Please remove this second line.
> > > OK
> > > > > +        */
> > > > > +       if (!(features & NETIF_F_RXCSUM))
> > > > > +               features &= ~NETIF_F_LRO;
> > > > > +
> > > > > +       return features;
> > > > > +}
> > > > > +
> > > > >  static int virtnet_set_features(struct net_device *dev,
> > > > >                                 netdev_features_t features)
> > > > >  {
> > > > >         struct virtnet_info *vi = netdev_priv(dev);
> > > > > -       u64 offloads;
> > > > > +       u64 offloads = vi->guest_offloads &
> > > > > +                      vi->guest_offloads_capable;
> > > >
> > > > When can vi->guest_offloads have bits set outside the mask of
> > > > vi->guest_offloads_capable?
> > > In this case, we can use only vi->guest_offloads. and
> > > guest_offloads_capable will not be used any more.
> > > so should we remove guest_offloads_capable ?
> >
> > That bitmap stores the capabilities of the device as learned at
> > initial device probe. I don't see how it can be removed.
> Hi Willem
> guest_offloads_capable was introduced by
> a02e8964eaf9 ("virtio-net: ethtool configurable LRO")
> and used only for LRO. Now we don't use it anymore, right ?
> because this patch (virtio-net: ethtool configurable RXCSUM)
> doesn't use it.

It is needed, because it serves as an upper bound on configurable options.

virtnet_set_features cannot enable LRO unless the LRO flags are
captured by the feature negotiation at probe time.

I think on enable you need something like

-                       offloads = vi->guest_offloads_capable;
+                       offloads |= vi->guest_offloads_capable &
GUEST_OFFLOAD_LRO_MASK;

instead of unconditional

+                       offloads |= GUEST_OFFLOAD_LRO_MASK;
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
